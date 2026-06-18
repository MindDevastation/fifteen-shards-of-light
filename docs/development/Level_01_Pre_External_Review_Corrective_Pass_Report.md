# Level 01 Pre-External Review Corrective Pass Report

## Branch and baseline

- Branch: `work`.
- Starting SHA: `114c89c38fb26fca61abd202fc83944c3a13b3a8`.
- Final local SHA: recorded in final handoff after commit.
- Final verified remote SHA: `NOT VERIFIED`.
- Merge performed: no.
- Auto-merge enabled: no.
- New PR created: no.

## Ordered implementation summary

1. Finale six-line control fix — COMPLETED.
2. Finale visual bounds validation — COMPLETED by automated headless layout validation for 1920×1080 and 1280×720; rendered graphical QA remains manual.
3. Lamp initial beam state — COMPLETED.
4. Free-route behavior — COMPLETED.
5. Wrong-route behavior — COMPLETED.
6. Channel reset behavior — COMPLETED.
7. Prompt refresh behavior — COMPLETED.
8. Existing lamp visual binding — COMPLETED.
9. Portal stable-arm geometry — COMPLETED by structural/script validation; rendered visual QA remains manual.
10. Lower-third vortex — COMPLETED.
11. Collision root-cause analysis — COMPLETED for the identified Level_01 start-zone culprit.
12. Runtime puzzle test — COMPLETED.
13. Editor import and Level_01 load — COMPLETED.

## Finale details

- `MAX_TEXT_LINES = 6` is the single source of truth for line allocation, wrapping, fitting, fallback, and validation.
- The overlay now creates six `LineMask` controls and six `RichTextLabel` controls.
- `_lines_fit()` checks line count, per-line width including horizontal padding, visual line height, and total visual height inside the 80% inner vine-frame safe rect.
- Visual line height includes font height, outline, shadow Y offset, reveal offset, and vertical padding.
- Unused masks and labels are hidden/reset before every layout pass.
- Reveal uses the padded mask width and settles label Y back to its padded final position instead of the mask edge.
- Six-line reveal stagger is capped so total reveal stays in the intended 6–9 second range.

## Lamp puzzle details

- Initial state creates two automatic beams: `SourceWarm → WarmRelay01` and `SourceMoon → MoonRelay01`.
- Sources remain locked and are not valid link targets.
- The first relay in each channel becomes `AVAILABLE_ENDPOINT`, so the player starts from the already-lit relay.
- Route state stores the actual selected lamp sequence per channel.
- After selecting an endpoint, the player can connect to any inactive relay or the matching channel destination.
- Wrong relays create real beams and lock/assign the chosen lamp, but only the exact configured route completes a channel.
- Wrong destinations mark the channel incorrect and expose source reset.
- Resetting one channel removes non-initial beams for that channel, releases lamps after the first relay, restores the initial beam, and leaves the other channel intact.
- Re-selecting the selected endpoint cancels selection.
- Prompt text is centralized through `refresh_all_prompts()` and the reusable `WorldInteractionPrompt.set_action_text()` API.

## Existing lamp visual binding

Existing relay visual node paths used by the logical lamp anchors:

- `LandmarkIsland01/Lantern/lantern_02` → `WarmRelay01`.
- `LandmarkIsland01/Lantern/lantern_03` → `WarmRelay02`.
- `LandmarkIsland01/Lantern/lantern_01` → `WarmRelay03`.
- `LandmarkIsland01/Lantern/lantern_07` → `WarmRelay04`.
- `LandmarkIsland01/Lantern/lantern_04` → `MoonRelay01`.
- `LandmarkIsland01/Lantern/lantern_05` → `MoonRelay02`.
- `LandmarkIsland01/Lantern/lantern_06` → `MoonRelay03`.

Source/destination sockets prepared for manual replacement:

- `SideIslandLampPuzzle/WarmSourceSocket`.
- `SideIslandLampPuzzle/MoonSourceSocket`.
- `SideIslandLampPuzzle/WarmDestinationSocket`.
- `SideIslandLampPuzzle/MoonDestinationSocket`.

All logical lamp `LampMesh` placeholders are `visible = false`; beam endpoints use child `BeamAnchor` nodes.

## Portal details

- Sleeve count: 5.
- Motes per sleeve: 54.
- Global rotation speed: 0.24, applied by decrementing `_global_rotation_phase` for counterclockwise motion.
- Sleeve twist: `turn_count = 1.55`.
- Stable-arm proof: sleeve Y is computed as `portal_center_y + sin(spiral_angle) * radius_y`, not by a monotonic bottom-to-top lerp.
- Lower vortex group: `LowerVortexMotes`.
- Lower vortex mote count: 56.
- Galaxy mote count: 60.
- Rim mote count: 72.
- Total mote target: 458 configured instances (270 sleeves + 60 galaxy + 72 rim + 56 lower vortex), slightly above the 350–450 soft target but still within the explicit per-group budgets.

## Collision root-cause analysis

- Identified culprit: `StepAssistRoot/StepAssistRamp_04/StepAssistCapShape_04`.
- Cause: the protruding cap collider overlapped the early start-route movement corridor near spawn and could catch the player capsule against the helper ramp edge.
- Old state: `StepAssistCapShape_04` was enabled as a solid decorative/helper cap with an oversized box relative to the early-route corridor.
- New state: only `StepAssistCapShape_04` is disabled; `StepAssistCapShape_01`, `StepAssistCapShape_02`, and `StepAssistCapShape_03` remain enabled.
- Player `safe_margin` is restored to `0.01`; the fix no longer relies on a global safe-margin increase.
- Spawn collision static validation passed for this targeted correction.

## Automated validation

- `git diff --check` — pass.
- `godot --headless --path . --quit --check-only` — pass.
- `timeout 300s godot --headless --editor --path . --quit` — pass, exit code 0.
- `/tmp/validate_target_loads.gd` — pass for `Level_01.tscn`, `LevelPortal.tscn`, `LevelFinaleOverlay.tscn`, and `scenes/environment/assets/cloud_001.tscn`.
- `/tmp/validate_light_route_runtime.gd` — pass for initial beams, cancel, wrong route beam, reset, correct warm/moon route, and barrier unlock.
- `/tmp/validate_finale_six_lines.gd` — pass for 1/3/4/5/6 line cases at 1920×1080 and 1280×720; warnings were limited to the temporary test forcing size on an anchored control in headless mode.
- `/tmp/validate_portal_targeted.gd` — pass for structural portal requirements and mote budgets.
- `/tmp/validate_spawn_collisions.gd` — pass for specific culprit state and non-culprit caps.

## Targeted validation

- Lamp puzzle: COMPLETED by runtime script.
- Finale responsive layout: COMPLETED by headless script; rendered visual QA still manual.
- Portal targeted validation: COMPLETED by structural/script validation; rendered visual QA still manual.
- Cloud scene load: COMPLETED by targeted load script.
- Collision-focused validation: PARTIAL/COMPLETED for the documented culprit and static state; full rendered gameplay feel remains manual.

## Review Pass 1 — Against requirements

- Finale six-line controls: COMPLETED.
- Finale clipping prevention: COMPLETED by visual-bounds calculations and automated validation.
- Lamp initial beams: COMPLETED.
- Lamp free routing: COMPLETED.
- Lamp wrong-route behavior: COMPLETED.
- Lamp channel reset/backtracking: COMPLETED.
- Lamp centralized prompt refresh: COMPLETED.
- Existing seven relay lamp visuals: COMPLETED.
- Beam robustness and BeamAnchor endpoints: COMPLETED.
- Portal no vertical lift: COMPLETED by script formula; rendered QA still manual.
- Lower-third vortex: COMPLETED.
- Collision culprit: COMPLETED.
- Editor import / Level_01 load / runtime validation: COMPLETED.

## Review Pass 2 — Actual runtime implementation

- Reopened scripts, scene wiring, and portal/finale scene dependencies through targeted Godot load scripts.
- Verified controller route state and prompt paths are runtime-driven, not only declarative.
- Verified reset leaves the other channel intact in the runtime puzzle test.
- Verified no procedural sphere placeholders are visible at runtime for logical lamp anchors.
- Verified `Level_01.tscn` loads after editor import.

## Review Pass 3 — Review the review

- Route choice is free after endpoint selection: COMPLETED.
- Wrong route creates a beam: COMPLETED.
- Reset path exists and works: COMPLETED.
- Six controls are allocated: COMPLETED.
- Vertical fit is checked: COMPLETED.
- Portal arms use non-monotonic Y: COMPLETED.
- Lower-third vortex exists: COMPLETED.
- Collision culprit is documented: COMPLETED.
- Level_01 load is verified: COMPLETED.
- Handoff matches diff: COMPLETED.

## Graphical QA and performance

- Graphical QA actually performed: no rendered gameplay capture was produced in this headless environment.
- Performance actually measured: no frame-time benchmark was captured; only configured mote budgets were validated.
- Remaining manual QA: rendered portal read, final overlay aesthetics at real display sizes, player feel around spawn/start route, and side-island lamp placement readability.

## Report path

`docs/development/Level_01_Pre_External_Review_Corrective_Pass_Report.md`
