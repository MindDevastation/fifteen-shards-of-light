# Fifteen Shards of Light
## Codex Implementation Pack — Remaining SoulShard Slices

Repository: `MindDevastation/fifteen-shards-of-light`  
Engine: Godot 4.x + GDScript  
Purpose: complete the reusable SoulShard interaction/reward sequence after **SoulShard Slice 1 — Reusable World Presentation**.

---

# 0. How to use this file

This file contains four separate Codex tasks:

1. **Slice 2 — Interaction Charge and World Collection Burst**
2. **Slice 3 — Reusable Full-Screen Shard Reward Overlay**
3. **Slice 4 — Return Fragments to SoulOrb and Sequence Controller**
4. **Slice 5 — Level_01 Integration with Two Soul Shards**

Run them strictly in this order.

Each slice must use:

- one Codex thread;
- one branch;
- one focused commit;
- one PR;
- a fresh branch from the current `main`;
- manual review before merge.

Do not combine multiple slices into one PR.

Before beginning any later slice, confirm that all preceding slices are merged into `main`.

---

# 1. Shared verified baseline

The current project contains:

- `res://scenes/environment/assets/shoul_shard.tscn`
  - visual-only wrapper around:
  - `res://assets/props/Soul_Shard/Shoul_Shard.glb`

- `res://scenes/core/SoulShard.tscn`
  - reusable gameplay SoulShard prefab;
  - root remains `Area3D`;
  - real shard model is placed under `VisualRoot/ModelOffset`;
  - idle hover, slow rotation, halo, glow light, and idle particles are implemented;
  - `CollisionShape3D` and `InteractPrompt` remain outside `VisualRoot`.

- `res://scripts/soul/soul_shard.gd`
  - joins `player_interactable`;
  - exposes `can_player_interact(player)`;
  - exposes `interact(player)`;
  - emits `collected`;
  - guards against duplicate collection;
  - disables collision and monitoring after collection.

- `res://scenes/core/SoulOrb_World.tscn`
  - collectible world SoulOrb.

- `res://scenes/core/SoulOrb_Follow.tscn`
  - following SoulOrb created after the world orb is collected.

- `res://scenes/core/SoulOrb_Base.tscn`
  - reusable visual core used by both world and follow orb variants.

- `res://scripts/player/player_controller.gd`
  - existing E interaction;
  - finds the nearest `player_interactable`;
  - calls `can_player_interact()` and `interact()`.

- `Level_01`
  - already contains two visual-only shard instances:
    - `Shoul_Shard`
    - `Shoul_Shard2`
  - these are not yet gameplay SoulShard instances.

- Active Stage 2 narrative model:
  - 6 active emotional chapters;
  - 15 total soul shards;
  - `Level_01` contains `Shard_01` and `Shard_02`.

Test text for the Level_01 integration slice:

- `Shard_01` → `Test_1`
- `Shard_02` → `Test_2`

Do not replace these test texts with final approved narrative phrases in this implementation pack.

---

# 2. Shared workflow rules for every slice

## Mandatory workflow

Before APPLY:

1. Inspect current repository state.
2. Read:
   - `AGENTS.md`
   - `README.md`
   - relevant Stage 2 REQ / SPEC / Level Matrix docs
   - all scenes/scripts affected by the slice
3. Produce a concise **PLAN**.
4. Produce a **TEST-IMPACT CHECK**.
5. Apply only if no real blocker exists.

If a blocker requires wider scope:

- stop;
- explain the blocker;
- list the additional files required;
- do not apply wider changes without approval.

## Branch rules

- Start from fresh current `main`.
- Do not commit directly to `main`.
- One slice = one branch.
- One slice = one focused commit.
- One slice = one PR.
- Do not reuse an old feature branch from a previous slice.

## Scope discipline

Never introduce unless explicitly required by the current slice:

- GameState;
- save/progress;
- global progression;
- acrostic manager;
- final poem;
- final personal message;
- voiceover;
- cinematics;
- audio;
- combat;
- enemies;
- inventory;
- dialogue;
- online systems;
- open world;
- global VFX framework;
- unrelated refactors;
- renaming `shoul_shard.tscn` or `Shoul_Shard.glb`;
- raw `.glb`, `.import`, or texture modifications.

## Standard handoff

Every Codex handoff must return:

1. Branch name.
2. Commit summary.
3. Commit SHA.
4. PR link.
5. Exact changed files.
6. Exact files intentionally not changed.
7. Implementation summary.
8. Static/headless checks.
9. Manual checklist with `PASS / FAIL / NOT RUN`.
10. Risks.
11. Blockers.
12. Explicit `NOT VERIFIED`.
13. Recommended next slice.

---

# SLICE 2
# SoulShard Interaction Charge and World Collection Burst

## Context

Slice 1 is already merged into `main`.

The reusable core SoulShard already has:

- actual model;
- idle hover;
- idle rotation;
- soft halo;
- glow light;
- idle particles;
- existing E interaction contract.

This slice adds only the world-space collection presentation and the minimal reusable data/signals needed by future reward UI integration.

## Goal

When the player interacts with the SoulShard:

1. prevent duplicate interaction;
2. hide the interaction prompt;
3. disable further interaction immediately;
4. softly intensify the shard glow;
5. briefly scale/pulse the visible crystal;
6. make the crystal disappear;
7. emit a short one-shot burst of small glowing world-space fragments/motes;
8. request a future reward sequence;
9. preserve a safe fallback for legacy levels that do not have the future sequence controller.

Do not implement any full-screen UI in this slice.

## Preferred changed files

- `scenes/core/SoulShard.tscn`
- `scripts/soul/soul_shard.gd`

No other file should change unless a real blocker is found and reported before APPLY.

## Required inspection

Inspect:

- `AGENTS.md`
- `README.md`
- Stage 2 REQ / SPEC / Level Matrix
- `scenes/core/SoulShard.tscn`
- `scripts/soul/soul_shard.gd`
- `scripts/player/player_controller.gd`
- all references to `signal collected`
- all usages of `scenes/core/SoulShard.tscn`
- existing particle/VFX conventions
- current Slice 1 node tree and tuning values

## Required reusable data

Add to `SoulShard`:

```gdscript
@export var shard_id: StringName = &""
@export_multiline var reward_text: String = ""
```

These fields store only local shard identity and text.

They must not create global progression or save data.

## Required signals/API

Preserve:

```gdscript
signal collected
```

Add a reusable request signal, conceptually:

```gdscript
signal reward_sequence_requested(
    shard: Node,
    shard_id: StringName,
    reward_text: String,
    world_position: Vector3
)
```

Exact signal typing may be adjusted to project conventions.

Add a public completion method, conceptually:

```gdscript
func complete_collection_sequence() -> void
```

Requirements:

- `collected` must emit exactly once;
- future controller calls `complete_collection_sequence()` after the full UI/SoulOrb sequence;
- legacy scenes without a connected reward controller must still complete collection automatically after the world burst;
- no shard may become permanently stuck waiting for a controller that does not exist.

Before implementation, verify the safest Godot 4 method for detecting whether the request signal has listeners.

## Required state flow

Use a small local state or guarded booleans.

Conceptual flow:

```text
IDLE
→ CHARGING
→ BURSTING
→ WAITING_FOR_REWARD_SEQUENCE
→ COLLECTED
```

Requirements:

- repeated E presses do nothing after the first valid interaction;
- prompt disappears immediately;
- monitoring and collision are disabled when interaction starts;
- the crystal remains visible during charge;
- the model disappears at burst;
- halo/light/idle particles transition cleanly;
- burst particles may remain alive briefly after the model disappears;
- the root must not be freed before a future controller can finish the sequence.

## Charge effect

Use a short local tween or AnimationPlayer.

Target duration:
- approximately `0.45–0.8` seconds.

Suggested behavior:

- glow energy rises softly;
- halo opacity/scale increases slightly;
- visual scale increases slightly, then settles;
- no violent flash;
- no camera shake;
- no sound;
- no damage/gameplay effect.

Expose only a few useful tuning values.

Do not create a generic animation framework.

## World burst

Add a one-shot local particle node, for example:

```text
VisualRoot
└── CollectionBurst
```

or another structurally appropriate local position.

Requirements:

- `GPUParticles3D` or similarly lightweight local effect;
- one-shot;
- explicit draw pass;
- small glowing fragments/motes;
- moderate outward spread;
- short lifetime;
- no collision;
- no external textures;
- no screen-space particles;
- no full-screen frame;
- no physical shard debris;
- no hundreds of particles.

Suggested range:
- 18–36 particles;
- lifetime around `0.6–1.2` seconds.

The burst should visually imply that the crystal breaks into light, but this slice does not form the screen frame yet.

## Legacy fallback behavior

If no future reward sequence controller is connected:

1. play charge;
2. play burst;
3. call `complete_collection_sequence()`;
4. emit `collected`;
5. preserve legacy level behavior.

If a controller is connected:

1. play charge;
2. play burst;
3. emit `reward_sequence_requested(...)`;
4. wait;
5. controller later calls `complete_collection_sequence()`;
6. then emit `collected`.

`collected` must never emit both from fallback and controller completion.

## Interaction compatibility

Preserve:

- `player_interactable`;
- player-only checks;
- `can_player_interact(player)`;
- `interact(player)`;
- prompt enter/exit behavior before interaction;
- stationary collision;
- existing Player interaction code unchanged.

## Hard out of scope

Do not implement:

- full-screen overlay;
- border fragments;
- mint/pink/orange background;
- typewriter text;
- italic reward text;
- `Хорошо` button;
- SoulOrb target search;
- 3D-to-screen projection;
- return flight into SoulOrb;
- SoulOrb pulse;
- player input lock;
- Level_01 integration;
- portal/progression changes.

## PLAN requirements

Before APPLY, provide:

1. Current baseline confirmation.
2. Exact files inspected.
3. Existing SoulShard usages.
4. Proposed state flow.
5. Proposed signal/API contract.
6. Legacy fallback strategy.
7. Charge implementation.
8. Burst implementation.
9. Exact files to change.
10. Explicit out-of-scope confirmation.
11. Regression risks.
12. Manual test plan.

## TEST-IMPACT CHECK

Cover:

- interaction contract;
- duplicate interaction;
- signal emission count;
- legacy levels without controller;
- lifetime of the root while waiting;
- collision/prompt state;
- particle draw-pass warnings;
- visual nodes hiding correctly;
- no Player changes;
- no Level_01 changes;
- no raw asset changes.

## Acceptance criteria

- interaction locks immediately;
- charge effect plays;
- crystal disappears only after charge;
- one-shot world burst plays;
- future reward request signal exists;
- `shard_id` and `reward_text` exist;
- fallback works without controller;
- `collected` emits exactly once;
- legacy Level_02 still completes its old reward/portal flow;
- no full-screen UI is added;
- no Level_01 changes;
- no runtime errors.

## Suggested checks

```text
git status --short --branch
git diff --check
git diff --name-only

rg -n "shard_id|reward_text|reward_sequence_requested|complete_collection_sequence|collected|CollectionBurst|one_shot" scenes/core/SoulShard.tscn scripts/soul/soul_shard.gd

rg -n "scenes/core/SoulShard.tscn" scenes

godot --headless --path . --quit
godot --headless --path . --scene res://scenes/core/SoulShard.tscn --quit
godot --headless --path . --scene res://scenes/levels/Level_02.tscn --quit
```

Add a small temporary headless interaction test if useful, but do not commit temporary test files.

## Manual checklist

- charge is soft;
- flash is not harsh;
- crystal remains visible during charge;
- crystal disappears at burst;
- burst originates from shard position;
- burst does not look explosive/aggressive;
- prompt disappears immediately;
- second E does nothing;
- legacy Level_02 still completes;
- no stuck waiting state without controller;
- `collected` fires once;
- no particle warnings;
- no runtime errors.

## Suggested commit

```text
Add SoulShard charge and world collection burst
```

---

# SLICE 3
# Reusable Full-Screen Shard Reward Overlay

## Context

Slices 1 and 2 are merged into `main`.

SoulShard can now:

- play charge;
- play a world burst;
- emit a reward sequence request containing shard identity/text/world position;
- wait for external completion;
- fall back safely in legacy levels.

This slice creates the reusable full-screen reward UI only.

Do not integrate it with SoulShard, SoulOrb, or Level_01 yet.

## Goal

Create a reusable full-screen overlay that can:

1. start from a provided screen position;
2. generate small glowing 2D shard fragments;
3. animate them into an asymmetric full-screen border/frame;
4. keep the frame subtly alive;
5. fade in a soft mint/pink/warm-orange background;
6. reveal italic reward text gradually from left to right;
7. show a bottom button:
   - `Хорошо`
8. emit a signal when the user confirms.

This slice stops after confirmation.

The return flight into SoulOrb belongs to Slice 4.

## New files

Preferred:

- `scenes/ui/ShardRewardOverlay.tscn`
- `scripts/ui/shard_reward_overlay.gd`
- `scenes/dev/ShardRewardOverlayTest.tscn`
- optionally one very small test-only script under `scripts/dev/` if strictly required

Do not modify:

- `PoemRewardUI`;
- SoulShard;
- SoulOrb;
- Level_01;
- Player;
- LevelManager;
- project settings;
- raw assets.

## Required inspection

Inspect:

- `AGENTS.md`
- `README.md`
- Stage 2 docs
- existing UI scene conventions
- `PoemRewardUI.tscn`
- `poem_reward_ui.gd`
- viewport/stretch settings in `project.godot`
- any existing CanvasLayer/full-screen UI patterns
- current target resolution and window mode

## Required public API

Provide a reusable method, conceptually:

```gdscript
func play_reward(
    reward_text: String,
    origin_screen_position: Vector2
) -> void
```

Provide a confirmation signal, conceptually:

```gdscript
signal confirmation_requested
```

Provide a future-facing return API stub only if it can remain inert and does not implement Slice 4 behavior.

Do not fake SoulOrb return in this slice.

## Root structure

Preferred structure:

```text
ShardRewardOverlay (Control)
├── Background
├── FragmentLayer
├── Content
│   ├── RewardText
│   └── ConfirmButton
└── Animation helpers as needed
```

Requirements:

- full-rect anchors;
- hidden by default;
- consumes mouse input while active;
- scales correctly at 1920×1080 and other common aspect ratios;
- no external image assets;
- no dependency on level-specific nodes.

A `CanvasLayer` wrapper is acceptable if consistent with project architecture.

## Border fragment implementation

Use generated lightweight 2D fragments.

Preferred options:

- `Polygon2D` triangular/irregular fragments;
- rotated small `ColorRect`/custom `Control` pieces;
- another simple scene-local UI approach.

Do not use actual 3D physics fragments.

Requirements:

- approximately 24–40 fragments;
- varied sizes;
- varied rotations;
- visible gaps;
- denser corners;
- irregular/asymmetric composition;
- not a perfect rectangular line;
- fragments begin near `origin_screen_position`;
- fragments animate outward and settle along screen edges;
- frame never covers central text;
- frame remains readable on different viewport sizes.

Use deterministic generation where practical so visual output is stable between runs.

## Living frame motion

After formation:

- fragments move very slightly;
- subtle oscillation;
- slight rotation;
- low amplitude;
- no distracting shaking;
- no constant re-randomization;
- no physics engine required.

The frame should feel alive, not unstable.

## Background

Create a soft full-screen background with:

- mint;
- soft pink;
- muted warm orange;
- gentle blending;
- low-to-moderate opacity;
- slow fade-in.

Preferred:

- scene-local `GradientTexture2D`;
- or one small local CanvasItem shader if simpler.

Do not create a reusable global shader framework.

No hard saturated colors.

## Reward text

Use `RichTextLabel`.

Requirements:

- centered;
- italic;
- readable;
- supports multiline;
- large but not oversized;
- fades/reveals only after the frame/background begin forming;
- appears gradually left-to-right;
- use `visible_ratio`, `visible_characters`, or equivalent;
- default reveal duration around `1.2–2.5` seconds depending on text length;
- no final typography asset required.

The test scene must demonstrate:

- `Test_1`
- `Test_2`

## Confirm button

Text:

```text
Хорошо
```

Requirements:

- bottom-centered;
- not visible or not enabled until text reveal completes;
- once pressed:
  - disable itself;
  - emit `confirmation_requested`;
  - do not immediately destroy the fragment frame;
  - do not perform SoulOrb return yet.

## Test scene

Create a simple dev scene allowing manual preview.

Requirements:

- one control to launch `Test_1`;
- one control to launch `Test_2`;
- use at least two different origin screen positions;
- allow replay/reset;
- do not depend on Level_01;
- do not modify DevLevelMenu unless explicitly required and approved.

Prefer a directly runnable dev scene.

## Hard out of scope

Do not implement:

- SoulShard signal connections;
- SoulOrb lookup;
- world-to-screen projection;
- fragment return flight;
- SoulOrb pulse;
- player input lock;
- `collected` completion;
- Level_01 integration;
- portal/progression;
- chapter completion;
- final fonts/assets;
- audio.

## PLAN requirements

Before APPLY, provide:

1. UI conventions inspected.
2. Exact files to create.
3. Overlay node structure.
4. Public API.
5. Fragment generation strategy.
6. Frame target calculation strategy.
7. Living motion strategy.
8. Background implementation.
9. Text reveal implementation.
10. Button behavior.
11. Test scene plan.
12. Resolution/aspect-ratio risks.
13. Explicit out-of-scope confirmation.

## TEST-IMPACT CHECK

Cover:

- viewport resizing;
- anchor/layout correctness;
- fragment count/performance;
- mouse input capture;
- repeat playback/reset;
- long text;
- empty text fallback;
- confirmation signal firing once;
- button double-click protection;
- no modifications to legacy reward UI;
- no level dependencies.

## Acceptance criteria

- overlay is hidden by default;
- `play_reward()` accepts arbitrary text and origin position;
- fragments fly from origin to frame;
- frame is irregular and alive;
- background fades in;
- text reveals gradually left-to-right;
- text is italic;
- button reads `Хорошо`;
- button appears/enables after text;
- confirmation signal emits once;
- Test_1 and Test_2 are demonstrated;
- no SoulOrb return exists yet;
- no runtime errors.

## Suggested checks

```text
git status --short --branch
git diff --check
git diff --name-only

rg -n "ShardRewardOverlay|play_reward|confirmation_requested|Test_1|Test_2|Хорошо|visible_ratio|visible_characters" scenes scripts

godot --headless --path . --quit
godot --headless --path . --scene res://scenes/ui/ShardRewardOverlay.tscn --quit
godot --headless --path . --scene res://scenes/dev/ShardRewardOverlayTest.tscn --quit
```

## Manual checklist

- origin positions work;
- fragments do not all look identical;
- corners are denser;
- center remains readable;
- frame motion is subtle;
- background colors are soft;
- text is readable and italic;
- reveal speed feels gentle;
- button appears at correct time;
- double click does not emit twice;
- replay/reset works;
- 16:9 and another aspect ratio remain acceptable;
- no runtime errors.

## Suggested commit

```text
Add reusable shard reward overlay
```

---

# SLICE 4
# Return Overlay Fragments to SoulOrb and Sequence Controller

## Context

Slices 1–3 are merged into `main`.

Available systems:

- reusable SoulShard with charge/burst and reward request signal;
- reusable ShardRewardOverlay with full-screen frame/background/text/button;
- SoulOrb world and follow variants using `SoulOrb_Base`.

This slice connects the systems through a reusable sequence controller.

Do not integrate into Level_01 yet.

## Goal

Create a reusable controller that:

1. receives a SoulShard reward request;
2. projects the shard world position into screen coordinates;
3. opens `ShardRewardOverlay`;
4. temporarily prevents player movement/interactions;
5. waits for `Хорошо`;
6. fades text/background;
7. animates frame fragments from the border into the active SoulOrb;
8. triggers a soft SoulOrb absorb pulse;
9. tells SoulShard to complete collection;
10. restores player control;
11. supports only one active reward sequence at a time.

## Preferred new files

- `scenes/core/ShardRewardSequenceController.tscn`
- `scripts/core/shard_reward_sequence_controller.gd`

Likely modified files:

- `scenes/ui/ShardRewardOverlay.tscn`
- `scripts/ui/shard_reward_overlay.gd`
- `scenes/core/SoulOrb_Base.tscn`
- `scripts/soul/soul_orb_base.gd`

Allowed only if clearly required:

- `scripts/player/player_controller.gd`

Do not modify Level_01 in this slice.

## Required inspection

Inspect:

- all Slice 2 and Slice 3 code;
- `SoulOrb_World.tscn`
- `soul_orb_world.gd`
- `SoulOrb_Follow.tscn`
- `soul_orb_follow.gd`
- `SoulOrb_Base.tscn`
- `soul_orb_base.gd`
- Player process/input behavior;
- scene-tree visibility behavior after world orb pickup;
- camera API and current active camera handling;
- existing groups and naming conventions.

## SoulOrb discovery

Use a reusable group-based approach.

Preferred:

- every `SoulOrb_Base` adds itself to a group such as:
  - `soul_orb_visual`

The controller should:

1. find visible in-tree SoulOrb visual candidates;
2. prefer the currently visible follow orb after pickup;
3. otherwise use the visible world orb;
4. fail safely if no orb is available.

Do not hardcode Level_01 NodePaths.

Do not search by a single fragile absolute path.

## SoulOrb screen position

Use the active `Camera3D`.

Conceptual:

```gdscript
camera.unproject_position(orb_global_position)
```

Requirements:

- use an appropriate visual center/anchor position;
- support moving `SoulOrb_Follow`;
- resolve/update target shortly before return animation;
- clamp/fail safely if target is behind the camera or unavailable.

## Overlay return API

Extend the overlay with a reusable method, conceptually:

```gdscript
func play_return_to(target_screen_position: Vector2) -> void
```

Provide a completion signal, conceptually:

```gdscript
signal return_completed
```

Return animation:

1. disable confirm button;
2. fade text;
3. fade background;
4. stop or reduce living-frame motion;
5. detach fragments from border targets;
6. animate fragments toward SoulOrb screen position;
7. slightly stagger arrival;
8. fade/scale fragments as they reach target;
9. hide/reset overlay;
10. emit `return_completed`.

Do not spawn physical 3D fragments.

## SoulOrb absorb pulse

Add a small reusable method to `SoulOrb_Base`, conceptually:

```gdscript
func play_absorb_pulse() -> void
```

Suggested behavior:

- short glow-energy increase;
- small core scale pulse;
- optional slight petal/ring response;
- approximately `0.35–0.7` seconds;
- non-blocking;
- safe to call repeatedly;
- no audio;
- no global state.

Do not rebuild existing SoulOrb animation architecture.

## Sequence controller behavior

Conceptual state:

```text
IDLE
OPENING
WAITING_FOR_CONFIRMATION
RETURNING
COMPLETING
```

Required behavior:

- connect to one or more SoulShard instances through explicit setup or local discovery;
- reject/queue additional shard requests while one sequence is active;
- store the active shard safely;
- store its text/id/world position;
- convert origin world position to screen position;
- call overlay `play_reward(...)`;
- on confirmation:
  - resolve active SoulOrb;
  - call overlay `play_return_to(...)`;
- on return completion:
  - trigger SoulOrb pulse;
  - call active shard `complete_collection_sequence()`;
  - release active state;
  - restore player control.

A simple rejection of a second simultaneous request is acceptable because the player cannot interact with two shards at once during the overlay.

Do not create a global singleton.

## Player control lock

Use the narrowest safe method.

Preferred options:

1. add a small reusable `set_controls_enabled(enabled: bool)` API to Player if required;
2. or use an existing process/input lock mechanism if already available.

Requirements:

- movement input blocked;
- jump blocked;
- interaction blocked;
- no permanent freeze after errors;
- control restored on successful completion;
- control restored on safe failure/reset;
- avoid pausing the entire tree unless clearly justified.

If Player modification is required, explain it in PLAN before APPLY.

## Failure handling

If no camera or SoulOrb is found:

- do not leave player frozen;
- do not leave shard permanently waiting;
- use a safe fallback:
  - close/reset overlay;
  - complete the shard sequence;
  - emit a warning;
  - restore controls.

If the active shard is freed unexpectedly:

- reset safely;
- restore controls.

## Hard out of scope

Do not implement:

- Level_01 integration;
- Test_1/Test_2 assignments;
- replacing visual shard instances;
- chapter completion;
- counting 2/2 shards;
- portal activation;
- main chapter monologue;
- save/progress;
- final narrative text;
- audio/cinematics.

## PLAN requirements

Before APPLY, provide:

1. Exact current APIs from Slices 2 and 3.
2. SoulOrb scene-tree findings.
3. Orb discovery strategy.
4. Camera projection strategy.
5. Overlay return strategy.
6. SoulOrb pulse strategy.
7. Player lock strategy.
8. Failure recovery.
9. Exact files to change/create.
10. Explicit no-Level_01 confirmation.
11. Manual test scene/approach.
12. Risks and blockers.

## TEST-IMPACT CHECK

Cover:

- multiple shard requests;
- missing orb;
- missing camera;
- orb moving during return;
- player lock restoration;
- overlay reset;
- shard completion exactly once;
- SoulOrb pulse reentrancy;
- world orb vs follow orb;
- no progression/portal changes;
- no Level_01 changes.

## Acceptance criteria

- controller receives reward request;
- overlay origin matches shard screen position;
- player cannot move/interact during overlay;
- confirmation starts close/return sequence;
- background/text fade;
- fragments fly to visible SoulOrb;
- visible follow orb is preferred after pickup;
- SoulOrb pulses;
- shard completes and emits `collected` once;
- player control returns;
- missing target fails safely;
- one active sequence at a time;
- no Level_01 integration;
- no runtime errors.

## Suggested checks

```text
git status --short --branch
git diff --check
git diff --name-only

rg -n "ShardRewardSequenceController|reward_sequence_requested|play_return_to|return_completed|soul_orb_visual|play_absorb_pulse|complete_collection_sequence|controls_enabled" scenes scripts

godot --headless --path . --quit
godot --headless --path . --scene res://scenes/core/ShardRewardSequenceController.tscn --quit
godot --headless --path . --scene res://scenes/ui/ShardRewardOverlay.tscn --quit
godot --headless --path . --scene res://scenes/core/SoulOrb_World.tscn --quit
godot --headless --path . --scene res://scenes/core/SoulOrb_Follow.tscn --quit
```

A dedicated temporary headless integration test may be used but must not be committed unless explicitly scoped.

## Manual checklist

- frame originates from shard screen position;
- player locks;
- button works;
- text/background fade correctly;
- frame fragments converge smoothly;
- moving follow orb remains a believable target;
- visible orb receives fragments;
- pulse is soft;
- shard emits collected once;
- player unlocks;
- second request cannot corrupt state;
- missing orb fallback works;
- no runtime errors.

## Suggested commit

```text
Add reusable shard reward sequence controller
```

---

# SLICE 5
# Level_01 Integration with Two Soul Shards

## Context

Slices 1–4 are merged into `main`.

Level_01 currently contains two visual-only instances:

- `Shoul_Shard`
- `Shoul_Shard2`

The reusable systems now exist:

- interactive core `SoulShard.tscn`;
- world charge/burst;
- reward overlay;
- sequence controller;
- fragment return to SoulOrb;
- SoulOrb absorb pulse.

This slice integrates the systems into Level_01 only.

## Goal

Replace the two visual-only shard instances in `Level_01` with two reusable gameplay SoulShard instances while preserving their existing transforms and level layout.

Assign:

```text
Shard_01:
  shard_id = "Shard_01"
  reward_text = "Test_1"

Shard_02:
  shard_id = "Shard_02"
  reward_text = "Test_2"
```

Add one local reward sequence controller and one overlay integration for the level.

Both shards must independently perform:

```text
E interaction
→ charge
→ world burst
→ full-screen border
→ background
→ typewriter text
→ Хорошо
→ fragments return to SoulOrb
→ SoulOrb pulse
→ shard collected
```

## Preferred changed files

Primary:

- `scenes/levels/Level_01.tscn`

Allowed only if a real integration blocker is found:

- reusable controller/overlay/SoulShard files from prior slices

Do not modify prior reusable systems merely for aesthetic tuning unless Level_01 exposes a real functional bug.

## Required inspection

Inspect:

- `Level_01.tscn`
- current transforms of `Shoul_Shard` and `Shoul_Shard2`
- `SoulOrb_World` placement and pickup flow
- `SoulOrb_Follow` behavior
- current `LevelManager` instance and warnings
- existing UI roots/CanvasLayers
- barrier controller
- block/terrain scenes
- current route and portal state
- all prior reusable sequence APIs

## Integration requirements

### Replace visual instances

Remove the two direct visual wrapper instances from `Level_01`.

Instance:

```text
res://scenes/core/SoulShard.tscn
```

twice.

Preferred node names:

```text
Shard_01
Shard_02
```

Preserve the existing world transforms of:

- old `Shoul_Shard`;
- old `Shoul_Shard2`.

Do not move terrain, bridges, barriers, SoulOrb, player, camera, or landmarks.

### Assign data

Set in the scene:

```text
Shard_01:
  shard_id = &"Shard_01"
  reward_text = "Test_1"

Shard_02:
  shard_id = &"Shard_02"
  reward_text = "Test_2"
```

No final narrative text in this slice.

### Add sequence controller

Add one reusable controller instance to Level_01.

Preferred parent:

- `LevelRuntimeRoot`;
- or another existing runtime/system root consistent with the scene.

Connect/register both shard instances.

Do not use a global singleton.

### Add overlay

Add one overlay instance under an appropriate `CanvasLayer` or full-screen UI root.

Requirements:

- only one overlay instance;
- hidden by default;
- controller owns the active sequence;
- correct full-screen anchors;
- no duplicate overlays per shard.

### SoulOrb target

Use the existing Level_01 SoulOrb system.

Expected:

- before pickup: visible `SoulOrb_World` may be target;
- after pickup: visible `SoulOrb_Follow` should be target.

Do not create another SoulOrb.

Do not change barrier opening behavior tied to SoulOrb collection.

## LevelManager compatibility

Current LevelManager may still represent legacy one-shard reward flow.

Inspect actual current behavior.

Requirements:

- new shards must not trigger the old `PoemRewardUI`;
- old LevelManager must not double-handle one of the new shard signals;
- avoid renaming a new shard to the exact legacy default `SoulShard` path if that would cause unintended connection;
- do not broadly refactor LevelManager in this slice.

If LevelManager produces harmless missing-node warnings but does not break gameplay, report them.

If it actively conflicts with the new two-shard flow, apply the narrowest Level_01-local configuration change possible.

Do not redesign LevelManager globally without approval.

## Player flow

During each overlay:

- player controls lock;
- only one reward sequence active;
- after return to SoulOrb, controls restore;
- player can continue toward the second shard.

After collecting both shards:

- no new chapter completion UI;
- no portal activation change;
- no final monologue;
- no save/progress;
- no shard counter UI.

This slice proves only the two reusable shard interactions.

## Hard out of scope

Do not implement:

- final approved shard phrases;
- main Level_01 monologue;
- two-shard completion condition;
- portal activation after 2/2;
- route rewrite;
- Level_02 changes;
- progression;
- save;
- GameState;
- final UI polish;
- audio;
- cinematics;
- level geometry changes;
- lighting redesign;
- environment asset changes.

## PLAN requirements

Before APPLY, provide:

1. Current Level_01 shard nodes/transforms.
2. Current SoulOrb and barrier flow.
3. Current LevelManager behavior.
4. Exact nodes to remove/add.
5. Exact data values.
6. Controller placement.
7. Overlay placement.
8. Connection strategy.
9. Prevention of old PoemRewardUI interference.
10. Exact changed files.
11. Explicit no-geometry/no-route changes.
12. Manual traversal test plan.
13. Risks/blockers.

## TEST-IMPACT CHECK

Cover:

- preserving shard transforms;
- preserving SoulOrb;
- preserving barrier logic;
- first shard sequence;
- second shard sequence;
- overlay reset between uses;
- controller reuse;
- player lock/unlock twice;
- active orb target;
- old LevelManager interference;
- no Level_02 changes;
- no route/portal changes;
- no terrain/camera/player placement changes.

## Acceptance criteria

- exactly two gameplay shards in Level_01;
- old visual-only shard instances removed;
- positions/scales preserved;
- first shard displays `Test_1`;
- second shard displays `Test_2`;
- both use the same overlay/controller;
- charge/burst works for both;
- frame/background/typewriter/button work for both;
- fragments return to visible SoulOrb;
- SoulOrb pulses;
- player unlocks after each sequence;
- each shard collects once;
- old PoemRewardUI does not appear;
- SoulOrb pickup/barrier behavior remains intact;
- level geometry unchanged;
- route unchanged;
- Level_02 untouched;
- no runtime errors.

## Suggested static checks

```text
git status --short --branch
git diff --check
git diff --name-only

rg -n "Shard_01|Shard_02|Test_1|Test_2|ShardRewardSequenceController|ShardRewardOverlay|shoul_shard.tscn|SoulShard.tscn" scenes/levels/Level_01.tscn

rg -n "Shoul_Shard|Shoul_Shard2" scenes/levels/Level_01.tscn

git diff --name-only -- scenes/levels/Level_02.tscn scenes/levels/Level_03.tscn scenes/core/StartScene.tscn scenes/core/FinalScene.tscn project.godot assets docs

godot --headless --path . --quit
godot --headless --path . --scene res://scenes/levels/Level_01.tscn --quit
godot --headless --path . --scene res://scenes/levels/Level_02.tscn --quit
```

Expected old visual-only names:
- absent, unless retained only in unrelated comments/history.

## Full manual verification

### Initial level state

- StartScene loads Level_01.
- SoulOrb appears normally.
- both shards are visible in their old positions.
- no reward overlay is visible at start.
- no old PoemRewardUI appears.

### SoulOrb

- SoulOrb pickup works.
- SoulOrb_Follow appears.
- barrier still opens.
- following orb remains visible and animated.

### Shard_01

- prompt appears in range;
- E starts charge once;
- crystal disappears into world burst;
- frame forms;
- background appears;
- `Test_1` reveals gradually in italic;
- `Хорошо` appears;
- click closes background/text;
- fragments fly into SoulOrb;
- SoulOrb pulses;
- player unlocks;
- shard cannot be collected twice.

### Shard_02

Repeat all checks with:

```text
Test_2
```

Verify overlay/controller reset completely after Shard_01.

### Regression

- player movement remains stable;
- step assist remains stable;
- camera remains stable;
- no geometry moved;
- no barrier regression;
- no route/portal regression;
- Level_02 still loads;
- no runtime errors.

## Suggested commit

```text
Integrate two reusable SoulShards into Level_01
```

---

# 3. Final completion boundary

After Slice 5, the project should have a reusable technical SoulShard reward pipeline:

```text
Reusable SoulShard
→ charge
→ world burst
→ full-screen living shard frame
→ soft gradient background
→ italic typewriter text
→ Хорошо
→ fragments return to active SoulOrb
→ SoulOrb absorb pulse
→ collected
```

Level_01 should demonstrate it twice:

```text
Shard_01 → Test_1
Shard_02 → Test_2
```

The following work remains separate and must not be silently added to any slice above:

- final Level_01 shard phrases;
- main chapter monologue;
- chapter completion after both shards;
- portal/route progression;
- saved shard progress;
- final typography;
- sound design;
- cinematic polish;
- final emotional text approval.
