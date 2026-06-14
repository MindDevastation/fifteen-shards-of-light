# SoulShard Warm Crystal Collection Burst - Implementation Summary

## Initial architecture

- Baseline file scope was limited to `scenes/core/SoulShard.tscn` and `scripts/soul/soul_shard.gd`.
- The existing collection burst was a root-level `GPUParticles3D` node named `CollectionBurst`.
- `_play_world_burst()` hid `VisualRoot` and `GroundVFXRoot`, positioned `CollectionBurst`, restarted it, and enabled emitting.
- `_on_charge_finished()` called `_play_world_burst()` and then immediately called `_request_or_complete_collection()`.
- Reward flow did not wait for particle completion and this behavior was preserved.

## Final architecture

- `CollectionBurst` remains the primary root-level spark layer and keeps its existing node path.
- `CollectionPetalBurst` was added as a secondary root-level one-shot accent layer.
- `CollectionBloomRoot` was added as a root-level bloom owner hidden by default.
- `CollectionOuterBloom` and `CollectionInnerBloom` were added as children of `CollectionBloomRoot`.
- Burst layers remain outside `VisualRoot` and `GroundVFXRoot` so they continue to render after those roots are hidden during collection.
- `_play_world_burst()` remains the central burst handoff and delegates presentation work to `_start_collection_burst_visuals()`.

## Final node tree

```text
SoulShard
├── GroundVFXRoot
├── VisualRoot
├── CollisionShape3D
├── PromptAnchor
├── WorldInteractionPrompt
├── CollectionBurst
├── CollectionPetalBurst
├── CollectionBloomRoot
│   ├── CollectionOuterBloom
│   └── CollectionInnerBloom
└── ShoulShardModel
```

## Final spark values

`CollectionBurst` final values:

```text
amount = 24
lifetime = 0.72
one_shot = true
explosiveness = 0.96
randomness = 0.38
fixed_fps = 30
visibility_aabb = AABB(-1.2, -1.2, -1.2, 2.4, 2.4, 2.4)
```

Spark process material:

```text
emission_shape = sphere
emission_sphere_radius = 0.08
direction = Vector3(0, 1, 0)
spread = 180
initial_velocity_min = 0.48
initial_velocity_max = 0.88
angular_velocity_min = -1.4
angular_velocity_max = 1.4
gravity = Vector3(0, 0.04, 0)
damping_min = 0.48
damping_max = 0.85
scale_min = 0.045
scale_max = 0.11
color = Color(1, 0.84, 0.58, 0.7)
```

Spark draw material:

```text
texture = assets/vfx/soul_shard_spark.png
albedo_color = Color(1, 0.84, 0.58, 0.7)
emission = Color(1, 0.62, 0.28, 1)
emission_energy_multiplier = 1.05
```

## Final petal values

`CollectionPetalBurst` final values:

```text
amount = 7
lifetime = 1.0
one_shot = true
explosiveness = 0.9
randomness = 0.72
fixed_fps = 24
visibility_aabb = AABB(-1.1, -1.1, -1.1, 2.2, 2.2, 2.2)
```

Petal process material:

```text
emission_shape = sphere
emission_sphere_radius = 0.1
direction = Vector3(0, 1, 0)
spread = 145
initial_velocity_min = 0.18
initial_velocity_max = 0.42
angular_velocity_min = -1.2
angular_velocity_max = 1.2
gravity = Vector3(0, 0.035, 0)
damping_min = 0.24
damping_max = 0.52
scale_min = 0.035
scale_max = 0.075
color = Color(1, 0.48, 0.36, 0.34)
```

Petal draw material:

```text
texture = assets/vfx/soul_shard_light_petal.png
albedo_color = Color(1, 0.48, 0.36, 0.34)
emission = Color(1, 0.38, 0.24, 1)
emission_energy_multiplier = 0.58
```

## Final bloom values

Inner bloom:

```text
node = CollectionBloomRoot/CollectionInnerBloom
texture = assets/vfx/soul_shard_spark.png
mesh size = Vector2(0.34, 0.34)
duration segment = normalized progress 0.00-0.43
start scale = 0.18
peak scale = 0.62
start alpha = 0.56
end alpha = 0.0
start emission = 1.25
end emission = 0.20
```

Outer bloom:

```text
node = CollectionBloomRoot/CollectionOuterBloom
texture = assets/vfx/soul_shard_halo.png
mesh size = Vector2(0.90, 1.05)
duration = 0.42 seconds
start scale = 0.22
end scale = 0.92
start alpha = 0.28
end alpha = 0.0
start emission = 0.72
end emission = 0.12
```

## Tween lifecycle

- Charge Anticipation still owns `_charge_tween`.
- Collection bloom owns a separate `_collection_bloom_tween`.
- `_start_collection_burst_visuals()` kills any existing bloom tween via `_reset_collection_burst_visuals()` before starting a new one.
- Bloom tween animates normalized progress from `0.0` to `1.0` over `0.42` seconds.
- Inner bloom remaps normalized progress through `0.00-0.43`.
- Outer bloom uses the full normalized progress range.
- `_finish_collection_bloom()` clears the tween reference, applies final hidden bloom values, and hides `CollectionBloomRoot`.

## Material duplication

- Bloom materials are duplicated in `_setup_collection_bloom_materials()`.
- `CollectionOuterBloom` and `CollectionInnerBloom` receive duplicated `material_override` instances.
- Runtime alpha and emission mutations are applied only to these duplicated materials.
- Existing shared scene material subresources are not mutated at runtime for bloom animation.

## Reset behavior

`_reset_collection_burst_visuals()` deterministically resets:

- existing bloom tween;
- bloom progress;
- spark emitting state;
- petal emitting state;
- bloom root visibility;
- bloom root world position;
- inner bloom scale;
- outer bloom scale;
- inner bloom alpha/emission;
- outer bloom alpha/emission.

Particle layers are positioned at the shard world position, restarted, and then set to emitting in `_start_collection_burst_visuals()`.

## Burst handoff

`_play_world_burst()` final contract:

```text
set state to BURSTING
hide VisualRoot
hide GroundVFXRoot
start collection burst visuals
```

It remains presentation-only and does not await particles or bloom.

## Reward flow preservation

- `_on_charge_finished()` still calls `_play_world_burst()` once and immediately calls `_request_or_complete_collection()`.
- `reward_sequence_requested` signal signature is unchanged.
- Reward request timing is unchanged.
- `complete_collection_sequence()` behavior is unchanged.
- `ShardRewardSequenceController`, `ShardRewardOverlay`, `WorldInteractionPrompt`, SoulOrb scripts/scenes, player scripts, levels, and project settings were not modified.

## Slice log

### WB-1 - Burst Lifecycle Foundation

- Added burst-specific scene nodes.
- Added onready references.
- Added per-instance bloom material duplication.
- Added stored bloom tween field.
- Added deterministic reset foundation.
- Preserved `CollectionBurst` node path and reward handoff.
- Commit: `c916eab Add Warm Crystal Collection Burst lifecycle foundation`

### WB-2 - Warm Crystal Spark Layer

- Retuned existing `CollectionBurst` to warm ivory/gold restrained crystal sparks.
- Reduced particle amount, lifetime, velocity, scale, and AABB.
- Increased damping.
- Removed mint/cyan-dominant material values.
- Commit: `cece0a9 Retune SoulShard collection sparks to warm crystal release`

### WB-3 - Soft Petal Accent Layer

- Integrated `CollectionPetalBurst` into the central burst start method.
- Uses existing `soul_shard_light_petal.png` texture.
- One-shot petal particles restart safely with the spark layer.
- Commit: `80375af Add soft petal accents to SoulShard collection burst`

### WB-4 - Local Bloom and Integration Polish

- Added normalized local bloom tween.
- Added compact inner bloom and soft outer bloom animation values.
- Added deterministic finish/hide behavior.
- Preserved reward flow timing.
- Commit: `c96c0d9 Add local bloom to Warm Crystal Collection Burst`

### WB-5 - Runtime and Visual Validation

- Added this implementation summary.
- Ran static, headless, and search validations.
- Runtime visual quality and two-shard interactive flow remain not verified without manual video evidence.
- Commit: `Validate and document Warm Crystal Collection Burst` (final local SHA recorded in handoff)

## Tests

Commands run before summary creation:

```bash
git diff --check ba5966b1447906c2fb5a74e9cef13d2a8fcb4ed8...HEAD
godot --headless --path . --check-only --quit
timeout 20s godot --headless --path . --quit
rg -n "_play_world_burst\(" scripts/soul/soul_shard.gd
rg -n "reward_sequence_requested|_request_or_complete_collection" scripts/soul/soul_shard.gd
rg -n "CollectionBurst|CollectionPetalBurst|CollectionBloom" scenes/core/SoulShard.tscn scripts/soul/soul_shard.gd
rg -n "create_tween|tween_method|tween_interval" scripts/soul/soul_shard.gd
git diff --name-only ba5966b1447906c2fb5a74e9cef13d2a8fcb4ed8...HEAD
git status --short --branch
```

Results:

- `git diff --check`: passed.
- `godot --headless --path . --check-only --quit`: passed.
- `timeout 20s godot --headless --path . --quit`: passed.
- Required searches completed and confirmed one charge tween, one bloom tween, one burst handoff, and unchanged reward request location.

## Runtime limitations

- No interactive gameplay session was performed in this environment.
- Two sequential shards were not manually collected in this environment.
- Output/Debugger during interactive play was not manually inspected.
- Push and PR creation were not verified because the local repository has no configured remote, direct GitHub access failed during preflight, and `gh` is unavailable.

## Video requirements

Manual video review is still required before merge. Minimum clip:

```text
idle
→ prompt
→ E
→ full charge
→ full burst
→ beginning of Reward Overlay
```

Visual checklist still requiring manual video confirmation:

- warm dominant hue;
- no mint/cyan dominance;
- compact Inner Bloom;
- soft Outer Bloom;
- small sparks;
- petals secondary;
- no shockwave;
- no fullscreen flash;
- no player overexposure;
- burst follows compression naturally;
- overlay remains readable.

Until video review:

```text
Visual quality: NOT VERIFIED
Two sequential shards: NOT VERIFIED
Merge: WAIT FOR VIDEO
```

## Branch

```text
feature/soul-shard-warm-crystal-collection-burst
```

## Commits

```text
c916eab Add Warm Crystal Collection Burst lifecycle foundation
cece0a9 Retune SoulShard collection sparks to warm crystal release
80375af Add soft petal accents to SoulShard collection burst
c96c0d9 Add local bloom to Warm Crystal Collection Burst
Validate and document Warm Crystal Collection Burst (final local SHA recorded in handoff)
```

## PR

- PR title requested: `Polish SoulShard warm crystal collection burst`
- PR number: NOT CREATED / NOT VERIFIED at the time this summary file was authored.
- PR URL: NOT CREATED / NOT VERIFIED at the time this summary file was authored.

## Scope confirmation

Modified production files:

```text
scenes/core/SoulShard.tscn
scripts/soul/soul_shard.gd
```

Created documentation file:

```text
docs/development/SoulShard_Warm_Crystal_Collection_Burst_Implementation_Summary.md
```

No new textures, shaders, lights, audio, camera shake, fullscreen effects, reward delay, autoloads, global VFX managers, or unrelated gameplay systems were added.
