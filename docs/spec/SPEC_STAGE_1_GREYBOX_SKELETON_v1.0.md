# SPEC: Stage 1 Greybox Skeleton v1.0

## Status

Ready for producer review before implementation.

## Source Requirement

docs/req/REQ_STAGE_1_GREYBOX_SKELETON_v1.0.md

## Purpose

Define the technical implementation plan for Stage 1: a fully playable greybox skeleton of the game.

This SPEC describes the intended architecture, scene structure, script responsibilities, data flow, implementation slices, and manual verification expectations.

This SPEC does not authorize full implementation in one Codex task.

## Technical Stack

- Engine: Godot 4.x
- Language: GDScript
- Project type: 3D puzzle-platformer greybox
- Target platform for manual testing: Windows editor/local Godot
- Automated test framework: not required for Stage 1
- Verification method: manual checklists + Godot editor/headless checks where available

## Implementation Principle

Stage 1 must prove the full playable path before visual polish.

The implementation must be simple enough that the project owner can open the project in Godot and verify each slice manually.

Codex must not implement the entire Stage 1 in one task.

## Repository Conventions

### Godot Scenes

Godot scene files should live under:

- scenes/core
- scenes/levels
- scenes/ui

### Godot Scripts

GDScript gameplay scripts should live under:

- scripts/core
- scripts/player
- scripts/soul
- scripts/ui

### Tools

Non-Godot helper scripts, if needed later, should live under:

- tools

No helper tooling scripts are required for the first implementation slice.

### Assets

Placeholder and future assets should live under:

- assets/placeholders
- assets/models
- assets/materials
- assets/audio
- assets/fonts

Stage 1 should use generated simple meshes or placeholder objects where possible.

Do not add final art assets in Stage 1.

## Scene Architecture

### Required Core Scenes

#### scenes/core/StartScene.tscn

Type: Control

Purpose:
Minimal start screen.

Contains:
- Working title label.
- Start button.
- Optional Quit button.

Behavior:
- Stage 1A: Start button uses a safe placeholder handler that does not error while Level_01 does not exist.
- Stage 1C: Start button starts a new playthrough and loads Level_01 after `Level_01.tscn` exists.
- Quit button quits the game if present.

No full menu system.

#### scenes/core/Player.tscn

Type: CharacterBody3D or equivalent simple 3D player root.

Purpose:
Reusable placeholder player.

Contains:
- Placeholder visible mesh.
- Collision shape.
- Player movement script.
- Optional child camera rig if kept simple.

#### scenes/core/SoulOrb.tscn

Type: Node3D / MeshInstance3D placeholder.

Purpose:
Placeholder soul sphere visual and future helper object.

Stage 1 minimal behavior:
- Follow or stay near player if implemented in the relevant slice.
- No final VFX.

#### scenes/core/SoulShard.tscn

Type: Area3D

Purpose:
Reusable shard pickup.

Contains:
- Placeholder mesh.
- Collision shape.
- Pickup script.

Behavior:
- Detect player.
- Emit pickup/completion signal.
- Disable itself after collection.

#### scenes/core/FinalScene.tscn

Type: Control or Node3D with UI overlay.

Purpose:
Placeholder final epilogue.

Contains:
- Full placeholder poem entries.
- Highlighted acrostic letters.
- Revealed phrase.
- Placeholder final message.
- Optional simple sphere restoration visual.

No AI video.
No cinematic dependency.

### Required Level Scenes

Create or generate eventually:

- scenes/levels/Level_01.tscn
- scenes/levels/Level_02.tscn
- scenes/levels/Level_03.tscn
- scenes/levels/Level_04.tscn
- scenes/levels/Level_05.tscn
- scenes/levels/Level_06.tscn
- scenes/levels/Level_07.tscn
- scenes/levels/Level_08.tscn
- scenes/levels/Level_09.tscn
- scenes/levels/Level_10.tscn
- scenes/levels/Level_11.tscn
- scenes/levels/Level_12.tscn
- scenes/levels/Level_13.tscn
- scenes/levels/Level_14.tscn
- scenes/levels/Level_15.tscn

Each level should be a short greybox scene.

Level scenes may share a common structure and script.

## Level Scene Contract

Each level scene should provide:

- Root Node3D.
- Level identifier.
- Spawn point.
- Player instance or spawn mechanism.
- One SoulShard instance.
- Simple path to the shard.
- Optional reusable mechanic instance.
- Exit/transition handled after shard reward.

Each level must have exactly one required shard for Stage 1.

## Script Architecture

### scripts/ui/start_scene.gd

Attached to:
- scenes/core/StartScene.tscn

Responsibilities:
- Handle Start button.
- Stage 1A: provide a safe placeholder Start handler that does not error while `Level_01.tscn` does not exist.
- Stage 1C and later: reset temporary playthrough progress if GameState exists, then load Level_01.

Out of scope:
- Save/load.
- Settings.
- Level selection.
- Animated menu.

### scripts/player/player_controller.gd

Attached to:
- Player root.

Responsibilities:
- Basic 3D movement.
- Optional jump.
- Stable collision behavior.
- No combat.
- No special abilities.

Expected controls:
- WASD or arrow movement.
- Space jump if implemented.
- Escape behavior only if trivial and explicitly scoped.

### scripts/player/camera_controller.gd

Attached to:
- Camera rig or Camera3D parent.

Responsibilities:
- Basic follow camera.
- Keep player visible.
- No cinematic camera system.
- No complex camera collision unless required by manual testing.

### scripts/core/game_state.gd

May be used as an Autoload when needed.

Responsibilities:
- Track current level index.
- Track collected shard count for current playthrough.
- Track unlocked poem/acrostic entries.
- Reset progress at the start of a new playthrough.

Out of scope:
- Persistent save files.
- Multiple profiles.
- Settings persistence.

### scripts/core/level_manager.gd

Attached to:
- Level root or reusable level manager node.

Responsibilities:
- Know current level id.
- React to shard collection.
- Show PoemRewardUI.
- Transition to the next level after reward confirmation.
- Transition to FinalScene after Level_15.

### scripts/core/game_data.gd

May be used as a simple static data source.

Responsibilities:
- Store level metadata.
- Store placeholder poem text.
- Store acrostic letters.
- Store level scene paths.

Data should remain simple and local.

No external database.
No network.
No complex resource pipeline.

### scripts/soul/soul_shard.gd

Attached to:
- SoulShard scene.

Responsibilities:
- Detect player entering pickup area.
- Emit signal when collected.
- Hide/disable shard after pickup.

### scripts/soul/soul_orb.gd

Attached to:
- SoulOrb scene.

Responsibilities:
- Minimal placeholder behavior only.
- May follow player if scoped.
- May support later reveal/presence mechanics.

### scripts/ui/poem_reward_ui.gd

Attached to:
- scenes/ui/PoemRewardUI.tscn

Responsibilities:
- Show placeholder poem/couplet for completed level.
- Show continue button or input prompt.
- Emit continue signal.

### scripts/ui/final_scene.gd

Attached to:
- scenes/core/FinalScene.tscn

Responsibilities:
- Display all placeholder poem entries.
- Highlight acrostic letters.
- Show phrase "Алена, я люблю тебя".
- Show placeholder final message.

## Data Model

Stage 1 should use simple in-code data, not complex external files.

Recommended data shape:

LEVELS = [
  {
    "id": 1,
    "scene": "res://scenes/levels/Level_01.tscn",
    "letter": "А",
    "title": "Апрельский свет",
    "placeholder_text": "А placeholder line 1\nplaceholder line 2"
  },
  ...
]

Required 15 letters in order:

А
Л
Е
Н
А
Я
Л
Ю
Б
Л
Ю
Т
Е
Б
Я

Final phrase display should include punctuation:

"Алена, я люблю тебя"

## Placeholder Level List

Stage 1 should preserve these level identities:

1. А — Апрельский свет
2. Л — Лёд с другим путём
3. Е — Если путь не виден
4. Н — Не тревожа тихое
5. А — А за тенью — крыло
6. Я — Я рядом
7. Л — Лёгкость тишины
8. Ю — Юный смех в стороне от тяжести
9. Б — Больше не нужно держать всё старое
10. Л — Лисёнок идёт рядом
11. Ю — Южный дождь на крыше
12. Т — Тепло не торопит
13. Е — Есть магия в простом
14. Б — Без необходимости быть другой
15. Я — Яркий сад синих роз

Stage 1 text can be placeholder and does not need final poetry.

## Runtime Flow

### Start Flow

Completed Stage 1 flow:

1. Project main scene loads StartScene.
2. Player presses Start.
3. GameState resets progress if available.
4. Level_01 loads.

Stage 1A exception:

- Level_01 is not created until Stage 1C.
- In Stage 1A, pressing Start must not error; it may use a safe placeholder handler instead of loading a level.

### Level Flow

1. Level scene loads.
2. Player appears at spawn point.
3. Player reaches shard.
4. SoulShard emits collected signal.
5. LevelManager receives collected event.
6. LevelManager opens PoemRewardUI.
7. Player confirms continue.
8. LevelManager loads next level.

### Final Flow

1. Level_15 shard/reward completes.
2. FinalScene loads.
3. FinalScene displays all entries.
4. First letters are highlighted.
5. Phrase appears:
   "Алена, я люблю тебя"
6. Placeholder personal message appears.
7. No answer is requested.

## Reusable Greybox Mechanics

These mechanics may be implemented in later Stage 1 slices.

### Reveal Path

Suggested script:
- scripts/core/reveal_path.gd

Possible scene usage:
- Hidden bridge/platform starts invisible or disabled.
- Trigger enables it.

Must remain simple.

### Presence Zone

Suggested script:
- scripts/core/presence_zone.gd

Possible scene usage:
- Player stays in Area3D for 2–3 seconds.
- Zone emits activated signal.

Must not require precision timing.

### Activate Points

Suggested script:
- scripts/core/activation_point.gd
- scripts/core/activation_group.gd

Possible scene usage:
- Player activates 2–3 points.
- Group emits completed signal.
- Path opens or shard becomes available.

Must not become puzzle-heavy.

### Scripted Helper

Suggested script:
- scripts/core/scripted_helper.gd

Possible scene usage:
- A simple object moves along a predefined path or toggles a bridge.

No AI pathfinding.
No complex NPC behavior.

## Final Garden Placeholder

Final garden should be implemented only as a greybox scripted interaction.

Required elements:

- Simple garden area.
- Three activation points.
- Placeholder blue rose markers.
- Placeholder Garden Guardian object.
- Final shard or final trigger.

Forbidden elements:

- Combat.
- Boss health.
- Attacks.
- Dodging.
- Damage.
- Fail states.
- Dramatic defeat/victory language.

## Project Settings

The project main scene should eventually be set to:

res://scenes/core/StartScene.tscn

This should be done in the Stage 1A implementation slice.

Do not change unrelated project settings.

## Slice Plan

### Stage 1A — StartScene and Main Scene Setup

Goal:
Create minimal StartScene and set it as the main scene.

Stage 1A must not create `Level_01.tscn`.

The Start button may have a safe placeholder handler that does not error while `Level_01.tscn` does not exist. The actual StartScene → Level_01 loading behavior is wired in Stage 1C after `Level_01.tscn` exists.

Expected files:
- scenes/core/StartScene.tscn
- scripts/ui/start_scene.gd
- possible project.godot main scene update

Manual check:
- Godot opens project.
- Running project shows StartScene.
- Start button exists.
- Pressing Start does not error while Level_01 is not present.
- No Level_01 scene is created in Stage 1A.
- No gameplay is implemented yet unless explicitly scoped.

### Stage 1B — Player and Camera Prototype

Goal:
Create placeholder Player scene and basic follow camera.

Expected files:
- scenes/core/Player.tscn
- scripts/player/player_controller.gd
- scripts/player/camera_controller.gd

Manual check:
- Player can move in a simple test scene.
- Camera follows.
- No combat/inventory/dialogue exists.

### Stage 1C — Level_01 Template and LevelManager Basics

Goal:
Create first greybox level and level completion structure.

Expected files:
- scenes/levels/Level_01.tscn
- scripts/core/level_manager.gd

Manual check:
- Start can reach Level_01 or Level_01 can be run directly.
- Player spawn works.
- Scene is simple and navigable.

### Stage 1D — SoulShard and PoemRewardUI

Goal:
Add shard pickup and poem reward UI.

Expected files:
- scenes/core/SoulShard.tscn
- scripts/soul/soul_shard.gd
- scenes/ui/PoemRewardUI.tscn
- scripts/ui/poem_reward_ui.gd

Manual check:
- Shard can be collected.
- Placeholder poem UI appears.
- Continue closes UI or triggers next step.

### Stage 1E — Sequential Level Flow

Goal:
Make level progression work through multiple levels.

Expected files:
- scripts/core/game_state.gd
- scripts/core/game_data.gd
- updates to LevelManager

Manual check:
- Level_01 can transition to Level_02.
- Progress is tracked only for current playthrough.

### Stage 1F — FinalScene and Acrostic

Goal:
Add placeholder final scene and acrostic reveal.

Expected files:
- scenes/core/FinalScene.tscn
- scripts/ui/final_scene.gd
- updates to game data/state if needed

Manual check:
- FinalScene displays phrase "Алена, я люблю тебя".

### Stage 1G — 15 Placeholder Levels

Goal:
Create placeholder Level_01 through Level_15 using reusable structure.

Expected files:
- scenes/levels/Level_01.tscn through scenes/levels/Level_15.tscn

Manual check:
- Each level has one shard.
- Levels load sequentially.

### Stage 1H — Reusable Mechanics

Goal:
Add simple reusable greybox mechanics used by levels.

Expected files:
- reveal_path.gd
- presence_zone.gd
- activation_point.gd
- activation_group.gd
- scripted_helper.gd

Manual check:
- Each mechanic works in at least one placeholder level.

### Stage 1I — Final Garden Placeholder

Goal:
Add non-combat final garden interaction.

Manual check:
- Three points activate.
- Guardian is passive.
- Final shard/final trigger works.
- No combat exists.

### Stage 1J — Full Playthrough Stabilization

Goal:
Manual test and fix blockers only.

Manual check:
- Full start-to-final playthrough works.

## Testing / Verification

Stage 1 relies on manual checks.

Each slice must include:

- Godot editor open check when relevant.
- Scene run check when relevant.
- Manual input check when relevant.
- File scope check.
- Confirmation that no forbidden systems were added.

Suggested command check in Codex environment when appropriate:

godot --headless --path . --quit

This does not replace local manual gameplay verification.

## Forbidden Implementation Patterns

Do not:

- Implement all of Stage 1 in one task.
- Add unrelated polish.
- Add combat.
- Add inventory.
- Add dialogue system.
- Add save/load unless specifically approved.
- Add final assets.
- Add audio.
- Add AI video files.
- Create complex architecture for future commercial expansion.
- Add networking.
- Add external dependencies.
- Add C#/.NET.
- Rewrite Stage 0 docs without a scoped reason.

## Handoff Requirements

Every Stage 1 Codex task must return:

- Summary.
- Files changed.
- Manual checks performed.
- Godot checks performed, if any.
- Commit SHA.
- Branch name.
- PR link if applicable.
- Push proof or clear note that user will push via UI.
- Confirmation of no unrelated scope.
- Confirmation of forbidden systems not added.
- Risks.
- NOT VERIFIED.

## Stage 1 Done Criteria

Stage 1 is complete only when:

- The project opens locally in Godot.
- Running the project starts StartScene.
- The player can reach and complete all 15 placeholder levels.
- Each level has one shard.
- Each shard triggers placeholder poem UI.
- The game reaches FinalScene after Level_15.
- FinalScene reveals "Алена, я люблю тебя".
- No combat or pressure-heavy systems exist.
- The full path can be manually completed.