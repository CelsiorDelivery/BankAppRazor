# BankRazor

ASP.NET Core Razor Pages migration of the VB6 `BANK_SYSTEM` project.

## What was migrated

- Login against the existing `LOGIN` table.
- Main menu equivalents for Master, Transactions, and Reports.
- Customer add/edit/search/delete using `tblCustomers`.
- Deposit, withdrawal, and monthly interest transaction screens using `tblTransaction`.
- Account settings using `tblAccount`.
- Daily, between-dates, and monthly-statement report screens.
- The same Access database is copied to `App_Data/dbBank.mdb`.

## Run

Install the .NET 8 SDK and an Access OLE DB provider, then run:

```powershell
cd BankRazor
dotnet restore
dotnet run --urls http://localhost:5000
```

Open `http://localhost:5000/Login`.

If `dotnet` is installed but not on PATH, or your shell cannot write to the normal user-profile .NET/NuGet folders, run:

```powershell
cd BankRazor
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\run-local.ps1
```

The app defaults to `Microsoft.ACE.OLEDB.12.0` in `appsettings.json`. If your machine only has the classic Jet provider, change it to:

```json
"Provider": "Microsoft.Jet.OLEDB.4.0"
```

Jet is 32-bit only, so the project is set to `x86`.
