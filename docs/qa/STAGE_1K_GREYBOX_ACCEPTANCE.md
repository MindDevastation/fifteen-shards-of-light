# Stage 1K — Greybox Stabilization / Full Acceptance Pass

## 1. Scope

Stage 1K is a documentation-backed QA/stabilization pass for the full greybox skeleton. It is not a gameplay feature slice.

Execution mode for this pass was VERIFY ONLY by default. No runtime code, scenes, project settings, gameplay scripts, or UI implementation files were intentionally changed.

Allowed artifact for this slice:

- `docs/qa/STAGE_1K_GREYBOX_ACCEPTANCE.md`

## 2. Baseline

- Current branch: `work`
- Current HEAD commit SHA at verification start: `1c291422b233c21e702d5646717b0bb8cca1ea23`
- PR #12 merge presence: PASS — local history has `Merge pull request #12 from MindDevastation/feature/fix-finalscene-interaction-and-overlay` at HEAD.
- PR #12 expected context found in merge subject/body: PASS — `Fix FinalScene pedestal interaction and add ending overlay (E-only)`.
- Repository status summary before acceptance document edit: PASS — `git status --short --branch` returned only `## work`.
- Godot version: `4.6.2.stable.official.71f334935`.
- Remote freshness: NOT VERIFIED — this checkout has no configured `origin` remote, so `git fetch origin --prune` failed with `fatal: 'origin' does not appear to be a git repository`. Local HEAD itself is the PR #12 merge commit.

## 3. Acceptance Target

Target route for Stage 1K:

`StartScene -> Level_01 -> Level_02 -> ... -> Level_15 -> FinalScene -> E pedestal interaction -> EndingOverlay`

## 4. Source Files Inspected

Required documentation inspected:

- `AGENTS.md`
- `README.md`
- `docs/req/REQ_PROJECT_CORE_v1.0.md`
- `docs/req/REQ_STAGE_1_GREYBOX_SKELETON_v1.0.md`
- `docs/spec/SPEC_STAGE_0_WORKFLOW_v1.0.md`
- `docs/spec/SPEC_STAGE_1_GREYBOX_SKELETON_v1.0.md`
- `docs/architecture/SYSTEM_OVERVIEW.md`
- `docs/qa/HANDOFF_CHECKLIST.md`
- `docs/qa/MANUAL_TEST_CHECKLIST.md`
- `docs/decisions/ADR_001_AI_WORKFLOW.md`
- `prompts/codex/01_feature_slice_template.md`
- `prompts/reusable/test_impact_check.md`

Implementation files inspected for verification only:

- `project.godot`
- `scenes/core/StartScene.tscn`
- `scripts/ui/start_scene.gd`
- `scenes/levels/Level_01.tscn`
- `scenes/levels/Level_02.tscn`
- `scenes/levels/Level_03.tscn`
- `scenes/levels/Level_04.tscn`
- `scenes/levels/Level_05.tscn`
- `scenes/levels/Level_06.tscn`
- `scenes/levels/Level_07.tscn`
- `scenes/levels/Level_08.tscn`
- `scenes/levels/Level_09.tscn`
- `scenes/levels/Level_10.tscn`
- `scenes/levels/Level_11.tscn`
- `scenes/levels/Level_12.tscn`
- `scenes/levels/Level_13.tscn`
- `scenes/levels/Level_14.tscn`
- `scenes/levels/Level_15.tscn`
- `scenes/core/FinalScene.tscn`
- `scripts/core/final_scene.gd`
- `scenes/dev/DevLevelMenu.tscn`
- `scripts/dev/dev_level_menu.gd`
- `scenes/core/LevelPortal.tscn`
- `scripts/core/level_portal.gd`
- `scripts/core/level_manager.gd`
- `scenes/core/SoulShard.tscn`
- `scripts/soul/soul_shard.gd`
- `scenes/ui/PoemRewardUI.tscn`
- `scripts/ui/poem_reward_ui.gd`
- `scenes/core/Player.tscn`
- `scripts/player/player_controller.gd`
- `scripts/player/camera_controller.gd`

## 5. Static / Headless Checks

| Command | Result | Notes |
| --- | --- | --- |
| `git status --short --branch` | PASS | Before editing this document, output was `## work`. |
| `git fetch origin --prune` | FAIL | Remote freshness could not be verified because no `origin` remote is configured in this checkout. This did not change files. |
| `git log --oneline --decorate -n 20` | PASS | HEAD is PR #12 merge commit `1c29142`. |
| `git diff --check` | PASS | No whitespace errors before document edit. |
| `rg 'run/main_scene="res://scenes/core/StartScene.tscn"' project.godot` | PASS | Main scene remains `res://scenes/core/StartScene.tscn`. |
| `rg -n 'Level_16\|GameState\|game_data\|Acrostic\|final poem\|personal message\|confession\|VideoStreamPlayer\|save\|progress\|inventory\|combat\|dialogue\|online\|res://scenes/levels/Level_16.tscn' project.godot scenes scripts docs prompts README.md AGENTS.md` | PASS WITH EXPECTED DOC MATCHES | Matches were in requirements/spec/prompt guardrails plus one placeholder line in `scripts/ui/poem_reward_ui.gd`; no `Level_16` or forbidden runtime system was found. |
| `find scenes/levels -maxdepth 1 -name 'Level_16.tscn' -print` | PASS | No output; no `Level_16.tscn` exists. |
| `rg -n 'Level_16\|res://scenes/levels/Level_16.tscn' project.godot scenes scripts` | PASS | Exit code 1; no runtime `Level_16` reference found. |
| `rg -n 'GameState\|game_data\|Acrostic\|final poem\|personal message\|confession\|VideoStreamPlayer\|save\|progress\|inventory\|combat\|dialogue\|online\|cinematic' project.godot scenes scripts` | PASS WITH NOTE | Only runtime match was `Final cinematic placeholder` label text in `scenes/core/FinalScene.tscn`; no cinematic system or video playback node was found. |
| `godot --headless --path . --quit` | PASS | Project opened headlessly without parse/load errors. |
| `godot --headless --path . --scene res://scenes/core/StartScene.tscn --quit` | PASS | StartScene loaded headlessly without parse/load errors. |
| `godot --headless --path . --scene res://scenes/levels/Level_01.tscn --quit` | PASS | Level_01 loaded headlessly; printed `LevelManager ready for level 1.` |
| `godot --headless --path . --scene res://scenes/levels/Level_02.tscn --quit` | PASS | Level_02 loaded headlessly; printed `LevelManager ready for level 2.` |
| `godot --headless --path . --scene res://scenes/levels/Level_03.tscn --quit` | PASS | Level_03 loaded headlessly; printed `LevelManager ready for level 3.` |
| `godot --headless --path . --scene res://scenes/levels/Level_04.tscn --quit` | PASS | Level_04 loaded headlessly; printed `LevelManager ready for level 4.` |
| `godot --headless --path . --scene res://scenes/levels/Level_05.tscn --quit` | PASS | Level_05 loaded headlessly; printed `LevelManager ready for level 5.` |
| `godot --headless --path . --scene res://scenes/levels/Level_06.tscn --quit` | PASS | Level_06 loaded headlessly; printed `LevelManager ready for level 6.` |
| `godot --headless --path . --scene res://scenes/levels/Level_07.tscn --quit` | PASS | Level_07 loaded headlessly; printed `LevelManager ready for level 7.` |
| `godot --headless --path . --scene res://scenes/levels/Level_08.tscn --quit` | PASS | Level_08 loaded headlessly; printed `LevelManager ready for level 8.` |
| `godot --headless --path . --scene res://scenes/levels/Level_09.tscn --quit` | PASS | Level_09 loaded headlessly; printed `LevelManager ready for level 9.` |
| `godot --headless --path . --scene res://scenes/levels/Level_10.tscn --quit` | PASS | Level_10 loaded headlessly; printed `LevelManager ready for level 10.` |
| `godot --headless --path . --scene res://scenes/levels/Level_11.tscn --quit` | PASS | Level_11 loaded headlessly; printed `LevelManager ready for level 11.` |
| `godot --headless --path . --scene res://scenes/levels/Level_12.tscn --quit` | PASS | Level_12 loaded headlessly; printed `LevelManager ready for level 12.` |
| `godot --headless --path . --scene res://scenes/levels/Level_13.tscn --quit` | PASS | Level_13 loaded headlessly; printed `LevelManager ready for level 13.` |
| `godot --headless --path . --scene res://scenes/levels/Level_14.tscn --quit` | PASS | Level_14 loaded headlessly; printed `LevelManager ready for level 14.` |
| `godot --headless --path . --scene res://scenes/levels/Level_15.tscn --quit` | PASS | Level_15 loaded headlessly; printed `LevelManager ready for level 15.` |
| `godot --headless --path . --scene res://scenes/core/FinalScene.tscn --quit` | PASS | FinalScene loaded headlessly without parse/load errors. |

## 6. Manual QA Checklist

Manual interactive QA was not run in the Codex environment. The checklist below records static/headless evidence separately from interactive play requirements. No project-owner-provided manual results were supplied in this task prompt.

### 6.1 Full Path

| Check | Result | Notes |
| --- | --- | --- |
| StartScene -> Level_01 | NOT RUN | Static script inspection shows Start button calls `change_scene_to_file("res://scenes/levels/Level_01.tscn")`; interactive button click was not run. |
| Level_01 -> Level_02 | NOT RUN | Static target path is correct; interactive shard/UI/portal route was not run. |
| Level_02 -> Level_03 | NOT RUN | Static target path is correct; interactive shard/UI/portal route was not run. |
| Level_03 -> Level_04 | NOT RUN | Static target path is correct; interactive shard/UI/portal route was not run. |
| Level_04 -> Level_05 | NOT RUN | Static target path is correct; interactive shard/UI/portal route was not run. |
| Level_05 -> Level_06 | NOT RUN | Static target path is correct; interactive shard/UI/portal route was not run. |
| Level_06 -> Level_07 | NOT RUN | Static target path is correct; interactive shard/UI/portal route was not run. |
| Level_07 -> Level_08 | NOT RUN | Static target path is correct; interactive shard/UI/portal route was not run. |
| Level_08 -> Level_09 | NOT RUN | Static target path is correct; interactive shard/UI/portal route was not run. |
| Level_09 -> Level_10 | NOT RUN | Static target path is correct; interactive shard/UI/portal route was not run. |
| Level_10 -> Level_11 | NOT RUN | Static target path is correct; interactive shard/UI/portal route was not run. |
| Level_11 -> Level_12 | NOT RUN | Static target path is correct; interactive shard/UI/portal route was not run. |
| Level_12 -> Level_13 | NOT RUN | Static target path is correct; interactive shard/UI/portal route was not run. |
| Level_13 -> Level_14 | NOT RUN | Static target path is correct; interactive shard/UI/portal route was not run. |
| Level_14 -> Level_15 | NOT RUN | Static target path is correct; interactive shard/UI/portal route was not run. |
| Level_15 -> FinalScene | NOT RUN | Static target path is `res://scenes/core/FinalScene.tscn`; interactive shard/UI/final portal route was not run. |
| FinalScene -> EndingOverlay | NOT RUN | Static script inspection shows E activation reveals `EndingOverlay`; interactive E activation was not run. |

### 6.2 Level Consistency

| Check | Result | Notes |
| --- | --- | --- |
| Each level exists | PASS | `Level_01.tscn` through `Level_15.tscn` all exist and headless-load successfully. |
| Each level has player | PASS | Static inspection found `Player` instance in all 15 level scenes. |
| Each level has camera | PASS | Static inspection found `FollowCamera` / `Camera3D` in all 15 level scenes. |
| Each level has floor/collision | PASS | Static inspection found `Floor`, `StaticBody3D`, and `FloorCollision` in all 15 level scenes. |
| Each level has SoulShard | PASS | Static inspection found `SoulShard` instance in all 15 level scenes. |
| Each level has PoemRewardUI | PASS | Static inspection found `PoemRewardUI` under `UILayer` in all 15 level scenes. |
| Each level has LevelManager | PASS | Static inspection found `LevelManager` in all 15 level scenes. |
| Expected portal behavior is present | PASS | Static inspection found `LevelPortal` in all 15 level scenes; Level_01–Level_14 target the next level and Level_15 targets FinalScene. |

### 6.3 Portal Consistency

| Check | Result | Notes |
| --- | --- | --- |
| Portal appears after shard/UI | NOT RUN | Static script path is present: `SoulShard.collected` opens `PoemRewardUI`; `PoemRewardUI.closed` activates portal. Interactive timing was not run. |
| Physical arch/frame works | NOT RUN | Static inspection found `LeftPost`, `RightPost`, `TopBeam`, and collision shapes; physical collision behavior was not interactively tested. |
| Trigger is inside arch | NOT RUN | Static inspection found `PortalTrigger` in `LevelPortal.tscn`; spatial/player traversal behavior was not interactively tested. |
| Opening faces approach direction | NOT RUN | Requires interactive/spatial QA; not verified in headless mode. |
| No physics-callback error | PASS HEADLESS / NOT RUN INTERACTIVE | Headless scene loads produced no red physics-callback scene-change errors; interactive portal traversal was not run. |
| Target scene path is correct | PASS | Static inspection confirms Level_01 -> Level_02, Level_14 -> Level_15, and Level_15 -> FinalScene, with no Level_16 target. |

### 6.4 FinalScene

| Check | Result | Notes |
| --- | --- | --- |
| FinalScene loads | PASS | `godot --headless --path . --scene res://scenes/core/FinalScene.tscn --quit` passed. |
| Player can move | NOT RUN | Requires interactive play. |
| Pedestal prompt appears | NOT RUN | Static scene/script contains `InteractionPrompt`; trigger behavior requires interactive play. |
| Enter does not activate | NOT RUN | Static script checks `event.keycode == KEY_E`; interactive negative test was not run. |
| Space does not activate | NOT RUN | Static script checks `event.keycode == KEY_E`; interactive negative test was not run. |
| E activates | NOT RUN | Static script checks `event.keycode == KEY_E` and calls `_activate_pedestal()`; interactive positive test was not run. |
| Soul sphere appears/floats | NOT RUN | Static script shows `soul_sphere.show()` and `_process()` float motion after activation; visual behavior was not interactively verified. |
| EndingOverlay appears | NOT RUN | Static script shows `ending_overlay.show()` after E activation; interactive activation was not run. |
| "В главное меню" loads StartScene | NOT RUN | Static script connects button to deferred `change_scene_to_file(START_SCENE_PATH)`; interactive button click was not run. |
| "Выйти" quits | NOT RUN | Static script connects quit button to `get_tree().quit()`; interactive button click was not run. |

### 6.5 DevLevelMenu

| Check | Result | Notes |
| --- | --- | --- |
| Overlay appears | NOT RUN | Static scene contains `MenuPanel`; visual overlay behavior requires interactive play. |
| F10 hides/shows | NOT RUN | Static script toggles `menu_panel.visible` on `KEY_F10`; interactive key test was not run. |
| Level 01 loads Level_01 | NOT RUN | Static target exists; interactive button click was not run. |
| Level 10 loads Level_10 | NOT RUN | Static target exists; interactive button click was not run. |
| Level 15 loads Level_15 | NOT RUN | Static target exists; interactive button click was not run. |
| Final loads FinalScene | NOT RUN | Static target exists; interactive button click was not run. |

## 7. Scope Audit

| Forbidden / out-of-scope item | Result | Notes |
| --- | --- | --- |
| GameState | PASS | No runtime `GameState` implementation found in `project.godot`, `scenes`, or `scripts`. |
| game_data | PASS | No runtime `game_data` implementation found in `project.godot`, `scenes`, or `scripts`. |
| save/progress | PASS | No runtime save/progress system found. Mentions in docs/specs are requirements history only. |
| acrostic manager | PASS | No runtime acrostic manager found. Mentions in docs/specs are requirements history only. |
| final poem text | PASS | No actual final poem text found in runtime files. One placeholder message says final poem text will be added later. |
| final personal message | PASS | No actual final personal message found in runtime files. |
| final video | PASS | No video asset or final video playback found. |
| Level_16 | PASS | No `Level_16.tscn` exists and no runtime `Level_16` reference was found. |
| new gameplay mechanics | PASS | No Stage 1K runtime changes were made; static inspection did not find newly added forbidden gameplay systems. |
| art/audio/polish | PASS | No art/audio/polish additions were made in Stage 1K. |
| cinematic system | PASS WITH NOTE | `FinalScene.tscn` contains a label with text `Final cinematic placeholder`, but no cinematic system, animation/video player, or real video playback was found. |
| combat | PASS | No combat system found. |
| inventory | PASS | No inventory system found. |
| dialogue | PASS | No dialogue system found. |
| online | PASS | No online feature found. |
| complex AI | PASS | No complex AI found. |

## 8. Findings

### Blockers

None found by static/headless verification.

Important limitation: full interactive manual QA was NOT RUN in the Codex environment. If Producer requires Codex-verified interactive gameplay for final Stage 1 acceptance, that remains a verification gap rather than a code blocker found by this pass.

### Risks / Non-blockers

- Remote freshness could not be verified because no `origin` remote is configured in this checkout. Local HEAD is the PR #12 merge commit.
- The runtime scope audit found `Final cinematic placeholder` as label text in `FinalScene.tscn`. This is not a cinematic system or video playback implementation, but the wording should be kept in mind for later scope review.
- Headless scene loads do not prove player collision feel, portal approach orientation, button clicks, E-only input behavior, or full route timing.

### NOT VERIFIED

- Interactive full path: StartScene -> Level_01 -> ... -> Level_15 -> FinalScene.
- Interactive shard collection and PoemRewardUI close behavior in all levels.
- Interactive portal activation timing and physical arch collision.
- Interactive absence of red physics-callback errors during actual portal traversal.
- Interactive FinalScene E-only behavior: Enter/Space negative tests and E positive test.
- Interactive soul sphere visual float confirmation.
- Interactive EndingOverlay button behavior.
- Interactive DevLevelMenu overlay/F10/button behavior.
- Remote freshness against GitHub `main`.

## 9. Final Verdict

PASS WITH NOT VERIFIED ITEMS — Stage 1 greybox skeleton accepted with listed manual gaps.

Justification: required files exist, PR #12 merge is present locally at HEAD, main scene remains StartScene, all 15 level scenes and FinalScene load headlessly without parse/load errors, static portal targets form `Level_01 -> ... -> Level_15 -> FinalScene`, no Level_16 exists or is referenced in runtime files, and no forbidden runtime systems were found. Interactive manual QA was not run in this environment, so those checks are documented as NOT RUN / NOT VERIFIED rather than claimed as Codex-verified PASS.

## 10. Recommended Next Slice

Next slice should be Producer-approved and should not add polish before Stage 1 acceptance is locked. If the Producer requires fully interactive confirmation before locking Stage 1, run a separate human manual QA pass using the checklist above and record the project-owner-provided results in this document or a follow-up QA note.
