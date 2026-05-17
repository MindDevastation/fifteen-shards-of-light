# AGENTS.md — Fifteen Shards of Light

## Project
- Repository: `MindDevastation/fifteen-shards-of-light`
- Engine: Godot 4.x
- Language: GDScript
- Project type: small personal non-commercial 3D puzzle-platformer gift game.
- Current production stage: Stage 0B — AI Workflow Scaffold.

## Canon
The game is about a nine-tailed fox, a soul sphere, 15 soul shards, 15 short micro-levels, couplets after each level, the hidden phrase “Алена, я люблю тебя”, and a gentle final epilogue.

## Production Goal
Build a finished playable 15–20 minute gift version. This is a one-time gift build, not a commercial game.

## Pipeline
1. Stage 0 — GitHub, AI workflow, local environment.
2. Stage 1 — playable greybox skeleton.
3. Stage 2 — model/visual polish.
4. Stage 3 — sound pass.
5. Stage 4 — final gift polish.
6. Stage 5 — gift build.

## Hard Constraints
- Use Godot 4.x and GDScript.
- Do not add combat, inventory, dialogue systems, online features, open world features, complex AI, or RPG systems.
- Do not add polished assets before the greybox build works.
- Treat one Codex task as one small slice.
- Do not invent missing requirements.
- Do not change unrelated files.

## Workflow Expectations
Before applying changes:
1. Inspect the current repository.
2. Report current files and folders relevant to the task.
3. Provide a short plan.
4. Provide a test-impact check.

When applying changes:
- Keep changes scoped to the requested slice.
- Prefer documentation and placeholders during Stage 0.
- Do not implement gameplay unless the task explicitly requests a gameplay slice.
- Preserve existing Godot project files unless a task explicitly requests a project setting change.

After changes:
- Provide a handoff report with summary, changed files, checks performed, risks, and not-verified items.
- Confirm whether the Godot project structure was preserved.
- Confirm whether gameplay was implemented.
