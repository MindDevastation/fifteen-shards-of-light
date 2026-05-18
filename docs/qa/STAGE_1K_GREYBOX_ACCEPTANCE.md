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

Interactive manual QA was provided by the project owner, not run by Codex. The checklist below keeps Codex static/headless checks separate from project-owner-provided interactive manual QA results.

### 6.0 Project-owner-provided Manual QA Result

Manual result provided by project owner: PASS.

The project owner confirmed:

- Full greybox route works: `StartScene -> Level_01 -> ... -> Level_15 -> FinalScene`.
- DevLevelMenu works.
- FinalScene opens.
- Player can approach the pedestal.
- Enter does not activate the pedestal.
- Space does not activate the pedestal.
- E activates the pedestal.
- Soul sphere appears and floats.
- EndingOverlay appears.
- `В главное меню` loads StartScene.
- `Выйти` quits the game.
- Runtime errors: none.

### 6.1 Full Path

| Check | Result | Notes |
| --- | --- | --- |
| StartScene -> Level_01 | PASS — project-owner-provided manual QA | Project owner confirmed the full greybox route works from StartScene through FinalScene. Codex did not run this interactive check. |
| Level_01 -> Level_02 | PASS — project-owner-provided manual QA | Project owner confirmed the full greybox route works. Codex did not run this interactive check. |
| Level_02 -> Level_03 | PASS — project-owner-provided manual QA | Project owner confirmed the full greybox route works. Codex did not run this interactive check. |
| Level_03 -> Level_04 | PASS — project-owner-provided manual QA | Project owner confirmed the full greybox route works. Codex did not run this interactive check. |
| Level_04 -> Level_05 | PASS — project-owner-provided manual QA | Project owner confirmed the full greybox route works. Codex did not run this interactive check. |
| Level_05 -> Level_06 | PASS — project-owner-provided manual QA | Project owner confirmed the full greybox route works. Codex did not run this interactive check. |
| Level_06 -> Level_07 | PASS — project-owner-provided manual QA | Project owner confirmed the full greybox route works. Codex did not run this interactive check. |
| Level_07 -> Level_08 | PASS — project-owner-provided manual QA | Project owner confirmed the full greybox route works. Codex did not run this interactive check. |
| Level_08 -> Level_09 | PASS — project-owner-provided manual QA | Project owner confirmed the full greybox route works. Codex did not run this interactive check. |
| Level_09 -> Level_10 | PASS — project-owner-provided manual QA | Project owner confirmed the full greybox route works. Codex did not run this interactive check. |
| Level_10 -> Level_11 | PASS — project-owner-provided manual QA | Project owner confirmed the full greybox route works. Codex did not run this interactive check. |
| Level_11 -> Level_12 | PASS — project-owner-provided manual QA | Project owner confirmed the full greybox route works. Codex did not run this interactive check. |
| Level_12 -> Level_13 | PASS — project-owner-provided manual QA | Project owner confirmed the full greybox route works. Codex did not run this interactive check. |
| Level_13 -> Level_14 | PASS — project-owner-provided manual QA | Project owner confirmed the full greybox route works. Codex did not run this interactive check. |
| Level_14 -> Level_15 | PASS — project-owner-provided manual QA | Project owner confirmed the full greybox route works. Codex did not run this interactive check. |
| Level_15 -> FinalScene | PASS — project-owner-provided manual QA | Project owner confirmed the full greybox route reaches FinalScene. Codex did not run this interactive check. |
| FinalScene -> EndingOverlay | PASS — project-owner-provided manual QA | Project owner confirmed E activates the pedestal and EndingOverlay appears. Codex did not run this interactive check. |

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
| Portal appears after shard/UI | PASS — project-owner-provided manual QA | Project owner confirmed the full greybox route works with no runtime errors. Codex did not run this interactive check. |
| Physical arch/frame works | PASS — project-owner-provided manual QA | Project owner confirmed manual QA passed successfully. Codex did not run this interactive check. |
| Trigger is inside arch | PASS — project-owner-provided manual QA | Project owner confirmed manual QA passed successfully. Codex did not run this interactive check. |
| Opening faces approach direction | PASS — project-owner-provided manual QA | Project owner confirmed manual QA passed successfully. Codex did not run this interactive check. |
| No physics-callback error | PASS — Codex headless and project-owner-provided manual QA | Headless scene loads produced no red physics-callback scene-change errors; project owner confirmed runtime errors: none. |
| Target scene path is correct | PASS | Static inspection confirms Level_01 -> Level_02, Level_14 -> Level_15, and Level_15 -> FinalScene, with no Level_16 target. |

### 6.4 FinalScene

| Check | Result | Notes |
| --- | --- | --- |
| FinalScene loads | PASS — Codex headless and project-owner-provided manual QA | Headless scene load passed; project owner confirmed FinalScene opens. |
| Player can move | PASS — project-owner-provided manual QA | Project owner confirmed the player can approach the pedestal. Codex did not run this interactive check. |
| Pedestal prompt appears | PASS — project-owner-provided manual QA | Project owner confirmed the player can approach the pedestal and complete the pedestal interaction. Codex did not run this interactive check. |
| Enter does not activate | PASS — project-owner-provided manual QA | Project owner confirmed Enter does not activate the pedestal. Codex did not run this interactive check. |
| Space does not activate | PASS — project-owner-provided manual QA | Project owner confirmed Space does not activate the pedestal. Codex did not run this interactive check. |
| E activates | PASS — project-owner-provided manual QA | Project owner confirmed E activates the pedestal. Codex did not run this interactive check. |
| Soul sphere appears/floats | PASS — project-owner-provided manual QA | Project owner confirmed the soul sphere appears and floats. Codex did not run this interactive check. |
| EndingOverlay appears | PASS — project-owner-provided manual QA | Project owner confirmed EndingOverlay appears. Codex did not run this interactive check. |
| "В главное меню" loads StartScene | PASS — project-owner-provided manual QA | Project owner confirmed the button loads StartScene. Codex did not run this interactive check. |
| "Выйти" quits | PASS — project-owner-provided manual QA | Project owner confirmed the button quits the game. Codex did not run this interactive check. |

### 6.5 DevLevelMenu

| Check | Result | Notes |
| --- | --- | --- |
| Overlay appears | PASS — project-owner-provided manual QA | Project owner confirmed DevLevelMenu works. Codex did not run this interactive check. |
| F10 hides/shows | PASS — project-owner-provided manual QA | Project owner confirmed DevLevelMenu works. Codex did not run this interactive check. |
| Level 01 loads Level_01 | PASS — project-owner-provided manual QA | Project owner confirmed DevLevelMenu works. Codex did not run this interactive check. |
| Level 10 loads Level_10 | PASS — project-owner-provided manual QA | Project owner confirmed DevLevelMenu works. Codex did not run this interactive check. |
| Level 15 loads Level_15 | PASS — project-owner-provided manual QA | Project owner confirmed DevLevelMenu works. Codex did not run this interactive check. |
| Final loads FinalScene | PASS — project-owner-provided manual QA | Project owner confirmed DevLevelMenu works and FinalScene opens. Codex did not run this interactive check. |

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

None found by static/headless verification or project-owner-provided manual QA.

Interactive manual QA was provided by the project owner, not run by Codex.

### Risks / Non-blockers

- Remote freshness could not be verified because no `origin` remote is configured in this checkout. Local HEAD is the PR #12 merge commit.
- The runtime scope audit found `Final cinematic placeholder` as label text in `FinalScene.tscn`. This is not a cinematic system or video playback implementation, but the wording should be kept in mind for later scope review.
- Headless scene loads alone do not prove player collision feel, portal approach orientation, button clicks, E-only input behavior, or full route timing; these interactive areas are now covered by project-owner-provided manual QA, not Codex-run QA.

### NOT VERIFIED

- Remote freshness against GitHub `main` remains NOT VERIFIED because no `origin` remote is configured in this checkout.
- Codex-run interactive manual QA remains NOT RUN; interactive PASS results in this report are project-owner-provided.

## 9. Final Verdict

PASS — Stage 1 greybox skeleton accepted.

Justification: required files exist, PR #12 merge is present locally at HEAD, main scene remains StartScene, all 15 level scenes and FinalScene load headlessly without parse/load errors, static portal targets form `Level_01 -> ... -> Level_15 -> FinalScene`, no Level_16 exists or is referenced in runtime files, and no forbidden runtime systems were found. The project owner also provided manual QA PASS for the full greybox route, DevLevelMenu, FinalScene E-only pedestal interaction, soul sphere/EndingOverlay behavior, ending buttons, and no runtime errors. Interactive manual QA was provided by the project owner, not run by Codex.

## 10. Recommended Next Slice

Next slice should be Producer-approved and should not add polish before Stage 1 acceptance is locked.
