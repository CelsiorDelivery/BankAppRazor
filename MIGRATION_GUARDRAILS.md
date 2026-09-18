# VB6 to ASP.NET Core Razor Migration Guardrails

This project must be migrated evidence-first. The developer agent must not generate target code from source files alone when discovery and architecture artifacts are available.

## Required Inputs

Before implementing target code, read and reconcile:

- VB6 project manifest discovery:
  - Search the configured source root for `*.vbp`.
  - If exactly one project file exists, use it as the VB6 project manifest.
  - If multiple project files exist, inspect all manifests and migrate the project(s) selected by the run scope.
  - If no project file exists, fall back to a full source inventory from `*.frm`, `*.bas`, `*.cls`, `*.ctl`, `*.dsr`, and related data/report files.
- Active VB6 source files referenced by discovered project manifest(s), when manifest(s) exist
- Shared VB6 modules and data environment/report designers
- Access database schema and representative data from `dbBank.mdb`
- Discovery artifacts from the analyst agent, when present:
  - capability BRD
  - analyst module cards
  - analyst domain dossiers
  - process/use-case inventories
  - screen/control inventories
- Architecture artifacts from the architect agent, when present:
  - legacy architecture
  - target architecture
  - migration strategy
  - target technology selection
  - data-access and deployment guidance

If any expected analyst/architect artifact is missing, the developer agent must state that explicitly and use the best available substitutes, such as Speckit reports and direct source inspection.

## Required Traceability

For every active VB6 form, maintain a traceability matrix:

| VB6 artifact | Target Razor artifact | Controls covered | Events covered | Data operations covered | Gaps |
| --- | --- | --- | --- | --- | --- |

The matrix must include every form listed in the discovered `*.vbp` project manifest(s), not merely every form found on disk. If no project manifest exists, the matrix must include all discovered form/control/report artifacts and mark the project-manifest source as unavailable. Orphan forms must be listed separately with a migrate/exclude decision and reason.

## Acceptance Criteria

Generated ASP.NET Core/Razor code is not complete until:

- Every active VB6 screen has an equivalent reachable Razor page or documented replacement.
- Every required control/input/action from the source screen is represented or intentionally redesigned with traceability.
- Every validation and transaction rule is implemented or marked as a known gap.
- Every database table/field used by the VB6 logic has been checked against the actual MDB schema.
- Every report/data-environment command has a Razor report equivalent or documented replacement.
- The app builds successfully.
- Smoke tests cover login, navigation, customer CRUD, deposit, withdrawal, interest, close account, settings, and reports.

## Current Workspace Note

At the time this file was added, the workspace contained Speckit reverse-engineering/specification/phase reports under `BankVB6`, but no files explicitly named capability BRD, legacy architecture, target architecture, analyst module cards, or analyst domain dossiers were found in the repository tree.
