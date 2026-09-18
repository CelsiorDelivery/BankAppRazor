$ErrorActionPreference = "Stop"

$projectRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$workspaceRoot = Split-Path -Parent $projectRoot

$env:DOTNET_CLI_HOME = Join-Path $workspaceRoot ".dotnet-home"
$env:DOTNET_SKIP_FIRST_TIME_EXPERIENCE = "1"
$env:DOTNET_CLI_TELEMETRY_OPTOUT = "1"
$env:NUGET_PACKAGES = Join-Path $workspaceRoot ".nuget-packages"
$env:APPDATA = Join-Path $workspaceRoot ".appdata"
$env:LOCALAPPDATA = Join-Path $workspaceRoot ".localappdata"

& "C:\Program Files\dotnet\dotnet.exe" run --project $projectRoot --urls http://localhost:5000
