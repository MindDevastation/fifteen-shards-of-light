# Level 01 Completion: Barrier, Landmark Finale and Transition to Level 02

**Project:** Fifteen Shards of Light  
**Repository:** `MindDevastation/fifteen-shards-of-light`  
**Engine:** Godot 4.6  
**Renderer:** Forward Plus  
**Physics:** Jolt Physics  
**Document role:** authoritative development reference and target specification  
**Target scope:** complete the playable flow of `Level_01` from the two SoulShards through the Landmark finale and the transition to `Level_02`  
**Verified repository baseline at document creation:** `main` at `fd4ac99636704fca37a6200eedf0988dbfed931e`  
**Target scene:** `res://scenes/levels/Level_01.tscn`  
**Transition target:** `res://scenes/levels/Level_02.tscn`

---

## 1. Authority and interpretation rules

This document is the source of truth for the target behavior, scene composition, state transitions, visual direction, acceptance criteria and implementation order for the barrier, Landmark finale and portal flow in `Level_01`.

The repository remains the source of truth for the actual current file contents, APIs and paths. Before implementation, the developer must inspect the latest `main` and adapt this target design to any safe repository changes without weakening the behavior defined here.

Conflict precedence:

1. User-approved emotional and visual direction.
2. This development reference for target behavior.
3. Current repository APIs and scene composition.
4. Existing legacy behavior that is outside this scope.

When the repository has moved since the verified baseline:

- do not reset or revert unrelated work;
- do not overwrite newer scene changes;
- preserve working Player, Camera, SoulOrb and shard reward systems;
- implement the smallest compatible adaptation;
- record every material deviation in the final implementation report.

No automatic merge is allowed.

---

## 2. Product goal

`Level_01` must become a complete, coherent opening chapter rather than a greybox route ending at a blocked Landmark.

The final player flow is:

```text
Start Level_01
→ collect Shard_01 and complete its reward sequence
→ collect Shard_02 and complete its reward sequence
→ stone barrier lowers
→ player reaches the Landmark
→ one-shot finale trigger starts
→ a restrained warm column of light rises from the Landmark
→ Level_01 finale text appears
→ player closes the finale text
→ a warm woven-light portal materializes beside the Landmark
→ player approaches the portal
→ interaction prompt appears
→ player presses E
→ short portal transition plays
→ Level_02 loads
```

The sequence must be emotionally warm, readable and polished, but not grandiose or visually aggressive.

---

## 3. Non-negotiable constraints

The implementation must not:

- break `SoulShard`;
- break `ShardRewardSequenceController`;
- break `ShardRewardOverlay`;
- break `SoulOrb`;
- break Player movement, interaction or animation;
- break Camera behavior;
- open the barrier on `reward_sequence_requested`;
- use `SoulOrb_Follow` creation as progression;
- put all responsibilities into one giant manager;
- hardcode `Level_02` inside a shared portal script;
- introduce a second competing portal system while the reusable `LevelPortal` already exists;
- use an opaque cylinder as the final beam visual;
- use a static grey portal placeholder;
- add high-cost volumetric effects or hundreds of particles;
- add SSAO or start another general optimization pass;
- require Blender for the beam or portal;
- use external copyrighted textures;
- merge a PR automatically.

---

## 4. Verified current repository facts

At the verified baseline:

### 4.1 Current Level_01 paths

```text
Level_01
├─ LevelManager
├─ BlockRoot
│  ├─ SoulOrb_World
│  ├─ Block_01_01_StartClearing
│  └─ SunLight_Block01
├─ PlayerRoot
│  └─ Player
├─ CameraRoot
│  └─ FollowCamera
├─ LevelRuntimeRoot
│  └─ ShardRewardSequenceController
├─ UILayer
│  └─ ShardRewardOverlay
├─ StepAssistRoot
├─ WorldEnvironment_Block01
├─ MainIsland01
├─ LandmarkIsland01
├─ Shard_01
├─ Shard_02
├─ Architecture
│  ├─ bridge sectors
│  └─ Ancient_Stone_Barrier_01
└─ Clouds
```

Verified NodePaths from `Level_01` root:

```text
Shard_01
Shard_02
Architecture/Ancient_Stone_Barrier_01
LandmarkIsland01
LevelRuntimeRoot/ShardRewardSequenceController
UILayer/ShardRewardOverlay
PlayerRoot/Player
```

### 4.2 Current shard completion contract

`SoulShard` exposes:

```gdscript
signal collected
signal reward_sequence_requested(
    shard: Node,
    shard_id: StringName,
    reward_text: String,
    world_position: Vector3
)
```

The correct final completion signal is:

```text
collected
```

`collected` is emitted only inside `complete_collection_sequence()`, after the reward overlay and the return-to-SoulOrb sequence.

### 4.3 Current Player interaction contract

Player:

- listens to the existing input action `interact`;
- searches group `player_interactable`;
- calls `can_player_interact(player)`;
- calls `interact(player)` on the best valid nearby interactable.

The portal must use this contract. It must not add a competing `Input.is_action_just_pressed("interact")` polling loop.

### 4.4 Existing portal compatibility

The repository already contains:

```text
res://scenes/core/LevelPortal.tscn
res://scripts/core/level_portal.gd
```

Current public compatibility points:

```gdscript
@export var target_scene_path: String
func activate() -> void
```

The improved portal must retain these public points so existing `LevelManager` and level scenes do not break.

### 4.5 Existing performance baseline

Accepted current settings:

```text
Camera Far = 60

DirectionalLight3D:
Shadow Enabled = ON
Directional Shadow Max Distance = 25
Directional Shadow Mode = PSSM 2 Splits

SSAO = OFF
Glow = ON
```

Expected real-play baseline:

```text
approximately 55-60 FPS
```

Only new VFX may be optimized during this task. No general rendering rework is in scope.

---

## 5. Target architecture

Use scene composition and explicit signals.

```text
Level_01
├─ LevelRuntimeRoot
│  ├─ ShardRewardSequenceController
│  ├─ Level01ProgressionController
│  └─ Level01FinaleController
├─ LandmarkFinaleRoot
│  ├─ FinaleApproachMarker
│  ├─ FinaleTrigger
│  │  └─ CollisionShape3D
│  ├─ LandmarkLightAnchor
│  │  └─ LandmarkLightColumn
│  └─ PortalAnchor
│     └─ LevelPortal
└─ UILayer
   ├─ ShardRewardOverlay
   └─ LevelFinaleOverlay
```

The exact parent of the Landmark markers may be the `LandmarkIsland01` wrapper if that produces clearer local positioning. The behavior and path ownership are more important than the exact parent.

### 5.1 Responsibility boundaries

#### Level01ProgressionController

Owns:

- explicit required shard references;
- unique completed-shard tracking;
- barrier state;
- barrier lowering Tween;
- progression readiness query;
- signals for requirements satisfied and barrier opened.

Does not own:

- reward overlay;
- SoulOrb;
- Landmark Area3D;
- finale text;
- light-column internals;
- portal visuals;
- scene loading.

#### Level01FinaleController

Owns:

- Landmark trigger gating;
- one-shot finale state;
- Player control locking during the finale;
- light-column sequence orchestration;
- finale overlay orchestration;
- portal activation after overlay completion.

Does not own:

- shard reward sequence;
- barrier animation details;
- portal rendering internals;
- scene loading internals.

#### LandmarkLightColumn

Owns:

- warm beam visuals;
- beam reveal and settle animation;
- restrained falling light particles;
- ground ring;
- local Landmark glow;
- its own appearance completion signal.

#### LevelFinaleOverlay

Owns:

- presentation of Level_01 finale text;
- opening and closing animation;
- confirmation interaction;
- closed signal.

It must not reuse or mutate the active `ShardRewardOverlay` state.

#### LevelPortal

Owns:

- reusable portal visual state;
- materialization animation;
- interaction range;
- interaction prompt;
- one-shot entry;
- transition veil;
- target scene loading.

---

## 6. Global state model

### 6.1 Progression state

```gdscript
enum BarrierState {
    LOCKED,
    OPEN_PENDING,
    OPENING,
    OPEN,
}
```

Transitions:

```text
LOCKED
→ second unique required shard emits collected
→ OPEN_PENDING
→ deferred open call
→ OPENING
→ Tween completed
→ OPEN
```

No reverse transition is required inside one scene run.

### 6.2 Finale state

```gdscript
enum FinaleState {
    LOCKED,
    ARMED,
    STARTING,
    SHOWING_TEXT,
    ACTIVATING_PORTAL,
    COMPLETE,
}
```

Transitions:

```text
LOCKED
→ barrier_opened
→ ARMED
→ valid player entry
→ STARTING
→ beam appearance completed
→ SHOWING_TEXT
→ overlay closed
→ ACTIVATING_PORTAL
→ portal activation completed
→ COMPLETE
```

### 6.3 Portal state

```gdscript
enum PortalState {
    INACTIVE,
    ACTIVATING,
    ACTIVE,
    ENTERING,
}
```

Transitions:

```text
INACTIVE
→ activate()
→ ACTIVATING
→ materialization completed
→ ACTIVE
→ valid interaction or compatibility auto-entry
→ ENTERING
→ change_scene_to_file(target_scene_path)
```

No second entry may start after `ENTERING`.

---

## 7. File plan

Expected target files:

### New files

```text
scripts/levels/level_01_progression_controller.gd
scripts/levels/level_01_finale_controller.gd

scenes/environment/vfx/LandmarkLightColumn.tscn
scripts/environment/vfx/landmark_light_column.gd
shaders/vfx/landmark_light_beam.gdshader
shaders/vfx/landmark_ground_ring.gdshader
resources/vfx/landmark_light_noise.tres
resources/vfx/landmark_particle_gradient.tres

scenes/ui/LevelFinaleOverlay.tscn
scripts/ui/level_finale_overlay.gd

shaders/vfx/level_portal_surface.gdshader
shaders/vfx/level_portal_ring.gdshader
shaders/vfx/level_portal_ground_ring.gdshader
resources/vfx/level_portal_swirl_noise.tres
resources/vfx/level_portal_particle_gradient.tres
```

### Modified files

```text
scenes/levels/Level_01.tscn
scenes/levels/level_01/blocks/Landmark_Island_01.tscn
scenes/core/LevelPortal.tscn
scripts/core/level_portal.gd
```

Only modify additional files when the repository state proves it necessary. Every extra file must be justified in the final report.

### Files that must not be modified without a demonstrated blocker

```text
scripts/soul/soul_shard.gd
scripts/core/shard_reward_sequence_controller.gd
scripts/player/player_controller.gd
scripts/player/camera_controller.gd
scenes/core/Player.tscn
scenes/core/SoulOrb_World.tscn
scripts/ui/shard_reward_overlay.gd
scenes/ui/ShardRewardOverlay.tscn
```

---

# PART A - BARRIER PROGRESSION

## 8. Level01ProgressionController contract

Recommended script:

```text
res://scripts/levels/level_01_progression_controller.gd
```

Base type:

```gdscript
extends Node
class_name Level01ProgressionController
```

### 8.1 Signals

```gdscript
signal all_required_shards_collected
signal barrier_opening_started
signal barrier_opened
```

### 8.2 Export parameters

```gdscript
@export var required_shard_paths: Array[NodePath] = []
@export var barrier_path: NodePath
@export var barrier_open_offset: Vector3 = Vector3(0.0, -7.0, 0.0)
@export_range(0.1, 10.0, 0.1) var barrier_open_duration: float = 2.5
```

Optional, only when useful for tuning:

```gdscript
@export var barrier_transition: Tween.TransitionType = Tween.TRANS_SINE
@export var barrier_ease: Tween.EaseType = Tween.EASE_IN_OUT
```

Do not export unnecessary portal or finale references from this controller.

### 8.3 Internal state

```gdscript
var _barrier_state := BarrierState.LOCKED
var _required_shards: Array[Node] = []
var _collected_shard_ids: Dictionary = {}
var _barrier: Node3D
var _barrier_tween: Tween
var _configuration_valid := false
```

### 8.4 Initialization rules

`_ready()` must:

1. resolve the barrier path;
2. require the barrier to be `Node3D`;
3. require at least one shard path;
4. resolve every required shard path;
5. verify every shard has signal `collected`;
6. reject duplicate node references;
7. connect each signal with the shard bound into the callback;
8. set `_configuration_valid = true` only after all checks pass.

Configuration errors must fail closed.

Incorrect behavior:

```text
Shard_02 path missing
→ controller silently treats one shard as enough
→ barrier opens after Shard_01
```

Required behavior:

```text
Shard_02 path missing
→ clear push_error
→ configuration remains invalid
→ barrier never opens
```

### 8.5 Shard tracking

Use node instance IDs, not string names:

```gdscript
func _on_required_shard_collected(shard: Node) -> void:
    var instance_id := shard.get_instance_id()
```

A shard is counted only once.

The open condition is:

```gdscript
_collected_shard_ids.size() == _required_shards.size()
```

### 8.6 Deferred open requirement

When the last required shard emits `collected`:

```gdscript
_barrier_state = BarrierState.OPEN_PENDING
all_required_shards_collected.emit()
call_deferred("_begin_barrier_opening")
```

Reason:

`collected` is emitted inside `ShardRewardSequenceController` completion. Deferred opening allows the reward controller to finish its callback and restore Player controls before the barrier starts moving.

### 8.7 Barrier Tween

Move the root node:

```text
Architecture/Ancient_Stone_Barrier_01
```

Do not animate only `VisualRoot`.

Target:

```gdscript
var target_position := _barrier.position + barrier_open_offset
```

Animation:

```gdscript
_barrier_tween = create_tween()
_barrier_tween.set_trans(Tween.TRANS_SINE)
_barrier_tween.set_ease(Tween.EASE_IN_OUT)
_barrier_tween.tween_property(
    _barrier,
    "position",
    target_position,
    barrier_open_duration
)
```

On start:

```gdscript
barrier_opening_started.emit()
```

On completion:

```gdscript
_barrier_state = BarrierState.OPEN
barrier_opened.emit()
```

### 8.8 Progression query API

Expose:

```gdscript
func are_all_required_shards_collected() -> bool
func is_barrier_open() -> bool
func is_finale_unlocked() -> bool
```

`is_finale_unlocked()` returns true only when the barrier is fully open.

### 8.9 Inspector setup

Node:

```text
Level_01/LevelRuntimeRoot/Level01ProgressionController
```

Paths relative to this node:

```text
required_shard_paths[0] = ../../Shard_01
required_shard_paths[1] = ../../Shard_02
barrier_path = ../../Architecture/Ancient_Stone_Barrier_01
barrier_open_offset = (0, -7, 0)
barrier_open_duration = 2.5
```

`-7` is the starting value. Final value must be adjusted with visible collision shapes so the full passage is physically clear.

### 8.10 Barrier acceptance criteria

- Shard_01 alone does not open the barrier.
- Shard_02 alone does not open the barrier.
- Order 1 → 2 opens the barrier.
- Order 2 → 1 opens the barrier.
- The barrier remains still during Charge Anticipation.
- The barrier remains still during burst.
- The barrier remains still while `ShardRewardOverlay` is active.
- The barrier remains still during return-to-SoulOrb.
- It starts after the second final `collected`.
- It opens only once.
- Visual and collision move together.
- No invisible collision remains in the passage.
- The Player is not trapped or launched by Jolt.

---

# PART B - LANDMARK FINALE GATE

## 9. Landmark wrapper additions

The Landmark wrapper is:

```text
res://scenes/levels/level_01/blocks/Landmark_Island_01.tscn
```

Add level-specific placement markers. Recommended structure:

```text
LandmarkIsland01
├─ existing content
└─ FinaleMarkers
   ├─ FinaleApproachMarker
   ├─ FinaleTriggerMarker
   ├─ LandmarkLightAnchor
   └─ PortalAnchor
```

Starting local positions are guidance, not immutable art values:

```text
FinaleApproachMarker:
approximately (-0.65, 6.3, 3.5)

FinaleTriggerMarker:
approximately (-0.65, 6.3, -2.0)

LandmarkLightAnchor:
approximately (-0.65, 8.1, -10.33)

PortalAnchor:
approximately (4.4, 6.4, -5.5)
```

These coordinates are derived from the current Landmark composition and route direction. They must be validated against terrain and collision in the editor.

The light anchor must be centered on the Landmark, not merely at the island origin.

The portal anchor must:

- be on a stable walkable surface;
- be offset from the beam;
- not overlap the Landmark mesh;
- not overlap a tree, lantern, rock or bush;
- have enough space for the portal frame and the Player capsule;
- face the route from the trigger area.

## 10. Finale trigger structure

Recommended in `Level_01.tscn`:

```text
LandmarkFinaleRoot
├─ FinaleTrigger
│  └─ CollisionShape3D
├─ LandmarkLightColumn
└─ LevelPortal
```

Alternatively, instantiate these under marker nodes in the Landmark wrapper.

Trigger shape:

```text
BoxShape3D
size approximately (3.0, 2.0, 2.6)
```

The trigger must be compact enough that it cannot be entered from below through island geometry.

### 10.1 Trigger safety checks

A body is accepted only when all are true:

```text
body is CharacterBody3D
body.name == "Player"
finale state == ARMED
progression controller is valid
progression.is_finale_unlocked() == true
body is not substantially below trigger height
body entered from the approach side
finale has never started
```

Recommended height check:

```gdscript
@export var minimum_player_y_offset: float = -0.75
```

Recommended directional check:

```text
forward = normalized(trigger - approach marker)
signed_side = dot(player_position - trigger_position, forward)
accept only when signed_side <= approach_side_tolerance
```

Recommended tolerance:

```gdscript
@export var approach_side_tolerance: float = 0.35
```

This prevents a player entering from the far side from triggering the sequence.

### 10.2 Trigger lifecycle

Before barrier completion:

```text
monitoring may remain enabled,
but controller state is LOCKED and entry is rejected
```

After `barrier_opened`:

```text
state = ARMED
```

On valid entry:

```text
state = STARTING
monitoring = false
collision disabled deferred
```

The trigger never re-enables in the same scene run.

---

# PART C - LANDMARK LIGHT COLUMN

## 11. Visual direction

The effect is a restrained warm column of light emerging from the Landmark and reaching upward.

It must communicate:

```text
the place has awakened
the collected light has reached its destination
the chapter is complete
```

It must not communicate:

```text
boss fight
divine judgement
explosion
teleport strike
stage spotlight
```

The beam should be visible, elegant and readable, but remain secondary to the finale text and portal.

### 11.1 Color palette

Use this target palette:

```text
Core ivory:
#FFF2C8
linear-style working value approximately Color(1.00, 0.89, 0.64)

Warm gold:
#F6B95E
approximately Color(1.00, 0.58, 0.24)

Soft amber:
#D9843E
approximately Color(0.78, 0.30, 0.09)

Faint blush accent:
#F3A887
approximately Color(0.90, 0.42, 0.27)
```

Avoid saturated yellow and pure white over large areas.

### 11.2 Scene structure

```text
LandmarkLightColumn - Node3D
├─ BeamRoot - Node3D
│  ├─ BeamSoftA - MeshInstance3D
│  ├─ BeamSoftB - MeshInstance3D
│  ├─ BeamCore - MeshInstance3D
│  └─ BeamHalo - MeshInstance3D
├─ GroundRingRoot - Node3D
│  ├─ GroundRingOuter - MeshInstance3D
│  └─ GroundRingInner - MeshInstance3D
├─ FallingMotes - GPUParticles3D
├─ RisingMotes - GPUParticles3D
├─ LandmarkGlow - OmniLight3D
└─ AnimationPlayer or script-driven Tween
```

Use Tween for activation and a minimal `_process()` only while active for gentle idle motion. AnimationPlayer is allowed if it produces cleaner property animation. Do not run per-frame scene-tree searches.

### 11.3 Beam geometry

#### BeamSoftA and BeamSoftB

Use two crossed `QuadMesh` planes:

```text
height: 30-34 m
width: 1.6-2.0 m
```

Each plane:

- centered vertically at half its height;
- root pivot remains at the Landmark base;
- one plane rotates around Y by approximately `0°`;
- the other rotates around Y by approximately `90°`;
- uses additive transparent unshaded beam shader;
- casts no shadow.

The crossed planes remove the flat-card appearance without using expensive volume rendering.

#### BeamCore

Use:

- a narrower crossed pair or a thin `CylinderMesh`;
- width or diameter approximately `0.35-0.5 m`;
- lower alpha than an opaque solid;
- higher emission than outer beam;
- no shadow.

#### BeamHalo

Use:

- a very soft outer cylinder or crossed planes;
- diameter approximately `2.2-2.8 m`;
- alpha below `0.08`;
- emission below the core;
- optional and removable if it causes sorting artifacts.

### 11.4 Beam procedural texture

Create:

```text
res://resources/vfx/landmark_light_noise.tres
```

Recommended resource:

```text
NoiseTexture2D
width = 256
height = 256
seamless = true
normalize = true
generate_mipmaps = true
noise = FastNoiseLite
```

Recommended FastNoiseLite values:

```text
noise_type = Simplex Smooth or Perlin
frequency = 0.018
fractal_type = FBM
fractal_octaves = 3
fractal_lacunarity = 2.0
fractal_gain = 0.48
```

This is a real reusable procedural texture, not a placeholder image.

### 11.5 Beam shader

Create:

```text
res://shaders/vfx/landmark_light_beam.gdshader
```

Target implementation:

```glsl
shader_type spatial;
render_mode unshaded, cull_disabled, blend_add, depth_draw_never;

uniform sampler2D noise_texture : repeat_enable, filter_linear_mipmap;
uniform vec4 beam_color : source_color = vec4(1.0, 0.76, 0.36, 1.0);
uniform float opacity : hint_range(0.0, 1.0) = 0.0;
uniform float emission_strength : hint_range(0.0, 4.0) = 1.0;
uniform float scroll_speed : hint_range(-0.2, 0.2) = 0.026;
uniform float edge_softness : hint_range(0.05, 0.9) = 0.34;
uniform float breakup_amount : hint_range(0.0, 1.0) = 0.22;
uniform float pulse_amount : hint_range(0.0, 0.3) = 0.06;
uniform float pulse_speed : hint_range(0.0, 4.0) = 1.05;

void fragment() {
    vec2 uv = UV;
    float center_distance = abs(uv.x - 0.5) * 2.0;
    float horizontal_mask = 1.0 - smoothstep(
        max(0.0, 1.0 - edge_softness),
        1.0,
        center_distance
    );

    float bottom_fade = smoothstep(0.0, 0.08, uv.y);
    float top_fade = 1.0 - smoothstep(0.86, 1.0, uv.y);
    float vertical_mask = bottom_fade * top_fade;

    vec2 noise_uv = vec2(uv.x * 1.7, uv.y * 2.6 - TIME * scroll_speed);
    float noise_value = texture(noise_texture, noise_uv).r;
    float breakup = mix(1.0, 0.70 + noise_value * 0.30, breakup_amount);
    float pulse = 1.0 + sin(TIME * pulse_speed) * pulse_amount;

    float final_alpha = horizontal_mask * vertical_mask * breakup * opacity;
    ALBEDO = beam_color.rgb;
    EMISSION = beam_color.rgb * emission_strength * pulse;
    ALPHA = final_alpha;
}
```

Codex may correct syntax or mask math for Godot 4.6, but the visual result and parameters are mandatory.

### 11.6 Ground ring

Use horizontal `QuadMesh` or thin `CylinderMesh` discs with a radial shader.

Create:

```text
res://shaders/vfx/landmark_ground_ring.gdshader
```

Requirements:

- additive unshaded;
- radial ring derived from UV, not a flat square;
- soft inner and outer edge;
- slow outward drift in noise;
- target diameter approximately `3.5-4.5 m`;
- target alpha approximately `0.12-0.22`;
- no shadow.

The ground ring must visually bind the beam to the Landmark and prevent the effect from looking like a detached tube.

### 11.7 Falling particles

Primary particle behavior requested by the visual concept:

```text
small warm light particles emerge around the beam
and gently fall downward
```

`FallingMotes` target:

```text
amount = 18-24
lifetime = 4.0-5.5 s
one_shot = false
randomness = 0.55
visibility_aabb = explicitly bounded
emission shape = box or cylinder around upper and middle beam
initial velocity Y = -0.18 to -0.55
gravity Y = -0.04 to -0.10
scale = 0.025 to 0.075
angular velocity = low
color ramp = ivory → warm gold → transparent
```

Particles must drift slightly sideways. They must not resemble sparks or rain.

### 11.8 Rising particles

Optional low-density support:

```text
amount = 6-10
lifetime = 2.5-3.5 s
initial velocity Y = 0.15-0.35
scale = 0.02-0.05
alpha lower than FallingMotes
```

Remove this emitter if it makes the effect busy.

### 11.9 Particle texture

Create a procedural particle draw-pass texture:

- small `QuadMesh`;
- material uses a soft radial alpha mask from UV;
- no external PNG required;
- warm emission;
- additive blend;
- no shadow.

Create a `GradientTexture1D` resource:

```text
res://resources/vfx/landmark_particle_gradient.tres
```

Color sequence:

```text
0.00: transparent warm ivory
0.15: soft ivory at alpha 0.75
0.55: warm gold at alpha 0.48
1.00: amber transparent
```

### 11.10 LandmarkGlow

Use one `OmniLight3D`:

```text
shadow_enabled = false
omni_range = 5.0-7.0
light_energy target = 0.45-0.75
light_color = warm ivory-gold
distance_fade_enabled = true
```

The light must fade with distance and must not add a new shadow pass.

### 11.11 Light-column animation

Initial state:

```text
root visible = false
beam opacity = 0
beam root scale.y = 0.06
ground ring alpha = 0
ground ring scale = 0.55
particle emission = false
LandmarkGlow energy = 0
```

Activation sequence:

```text
0.00 s:
show root
reset all visual state

0.00-0.35 s:
ground ring scale 0.55 → 1.0
ground ring alpha 0 → target

0.12-1.35 s:
beam root scale.y 0.06 → 1.0
beam outer opacity 0 → 0.18-0.24
beam core opacity 0 → 0.36-0.50
use TRANS_SINE, EASE_OUT

0.45 s:
enable FallingMotes
optionally enable RisingMotes

0.35-1.10 s:
LandmarkGlow energy 0 → target

1.35-1.60 s:
settle emission and opacity down by approximately 8-12 percent

1.60 s:
emit appearance_completed
```

Idle after activation:

```text
beam opacity pulse amplitude <= 0.06
pulse period approximately 4.5-5.5 s
ground ring rotation <= 0.025 rad/s
particle rates remain stable
```

The idle effect must not continuously allocate nodes or materials.

### 11.12 Beam public API

```gdscript
signal appearance_completed

func play_appearance() -> void
func set_active_immediately() -> void
func deactivate_immediately() -> void
func is_active() -> bool
```

`play_appearance()` must be idempotent.

---

# PART D - LEVEL FINALE OVERLAY

## 12. Overlay purpose

The finale overlay is separate from `ShardRewardOverlay`.

Reason:

- shard overlay has return-to-SoulOrb logic;
- finale overlay has no shard return;
- finale text belongs to the whole level;
- reusing the shard overlay would couple unrelated state and risk regression.

### 12.1 Scene

```text
res://scenes/ui/LevelFinaleOverlay.tscn
```

Suggested structure:

```text
LevelFinaleOverlay - Control
├─ Atmosphere
│  ├─ MatteVeil
│  └─ WarmWash
├─ LightFrame
├─ TextRoot
│  └─ FinaleText
└─ ConfirmRoot
   └─ ConfirmButton
```

Reuse existing fonts and button textures where legally and technically appropriate:

```text
Cormorant Garamond project fonts
assets/ui/shard_reward_overlay/button_idle.png
assets/ui/shard_reward_overlay/button_hovered.png
assets/ui/shard_reward_overlay/button_pressed.png
```

Do not duplicate large textures unnecessarily.

### 12.2 Visual target

Compared with `ShardRewardOverlay`, the finale overlay should be quieter:

- veil alpha approximately `0.46-0.56`, not `0.62+`;
- warm wash alpha approximately `0.08-0.12`;
- no dense 72-particle frame;
- use two or four restrained corner glows or short light vines;
- text remains the focus;
- no full-screen flash.

### 12.3 Text

Controller export:

```gdscript
@export_multiline var finale_text: String = "Ты появилась - и мой мир стал теплее."
```

This is the safe provisional Level_01 line. It may be replaced later in Inspector without code changes.

Do not embed the text permanently inside the overlay scene.

### 12.4 Overlay API

```gdscript
signal closed

func show_finale(text: String) -> void
func close_finale() -> void
func reset_overlay() -> void
func is_open() -> bool
```

### 12.5 Opening animation

Target:

```text
0.00-0.45 s:
veil and warm wash fade in

0.18-0.90 s:
small corner light details appear

0.30-1.55 s:
text reveals by line or by visible_ratio
minimum reveal duration 1.0 s
maximum reveal duration 2.2 s

after text reveal:
confirmation button enables
button grabs focus
```

### 12.6 Closing animation

Target:

```text
button confirm feedback 0.12-0.18 s
text fade 0.35-0.55 s
corner light fade 0.45-0.70 s
veil fade 0.55-0.80 s
emit closed only when overlay no longer blocks the screen
```

### 12.7 Input

Mouse confirmation is required.

Keyboard confirmation may use an existing UI accept action when available, but must not add a second gameplay `interact` poll that conflicts with Player. Button focus and Enter/Space through Godot UI are sufficient.

### 12.8 Overlay safety

While visible:

- root mouse filter blocks gameplay mouse input;
- Player controls are already disabled by finale controller;
- repeated `show_finale()` calls are ignored or safely restart only from reset state;
- repeated close events emit `closed` once.

---

# PART E - LEVEL 01 FINALE CONTROLLER

## 13. Level01FinaleController contract

Script:

```text
res://scripts/levels/level_01_finale_controller.gd
```

Base:

```gdscript
extends Node
class_name Level01FinaleController
```

### 13.1 Export parameters

```gdscript
@export var progression_controller_path: NodePath
@export var player_path: NodePath
@export var trigger_area_path: NodePath
@export var trigger_collision_path: NodePath
@export var approach_marker_path: NodePath
@export var light_column_path: NodePath
@export var finale_overlay_path: NodePath
@export var portal_path: NodePath
@export_multiline var finale_text: String = "Ты появилась - и мой мир стал теплее."
@export var minimum_player_y_offset: float = -0.75
@export var approach_side_tolerance: float = 0.35
@export_range(0.0, 3.0, 0.05) var text_delay_after_beam: float = 0.20
```

### 13.2 Initialization

Resolve all explicit paths. Fail closed on missing progression, trigger, light column, overlay or portal.

Player may be resolved explicitly and cached.

Connect:

```text
progression.barrier_opened
trigger.body_entered
light_column.appearance_completed
finale_overlay.closed
portal.activation_completed
```

### 13.3 Arming

On `barrier_opened`:

```gdscript
_state = FinaleState.ARMED
```

Do not auto-start the finale at barrier completion.

### 13.4 Valid trigger

On valid Player entry:

```text
state = STARTING
disable trigger
disable Player controls
hide any portal prompt
start light column appearance
```

The existing Player method must be used:

```gdscript
player.set_controls_enabled(false)
```

Do not write directly to Player velocity or input state beyond the public method.

### 13.5 Beam to text

When light appearance completes:

```text
wait text_delay_after_beam
state = SHOWING_TEXT
overlay.show_finale(finale_text)
```

If light scene is missing due to a non-production fallback, show text safely and record an error. Production acceptance still requires the light scene.

### 13.6 Text to portal

When overlay emits `closed`:

```text
state = ACTIVATING_PORTAL
portal.activate()
```

Keep Player controls disabled while the portal materializes.

When portal emits `activation_completed`:

```text
state = COMPLETE
player.set_controls_enabled(true)
```

The Player must regain control only after the portal is active and safe to approach.

### 13.7 Reload behavior

Reloading `Level_01` resets all runtime state:

- barrier locked;
- shards visible;
- finale locked;
- beam hidden;
- portal inactive;
- overlay hidden.

No persistent save logic is added in this task.

---

# PART F - REUSABLE PRE-END LEVEL PORTAL

## 14. Visual concept: Woven Light Vortex

The portal is a slow clockwise vortex made of warm light strands.

It is thematically connected to:

- SoulShard crystal glow;
- SoulOrb warmth;
- the Landmark beam;
- natural and ancient magical motifs.

It must not resemble:

- a sci-fi gate;
- a black hole;
- a blue MMO dungeon portal;
- a hard opaque disc;
- a rapid combat spell.

### 14.1 Palette

```text
Portal core ivory:
Color(1.00, 0.91, 0.69)

Main warm gold:
Color(1.00, 0.63, 0.28)

Outer amber:
Color(0.84, 0.36, 0.12)

Soft rose accent:
Color(0.92, 0.46, 0.30)

Dark transparent backing:
Color(0.10, 0.055, 0.045, 0.24)
```

The overall perceived motion is clockwise.

### 14.2 Compatibility entry mode

Add:

```gdscript
enum EntryMode {
    AUTO_ENTER,
    INTERACT,
}

@export var entry_mode := EntryMode.AUTO_ENTER
```

Default remains `AUTO_ENTER` to preserve existing greybox levels.

The `Level_01` portal instance must override:

```text
entry_mode = INTERACT
```

Future levels may migrate explicitly.

### 14.3 Updated scene structure

Refactor the existing:

```text
res://scenes/core/LevelPortal.tscn
```

Target:

```text
LevelPortal - Node3D
├─ VisualRoot - Node3D
│  ├─ GroundRing - MeshInstance3D
│  ├─ OuterRing - MeshInstance3D
│  ├─ InnerRing - MeshInstance3D
│  ├─ PortalSurface - MeshInstance3D
│  ├─ BackVeil - MeshInstance3D
│  ├─ OrbitMotes - GPUParticles3D
│  └─ PortalLight - OmniLight3D
├─ FrameCollisionRoot - Node3D
│  ├─ optional left/right frame collisions
├─ InteractionArea - Area3D
│  └─ CollisionShape3D
├─ PromptAnchor - Marker3D
├─ WorldInteractionPrompt
└─ TransitionLayer - CanvasLayer
   └─ TransitionVeil - ColorRect
```

The old rectangular grey frame may be removed or transformed into a subtle stone-light base only if doing so does not break collision placement.

A full 3D external model is not required.

### 14.4 Geometry

#### OuterRing

Use `TorusMesh`:

```text
major radius approximately 1.15-1.30
minor radius approximately 0.055-0.085
vertical orientation
```

#### InnerRing

Use a second `TorusMesh`:

```text
major radius approximately 0.92-1.05
minor radius approximately 0.025-0.050
slightly different scale and rotation
```

Both rings use warm emissive transparent shaders and no shadows.

#### PortalSurface

Use vertical `QuadMesh`:

```text
size approximately 2.0 × 2.45
double-sided shader
bottom approximately 0.15 above ground
```

The plane must face the expected approach route.

#### BackVeil

Use a second plane a few centimeters behind PortalSurface:

- darker low-alpha backing;
- prevents distant world geometry from making the vortex unreadable;
- alpha below `0.18`;
- no opaque center.

### 14.5 Portal procedural texture

Create:

```text
res://resources/vfx/level_portal_swirl_noise.tres
```

Recommended:

```text
NoiseTexture2D
width = 256
height = 256
seamless = true
normalize = true
generate_mipmaps = true
noise = FastNoiseLite
```

FastNoiseLite:

```text
noise_type = Simplex Smooth
frequency = 0.022
fractal_type = FBM
fractal_octaves = 4
fractal_lacunarity = 2.05
fractal_gain = 0.46
```

### 14.6 Portal surface shader

Create:

```text
res://shaders/vfx/level_portal_surface.gdshader
```

Target shader:

```glsl
shader_type spatial;
render_mode unshaded, cull_disabled, blend_add, depth_draw_never;

uniform sampler2D swirl_noise : repeat_enable, filter_linear_mipmap;
uniform vec4 core_color : source_color = vec4(1.0, 0.91, 0.69, 1.0);
uniform vec4 strand_color : source_color = vec4(1.0, 0.58, 0.22, 1.0);
uniform float activation : hint_range(0.0, 1.0) = 0.0;
uniform float clockwise_speed : hint_range(0.0, 0.2) = 0.055;
uniform float distortion_strength : hint_range(0.0, 1.0) = 0.42;
uniform float strand_density : hint_range(1.0, 12.0) = 5.0;
uniform float base_alpha : hint_range(0.0, 1.0) = 0.14;
uniform float strand_alpha : hint_range(0.0, 1.0) = 0.34;
uniform float emission_strength : hint_range(0.0, 5.0) = 1.15;

void fragment() {
    vec2 p = UV - vec2(0.5);
    p.x *= 0.84;

    float radius = length(p) * 2.0;
    float angle = atan(p.y, p.x);

    float angular_uv = fract(
        angle / TAU
        - TIME * clockwise_speed
        + radius * distortion_strength
    );

    vec2 noise_uv = vec2(
        angular_uv * 2.0,
        radius * 1.6 - TIME * 0.018
    );

    float noise_value = texture(swirl_noise, noise_uv).r;
    float wave = sin(
        angle * strand_density
        - radius * 8.0
        - TIME * clockwise_speed * TAU * 2.0
    ) * 0.5 + 0.5;

    float disc_mask = 1.0 - smoothstep(0.78, 1.0, radius);
    float center_softness = smoothstep(0.04, 0.25, radius);
    float edge_glow = smoothstep(0.46, 0.92, radius)
        * (1.0 - smoothstep(0.88, 1.0, radius));

    float strand = smoothstep(
        0.58,
        0.84,
        noise_value * 0.58 + wave * 0.42
    );

    vec3 color = mix(core_color.rgb, strand_color.rgb, radius);
    float alpha = disc_mask * (
        base_alpha
        + strand * strand_alpha
        + edge_glow * 0.18
    ) * center_softness * activation;

    ALBEDO = color;
    EMISSION = color * emission_strength * (
        0.72 + strand * 0.45 + edge_glow * 0.35
    );
    ALPHA = alpha;
}
```

Codex may adjust for visual correctness and Godot shader parsing. The mandatory result is a soft, readable, slowly clockwise swirling portal.

### 14.7 Ring shader

Create:

```text
res://shaders/vfx/level_portal_ring.gdshader
```

Requirements:

- unshaded additive;
- warm emission;
- noise breakup from the same swirl texture;
- `activation` uniform;
- soft pulse amplitude no more than `0.08`;
- no rapid UV motion;
- no shadow.

Perceived rotation:

```text
OuterRing: clockwise, one revolution approximately 18-24 s
InnerRing: clockwise, one revolution approximately 28-36 s
```

The inner ring may have a slight oscillating tilt, but must not counteract the main clockwise read.

### 14.8 Ground ring shader

Create:

```text
res://shaders/vfx/level_portal_ground_ring.gdshader
```

Requirements:

- radial ring from UV;
- warm amber with ivory center edge;
- target diameter approximately 2.6-3.2 m;
- alpha approximately 0.10-0.18;
- slow rotation;
- appears before the vertical portal surface during materialization.

### 14.9 Orbit particles

`OrbitMotes`:

```text
amount = 16-22
lifetime = 3.0-4.5 s
emission around ring
scale = 0.025-0.065
low tangential velocity
low radial movement
color ramp = warm gold → ivory → transparent
```

Avoid trails unless they are proven cheap and subtle.

Create:

```text
res://resources/vfx/level_portal_particle_gradient.tres
```

### 14.10 PortalLight

```text
OmniLight3D
shadow_enabled = false
omni_range = 4.0-5.5
light_energy active target = 0.35-0.60
distance_fade_enabled = true
```

No portal shadow pass.

---

## 15. Portal script contract

Retain:

```gdscript
@export_file("*.tscn") var target_scene_path: String
func activate() -> void
```

Add:

```gdscript
signal activation_started
signal activation_completed
signal transition_started

@export var entry_mode := EntryMode.AUTO_ENTER
@export var interaction_prompt_text: String = "Шагнуть к свету"
@export_range(0.1, 5.0, 0.05) var activation_duration: float = 1.65
@export_range(0.1, 3.0, 0.05) var transition_duration: float = 0.65
```

The existing generic WorldInteractionPrompt currently has fixed label text in its scene. Add a safe public setter:

```gdscript
func set_action_text(text: String) -> void
```

Only make this small change if needed. Existing behavior must remain unchanged when no custom text is supplied.

### 15.1 Portal initialization

Initial state:

```text
state = INACTIVE
VisualRoot hidden or alpha zero
InteractionArea monitoring false
collision disabled
prompt hidden
transition veil transparent and non-blocking
frame collision disabled unless explicitly required
```

### 15.2 Material duplication

Any material whose shader uniforms are animated at runtime must be duplicated per scene instance.

Do not mutate a shared material resource used by portals in several loaded scenes.

### 15.3 Activation animation

Target:

```text
0.00 s:
state = ACTIVATING
show VisualRoot
activation_started emit
ground ring visible

0.00-0.45 s:
ground ring scale 0.55 → 1.0
ground ring activation 0 → target

0.18-1.25 s:
OuterRing scale 0.65 → 1.0
InnerRing scale 0.72 → 1.0
ring activation 0 → 1

0.35-1.45 s:
PortalSurface activation 0 → 1
BackVeil alpha 0 → target

0.55 s:
OrbitMotes emitting true

0.40-1.20 s:
PortalLight energy 0 → target

1.25-1.65 s:
small settle, emission decreases by approximately 8 percent

1.65 s:
state = ACTIVE
enable InteractionArea
activation_completed emit
```

### 15.4 Active motion

Only while ACTIVE:

```text
OuterRing rotates clockwise slowly
InnerRing rotates clockwise more slowly
GroundRing rotates very slowly
shader TIME drives swirl
```

Disable `_process()` while INACTIVE. It may remain enabled while ACTIVATING, ACTIVE or ENTERING if required.

### 15.5 Interaction range

`InteractionArea` tracks Player entry and exit.

For `INTERACT` mode:

```text
on Player entered:
_player_in_range = true
show prompt only when state == ACTIVE

on Player exited:
_player_in_range = false
hide prompt
```

Portal root joins group:

```text
player_interactable
```

Implement:

```gdscript
func can_player_interact(player: Node) -> bool:
    return (
        entry_mode == EntryMode.INTERACT
        and _state == PortalState.ACTIVE
        and _player_in_range
        and not _is_loading_scene
    )

func interact(player: Node) -> void:
    if not can_player_interact(player):
        return
    _begin_entry(player)
```

For `AUTO_ENTER` compatibility:

```text
body_entered while ACTIVE starts entry automatically
```

### 15.6 Entry sequence

On valid entry:

```text
state = ENTERING
_is_loading_scene = true
disable InteractionArea
hide prompt with confirm feedback
disable Player controls through set_controls_enabled(false)
transition_started emit
brief portal emission pulse
fade TransitionVeil in
change scene once
```

Transition veil:

```text
color = warm dark brown or deep plum-black
target alpha = 1.0
duration approximately 0.55-0.75 s
```

Do not use a pure white flash.

### 15.7 Load failure recovery

If `change_scene_to_file()` returns an error:

```text
_is_loading_scene = false
state = ACTIVE
fade veil out
re-enable Player controls
re-enable InteractionArea
show prompt if Player is still in range
push_error with path and error code
```

### 15.8 Portal acceptance criteria

- inactive portal is hidden;
- inactive collision is disabled;
- `activate()` is idempotent;
- portal materializes, not pops in;
- swirl reads clockwise;
- movement is slow;
- prompt appears only in range and only when active;
- Level_01 portal requires E;
- repeated E cannot start multiple loads;
- target path is exported;
- transition loads `res://scenes/levels/Level_02.tscn`;
- load failure recovers safely;
- legacy AUTO_ENTER remains available;
- current calls to `activate()` still work.

---

# PART G - LEVEL 01 INTEGRATION

## 16. Level_01 scene setup

### 16.1 Runtime controllers

Under:

```text
LevelRuntimeRoot
```

add:

```text
Level01ProgressionController
Level01FinaleController
```

### 16.2 UI

Under:

```text
UILayer
```

add:

```text
LevelFinaleOverlay
```

It must start hidden.

### 16.3 Landmark finale root

Add or instance:

```text
LandmarkFinaleRoot
├─ FinaleTrigger
├─ LandmarkLightColumn
└─ LevelPortal
```

Use the Landmark wrapper markers for transforms where practical.

### 16.4 Portal instance values

```text
target_scene_path = res://scenes/levels/Level_02.tscn
entry_mode = INTERACT
interaction_prompt_text = Шагнуть к свету
```

The portal starts inactive.

### 16.5 Finale controller paths

Example paths from:

```text
Level_01/LevelRuntimeRoot/Level01FinaleController
```

Adjust to actual final tree:

```text
progression_controller_path =
../Level01ProgressionController

player_path =
../../PlayerRoot/Player

trigger_area_path =
../../LandmarkFinaleRoot/FinaleTrigger

trigger_collision_path =
../../LandmarkFinaleRoot/FinaleTrigger/CollisionShape3D

approach_marker_path =
../../LandmarkIsland01/FinaleMarkers/FinaleApproachMarker

light_column_path =
../../LandmarkFinaleRoot/LandmarkLightColumn

finale_overlay_path =
../../UILayer/LevelFinaleOverlay

portal_path =
../../LandmarkFinaleRoot/LevelPortal
```

### 16.6 Legacy LevelManager

The existing `LevelManager` in `Level_01` is legacy Stage 1D logic and does not fit the two-shard finale.

During this work:

- do not route the new finale through it;
- do not let it activate the new portal;
- remove it from `Level_01` only if repository inspection confirms it has no other current responsibility;
- otherwise leave it inert and record the known warnings;
- do not change the shared `level_manager.gd` solely for `Level_01`.

Preferred final result:

```text
Level_01 no longer depends on legacy LevelManager progression
other levels remain unchanged
```

---

# PART H - IMPLEMENTATION SLICES

## 17. Slice 0 - Mandatory preflight

No production changes before preflight.

Actions:

1. fetch latest remote state;
2. inspect current `main` head;
3. inspect open PRs related to these files;
4. ensure clean working tree;
5. inspect repository instruction files;
6. inspect all files listed in sections 4 and 7;
7. verify Godot 4.6 project imports;
8. verify exact current NodePaths;
9. verify `Level_02.tscn`;
10. verify existing portal API and all portal instances;
11. create a dedicated feature branch from latest `main`.

Recommended branch:

```text
feature/complete-level-01-finale-transition
```

Do not wait for approval after preflight. Continue to Slice 1 unless a destructive blocker exists.

---

## 18. Slice 1 - Two-shard barrier progression

Implement:

- `Level01ProgressionController`;
- explicit shard paths;
- unique collected tracking;
- deferred barrier opening;
- root barrier Tween;
- readiness query;
- signals;
- Level_01 integration.

Expected commit:

```text
Implement two-shard barrier progression for Level 01
```

Validation:

- script parse;
- scene parse;
- no unrelated files;
- order 1 → 2 and 2 → 1 logic inspection;
- reward sequence untouched;
- manual QA checklist added to working notes.

Do not start Slice 2 until Slice 1 passes available validation.

---

## 19. Slice 2 - Landmark gate and finale state foundation

Implement:

- Landmark marker nodes;
- FinaleTrigger;
- trigger shape;
- `Level01FinaleController` state foundation;
- arming only after `barrier_opened`;
- height and direction checks;
- one-shot trigger;
- temporary safe hooks for future light, overlay and portal nodes.

The slice must not use visible placeholder cubes.

Expected commit:

```text
Add gated one-shot Landmark finale trigger
```

Validation:

- trigger cannot start while LOCKED;
- trigger cannot repeat;
- below-side entry rejected;
- far-side entry rejected;
- Player control lock API used;
- no portal loading yet.

---

## 20. Slice 3 - Pre-end Landmark light column

Implement all beam resources, shaders, materials, particles, scene and script from Part C.

Integrate it with `Level01FinaleController`.

Expected commit:

```text
Create polished Landmark light column finale effect
```

Validation:

- no opaque tube;
- procedural texture resource exists;
- appearance animation completes once;
- particles bounded;
- no shadow-casting new light;
- effect starts from Landmark center;
- effect remains restrained;
- no constant processing while inactive.

---

## 21. Slice 4 - Level finale overlay and sequence

Implement:

- `LevelFinaleOverlay.tscn`;
- `level_finale_overlay.gd`;
- separate finale text API;
- opening and closing animation;
- one-shot closed signal;
- full beam → text sequence;
- control lock maintained until portal active.

Expected commit:

```text
Add Level 01 finale overlay and sequence
```

Validation:

- does not call shard return logic;
- does not mutate ShardRewardOverlay;
- text comes from controller export;
- button cannot close before reveal completes;
- overlay blocks mouse safely;
- closed emits once.

---

## 22. Slice 5 - Reusable pre-end LevelPortal V2

Refactor the existing reusable portal while preserving compatibility.

Implement:

- portal states;
- backward-compatible `activate()`;
- `EntryMode`;
- procedural swirl and ring textures;
- shaders;
- ring geometry;
- portal surface;
- particles;
- light;
- materialization;
- interaction prompt setter if required;
- Player interaction contract;
- AUTO_ENTER compatibility;
- transition veil;
- load failure recovery.

Expected commit:

```text
Upgrade reusable LevelPortal with woven-light vortex
```

Validation:

- existing portal scene instances still parse;
- existing `target_scene_path` assignments remain valid;
- existing LevelManager `activate()` calls remain valid;
- default AUTO_ENTER preserves legacy;
- INTERACT works through Player group contract;
- shared materials are not mutated across instances.

---

## 23. Slice 6 - Complete Level_01 to Level_02 integration

Implement:

- portal instance at safe PortalAnchor;
- `entry_mode = INTERACT`;
- target `Level_02`;
- full finale controller path wiring;
- final state transitions;
- Player controls restored after portal activation;
- transition to Level_02.

Expected commit:

```text
Complete Level 01 finale and transition to Level 02
```

Validation:

```text
Shard_01
→ reward sequence
→ Shard_02
→ reward sequence
→ barrier opens
→ Landmark trigger
→ beam
→ finale overlay
→ portal materialization
→ E interaction
→ Level_02
```

Reverse shard order must also pass.

---

# PART I - THREE-PASS COMPLETION PROTOCOL

## 24. Pass 1 - Full implementation pass

Complete Slices 0-6 in order.

After every slice:

1. inspect `git diff`;
2. run `git diff --check`;
3. confirm no unrelated files;
4. run available Godot 4.6 headless/editor parse;
5. inspect changed `.tscn`, `.tres`, `.gdshader` and `.gd`;
6. commit the slice;
7. continue immediately to the next slice.

Do not stop after a successful slice.

## 25. Pass 2 - Reference coverage audit

After Slice 6, reread this entire document from the beginning.

Create a requirement checklist and mark:

```text
implemented
partially implemented
not implemented
not applicable with reason
```

Then correct every safe missing or partial item.

Pass 2 priorities:

- missing exported tuning parameters;
- missing fail-closed validation;
- missing idempotency;
- incomplete load failure recovery;
- shared material mutation;
- wrong interaction mode default;
- incorrect NodePaths;
- incomplete signal ordering;
- missing visibility bounds;
- effects active while hidden;
- Player controls not restored in an error path;
- broad changes outside scope.

Commit Pass 2 corrections separately with a clear message, for example:

```text
Complete Level 01 finale reference coverage
```

Do not stop after Pass 2.

## 26. Pass 3 - Final polish audit

Reread the document a third time and polish the completed implementation.

Pass 3 targets:

### Gameplay polish

- barrier movement reads clearly;
- trigger position feels intentional;
- no accidental trigger;
- Player regains control at the correct moment;
- prompt timing is clean;
- no duplicate transitions;
- Level_02 begins normally.

### Visual polish

- beam is warm and restrained;
- beam center is aligned;
- falling motes are visible but subtle;
- portal swirl clearly moves clockwise;
- portal is not too bright;
- ring layers have depth;
- portal materialization does not pop;
- portal does not overlap terrain;
- overlay visual language matches the game;
- no placeholder grey geometry remains in the Level_01 finale flow.

### Performance polish

- inactive VFX do not process;
- hidden particles do not emit;
- visibility AABB is bounded;
- new lights cast no shadows;
- material instances are duplicated only where runtime uniforms change;
- no particle leaks;
- no general optimization changes.

Commit final polish separately:

```text
Polish Level 01 Landmark finale and portal flow
```

---

# PART J - VALIDATION

## 27. Automated and static validation

Use the project-supported Godot 4.6 executable when available.

Required checks:

```text
git status --short
git diff --check
Godot project import/parse in headless or editor mode
GDScript parse validation
scene/resource load validation
shader compile validation when possible
```

Inspect every changed resource for:

- missing ext_resource;
- invalid UID/path;
- invalid NodePath;
- shared resource mutation;
- unsupported shader syntax;
- invalid exported enum values;
- accidental local absolute paths.

No claim of visual correctness may be made solely from static parsing.

## 28. Full manual QA matrix

### 28.1 Barrier

- no shards: closed;
- only Shard_01: closed;
- only Shard_02: closed;
- order 1 → 2: opens;
- order 2 → 1: opens;
- no movement during overlay;
- visual and collision synchronized;
- passage clear;
- Player safe at center and edges;
- no second Tween.

### 28.2 Landmark gate

- before barrier open: trigger rejected;
- after barrier open: trigger armed;
- entry from route: accepted;
- entry from below: rejected;
- entry from far side: rejected;
- repeated entry: rejected;
- trigger disabled after start.

### 28.3 Light column

- starts at Landmark center;
- grows from base;
- no hard opaque tube;
- warm palette;
- low visual aggression;
- falling motes visible;
- no spark explosion;
- no camera-filling artifact;
- effect remains after appearance;
- inactive effect has no processing/emission.

### 28.4 Overlay

- opens after beam;
- Player cannot move;
- text readable at 1920×1080;
- text not clipped at 1280×720;
- confirmation initially disabled;
- closes once;
- does not call SoulOrb return;
- does not reveal portal early.

### 28.5 Portal

- starts invisible;
- collision disabled while inactive;
- materializes after overlay close;
- perceived clockwise swirl;
- no hard grey placeholder;
- prompt only in range;
- E starts entry once;
- Player locked during transition;
- target path is Level_02;
- Level_02 loads;
- load failure path recovers in a controlled test;
- legacy AUTO_ENTER portal still works in one existing level.

### 28.6 Full flow

Test both:

```text
Shard_01 → Shard_02 → finale → Level_02
Shard_02 → Shard_01 → finale → Level_02
```

Also test:

- reload Level_01 after portal activation;
- reload during development with remote scene tree;
- collect a shard while standing near route edges;
- approach barrier immediately after second sequence;
- approach portal from left and right;
- press E repeatedly;
- leave portal range before pressing E;
- enter Level_02 and move/jump/interact normally.

### 28.7 Performance smoke test

Do not run a new project-wide optimization pass.

Check:

```text
roughly 55-60 FPS remains the expected real-play target
no large sustained drop during beam idle
no large sustained drop during portal idle
short activation spikes do not become persistent
no ever-growing particle count
no hidden active VFX after scene transition
```

If a new effect causes regression, optimize only that effect first:

1. reduce particle amount;
2. reduce overdraw plane size;
3. reduce additive layers;
4. reduce OmniLight range/energy;
5. disable optional BeamHalo or RisingMotes;
6. reduce noise texture resolution from 256 to 128 only if necessary.

Do not disable Glow or change the accepted global rendering baseline.

---

# PART K - DEFINITION OF DONE

## 29. Functional definition of done

The task is complete only when:

- both shard orders work;
- barrier opens after final reward completion;
- barrier opens once;
- Landmark finale is gated and one-shot;
- beam is a pre-end visual effect;
- finale text displays and closes;
- portal is a pre-end reusable effect;
- Level_01 portal requires E;
- transition loads Level_02;
- all relevant error paths are safe;
- Player, Camera, SoulOrb and shard reward sequence remain functional.

## 30. Visual definition of done

No visible part of the final flow may look like a raw development placeholder.

Allowed:

- procedural Godot geometry;
- TorusMesh;
- QuadMesh;
- CylinderMesh used subtly;
- procedural NoiseTexture2D;
- shader materials;
- GPUParticles3D;
- project fonts and approved UI textures.

Not allowed:

- plain grey boxes as final beam/portal art;
- opaque unshaded cylinder beam;
- static translucent rectangle portal;
- instant pop-in;
- excessive bloom;
- high-speed vortex;
- dense particle storm.

## 31. Technical definition of done

- one commit per implementation slice;
- Pass 2 correction commit;
- Pass 3 polish commit;
- clean final diff;
- no unrelated reformatting;
- no automatic merge;
- final implementation report created;
- report lists all deviations and manual QA still required.

---

# PART L - FINAL IMPLEMENTATION REPORT

## 32. Required report file

Create:

```text
docs/development/Level_01_Barrier_Landmark_Portal_Implementation_Report.md
```

Required sections:

```text
1. Executive summary
2. Baseline main SHA
3. Final branch and head SHA
4. Slice-by-slice commit list
5. Files created
6. Files modified
7. Barrier implementation
8. Landmark gate implementation
9. Light-column implementation
10. Finale overlay implementation
11. Portal V2 implementation
12. Level_02 transition implementation
13. Pass 2 corrections
14. Pass 3 polish
15. Automated validation performed
16. Manual QA performed
17. Manual QA still required
18. Performance observations
19. Deviations from reference
20. Known limitations
21. Inspector NodePaths and tuning values
22. Final no-merge status
```

The report must be factual. Do not claim rendered visual QA if the environment could not run Godot with graphics.

---

## 33. Expected final commit sequence

Recommended sequence:

```text
1. Implement two-shard barrier progression for Level 01
2. Add gated one-shot Landmark finale trigger
3. Create polished Landmark light column finale effect
4. Add Level 01 finale overlay and sequence
5. Upgrade reusable LevelPortal with woven-light vortex
6. Complete Level 01 finale and transition to Level 02
7. Complete Level 01 finale reference coverage
8. Polish Level 01 Landmark finale and portal flow
9. Add Level 01 finale implementation report
```

Small deviations in commit naming are acceptable. Combining implementation slices is not acceptable unless a repository constraint makes separation impossible and the report explains why.

---

## 34. Final risk register

### High risk

- changing shared `LevelPortal` and breaking existing levels;
- mutating shared ShaderMaterial resources between portal instances;
- invalid scene/resource syntax generated by text editing;
- Player controls remaining disabled after a load error;
- trigger starting before barrier completion;
- portal overlapping Landmark collision.

### Medium risk

- transparent sorting artifacts in beam or portal;
- additive overdraw causing FPS loss;
- portal prompt competing with another interactable;
- beam alignment not matching Landmark center;
- legacy LevelManager warnings in Level_01.

### Low risk

- exact color tuning;
- exact particle count;
- exact barrier offset;
- exact portal ring scale.

Mitigation order:

```text
correctness
→ regression safety
→ scene parsing
→ gameplay readability
→ visual polish
→ local VFX performance tuning
```

---

## 35. Final architectural verdict

The approved implementation is:

```text
explicit shard signals
→ small Level01ProgressionController
→ barrier open completion gates Landmark
→ small Level01FinaleController
→ standalone polished LandmarkLightColumn
→ standalone LevelFinaleOverlay
→ backward-compatible reusable LevelPortal V2
→ explicit exported target to Level_02
```

This keeps the current working shard reward sequence intact, avoids a giant manager, produces a pre-end visual result directly in Godot 4.6 and leaves the portal reusable for later level polish.
