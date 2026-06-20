# Level 01 Sun Ray Preflight

## 1. Repository and Git State
- Initial working branch before this task: `work`.
- Initial HEAD: `bcd677cc87d53669aca85b827843be06351b5c07`.
- Target working branch created for this slice: `feature/level-01-dual-light-ray-puzzle`.
- Baseline ancestry: the current HEAD is exactly the confirmed PR #96 merge commit `bcd677cc87d53669aca85b827843be06351b5c07`, so the local baseline contains that merge commit.
- Remote state: `git remote -v`, `git fetch origin --prune`, and `git branch -r` show no usable `origin` remote in this checkout. Push and remote-head proof are therefore blocked in this environment.
- Relevant current files and folders inspected for this preflight: `scenes/levels/Level_01.tscn`, `scenes/environment/assets/lantern_01.tscn`, `scenes/environment/assets/lantern_02.tscn`, `scripts/puzzles/moon_ray_puzzle_controller.gd`, `scripts/puzzles/moon_ray_lantern_node.gd`, `scripts/puzzles/moon_ray_particle_stream.gd`, `scripts/puzzles/celestial_barrier_gate.gd`, and `scripts/levels/level_01_progression_controller.gd`.
- Short plan used for this slice: preserve user-authored scene additions, inventory the Level 01 Sun Ray nodes, map existing Moon Ray and barrier behavior, document a future Slice 2 integration route, validate without gameplay implementation, then commit only the allowed documentation and any already-present user scene additions if they were uncommitted.
- Test-impact check: this slice is documentation/preflight only. It does not implement Sun Ray gameplay, does not alter Moon Ray scripts, and does not change either barrier condition.

## 2. User-Authored Scene Changes
- The six required Sun Ray lantern nodes were present in the working tree before Codex made any edits in this task. They were placed by the user and were not created by Codex.
- Codex did not move, rename, delete, replace, or re-transform these six required nodes.
- The nodes are saved in the Level 01 scene file at `scenes/levels/Level_01.tscn` under `/root/Level_01/Sun Ray`.
- A seventh sibling, `/root/Level_01/Sun Ray/sun_ray_lantern_node_5`, is also present in the scene. It is outside the requested six-node Sun Ray order and is treated as an existing out-of-scope scene fact for this preflight, not as a Codex-created node.
- The Sun Ray parent node is `[node name="Sun Ray" type="Node3D" parent="."]` and all listed Sun Ray lanterns are direct children of it.

## 3. Sun Ray Lantern Node Inventory
Expected future order, not implemented in this slice:

```text
sun_ray_lantern_start
→ sun_ray_lantern_node_1
→ sun_ray_lantern_node_2
→ sun_ray_lantern_node_3
→ sun_ray_lantern_node_4
→ sun_ray_lantern_end
```

Expected future initial segment, not implemented in this slice:

```text
sun_ray_lantern_start
→ sun_ray_lantern_node_1
```

All six required Sun Ray lanterns are direct instances of existing lantern scenes. The Level 01 `.tscn` entries do not assign scripts or groups to these six instance nodes. Inherited child content comes from the instanced lantern scenes:

- `sun_ray_lantern_start` and `sun_ray_lantern_end` instance `res://scenes/environment/assets/lantern_02.tscn`.
  - Root type in packed scene: `Node3D`.
  - Children in packed scene: `VisualRoot` (`Node3D`), `VisualRoot/Asset` (GLB instance), `SpotLight3D`, `StaticBody3D`, and `StaticBody3D/CollisionShape3D` using a `BoxShape3D`.
- `sun_ray_lantern_node_1` through `sun_ray_lantern_node_4` instance `res://scenes/environment/assets/lantern_01.tscn`.
  - Root type in packed scene: `Node3D`.
  - Children in packed scene: `VisualRoot` (`Node3D`), `VisualRoot/Asset` (GLB instance), `OmniLight3D`, `StaticBody3D`, and `StaticBody3D/CollisionShape3D` using a `CylinderShape3D`.

Required node inventory:

| Required node | Exact NodePath | Type | Parent | Owner | Script | Groups | Collision | Transform |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `sun_ray_lantern_start` | `/root/Level_01/Sun Ray/sun_ray_lantern_start` | instanced `Node3D` from `lantern_02.tscn` | `/root/Level_01/Sun Ray` | `Level_01` scene owner | none on Level 01 instance | none on Level 01 instance | inherited `StaticBody3D/CollisionShape3D`; default collision layer/mask from packed scene | `Transform3D(0.9631438, 0, -0.26898706, 0, 1, 0, 0.26898706, 0, 0.9631438, -29.130756, 3.4775624, 153.89972)` |
| `sun_ray_lantern_node_1` | `/root/Level_01/Sun Ray/sun_ray_lantern_node_1` | instanced `Node3D` from `lantern_01.tscn` | `/root/Level_01/Sun Ray` | `Level_01` scene owner | none on Level 01 instance | none on Level 01 instance | inherited `StaticBody3D/CollisionShape3D`; default collision layer/mask from packed scene | `Transform3D(0.90661734, 0, -0.4219538, 0, 1, 0, 0.4219538, 0, 0.90661734, -31.238493, 0.16439867, 165.80621)` |
| `sun_ray_lantern_node_2` | `/root/Level_01/Sun Ray/sun_ray_lantern_node_2` | instanced `Node3D` from `lantern_01.tscn` | `/root/Level_01/Sun Ray` | `Level_01` scene owner | none on Level 01 instance | none on Level 01 instance | inherited `StaticBody3D/CollisionShape3D`; default collision layer/mask from packed scene | `Transform3D(0.9995763, 0, -0.029107958, 0, 1, 0, 0.029107958, 0, 0.9995763, -31.5257, 0.16439867, 167.29549)` |
| `sun_ray_lantern_node_3` | `/root/Level_01/Sun Ray/sun_ray_lantern_node_3` | instanced `Node3D` from `lantern_01.tscn` | `/root/Level_01/Sun Ray` | `Level_01` scene owner | none on Level 01 instance | none on Level 01 instance | inherited `StaticBody3D/CollisionShape3D`; default collision layer/mask from packed scene | `Transform3D(0.8579932, 0, 0.5136611, 0, 1, 0, -0.5136611, 0, 0.8579932, -31.5257, -0.007477641, 171.10173)` |
| `sun_ray_lantern_node_4` | `/root/Level_01/Sun Ray/sun_ray_lantern_node_4` | instanced `Node3D` from `lantern_01.tscn` | `/root/Level_01/Sun Ray` | `Level_01` scene owner | none on Level 01 instance | none on Level 01 instance | inherited `StaticBody3D/CollisionShape3D`; default collision layer/mask from packed scene | `Transform3D(0.87951577, 0, -0.4758698, 0, 1, 0, 0.4758698, 0, 0.87951577, -28.242622, -0.047822356, 181.99454)` |
| `sun_ray_lantern_end` | `/root/Level_01/Sun Ray/sun_ray_lantern_end` | instanced `Node3D` from `lantern_02.tscn` | `/root/Level_01/Sun Ray` | `Level_01` scene owner | none on Level 01 instance | none on Level 01 instance | inherited `StaticBody3D/CollisionShape3D`; default collision layer/mask from packed scene | `Transform3D(-0.9619084, 0, 0.27337173, 0, 1, 0, -0.27337173, 0, -0.9619084, -33.670456, 1.5921514, 193.8144)` |

Scene integrity findings:

- The six required names are unique among siblings under `/root/Level_01/Sun Ray`.
- The six required nodes are copies/instances of the same packed lantern scenes used by existing Moon Ray lanterns: endpoints use `lantern_02.tscn`; relay nodes use `lantern_01.tscn`.
- The required nodes are serialized in `scenes/levels/Level_01.tscn` with explicit transforms.
- No missing `ExtResource` paths were found among the Level 01 external resources during path inspection.
- No invalid NodePath was found in the inspected Moon Ray controller exports or Level 01 progression/finale exports.
- No orphaned owner field is serialized on these scene-local nodes; in Godot `.tscn` terms they belong to the `Level_01` scene owner.
- No parse error was reported by the available Godot headless editor validation.

## 4. Existing Moon Ray Architecture
- Controller file: `scripts/puzzles/moon_ray_puzzle_controller.gd`.
- Controller class: `MoonRayPuzzleController`.
- Controller scene node: `/root/Level_01/Moon Ray/MoonRayPuzzleController`.
- Controller signal: `puzzle_completed`.
- Controller exported `ray_id`: default `&"moon"`; Level 01 does not override it.
- Controller exported `lantern_paths` in `scenes/levels/Level_01.tscn`:
  - `../moon_ray_lantern_start`
  - `../moon_ray_lantern_node_1`
  - `../moon_ray_lantern_node_2`
  - `../moon_ray_lantern_node_3`
  - `../moon_ray_lantern_end`
- Correct sequence is the order of `lantern_paths`, not a separate data resource.
- Initial state is established by `reset_to_initial()`:
  - index `0` (`moon_ray_lantern_start`) becomes `COMPLETED`;
  - index `1` (`moon_ray_lantern_node_1`) becomes `ACTIVE_ENDPOINT`;
  - all later nodes become `INACTIVE`;
  - `_create_stream(0, 1, true)` creates the mandatory initial stream.
- Selected lantern state is held in `_selected: MoonRayLanternNode` and uses `MoonRayLanternNode.LanternState.SELECTED`.
- Confirmed/activated route state uses `MoonRayLanternNode.LanternState.COMPLETED` for completed source nodes and the final target; active forward endpoint uses `ACTIVE_ENDPOINT`.
- Wrong selection is handled in `_try_connect()` by creating a non-initial stream, marking the target `RESETTING`, then calling `_start_wrong_reset(stream)`.
- Soft reset lifecycle in `_start_wrong_reset()`:
  - `_locked = true`;
  - waits `wrong_segment_hold`;
  - fades and removes all non-initial streams through `MoonRayParticleStream.fade_out_and_free(wrong_fade_duration)`;
  - marks relay/end lanterns `RESETTING`;
  - waits `wrong_fade_duration`;
  - restores `_current_index = 1`, start `COMPLETED`, node 1 `ACTIVE_ENDPOINT`, later nodes `INACTIVE`, and `_locked = false`.
- Stream creation is in `_create_stream(source_index, target_index, initial)` using `MoonRayParticleStream` from `scripts/puzzles/moon_ray_particle_stream.gd`.
- Runtime stream root is created in `_ready()` as `MoonRayRuntimeParticleStreams` under `/root/Level_01/Moon Ray/MoonRayPuzzleController`.
- Lantern interaction wrappers are runtime-only `MoonRayLanternNode` instances created by `_bind_lanterns()`. Wrapper names are `%s_interaction_anchor`, for example `moon_ray_lantern_node_1_interaction_anchor`.
- Lantern component file: `scripts/puzzles/moon_ray_lantern_node.gd`.
- Lantern component class: `MoonRayLanternNode`.
- Lantern component signal: `interaction_requested(node: MoonRayLanternNode, player: Node)`.
- The controller connects `wrapper.interaction_requested.connect(_on_lantern_interaction)` once when wrappers are created.
- Completion guard: `_complete_puzzle()` sets `_completed = true` and `_locked = true`; `can_lantern_be_interacted()` returns false when `_completed` is true. There is no explicit early return inside `_complete_puzzle()` itself, but normal route flow reaches it only once when the final ordered target is connected.
- Completion behavior: `_complete_puzzle()` calls `_barrier.open_gate()` if the configured barrier has that method, then emits `puzzle_completed`.
- Behavior after completion: interactions remain locked and completed route states/streams remain until reload.
- Behavior after reload: scene `_ready()` rebuilds wrappers and runtime streams from serialized scene data, and `reset_to_initial()` restores the initial Moon Ray segment/state.

## 5. Existing Barrier Architecture
There are two barrier systems in Level 01; this slice changes neither.

### Moon Ray celestial barrier
- Exact node: `/root/Level_01/Moon Ray/moon_ray_celestial_barrier`.
- Parent: `/root/Level_01/Moon Ray`.
- Script: `scripts/puzzles/celestial_barrier_gate.gd`.
- Class: `CelestialBarrierGate`.
- Signal: `dissolved`.
- Visual components are runtime-created in `_build_nodes()`:
  - `CelestialMistWall` (`MeshInstance3D` with `QuadMesh` and transparent unshaded `StandardMaterial3D`);
  - `ClockwiseSunMoonSigil` (`MeshInstance3D` with `QuadMesh` and generated `ShaderMaterial`).
- Collision component is runtime-created in `_build_nodes()` as `CollisionShape3D` with `BoxShape3D` size based on `barrier_size`.
- Current initial state: `_ready()` calls `_build_nodes()` and `reset_gate()`, which shows the barrier, enables collision, resets mesh position, alpha, emission energy, and sigil alpha.
- Current disappearance condition: `MoonRayPuzzleController._complete_puzzle()` calls `open_gate()` after the final correct Moon Ray segment reaches `moon_ray_lantern_end`.
- Collision disabling moment: `open_gate()` sets `_shape.disabled = true` immediately before starting the dissolve tween.
- Tween/shader behavior: `open_gate()` kills any valid prior `_tween`, creates a parallel tween for material alpha, emission, sigil shader `alpha`, and mesh Y offset, then hides the node and emits `dissolved` when the tween finishes.
- Repeat unlock: `_opened` causes subsequent `open_gate()` calls to return immediately.
- Reload behavior: the scene reloads with `_opened = false`; `_ready()` rebuilds and resets the barrier closed/visible/colliding.
- Current Moon Ray completion result: Moon Ray completion immediately disables the celestial barrier collision and starts visual dissolve, then hides the barrier at tween completion.

### Main progression stone barrier
- Exact node: `/root/Level_01/Architecture/Ancient_Stone_Barrier_01`.
- Parent: `/root/Level_01/Architecture`.
- Controller: `/root/Level_01/LevelRuntimeRoot/Level01ProgressionController`.
- Controller file/class: `scripts/levels/level_01_progression_controller.gd`, `Level01ProgressionController`.
- Current condition: both configured shards, `../../Shard_01` and `../../Shard_02`, emit `collected`; this does not depend on Moon Ray completion.
- Current behavior: `_on_required_shard_collected()` transitions to `OPEN_PENDING`, emits `all_required_shards_collected`, then defers `_begin_barrier_opening()`.
- Opening behavior: `_begin_barrier_opening()` kills any valid existing barrier tween, emits `barrier_opening_started`, and tweens the barrier node's `position` by `barrier_open_offset` over `barrier_open_duration`.
- Completion: `_on_barrier_tween_finished()` transitions to `OPEN` and emits `barrier_opened`.

## 6. Signals and State Transitions
Moon Ray signals and transitions:

```text
MoonRayLanternNode.interaction_requested
→ MoonRayPuzzleController._on_lantern_interaction()
→ MoonRayPuzzleController._try_connect()
→ correct final route
→ MoonRayPuzzleController._complete_puzzle()
→ CelestialBarrierGate.open_gate()
→ MoonRayPuzzleController.puzzle_completed
```

Moon Ray wrong-route transition:

```text
ACTIVE_ENDPOINT selected
→ non-next INACTIVE target chosen
→ non-initial stream created
→ target RESETTING
→ _start_wrong_reset()
→ non-initial streams fade/free
→ state returns to initial start-to-node-1 segment
```

Main progression barrier transition:

```text
Shard_01.collected + Shard_02.collected
→ Level01ProgressionController.all_required_shards_collected
→ barrier_opening_started
→ Ancient_Stone_Barrier_01 position tween
→ barrier_opened
→ Level01FinaleController._on_barrier_opened()
```

No Sun Ray signal exists yet. This preflight recommends a future `sun_ray_completed` signal but does not implement it.

## 7. Particle and Beam Lifecycle
- Existing Moon Ray does not create solid beam mesh segments. Its visible route is `MoonRayParticleStream`, implemented as a `MultiMeshInstance3D` of small sphere particles.
- `MoonRayParticleStream._ready()` creates the multimesh, sphere mesh, and silver unshaded material.
- `configure_between()` stores source/target IDs and nodes, marks `is_initial`, then calls `_update_instances(0.0)`.
- `_process(delta)` continuously updates particle positions and camera-distance visibility.
- Wrong-route cleanup uses `fade_out_and_free()`, which kills any valid `_fade_tween`, tweens `_alpha` to zero, and connects `finished` to `queue_free`.
- Controller reset cleanup in `reset_to_initial()` queues every known stream for freeing, clears `_streams`, then creates exactly one initial stream.
- Risk note: because wrong-route cleanup removes streams from `_streams` before they are actually freed, a future controller should avoid losing references to long-lived streams that might still emit callbacks or remain visible.

## 8. Proposed Minimal Integration
This is a recommendation for Slice 2 and is not implemented in this slice.

- Add a separate Sun Ray controller rather than rewriting `MoonRayPuzzleController` in place.
- Safely reuse the existing lantern wrapper concept from `MoonRayLanternNode`, but prefer either:
  - a small color-configurable base/variant only after tests prove Moon Ray parity; or
  - a new `SunRayLanternNode` copied narrowly from Moon Ray for first implementation if minimizing regression risk is more important than deduplication.
- Configure golden-orange color through exported controller/lantern colors rather than hardcoding all visual values in multiple functions.
- Store the Sun Ray sequence in exported `Array[NodePath]` on the future Sun Ray controller, using this exact order:
  - `../sun_ray_lantern_start`
  - `../sun_ray_lantern_node_1`
  - `../sun_ray_lantern_node_2`
  - `../sun_ray_lantern_node_3`
  - `../sun_ray_lantern_node_4`
  - `../sun_ray_lantern_end`
- Preserve the mandatory initial segment by following Moon Ray's `reset_to_initial()` pattern: start index `0` completed, index `1` active endpoint, `_current_index = 1`, and a single `is_initial` stream from `0` to `1`.
- Use a soft reset after wrong choice matching Moon Ray's lifecycle, but keep all Sun Ray state and runtime nodes under a Sun Ray controller-owned runtime root to prevent cross-puzzle cleanup.
- Emit a future Sun Ray completion signal, for example `sun_ray_completed`, once only after the last required ordered segment reaches `sun_ray_lantern_end`.
- Introduce a Level 01 light-puzzle coordinator only when both rays are ready. It should track two booleans:

```gdscript
moon_ray_completed
sun_ray_completed
```

- Use one centralized function such as `_check_light_barrier_unlock()` to unlock any future shared barrier only after both booleans are true.
- Do not directly open the future shared barrier from either ray controller once dual gating exists; controllers should emit completion and let the coordinator decide.
- Future activated rings can attach to the lantern wrapper state application point (`_apply_state()` equivalent), keyed by `COMPLETED` or active endpoint state.
- Future selected beacon can attach to the selected-state branch of the lantern wrapper state application point.
- Particle density should be increased by an exported `particle_count`/`amount` only; do not change speed (`_age * 0.105` equivalent), lifetime, wrong-route hold, or fade duration unless a separate tuning slice requests it.
- To make a barrier more visible without changing collision, adjust only visual child material alpha/emission/mesh size, not `CollisionShape3D.disabled`, shape size, or collision layer/mask.

## 9. Files Expected to Change in Slice 2
Potential files for a later implementation, not final commitments:

- `scenes/levels/Level_01.tscn` may receive a Sun Ray controller node and exported NodePath configuration.
- A new Sun Ray controller script may be added under `scripts/puzzles/`.
- A Sun Ray lantern wrapper script or a carefully generalized reusable lantern wrapper may be added under `scripts/puzzles/`.
- A Sun Ray particle stream script or a color-configurable reusable stream may be added under `scripts/puzzles/`.
- A Level 01 light-puzzle coordinator script may be added under `scripts/levels/` only if the barrier condition is intentionally changed in a future slice.
- Future documentation may be added under `docs/development/` after implementation.

## 10. Out-of-Scope Files
This preflight intentionally does not change:

- `scripts/puzzles/moon_ray_puzzle_controller.gd`
- `scripts/puzzles/moon_ray_lantern_node.gd`
- `scripts/puzzles/moon_ray_particle_stream.gd`
- `scripts/puzzles/celestial_barrier_gate.gd`
- `scripts/levels/level_01_progression_controller.gd`
- `scripts/levels/level_01_finale_controller.gd`
- finale overlay scenes/scripts
- shard reward scenes/scripts
- portal scenes/scripts
- narrative text
- other levels

## 11. Risks and Mitigations
- Sun Ray can be implemented without rewriting Moon Ray. Mitigation: add a separate Sun Ray controller and leave Moon Ray files unchanged until a dedicated refactor is justified.
- Safe Moon Ray reuse: exported NodePath sequence pattern, runtime wrapper pattern, initial segment logic, wrong-route soft reset concept, stream root ownership, completion signal pattern.
- Risky Moon Ray generalization: changing `MoonRayLanternNode` names, prompt text, silver material constants, hardcoded runtime child names, or `MoonRayParticleStream` color/speed logic could regress the existing puzzle.
- Hardcoded NodePaths exist in Level 01 scene exports for Moon Ray and progression/finale controllers. Mitigation: configure Sun Ray with its own exported paths and verify them in scene validation.
- Hardcoded sequence exists as `lantern_paths` array order in the scene, plus `_current_index = 1` in controller logic. Mitigation: document and test sequence order explicitly.
- No singleton/global state was found in Moon Ray; state is controller-local.
- Duplicate signal risk exists if a controller reconnects existing wrappers on reset. Mitigation: bind wrappers once in `_ready()` or disconnect defensively before reconnecting.
- Orphan tween risk exists in particle streams and barrier dissolve. Mitigation: kill valid tweens before replacing them, as current code does.
- Particle accumulation risk exists if future wrong-route streams are removed from tracking before `queue_free` completes. Mitigation: validate runtime child counts after repeated wrong choices.
- Premature barrier unlock risk is high if Sun Ray directly calls the current Moon Ray barrier. Mitigation: use a coordinator and centralized unlock check for dual completion.
- Existing Moon Ray regression risk is moderate if scripts are generalized. Mitigation: first implement Sun Ray in separate files or with narrowly additive exports, then validate Moon Ray unchanged.
- User placement risk is high if scene editing regenerates transforms. Mitigation: never recreate the six user nodes; preserve exact serialized transforms listed in this report.

## 12. Validation Results
- Static/code validation: `git diff --check` passed.
- Scene integrity validation: custom text/path inspection confirmed all six required Sun Ray names exist once under `/root/Level_01/Sun Ray`, are serialized in `scenes/levels/Level_01.tscn`, and have the transforms listed above.
- Headless runtime validation: `godot --headless --editor --path . --quit` passed in this environment. `godot --headless --path . --quit --check-only` also exited successfully with the installed Godot executable.
- Rendered gameplay QA: NOT APPLICABLE FOR PREFLIGHT.
- Level 01 scene parses under the available headless editor command.
- Existing Moon Ray scripts and barrier scripts were not modified by this slice.
- Main progression barrier behavior was not modified by this slice.

## 13. Blockers
- Push blocker: the checkout has no configured `origin` remote, so `git fetch origin --prune`, remote branch comparison, push to `origin/feature/level-01-dual-light-ray-puzzle`, and remote-head proof cannot be completed in this environment.
- Scene note, not a blocker for the requested six nodes: `/root/Level_01/Sun Ray/sun_ray_lantern_node_5` exists but is outside the requested future Sun Ray sequence.

## 14. Final Recommendation
Proceed to Slice 2 only after the remote/push blocker is resolved. Implement Sun Ray as an additive, separate controller under `/root/Level_01/Sun Ray`, configured with the six user-authored NodePaths and preserving their exact transforms. Keep Moon Ray behavior unchanged until dual completion has proven tests. If a shared barrier is introduced later, route `moon_ray_completed` and `sun_ray_completed` through a Level 01 coordinator with a single centralized unlock check rather than opening the barrier directly from either ray controller.
