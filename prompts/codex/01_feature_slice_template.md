# Codex Prompt — Feature Slice Template

## Context
Stage: `<stage>`
Slice: `<small requested slice>`

## Task
`<describe exactly one small implementation or documentation slice>`

## Constraints
- Godot 4.x + GDScript.
- No combat, inventory, dialogue system, online features, open world, complex AI, or complex RPG systems.
- Do not add polished assets before the greybox build works.
- Do not invent missing requirements.
- Do not change unrelated files.
- Use `scripts/` only for Godot GDScript game scripts.
- Use `tools/` only for future non-Godot helper or validation scripts.
- Future work branches should use `codex/*`, `feature/*`, or `fix/*`; do not use generic `work` branches.

## Required Process
1. Inspect relevant repository files.
2. Report current files and folders related to the task.
3. Provide a short plan.
4. Provide a test-impact check.
5. Apply only the requested changes.
6. Verify with the smallest useful manual/programmatic checks.
7. Provide a handoff report with commit SHA, branch name, PR link if applicable, push proof, risks, and explicit NOT VERIFIED items.
