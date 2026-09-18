<#
.SYNOPSIS
    Exports the Access bank database (schema + data) to a plain-text SQL script.

.DESCRIPTION
    The binary .mdb file is committed to this repository so that data is
    present on a fresh checkout. This script additionally produces a readable,
    diffable SQL snapshot (tools/seed-data.sql) so the data can be reviewed in
    pull requests or rebuilt into a new database if the .mdb is ever lost.

.EXAMPLE
    powershell -NoProfile -ExecutionPolicy Bypass -File tools\Export-BankData.ps1
#>
[CmdletBinding()]
param(
    [string]$Database,
    [string]$OutFile,
    [string]$Provider = 'Microsoft.ACE.OLEDB.12.0'
)

$ErrorActionPreference = 'Stop'

# $PSScriptRoot is not reliably populated in param defaults on Windows
# PowerShell 5.1, so resolve script-relative paths here instead.
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
if (-not $Database) { $Database = Join-Path $scriptDir '..\BankRazor\App_Data\dbBank.mdb' }
if (-not $OutFile)  { $OutFile  = Join-Path $scriptDir 'seed-data.sql' }
$Database = (Resolve-Path $Database).Path

# Map OLE DB type codes to Access SQL column types.
function Get-AccessType {
    param([int]$OleDbType, [int]$Size)
    switch ($OleDbType) {
        2   { 'SMALLINT' }        # SmallInt
        3   { 'INTEGER' }         # Integer
        4   { 'REAL' }            # Single
        5   { 'DOUBLE' }          # Double
        6   { 'CURRENCY' }        # Currency
        7   { 'DATETIME' }        # Date
        11  { 'BIT' }             # Boolean
        17  { 'BYTE' }            # UnsignedTinyInt
        72  { 'GUID' }            # Guid
        128 { 'LONGBINARY' }      # Binary
        130 { if ($Size -ge 255 -or $Size -le 0) { 'LONGTEXT' } else { "TEXT($Size)" } }
        202 { if ($Size -ge 255 -or $Size -le 0) { 'LONGTEXT' } else { "TEXT($Size)" } }
        203 { 'LONGTEXT' }
        default { 'LONGTEXT' }
    }
}

# Render a CLR value as a SQL literal.
function ConvertTo-SqlLiteral {
    param($Value)
    if ($null -eq $Value -or $Value -is [System.DBNull]) { return 'NULL' }
    if ($Value -is [datetime]) {
        # Slashes are escaped and the culture pinned, otherwise the machine's
        # date separator is substituted and Access misreads the literal.
        $inv = [System.Globalization.CultureInfo]::InvariantCulture
        return "#" + $Value.ToString('MM\/dd\/yyyy HH:mm:ss', $inv) + "#"
    }
    if ($Value -is [bool])     { if ($Value) { return 'True' } else { return 'False' } }
    if ($Value -is [byte[]])   { return 'NULL /* binary omitted */' }
    if ($Value -is [int] -or $Value -is [long] -or $Value -is [double] -or
        $Value -is [decimal] -or $Value -is [single] -or $Value -is [int16]) {
        return [string]$Value
    }
    # Text: single quotes are escaped by doubling them.
    return "'" + ([string]$Value).Replace("'", "''") + "'"
}

$connectionString = "Provider=$Provider;Data Source=$Database;"
$connection = New-Object System.Data.OleDb.OleDbConnection($connectionString)
$connection.Open()

$sb = New-Object System.Text.StringBuilder
[void]$sb.AppendLine("-- Bank database seed script")
[void]$sb.AppendLine("-- Source     : $(Split-Path -Leaf $Database)")
[void]$sb.AppendLine("-- Generated  : $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')")
[void]$sb.AppendLine("-- Regenerate : powershell -File tools\Export-BankData.ps1")
[void]$sb.AppendLine("--")
[void]$sb.AppendLine("-- This is a readable snapshot. The authoritative data ships as the")
[void]$sb.AppendLine("-- committed .mdb files; this script exists for review and recovery.")
[void]$sb.AppendLine()

$tables  = $connection.GetSchema('Tables') | Where-Object { $_.TABLE_TYPE -eq 'TABLE' } | Sort-Object TABLE_NAME
$columns = $connection.GetSchema('Columns')

foreach ($table in $tables) {
    $name = $table.TABLE_NAME
    $cols = $columns | Where-Object { $_.TABLE_NAME -eq $name } | Sort-Object ORDINAL_POSITION

    [void]$sb.AppendLine("-- ============================================================")
    [void]$sb.AppendLine("-- Table: $name")
    [void]$sb.AppendLine("-- ============================================================")

    $defs = foreach ($c in $cols) {
        $size = 0
        if ($c.CHARACTER_MAXIMUM_LENGTH -isnot [System.DBNull] -and $null -ne $c.CHARACTER_MAXIMUM_LENGTH) {
            $size = [int]$c.CHARACTER_MAXIMUM_LENGTH
        }
        "    [$($c.COLUMN_NAME)] $(Get-AccessType -OleDbType ([int]$c.DATA_TYPE) -Size $size)"
    }
    [void]$sb.AppendLine("CREATE TABLE [$name] (")
    [void]$sb.AppendLine(($defs -join ",`r`n"))
    [void]$sb.AppendLine(");")
    [void]$sb.AppendLine()

    $colNames    = $cols | ForEach-Object { $_.COLUMN_NAME }
    $colNameList = ($colNames | ForEach-Object { "[$_]" }) -join ', '

    $cmd = $connection.CreateCommand()
    $cmd.CommandText = "SELECT * FROM [$name]"
    $reader = $cmd.ExecuteReader()
    $rowCount = 0
    while ($reader.Read()) {
        $values = foreach ($cn in $colNames) { ConvertTo-SqlLiteral $reader[$cn] }
        [void]$sb.AppendLine("INSERT INTO [$name] ($colNameList) VALUES (" + ($values -join ', ') + ");")
        $rowCount++
    }
    $reader.Close()
    [void]$sb.AppendLine()
    [void]$sb.AppendLine("-- $rowCount row(s) in [$name]")
    [void]$sb.AppendLine()
    Write-Host ("Exported {0,-20} {1,4} row(s)" -f $name, $rowCount)
}

$connection.Close()
[System.IO.File]::WriteAllText($OutFile, $sb.ToString(), (New-Object System.Text.UTF8Encoding($false)))
Write-Host "`nWrote $OutFile"
