# HANDOFF_CHECKLIST

Use this checklist at the end of each Codex task.

## Required Handoff Sections
- Summary.
- Files changed.
- Manual checks performed.
- Godot project structure preservation status.
- Gameplay implementation status.
- Commit SHA.
- Branch name.
- PR link if applicable.
- Push proof.
- Risks.
- NOT VERIFIED section for anything not checked, unavailable, or unconfirmed.

## Branch and Push Checks
- Future work branches should use `codex/*`, `feature/*`, or `fix/*`.
- Do not use generic `work` branches for future tasks.
- If push proof is unavailable, mark push proof clearly as NOT VERIFIED.

## Scope Checks
- Confirm the task stayed within the requested slice.
- Confirm no unrelated files were changed.
- Confirm no missing requirements were invented.
- Confirm no out-of-scope systems were added.

## Godot Checks
- Confirm `project.godot` was not changed unless explicitly required.
- Confirm generated `.godot/` cache files are not committed.
- Confirm new scenes or scripts are only added when the task explicitly requests them.
