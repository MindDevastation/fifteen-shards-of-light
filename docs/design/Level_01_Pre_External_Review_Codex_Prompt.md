# Codex Prompt — Level_01 Pre-External-Review Corrective Pass

You are implementing the next corrective pass for `Level_01` in the Godot project.

Your source of truth is:
- `docs/design/Level_01_Pre_External_Review_Assessment_and_Fix_Task.md`

Read that file fully before making any changes.

## Goal
Bring `Level_01` materially closer to external-review readiness by fixing the remaining blocking issues and implementing the side-island lamp mini-game.

## Critical execution rules
1. **Follow the MD file exactly as the source of truth.**
2. **Implement by slices.** Do not start the next slice until the current slice is completed.
3. **Do not stop after each slice.** Continue automatically through all slices until the full task is complete.
4. After the first full implementation pass, perform a **Review Pass 1** against the MD file and fix anything missed.
5. After that, perform a **Review Pass 2** against the actual changed files/resources/scenes/scripts and fix anything inconsistent.
6. After that, perform a **Review Pass 3** (“review the review”) and do a final polish pass.
7. Preserve the approved Level_01 architecture unless the MD file explicitly requires a change.
8. Do not replace the baked Help Stone inscription. Keep the original baked inscription.
9. Keep the implementation reusable where the MD file asks for reusable systems.
10. Be honest in the final report about what was and was not actually validated.

## Required slices
Implement all slices from the MD file in order:
- Slice 0 — Preflight and baseline lock
- Slice 1 — Player collision reliability pass
- Slice 2 — Side-island lamp puzzle architecture
- Slice 3 — Lamp puzzle UX / prompt / state polish
- Slice 4 — Portal structural VFX rework
- Slice 5 — Cloud volume refinement
- Slice 6 — Finale overlay text layout and readability pass
- Slice 7 — Finale overlay animation polish
- Slice 8 — Integrated validation pass
- Slice 9 — Final report

## Special implementation requirements
### For the side-island lamp mini-game
- Build it as a reusable system, not a one-off hack.
- Support inspector-configured sources, relays, destinations, correct paths, channel colors, and barrier reference.
- Already activated lamps must not be re-usable.
- Invalid interactions must not soft-lock the puzzle.
- The intended solution path from the referenced screenshots must be implementable and should work.
- Add dedicated prompt text for this mini-game.

### For the portal
- The current upward spiral behavior is not the correct target.
- Keep a lower-third vortex only if it helps the final read.
- Build 5 vertical counterclockwise sleeves and sparse inner particles for a galaxy feel.
- Build a rim using the same particle language.
- If performance/readability becomes poor, prefer a cheaper correct read over an expensive wrong read.

### For the finale overlay
- Text area must use 80% of the frame’s inner area.
- Support up to 6 lines.
- Increase text size.
- Prevent clipping.
- Add subtle depth styling.
- Keep the overlay reusable.

## Validation rules
At minimum, run and record the following where possible:
- `git status --short --branch --untracked-files=all`
- `git diff --check`
- `git diff --stat`
- `godot --headless --path . --quit --check-only`
- headless/editor import validation as appropriate
- any targeted validation scripts needed for the new puzzle, portal, clouds, and finale overlay

If a check cannot be fully completed due environment limitations, state that clearly in the final report.

## Final output requirements
When the implementation is done, provide a final handoff that includes:
1. branch name
2. starting SHA
3. final local SHA
4. final verified remote SHA or `NOT VERIFIED`
5. ordered commit list
6. files created
7. files modified
8. files deleted
9. slice-by-slice completion summary
10. results of Review Pass 1, Review Pass 2, and Review Pass 3
11. testing performed
12. graphical QA actually performed vs not performed
13. performance actually measured vs not measured
14. remaining manual QA
15. report path
16. whether merge was performed
17. whether auto-merge was enabled
18. whether a new PR was created

## Important behavior
Do not stop early.
Complete the entire task, then do the three review passes, then final polish, then produce the final report and handoff.
