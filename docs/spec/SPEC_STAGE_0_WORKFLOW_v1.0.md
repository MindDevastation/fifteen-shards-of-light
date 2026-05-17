# SPEC_STAGE_0_WORKFLOW_v1.0

## Stage
Stage 0B — AI Workflow Scaffold.

## Goal
Create a lightweight repository scaffold for AI-assisted development without implementing gameplay.

## Expected Repository Areas
- `docs/req` — requirements and project canon.
- `docs/spec` — stage and feature specifications.
- `docs/architecture` — system maps and architectural notes.
- `docs/qa` — handoff and manual test checklists.
- `docs/decisions` — ADR records.
- `prompts/codex` — task prompts for implementation slices.
- `prompts/review` — review prompts.
- `prompts/reusable` — reusable prompt fragments.
- `scenes/core`, `scenes/levels`, `scenes/ui` — future Godot scene organization.
- `scripts/core`, `scripts/player`, `scripts/soul`, `scripts/ui` — future Godot GDScript game script organization only.
- `tools` — future non-Godot helper scripts, shell scripts, validation scripts, or development utilities.
- `assets/models`, `assets/materials`, `assets/audio`, `assets/fonts`, `assets/placeholders` — future asset organization.
- `manual_tests` — human-run test notes.
- `handoff` — per-slice handoff notes.

## Stage 0 Rules
- Do not create gameplay scripts.
- Do not create Godot scenes.
- Do not add player movement, camera logic, UI logic, art, audio, external dependencies, CI/CD, automated test frameworks, or actual tooling scripts.
- Use `.gitkeep` only where needed to preserve empty directories.

## Done Criteria
- Scaffold directories exist and are tracked by Git.
- Core requirement, workflow, architecture, QA, ADR, and prompt documents exist.
- README explains the project stage and scaffold map.
- Godot project files are preserved.
