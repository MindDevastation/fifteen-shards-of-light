# SoulShard Slices 1–5 Implementation Summary

## 1. Scope

This document records the factual repository state after the sequential SoulShard implementation pack.

The implemented SoulShard pipeline supports a reusable world shard that charges, bursts into world-space motes, opens a reusable full-screen reward overlay, reveals reward text, waits for `Хорошо`, returns overlay fragments to the active SoulOrb, pulses the SoulOrb, and completes shard collection.

Implemented slices:

- Slice 1 — baseline reusable SoulShard presentation audited as already present.
- Slice 2 — SoulShard charge, world burst, reward sequence request API, and legacy fallback.
- Slice 3 — reusable full-screen `ShardRewardOverlay` and dev preview scene.
- Slice 4 — reusable `ShardRewardSequenceController`, overlay return, SoulOrb pulse, and player control lock.
- Slice 5 — `Level_01` integration with two gameplay SoulShards.

Explicitly deferred work remains separate and is listed in section 13.

## 2. Slice 1 baseline

The Slice 1 baseline remains present in `scenes/core/SoulShard.tscn` and `scripts/soul/soul_shard.gd`:

- root node remains `Area3D`;
- real model wrapper remains `res://scenes/environment/assets/shoul_shard.tscn` under `VisualRoot/ModelOffset/ShoulShardModel`;
- idle hover is driven by `hover_amplitude` and `hover_speed`;
- slow rotation is driven by `rotation_speed`;
- a soft billboard halo remains under `VisualRoot/Halo`;
- `GlowLight` remains an `OmniLight3D` with glow pulse tuning;
- `IdleParticles` remains a lightweight local particle effect;
- `CollisionShape3D` and `InteractPrompt` remain outside `VisualRoot`;
- the player interaction compatibility methods `can_player_interact(player)` and `interact(player)` remain available;
- the legacy `collected` signal remains preserved.

## 3. Slice 2 implementation

Slice 2 modified:

- `scripts/soul/soul_shard.gd`
- `scenes/core/SoulShard.tscn`

State flow:

```text
IDLE
→ CHARGING
→ BURSTING
→ WAITING_FOR_REWARD_SEQUENCE
→ COLLECTED
```

New exported data:

```gdscript
@export var shard_id: StringName = &""
@export_multiline var reward_text: String = ""
```

Signals:

```gdscript
signal collected
signal reward_sequence_requested(shard: Node, shard_id: StringName, reward_text: String, world_position: Vector3)
```

Completion API:

```gdscript
func complete_collection_sequence() -> void
```

Legacy fallback:

- if no `reward_sequence_requested` listeners exist, the shard completes itself after the local charge/burst sequence;
- if a controller is connected, the shard waits for `complete_collection_sequence()`;
- `complete_collection_sequence()` is guarded so `collected` emits once.

World burst:

- `CollectionBurst` was added to `SoulShard.tscn` as a one-shot `GPUParticles3D` node;
- it uses local scene materials and a sphere draw pass;
- no full-screen UI, SoulOrb targeting, or Level_01 integration was added in Slice 2.

## 4. Slice 3 implementation

Slice 3 added:

- `scripts/ui/shard_reward_overlay.gd`
- `scenes/ui/ShardRewardOverlay.tscn`
- `scripts/dev/shard_reward_overlay_test.gd`
- `scenes/dev/ShardRewardOverlayTest.tscn`

Overlay architecture:

```text
ShardRewardOverlay (Control)
├── Background
│   ├── MintWash
│   ├── PinkWash
│   └── OrangeWash
├── FragmentLayer
└── Content
    ├── RewardText
    └── ConfirmButton
```

Public API:

```gdscript
signal confirmation_requested
func play_reward(display_text: String, origin_screen_position: Vector2) -> void
```

Fragment frame:

- generated with deterministic `Polygon2D` fragments;
- fragments start near the provided screen origin;
- targets are distributed around the screen border with corner density and irregular offsets;
- subtle living movement runs after formation.

Background:

- implemented with scene-local `ColorRect` layers using soft mint, pink, and warm orange colors;
- fades in during reward playback.

Text reveal:

- `RewardText` is a `RichTextLabel` using centered italic BBCode;
- `visible_ratio` gradually reveals the text left-to-right.

Confirm button:

- `ConfirmButton` text is `Хорошо`;
- it stays hidden/disabled until text reveal completes;
- it disables itself and emits `confirmation_requested` once.

Test scene:

- `ShardRewardOverlayTest.tscn` provides `Play Test_1` and `Play Test_2` buttons;
- each launches the overlay from a different screen origin;
- it has no Level_01, SoulShard, or SoulOrb dependency.

## 5. Slice 4 implementation

Slice 4 added/modified:

- `scripts/core/shard_reward_sequence_controller.gd`
- `scenes/core/ShardRewardSequenceController.tscn`
- `scripts/ui/shard_reward_overlay.gd`
- `scripts/soul/soul_orb_base.gd`
- `scripts/player/player_controller.gd`

Controller architecture:

```text
ShardRewardSequenceController (Node)
```

Controller state flow:

```text
IDLE
→ OPENING
→ WAITING_FOR_CONFIRMATION
→ RETURNING
→ COMPLETING
→ IDLE
```

Camera projection:

- the controller uses the active viewport `Camera3D` to project shard and SoulOrb world positions into screen coordinates;
- screen positions are clamped to the visible viewport.

Player lock:

- `Player` now exposes `set_controls_enabled(enabled: bool)`;
- when disabled, movement, jump, dance, and interaction input are suppressed while simple physics settling continues;
- controls are restored after success or safe fallback.

SoulOrb discovery:

- `SoulOrb_Base` adds itself to the `soul_orb_visual` group;
- the controller searches visible in-tree group candidates;
- visible `SoulOrb_Follow` ancestors are preferred over world orb candidates.

Overlay return:

```gdscript
signal return_completed
func play_return_to(target_screen_position: Vector2) -> void
func reset_overlay() -> void
```

Return animation:

- disables confirmation;
- fades content/background;
- stops living frame motion;
- animates fragments to the SoulOrb screen position;
- fades/scales fragments out;
- hides the overlay and emits `return_completed`.

SoulOrb pulse:

```gdscript
func play_absorb_pulse() -> void
```

Failure handling:

- missing overlay, camera, orb, or active shard triggers safe fallback;
- fallback restores player controls and calls shard completion when possible;
- simultaneous shard requests are rejected and safely completed to prevent stuck shards.

## 6. Slice 5 implementation

Slice 5 modified only:

- `scenes/levels/Level_01.tscn`

Level_01 node replacements:

- removed visual-only `Shoul_Shard`;
- removed visual-only `Shoul_Shard2`;
- added gameplay `Shard_01` using `res://scenes/core/SoulShard.tscn`;
- added gameplay `Shard_02` using `res://scenes/core/SoulShard.tscn`.

Shard assignments:

```text
Shard_01:
  shard_id = &"Shard_01"
  reward_text = "Test_1"

Shard_02:
  shard_id = &"Shard_02"
  reward_text = "Test_2"
```

Preserved transforms:

```text
Shard_01 transform = Transform3D(-0.6197755, 0, -0.32538947, 0, 0.7, 0, 0.32538947, 0, -0.6197755, -25.009495, 2.3859854, 118.55172)
Shard_02 transform = Transform3D(-0.6977452, 0, -0.056139253, 0, 0.7, 0, 0.056139253, 0, -0.6977452, -40.980263, 3.5240073, 254.95113)
```

Controller/overlay placement:

```text
Level_01
├── LevelRuntimeRoot
│   └── ShardRewardSequenceController
└── UILayer
    └── ShardRewardOverlay
```

Preserved behavior:

- existing `SoulOrb_World` placement was not changed;
- existing `SoulOrb_Follow` creation flow was not changed;
- existing barrier node placement was not changed;
- level route, terrain, bridges, player, camera, and portal behavior were not redesigned;
- `Level_02` was not modified;
- no 2/2 completion logic, portal progression, save/progress, final monologue, or final narrative text was added.

## 7. Final API reference

| Owner file | Signature / field / signal / group | Caller | Purpose | Fallback behavior |
|---|---|---|---|---|
| `scripts/soul/soul_shard.gd` | `@export var shard_id: StringName` | Level scenes / controller payload | Local shard identity | Empty value is allowed. |
| `scripts/soul/soul_shard.gd` | `@export_multiline var reward_text: String` | Level scenes / overlay payload | Local reward text | Empty text falls back in overlay. |
| `scripts/soul/soul_shard.gd` | `signal collected` | `LevelManager`, legacy systems | Legacy completion signal | Emitted once through guarded completion. |
| `scripts/soul/soul_shard.gd` | `signal reward_sequence_requested(shard, shard_id, reward_text, world_position)` | `ShardRewardSequenceController` | Starts reusable reward sequence | If no listener, shard completes after burst. |
| `scripts/soul/soul_shard.gd` | `func can_player_interact(player: Node3D) -> bool` | `Player` | E interaction eligibility | Returns false outside IDLE/range/player. |
| `scripts/soul/soul_shard.gd` | `func interact(player: Node3D) -> void` | `Player` | Starts charge/burst | Duplicate calls ignored after first valid interaction. |
| `scripts/soul/soul_shard.gd` | `func complete_collection_sequence() -> void` | Controller / fallback | Finalizes collection | Idempotent; emits `collected` once. |
| `scripts/ui/shard_reward_overlay.gd` | `signal confirmation_requested` | Controller / test scene | User pressed `Хорошо` | Button disables to prevent duplicate emits. |
| `scripts/ui/shard_reward_overlay.gd` | `signal return_completed` | Controller | Overlay fragments finished return | Emitted after return animation or immediate hidden fallback. |
| `scripts/ui/shard_reward_overlay.gd` | `func play_reward(display_text: String, origin_screen_position: Vector2) -> void` | Controller / test scene | Starts frame/background/text reward | Empty text uses overlay default. |
| `scripts/ui/shard_reward_overlay.gd` | `func play_return_to(target_screen_position: Vector2) -> void` | Controller | Returns fragments to screen target | Emits `return_completed` if overlay is not visible. |
| `scripts/ui/shard_reward_overlay.gd` | `func reset_overlay() -> void` | Controller fallback | Hides/resets overlay | Used when context is missing. |
| `scripts/core/shard_reward_sequence_controller.gd` | `func register_shard(shard: Node) -> void` | Optional scene setup | Explicitly connect shard request signal | Auto-discovery also scans the configured root. |
| `scripts/core/shard_reward_sequence_controller.gd` | `@export var overlay_path: NodePath` | Level scenes | Explicit overlay reference | Falls back to method search. |
| `scripts/core/shard_reward_sequence_controller.gd` | `@export var player_path: NodePath` | Level scenes | Explicit player reference | Falls back to node named `Player`. |
| `scripts/core/shard_reward_sequence_controller.gd` | `@export var shard_search_root_path: NodePath` | Level scenes | Root for shard auto-discovery | Falls back to current scene. |
| `scripts/soul/soul_orb_base.gd` | group `soul_orb_visual` | Controller | Finds visible SoulOrb target | Missing target triggers safe shard completion. |
| `scripts/soul/soul_orb_base.gd` | `func play_absorb_pulse() -> void` | Controller | Soft visual absorb pulse | Reentrant; previous pulse tween is killed. |
| `scripts/player/player_controller.gd` | `@export var controls_enabled: bool` | Controller | Runtime control lock state | Defaults true. |
| `scripts/player/player_controller.gd` | `func set_controls_enabled(enabled: bool) -> void` | Controller | Locks/unlocks player input | Safe fallback restores true. |

## 8. Final scene tree reference

### `SoulShard.tscn`

```text
SoulShard (Area3D)
├── VisualRoot
│   ├── ModelOffset
│   │   └── ShoulShardModel
│   ├── Halo
│   ├── GlowLight
│   └── IdleParticles
├── CollisionShape3D
├── InteractPrompt
└── CollectionBurst
```

### `ShardRewardOverlay.tscn`

```text
ShardRewardOverlay (Control)
├── Background
│   ├── MintWash
│   ├── PinkWash
│   └── OrangeWash
├── FragmentLayer
└── Content
    ├── RewardText
    └── ConfirmButton
```

### `ShardRewardSequenceController.tscn`

```text
ShardRewardSequenceController (Node)
```

### Relevant SoulOrb nodes

```text
SoulOrb_World
├── HoverRoot
│   └── SoulOrb_Base
├── PickupArea
└── InteractionPromptAnchor

SoulOrb_Follow
└── HoverRoot
    └── SoulOrb_Base

SoulOrb_Base
└── VisualRoot
    ├── CoreRoot
    ├── InnerRingRoot
    ├── OuterRingCenterRoot
    ├── PetalContainer
    └── GlowRoot
```

### Relevant Level_01 integration nodes

```text
Level_01
├── LevelManager
├── BlockRoot
│   └── SoulOrb_World
├── PlayerRoot
│   └── Player
├── CameraRoot
│   └── FollowCamera
├── LevelRuntimeRoot
│   └── ShardRewardSequenceController
├── UILayer
│   └── ShardRewardOverlay
├── Shard_01
├── Shard_02
└── Ancient_Stone_Barrier_01
```

## 9. Changed files by slice

### Slice 2

- `scripts/soul/soul_shard.gd`
- `scenes/core/SoulShard.tscn`

### Slice 3

- `scripts/ui/shard_reward_overlay.gd`
- `scenes/ui/ShardRewardOverlay.tscn`
- `scripts/dev/shard_reward_overlay_test.gd`
- `scenes/dev/ShardRewardOverlayTest.tscn`

### Slice 4

- `scripts/core/shard_reward_sequence_controller.gd`
- `scenes/core/ShardRewardSequenceController.tscn`
- `scripts/ui/shard_reward_overlay.gd`
- `scripts/soul/soul_orb_base.gd`
- `scripts/player/player_controller.gd`

### Slice 5

- `scenes/levels/Level_01.tscn`

### Summary documentation

- `docs/design/SOUL_SHARD_SLICES_1_5_IMPLEMENTATION_SUMMARY.md`

## 10. Commits and PR

Branch:

```text
feature/implement-soul-shard-slices-2-5
```

Commits at documentation time:

```text
1741100203e5af400c4a50d9c202ac3124c66c1f — Implement SoulShard Slice 2 charge and world burst
1263acd0b08ea414ce8de8626d00c9ec825e69fb — Implement SoulShard Slice 3 reward overlay
24bac0c17dd24665f9080287c7f1e7c996af162f — Implement SoulShard Slice 4 reward sequence controller
773aea179b713aaed5251e73e09b86a7d34ae58c — Implement SoulShard Slice 5 Level_01 integration
```

Summary commit SHA:

```text
To be assigned by the documentation commit.
```

PR status:

```text
Not created yet at documentation commit time.
```

## 11. Verification matrix

### Static verification

| Behavior / check | Status | Notes |
|---|---|---|
| `git diff --check` per slice | PASS | Passed before each slice commit. |
| Slice 2 API search | PASS | `shard_id`, `reward_text`, `reward_sequence_requested`, `complete_collection_sequence`, `CollectionBurst` found. |
| Slice 3 API/search | PASS | `ShardRewardOverlay`, `play_reward`, `confirmation_requested`, `Test_1`, `Test_2`, `Хорошо`, `visible_ratio` found. |
| Slice 4 API/search | PASS | `ShardRewardSequenceController`, `play_return_to`, `return_completed`, `soul_orb_visual`, `play_absorb_pulse`, `controls_enabled` found. |
| Slice 5 Level_01 search | PASS | `Shard_01`, `Shard_02`, `Test_1`, `Test_2`, controller, and overlay found. |
| Old `Shoul_Shard` / `Shoul_Shard2` names in Level_01 | PASS | Static search found no remaining old node names. |
| Level_02 diff in Slice 5 | PASS | Static scoped diff reported no Level_02 change. |

### Headless verification

| Scene / command category | Status | Notes |
|---|---|---|
| `ShardRewardOverlay.tscn` | PASS | Headless load exited 0. |
| `ShardRewardOverlayTest.tscn` | PASS | Headless load exited 0. |
| `ShardRewardSequenceController.tscn` | PASS | Headless load exited 0. |
| `SoulShard.tscn` | PASS WITH WARNINGS | Exited 0; warnings/errors are tied to pre-existing missing imported GLB cache. |
| `SoulOrb_World.tscn` | PASS WITH WARNINGS | Exited 0; missing imported GLB cache warnings/errors remain. |
| `SoulOrb_Follow.tscn` | PASS WITH WARNINGS | Exited 0; missing imported GLB cache warnings/errors remain. |
| `Level_01.tscn` | PASS WITH WARNINGS | Exited 0; pre-existing import/cache/dependency warnings and harmless LevelManager missing legacy nodes warnings. |
| `Level_02.tscn` | PASS WITH WARNINGS | Exited 0; pre-existing player/animation/import-cache warnings remain. |

### Temporary automated tests

| Test | Status | Notes |
|---|---|---|
| Dedicated temporary integration scene/script | NOT RUN | Static/headless scene checks were used; no temporary committed test file was added. |

### Manual visual verification

| Behavior | Status | Notes |
|---|---|---|
| Charge softness and burst appearance | NOT VERIFIED | Requires manual Godot runtime review. |
| Overlay colors/frame/text/button feel | NOT VERIFIED | Requires manual Godot runtime review. |
| Fragment return visual timing | NOT VERIFIED | Requires manual Godot runtime review. |
| SoulOrb pulse visual feel | NOT VERIFIED | Requires manual Godot runtime review. |
| Player lock/unlock feel during real traversal | NOT VERIFIED | Requires manual Godot runtime review. |
| Barrier behavior during live Level_01 traversal | NOT VERIFIED | Requires manual Godot runtime review. |

## 12. Known risks

- Visual tuning: charge, burst, overlay frame, return motion, and pulse require manual review.
- Resolution/aspect-ratio behavior: overlay computes targets from viewport size but only headless scene load was verified.
- Imported model alignment: replacing visual-only Level_01 shards with gameplay prefab preserves transforms but prefab-internal `ModelOffset`/scale may alter apparent size/alignment.
- Particle appearance: `CollectionBurst` uses local particles and no external textures; final look is not manually verified.
- SoulOrb targeting: controller prefers visible `SoulOrb_Follow` by ancestor name and otherwise falls back to first visible `soul_orb_visual`; live moving-orb target feel is not manually verified.
- LevelManager legacy behavior: `Level_01` still logs missing legacy `SoulShard`/`PoemRewardUI` warnings; this is expected because the new shards avoid old `../SoulShard` wiring.
- Headless environment: commands exit 0 but produce pre-existing missing `.godot/imported` GLB cache and script dependency warnings/errors.

## 13. Explicitly deferred work

The following work is not complete and must remain separate:

- final Level_01 shard phrases;
- main chapter monologue;
- 2/2 chapter completion;
- portal activation/progression;
- saved shard progress;
- final typography;
- final audio;
- final cinematic polish;
- final confession/final poem/acrostic reveal;
- save/progress/GameState systems;
- broader Level_02+ redesign.
