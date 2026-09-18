# BankAppRazor

ASP.NET Core 8 Razor Pages banking application, migrated from a legacy VB6
`BANK_SYSTEM` project. The VB6 source is not part of this repository.

## Layout

| Path | Contents |
| --- | --- |
| `BankRazor/` | The Razor Pages application |
| `tools/` | Database export script and plain-text data snapshot |
| `MIGRATION_GUARDRAILS.md` | Evidence-first rules the migration followed |

## Data persistence

The Access database is **committed on purpose**, so a fresh clone already has
its data and needs no import step:

- `BankRazor/App_Data/dbBank.mdb` — the database the app reads

`.gitignore` deliberately does not exclude `*.mdb` or `App_Data/`. Access lock
files (`*.ldb`) are excluded, since those are transient.

A readable snapshot of the same data lives at `tools/seed-data.sql`
(schema + 86 rows across `LOGIN`, `tblAccount`, `tblCustomers`,
`tbltransaction`). Regenerate it after changing data with:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File tools\Export-BankData.ps1
```

## Running

Requires the .NET 8 SDK and an Access OLE DB provider
(`Microsoft.ACE.OLEDB.12.0`).

```powershell
cd BankRazor
dotnet run --urls http://localhost:5000
```

Open <http://localhost:5000/Login>. The home page is routed to `/Menu`, not
`/Index`.

See [BankRazor/README.md](BankRazor/README.md) for provider and 32-bit notes.
