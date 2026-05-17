# REQ: Stage 1 Greybox Skeleton v1.0

## Status

Ready for producer review before implementation.

## Project

Fifteen Shards of Light

## Stage

Stage 1 — Playable Greybox Skeleton

## Goal

Create a fully playable greybox version of the game where the complete path works from the start scene through 15 placeholder micro-levels to the final epilogue scene.

This stage is not about visual polish. It is about proving that the full game loop works before models, sounds, cutscenes, and final visuals are added.

## Product Context

This is a small personal non-commercial 3D puzzle-platformer gift game.

The player controls a placeholder version of a nine-tailed fox heroine. She collects 15 soul shards across 15 short fairy-tale micro-levels. After each shard, a placeholder couplet is shown. The first letters of the couplets form the hidden phrase:

"Алена, я люблю тебя"

The final scene shows the full placeholder poem, highlights the first letters, reveals the phrase, restores the soul sphere through a simple placeholder effect, and displays a gentle personal message without pressure.

## Emotional Safety Rule

The game must not pressure, manipulate, guilt, demand an immediate answer, or imply that the heroine is broken and must be fixed.

The emotional tone must remain:

"I am near, I am careful, I do not break your ice, but my feeling is real."

## Stage 1 Success Definition

Stage 1 is complete when the project can be opened in Godot and played from beginning to end using placeholder assets, placeholder levels, and placeholder text.

The full greybox path must be:

StartScene
→ Level_01
→ Level_02
→ Level_03
→ Level_04
→ Level_05
→ Level_06
→ Level_07
→ Level_08
→ Level_09
→ Level_10
→ Level_11
→ Level_12
→ Level_13
→ Level_14
→ Level_15
→ FinalScene

## In Scope

### Core Flow

- Minimal StartScene.
- Start button that begins the game.
- Sequential level progression from Level_01 to Level_15.
- FinalScene after Level_15.
- No full main menu system.

### Player

- Simple placeholder 3D player character.
- Basic movement.
- Basic jump if needed for greybox platforming.
- Basic camera follow.

### Soul Shard Loop

- One placeholder soul shard per level.
- Player can collect the shard.
- Collecting the shard triggers the level reward flow.
- Collected shard count is tracked for the current playthrough.

### Poem / Acrostic Loop

- Placeholder poem reward after each level.
- One placeholder couplet or two-line text per level.
- First letters form the phrase "Алена, я люблю тебя".
- Text can be rough placeholder text, not final poetry.
- FinalScene shows all 15 placeholder lines/couplets and highlights the first letters.

### Level Structure

- 15 placeholder micro-levels.
- Each level is short and simple.
- Each level has one main interaction idea.
- Levels may reuse the same greybox layout patterns.
- Levels do not need final art, final lighting, final models, or final atmosphere.

### Reusable Greybox Mechanics

Stage 1 may include simple versions of these reusable mechanics:

1. Reveal Path
   - A hidden or inactive path becomes visible/usable through a simple trigger.

2. Presence Zone
   - Player stands in a zone for 2–3 seconds to activate something.

3. Activate Points
   - Player activates 2–3 simple points to open a path or complete a level step.

4. Scripted Helper
   - A simple scripted object helps open a path.
   - No AI pathfinding.
   - No complex NPC behavior.

### Final Garden Placeholder

Level_15 and/or FinalScene must include a placeholder version of the final garden idea:

- Placeholder blue roses.
- Three activation points.
- Placeholder Garden Guardian.
- No combat.
- No health bar.
- No damage.
- No attacks.
- No boss phases.
- Final shard is obtained after activating the required points.

### Local Verification

- Project opens in Godot.
- Game starts from StartScene.
- Full flow can be played manually.
- No blocking errors in Godot editor.
- Git state is clean after pulling accepted PRs.

## Out of Scope

Stage 1 must not include:

- Final nine-tailed fox model.
- Final character rig.
- Final tail animation.
- Final blue rose models.
- Final Garden Guardian model.
- Final sound design.
- Music.
- Voiceover.
- AI video cutscenes.
- Final poem text.
- Final personal message text.
- Main menu system.
- Save/load system.
- Level select.
- Settings menu.
- Inventory.
- Dialogue system.
- Combat.
- Boss fight.
- Health/damage system.
- Online/co-op.
- Open world.
- Complex AI.
- Complex physics puzzles.
- Cinematic polish.
- Visual polish pass.
- Export/build packaging.

## Functional Requirements

### FR-001 Start Scene

The game must have a minimal StartScene that can be set as the main scene.

It must contain:

- Working title text.
- Start button.
- Optional Quit button.

The Start button must begin the game at Level_01.

### FR-002 Player Control

The player must control a placeholder 3D character.

The player must be able to:

- Move on the ground.
- Navigate simple platforms.
- Jump if required by the level layout.
- Reach the shard in each level.

### FR-003 Camera

The game must have a basic camera that allows comfortable manual testing.

The camera does not need final cinematic behavior.

### FR-004 Level Progression

The game must progress sequentially through all 15 levels.

After Level_15, the game must transition to FinalScene.

### FR-005 Soul Shard Pickup

Each level must include one shard pickup.

Collecting the shard must trigger the poem reward UI.

### FR-006 Poem Reward UI

After shard pickup, the game must show a placeholder poem/couplet UI.

The UI must allow the player to continue to the next level.

### FR-007 Acrostic Tracking

The game must track the level letters in order.

The final revealed phrase must be:

"Алена, я люблю тебя"

### FR-008 Final Scene

FinalScene must show:

- Placeholder list of all 15 poem entries.
- Highlighted first letters.
- The revealed phrase.
- Placeholder soul sphere restoration.
- Placeholder personal message.

### FR-009 Final Garden No-Combat Rule

The final garden interaction must not use combat mechanics.

The Garden Guardian must be a non-combat scripted presence.

### FR-010 Greybox Completion

The entire game must be playable with placeholder objects and placeholder text.

## Non-Functional Requirements

### NFR-001 Simplicity

The implementation must be small, understandable, and manually testable.

### NFR-002 No Overengineering

Do not introduce architecture that is not needed for the greybox path.

### NFR-003 Reusable Systems

Do not create 15 unrelated custom systems for 15 levels.

Use reusable mechanics and simple scene contracts.

### NFR-004 Local Manual Testing

Every feature slice must include a manual test checklist.

### NFR-005 Godot Version

The project targets Godot 4.x and GDScript.

### NFR-006 One-Time Gift Build

The game is a one-time personal gift, not a long-term commercial product.

Anything that does not fit the gift build is cut, not backlog.

## User Flow

1. Player opens the game.
2. StartScene appears.
3. Player presses Start.
4. Level_01 loads.
5. Player reaches and collects the shard.
6. Placeholder poem reward appears.
7. Player confirms and moves to Level_02.
8. This repeats through Level_15.
9. Final garden placeholder interaction completes.
10. FinalScene appears.
11. Full placeholder poem is shown.
12. First letters are highlighted.
13. The phrase "Алена, я люблю тебя" is revealed.
14. Placeholder personal message appears.
15. The game ends calmly.

## Acceptance Criteria

Stage 1 is accepted only if all of the following are true:

- Godot opens the project without errors.
- StartScene can be played from the editor.
- Start button loads Level_01.
- Player can move in Level_01.
- Player can collect a shard.
- PoemRewardUI appears after shard pickup.
- Player can continue to the next level.
- All 15 placeholder levels are reachable in sequence.
- Each level has exactly one required shard.
- FinalScene appears after Level_15.
- FinalScene shows the acrostic phrase.
- FinalScene includes a placeholder personal message.
- No combat system exists.
- No inventory system exists.
- No dialogue system exists.
- No final assets are required.
- No AI video or cinematic work is required.
- All implementation slices have manual verification notes.
- No unrelated systems were added.

## Stage 1 Slice Plan

Stage 1 should be implemented through small Codex slices:

1. Stage 1A — StartScene and project main scene setup.
2. Stage 1B — Basic placeholder PlayerController and CameraController.
3. Stage 1C — Level_01 greybox template and LevelManager basics.
4. Stage 1D — SoulShard pickup and PoemRewardUI placeholder.
5. Stage 1E — Sequential level transition flow.
6. Stage 1F — Acrostic data and FinalScene placeholder.
7. Stage 1G — Generate/assemble Level_01 through Level_15 placeholders using reusable contracts.
8. Stage 1H — Add simple reusable mechanics: reveal path, presence zone, activate points, scripted helper.
9. Stage 1I — Final garden placeholder without combat.
10. Stage 1J — Full manual playthrough stabilization.

Each slice must be one small PR-friendly task.

## Producer Notes

The player experience must feel simple, soft, and complete.

A rough but playable full path is more important than a polished first level.

Do not polish before the full path works.