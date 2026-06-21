# Level 01 Dual Light Ray Puzzle Report

## Slice 2 - Standalone Sun Ray Puzzle

### Implemented files

- `scripts/puzzles/sun_ray_puzzle_controller.gd` adds the standalone `SunRayPuzzleController` state machine.
- `scripts/puzzles/sun_ray_lantern_node.gd` adds the Sun-specific runtime interaction wrapper, prompt text, and golden-orange functional feedback.
- `scripts/puzzles/sun_ray_particle_stream.gd` adds the Sun-specific particle stream implementation.
- `scenes/levels/Level_01.tscn` adds `SunRayPuzzleController` under `/root/Level_01/Sun Ray` and configures only the six approved Sun Ray lantern paths.

### Sequence

The configured route is exactly:

```text
sun_ray_lantern_start
→ sun_ray_lantern_node_1
→ sun_ray_lantern_node_2
→ sun_ray_lantern_node_3
→ sun_ray_lantern_node_4
→ sun_ray_lantern_end
```

The exported controller paths are:

```text
../sun_ray_lantern_start
../sun_ray_lantern_node_1
../sun_ray_lantern_node_2
../sun_ray_lantern_node_3
../sun_ray_lantern_node_4
../sun_ray_lantern_end
```

`sun_ray_lantern_node_5` is intentionally excluded.

### Initial state

On ready and `reset_to_initial()`, the controller sets:

- index `0` / `sun_ray_lantern_start`: `COMPLETED`;
- index `1` / `sun_ray_lantern_node_1`: `ACTIVE_ENDPOINT`;
- indices `2` through `5`: `INACTIVE`;
- `_current_index = 1`;
- `_selected = null`;
- `_completed = false`;
- `_locked = false`.

The controller clears tracked streams and creates exactly one initial stream, `start → node_1`, with `is_initial = true`.

### Correct progression

The only accepted target is `target_index == source_index + 1`. Correct choices create permanent Sun Ray streams, mark the source completed, move the active endpoint forward, and preserve all successful route streams. The final `sun_ray_lantern_node_4 → sun_ray_lantern_end` segment marks the end completed, locks input, sets completion true, and emits `sun_ray_completed` once.

### Wrong reset lifecycle

Wrong choices create a temporary invalid stream, mark the selected source completed, mark the wrong target resetting, lock input, wait `wrong_segment_hold`, fade every non-initial Sun stream, preserve the initial stream, mark relay/end lanterns resetting during the fade, then restore the initial state. Interactions during `_locked` are ignored and cannot create duplicate streams or a second reset.

### Completion signal

`sun_ray_completed` is emitted by `SunRayPuzzleController._complete_puzzle()` after the final ordered segment. `_complete_puzzle()` starts with an explicit `_completed` guard so the signal is emitted at most once per load/reset lifecycle.

### Golden-orange palette

Sun Ray feedback uses a golden-orange palette centered on `Color(1.0, 0.58, 0.16, 1.0)` with highlights using `Color(1.0, 0.82, 0.34, 1.0)`. Particle geometry, flow speed, arc behavior, lifetime/fade concepts, visibility range, and density remain aligned with the Moon Ray implementation; density stays at `48` for this slice.

### node_5 treatment

`/root/Level_01/Sun Ray/sun_ray_lantern_node_5` remains in the scene with its existing parent, name, and transform. It is not included in `lantern_paths`, does not receive a Sun Ray interaction wrapper or prompt, does not create streams, and does not affect completion.

### Transform preservation

The seven serialized Sun Ray lantern transforms were captured before scene edits and compared after integration. The integration added only the controller resource/node and did not modify the serialized transform lines for:

- `sun_ray_lantern_start`
- `sun_ray_lantern_node_1`
- `sun_ray_lantern_node_2`
- `sun_ray_lantern_node_3`
- `sun_ray_lantern_node_4`
- `sun_ray_lantern_end`
- `sun_ray_lantern_node_5`

### Moon Ray status

Moon Ray scripts are unchanged. Moon Ray scene configuration is unchanged.

### Barrier status

Barrier behavior is unchanged. The Sun Ray controller has no barrier export, no barrier reference, and never calls `open_gate()`.

### Validation results

- Static Godot parsing/check-only was run for this slice.
- A targeted temporary validator at `/tmp/validate_sun_ray_puzzle.gd` was used to verify scene configuration, initial state, correct completion, wrong reset paths, cleanup, node_5 exclusion, and barrier safety.
- Regression diffs for Moon Ray and barrier scripts were checked and remained empty.

### Rendered QA status

Rendered gameplay QA: PARTIAL. Headless validation was completed, but this environment did not provide a reliable normal graphical gameplay renderer for visual confirmation. Color/readability should receive an in-editor visual pass later.

### Remaining risks

- Golden-orange color and prompt readability were validated structurally but still need a real rendered gameplay QA pass.
- The implementation is intentionally standalone; future dual completion/barrier coordination remains out of scope for this slice.

## Slice 3 - Dual Light Completion Coordinator

### Coordinator architecture

Slice 3 adds `Level01LightPuzzleCoordinator` as the Level 01 runtime owner for the celestial light barrier unlock. The coordinator is signal-driven and does not use `_process()` polling or per-frame state checks.

The coordinator node is added under `/root/Level_01/LevelRuntimeRoot` with these scene NodePaths:

- `moon_ray_controller_path = NodePath("../../Moon Ray/MoonRayPuzzleController")`
- `sun_ray_controller_path = NodePath("../../Sun Ray/SunRayPuzzleController")`
- `celestial_barrier_path = NodePath("../../Moon Ray/moon_ray_celestial_barrier")`

### Signals and state flags

The coordinator listens to:

- `MoonRayPuzzleController.puzzle_completed`
- `SunRayPuzzleController.sun_ray_completed`

It emits:

- `barrier_unlock_requested`
- `dual_light_completed`

Runtime state is tracked with local flags:

- `_moon_ray_completed`
- `_sun_ray_completed`
- `_barrier_unlock_requested`
- `_configuration_valid`

The barrier is opened only when Moon Ray and Sun Ray are both complete. `_barrier_unlock_requested` is set before `open_gate()` is called, which protects against reentrant duplicate unlock requests.

### Deferred synchronization and validation

During `_ready()`, the coordinator resolves all three exported NodePaths, verifies the required puzzle signals, verifies both controllers expose `debug_is_completed()`, verifies the barrier exposes `open_gate()`, connects signals once, marks configuration valid, then calls deferred `_synchronize_completion_state()`.

Deferred synchronization reads each controller's actual completion state through `debug_is_completed()` to avoid sibling `_ready()` order assumptions. If required debug APIs are absent, the coordinator treats that as a configuration blocker instead of guessing state.

### Completion orders

Both supported orders are now coordinated centrally:

- Moon first: Moon completion sets `_moon_ray_completed = true`, leaves `_sun_ray_completed = false`, keeps `_barrier_unlock_requested = false`, and does not open the barrier.
- Sun second: Sun completion sets both completion flags true, requests the unlock once, calls `open_gate()`, and emits `dual_light_completed` once.
- Sun first: Sun completion sets `_sun_ray_completed = true`, leaves `_moon_ray_completed = false`, keeps `_barrier_unlock_requested = false`, and does not open the barrier.
- Moon second: Moon completion sets both completion flags true, requests the unlock once, calls `open_gate()`, and emits `dual_light_completed` once.

Duplicate completion signals are ignored after their corresponding local completion flag is already true, and duplicate unlocks are blocked by `_barrier_unlock_requested`.

### Moon backward compatibility

`MoonRayPuzzleController` now exposes `open_barrier_on_completion: bool = true`. The default remains `true` so other scenes preserve the previous direct Moon-to-barrier behavior unless they opt out.

The controller also exposes `debug_is_completed() -> bool` for coordinator synchronization and targeted validation. The Moon correct sequence, wrong reset lifecycle, lantern interaction behavior, particle streams, prompt text, and Moon visuals are otherwise unchanged.

### Level 01 direct unlock disabled

In `Level_01.tscn`, `MoonRayPuzzleController.open_barrier_on_completion` is serialized as `false`. The existing `barrier_path = NodePath("../moon_ray_celestial_barrier")` remains for backward compatibility and minimal scene diff, but Level 01 no longer lets Moon completion directly open the celestial barrier.

### Barrier status

`moon_ray_celestial_barrier` remains at `/root/Level_01/Moon Ray/moon_ray_celestial_barrier`. The barrier node name, parent, transform, script, mesh, shader/material, collision shape, dissolve timing, visibility style, and `scripts/puzzles/celestial_barrier_gate.gd` implementation are unchanged.

### Transform preservation

Before editing the scene, serialized transform lines for all Sun Ray lanterns, Moon Ray lanterns, and `moon_ray_celestial_barrier` were saved to `/tmp/level01_slice3_transform_before.txt`. After scene integration, the same serialized lines were captured and compared with no differences.

### Validation results

Static and targeted validation for Slice 3 covered:

- coordinator node presence;
- all three coordinator NodePaths resolving;
- valid coordinator configuration;
- Moon `debug_is_completed()` presence;
- Moon `open_barrier_on_completion` presence and Level 01 value `false`;
- Moon-first and Sun-first completion order behavior;
- single-puzzle completion leaving the barrier closed/collidable;
- second completion opening the barrier;
- duplicate signal protection for unlock and `dual_light_completed` emission counts;
- absence of `_process()` in the coordinator;
- unchanged barrier script;
- unchanged Sun scripts;
- unchanged Moon lantern/stream behavior scripts;
- new scene instance reset to closed initial state.

### Rendered QA status

Rendered gameplay QA: PARTIAL. Headless validation was completed, but this environment did not provide a reliable normal graphical gameplay renderer for manual rendered confirmation. A later in-editor pass should visually confirm the barrier remains visible/collidable after the first puzzle and dissolves only after the second puzzle in both completion orders.

### Remaining risks

- The coordinator validator exercises scene integration and actual controller signals, but full player-path manual rendered QA remains pending because no normal graphical renderer was available in this environment.
- Barrier visibility polish, dual-color visual treatment, audio feedback, particle density changes, and finale changes remain intentionally out of scope for Slice 3.

## Slice 4 - Double Light Ray Particle Density

Slice 4 doubles the real particle density of the main Moon Ray and Sun Ray streams by changing the exported `particle_count` defaults from `48` to `96` in both puzzle controllers and both standalone particle stream scripts.

Changed defaults:

- `MoonRayPuzzleController.particle_count`: `48 → 96`
- `SunRayPuzzleController.particle_count`: `48 → 96`
- `MoonRayParticleStream.particle_count`: `48 → 96`
- `SunRayParticleStream.particle_count`: `48 → 96`

The controllers still assign `stream.particle_count = particle_count` before `_stream_root.add_child(stream)`, so initial streams, correct permanent streams, and temporary wrong streams receive the same configured density before each stream enters `_ready()`.

The actual runtime density remains tied to the particle stream `MultiMesh` allocation: both stream scripts continue to use `multimesh.instance_count = particle_count` in `_ready()`. Targeted validation confirmed the Moon `SilverParticleMultiMesh` and Sun `GoldenParticleMultiMesh` each allocate `96` instances for initial streams, newly created correct streams, and temporary wrong streams. The validator also confirmed each stream contains one `MultiMeshInstance3D`; density was not simulated with a second overlapping stream or a second `MultiMesh`.

Logical stream counts were not doubled. The initial stream count remains one per puzzle after load, one correct connection adds one logical stream, one wrong connection adds one temporary logical stream, and wrong reset cleanup returns each puzzle to the initial stream only. Reset did not revert either stream back to `48`.

Unchanged visual and timing parameters:

- flow speed remains `_age * 0.105`;
- `arc_height` remains `0.82`;
- `visibility_range` remains `38.0`;
- particle mesh radius and height remain unchanged;
- Moon silver and Sun golden-orange color palettes remain unchanged;
- alpha, sparkle, camera-distance fading, fade duration, wrong reset timing, stream naming, `source_id`, `target_id`, and `is_initial` behavior remain unchanged.

Coordinator and barrier regression status: the dual-light coordinator, celestial barrier gate, progression controller, finale controller, and Moon/Sun lantern scripts were not modified. Targeted validation confirmed coordinator state and barrier gating behavior remain unchanged: the barrier stays gated until both puzzles are complete.

Static validation completed with `git diff --check`, Godot editor parse, and Godot `--check-only`. Targeted validation completed with `/tmp/validate_light_ray_particle_density.gd`, covering Level 01 load, controller defaults, stream defaults through runtime instance counts, correct streams, wrong streams, wrong reset cleanup, logical stream counts, coordinator/barrier state, and single-MultiMesh-per-stream density implementation.

Rendered gameplay QA: PARTIAL. Headless validation passed, but this environment did not provide a reliable normal graphical gameplay renderer for manual visual confirmation. A later in-editor rendered pass should confirm Moon Ray and Sun Ray look approximately twice as dense without becoming solid opaque tubes, without color overexposure, without visible speed change, and without hitching during stream creation or wrong-stream fade cleanup.

Performance risks: each main light stream now allocates `96` instances instead of `48`, doubling per-stream MultiMesh instance work. The implementation keeps one `MultiMeshInstance3D` per logical stream, does not create duplicate overlay streams, and targeted validation confirmed `instance_count` is `96`, not `192`.

## Slice 5 - Visually Readable Celestial Barrier

Slice 5 improves the runtime-only visual readability of `moon_ray_celestial_barrier` without changing Level 01 scene serialization, puzzle completion logic, collision sizing, or coordinator ownership. The previous runtime structure was `CelestialMistWall`, `ClockwiseSunMoonSigil`, and one `CollisionShape3D`; the final runtime structure is `CelestialBarrierAura`, `CelestialMistWall`, `ClockwiseSunMoonSigil`, and one `CollisionShape3D`.

The new `CelestialBarrierAura` is created inside `CelestialBarrierGate._build_nodes()` before the base wall. It uses a programmatic unshaded spatial shader with `blend_mix`, `cull_disabled`, `depth_draw_never`, built-in `TIME`, no textures, no noise resources, and no external assets. The aura quad is `barrier_size * 1.06`, sits at local `z = -0.012`, blends silver-blue Moon color on the left into gold-orange Sun color on the right, includes a soft full-area mist fill, a stronger but still transparent outer frame, two slow diagonal/vertical energy waves, and a gentle pulse.

`CelestialMistWall` remains a `QuadMesh` at exact `barrier_size` and keeps unshaded two-sided alpha transparency. Its closed defaults are now `Color(0.58, 0.66, 0.82, closed_wall_alpha)` with emission `Color(0.62, 0.74, 0.98, 1.0)` and `closed_wall_emission`, making the barrier read as a visible ethereal volume without becoming an opaque wall or covering the sigil.

`ClockwiseSunMoonSigil` remains a runtime quad at `barrier_size * 0.72`, local `z = 0.012`, with the existing clockwise rotation speed and geometry masks for the sun ring, 12 sun rays, crescent moon, and outer celestial circle. Its shader now separates the Moon and Sun palettes: the moon mask is silver-blue, the sun mask is gold-orange, and the outer circle uses a smooth Moon-to-Sun gradient. The sigil stays transparent outside its masks and uses `alpha` plus `emission_boost` for readability against the mist wall.

Exact visual export defaults added in this slice:

- `closed_wall_alpha = 0.52`
- `closed_wall_emission = 1.05`
- `closed_aura_alpha = 0.44`
- `closed_symbol_alpha = 0.95`
- `aura_pulse_speed = 1.10`
- `aura_pulse_strength = 0.12`

The barrier node remains at `/root/Level_01/Moon Ray/moon_ray_celestial_barrier`, and the serialized Level 01 scene was not changed. The required barrier transform remains `Transform3D(0.9947279, 0, -0.10254952, 0, 1, 0, 0.10254952, 0, 0.9947279, -36.61529, 2.3624349, 194.6155)`. The collision contract is unchanged: the gate remains a `StaticBody3D`, keeps exactly one `CollisionShape3D`, and the `BoxShape3D` size remains `Vector3(barrier_size.x, barrier_size.y, 0.36)`.

The Level 01 coordinator contract is unchanged. The coordinator remains the sole Level 01 owner of opening the barrier, still requires Moon completed AND Sun completed, does not use barrier polling, and no Moon/Sun controller direct connection was added. Single-puzzle completion leaves the barrier visible, closed, and collidable. Dual completion disables collision immediately, starts the dissolve on all three visual layers, lowers the aura, mist wall, and sigil by `0.45`, hides the barrier at the end of `dissolve_duration`, and emits `dissolved` exactly once. Duplicate `open_gate()` calls still return immediately after the first open, so they do not create another tween, do not duplicate children, and do not emit a second signal.

Targeted validation was performed with `/tmp/validate_readable_celestial_barrier.gd`. The validator covered Level 01 loading, barrier NodePath, exact transform, `barrier_size`, collision depth, one collision shape, one aura, one mist wall, one sigil, closed material/export alpha and emission values, aura and symbol shader/material presence, distinct Moon/Sun shader colors, Moon-only and Sun-only closed state, dual-completion open state, immediate collision disable, visual alpha tweening to zero, hidden barrier after a shortened dissolve, single `dissolved` emission, duplicate-open safety, reload closed-state restoration, and unchanged scene/coordinator/Moon/Sun/progression/finale files.

Static validation completed with `git diff --check`, Godot headless editor parse, Godot `--check-only`, the targeted validator, and zero-diff checks for `Level_01.tscn`, the Level 01 coordinator, Moon/Sun controllers, Moon/Sun particle streams, Moon/Sun lantern scripts, progression controller, and finale controller. Shader validation was covered by the Godot headless editor/check-only runs and the targeted runtime material checks; both shaders are spatial, unshaded, two-sided, transparent, depth-draw-never, and resource-free.

Rendered gameplay QA: PARTIAL. Headless validation passed, but this environment did not provide a normal graphical gameplay renderer for manual visual confirmation. A later in-editor rendered pass should confirm the barrier is immediately readable as a closed passage, remains ethereal and transparent, shows silver-blue Moon and gold-orange Sun halves with a soft center blend, keeps the sigil distinct, dissolves all three layers synchronously after the second puzzle, remains visible from both sides, and has no distracting depth-sorting or performance artifacts.

Visual and performance risks: the aura uses a few lightweight shader math operations and one additional quad, so the expected runtime cost is low. The main visual risk is subjective brightness/readability tuning in the real renderer: the current defaults are intentionally stronger than the previous grey quad while keeping alpha capped and preserving transparency. Full rendered QA remains pending outside this headless environment.

## Slice 6 - Activated Lantern Completion Rings

Slice 6 adds a third runtime-only VFX layer to every configured Level 01 Moon Ray and Sun Ray lantern wrapper: a static emissive completion ring that appears only when the wrapper state is `LanternState.COMPLETED`. The previous wrapper VFX remain unchanged: Moon keeps `MoonRaySilverHalo` for state feedback and `MoonRaySelectedVerticalParticles` for selection feedback; Sun keeps `SunRayGoldenHalo` for state feedback and `SunRaySelectedVerticalParticles` for selection feedback.

New runtime node names:

- Moon wrappers create one direct child named `MoonRayActivatedRing`.
- Sun wrappers create one direct child named `SunRayActivatedRing`.

Both rings are created exactly once in each wrapper's `_build_runtime_nodes()` method. They are not added to custom lantern scenes, are not parented under `visual_target_path`, do not use collisions, and do not require serialized Level 01 scene hierarchy edits.

The activated rings use `TorusMesh` geometry with default exports `activated_ring_inner_radius = 0.48`, `activated_ring_outer_radius = 0.62`, `activated_ring_height = 0.18`, `activated_ring_alpha = 0.78`, and `activated_ring_emission = 1.20`. Runtime mesh defaults are `rings = 48` and `ring_segments = 16`; shadow casting is disabled. Invalid inner/outer radius ordering is handled locally at mesh creation so the wrapper does not fail with a runtime error.

Moon rings use a silver-blue transparent unshaded two-sided material with albedo `Color(0.78, 0.84, 0.90, activated_ring_alpha)`, emission `Color(0.86, 0.92, 1.0, 1.0)`, and emission energy from `activated_ring_emission`. Sun rings use a gold-orange transparent unshaded two-sided material with albedo `Color(1.0, 0.58, 0.16, activated_ring_alpha)`, emission `Color(1.0, 0.82, 0.34, 1.0)`, and the same emission default.

Completed-only visibility contract:

- `INACTIVE`: ring hidden; selected particles off; halo behavior unchanged.
- `ACTIVE_ENDPOINT`: ring hidden; selected particles off; endpoint halo remains unchanged.
- `SELECTED`: ring hidden; selected vertical particles still emit/restart; selected halo remains unchanged.
- `COMPLETED`: ring visible; selected particles off; completed halo remains unchanged.
- `RESETTING`: ring hidden; selected particles off; resetting halo remains unchanged.

Initial Level 01 integration: the configured Moon and Sun start lanterns are `COMPLETED`, node 1 is `ACTIVE_ENDPOINT`, and the remaining configured lanterns are `INACTIVE`, so targeted validation expects one visible Moon activated ring and one visible Sun activated ring immediately after load. Correct route progression accumulates one visible ring per completed configured node: after one correct connection each puzzle has two visible rings, full Moon completion has five visible rings, and full Sun completion has six visible rings. The excluded `sun_ray_lantern_node_5` remains outside the configured Sun sequence and does not receive a wrapper or activated ring.

Wrong-route behavior follows the existing controller lifecycle without controller changes. During the short wrong-segment hold, the selected source may briefly show a completed ring because the controller already transitions that source to `COMPLETED`; after `RESETTING` and full reset, targeted validation expects only the start ring to remain visible for each puzzle, with no stale false rings.

Regression notes: `MoonRaySelectedVerticalParticles.amount` and `SunRaySelectedVerticalParticles.amount` remain `24`; selected particles still emit only in `SELECTED`, and completed state does not start them. Existing halo node names, colors, alpha values, scale values, and selected particle behavior were preserved. The Level 01 scene, Moon/Sun puzzle controllers, Moon/Sun particle streams, celestial barrier gate, Level 01 light puzzle coordinator, progression controller, and finale controller were not modified.

Static validation for this slice includes `git diff --check`, Godot headless editor parse, Godot `--check-only`, zero-diff checks for the protected scene/controller/stream/barrier/coordinator/progression/finale files, and the targeted validator `/tmp/validate_activated_lantern_rings.gd`. The validator covers Level 01 loading, configured wrapper presence, single ring child counts, TorusMesh geometry, material colors, alpha/emission defaults, shadow settings, state visibility matrix, initial counts, correct path counts, full completion counts, wrong reset cleanup, duplicate ring prevention, selected particle amount/emission regression, halo constants, excluded Sun lantern safety, and protected-file cleanliness.

Rendered gameplay QA: PARTIAL. Headless validation can confirm runtime structure and state lifecycle, but this environment did not provide a reliable normal graphical gameplay renderer for manual visual confirmation. A later in-editor rendered pass should confirm the rings sit around the lantern bases, are horizontal, do not sink below terrain or float too high, remain readable from the gameplay camera, do not overlap prompts, do not conflict with spherical halos or selected vertical particles, do not make active endpoints look completed, and do not show depth flicker.

Visual and performance risks: the rings add one static unshaded transparent `TorusMesh` per configured wrapper, so runtime cost should remain low. The main remaining risk is subjective visual tuning in a real renderer: base height, brightness, and transparency may need polish after manual QA, but no animation, lights, audio, particles, or extra resources were added in Slice 6.

## Slice 7 - Selected Lantern Beacons

### Scope and existing wrapper VFX

Slice 7 adds a fourth, separate runtime VFX layer for the currently selected source lantern only. Existing wrapper VFX remain intact:

- Moon wrapper: `MoonRaySilverHalo`, `MoonRaySelectedVerticalParticles`, and `MoonRayActivatedRing`.
- Sun wrapper: `SunRayGoldenHalo`, `SunRaySelectedVerticalParticles`, and `SunRayActivatedRing`.

The halo remains the local state indicator, selected vertical particles remain the dynamic local selection feedback, and activated rings remain the permanent `COMPLETED` marker.

### Runtime beacon nodes

Each configured Moon wrapper now creates exactly one direct child named `MoonRaySelectedBeacon` in `_build_runtime_nodes()`. Each configured Sun wrapper creates exactly one direct child named `SunRaySelectedBeacon` in `_build_runtime_nodes()`. The beacons are not serialized into `Level_01.tscn`, are not placed under the visual target, selected particles, or activated ring, and do not add collision or Light3D nodes.

### CylinderMesh geometry and placement

Both Moon and Sun beacons use a runtime `CylinderMesh` with the exported defaults:

- `top_radius = 0.10`
- `bottom_radius = 0.10`
- `height = 4.20`
- `radial_segments = 24`
- `rings = 2`
- `cap_top = false`
- `cap_bottom = false`

Shadows are disabled. The beacon position is `beam_anchor_offset + Vector3(0.0, selected_beacon_height * 0.5, 0.0)`, so the lower edge starts at the beam anchor and extends upward without changing the wrapper, visual target, lantern model, or anchor transforms.

### Materials, colors, and shader behavior

Each beacon receives a runtime `ShaderMaterial` from a local wrapper shader function. Moon uses `Color(0.70, 0.84, 1.0, 1.0)` for a silver-blue column; Sun uses `Color(1.0, 0.64, 0.18, 1.0)` for a golden-orange column. Both wrappers expose matching defaults:

- `selected_beacon_height = 4.20`
- `selected_beacon_radius = 0.10`
- `selected_beacon_alpha = 0.34`
- `selected_beacon_emission = 1.30`
- `selected_beacon_pulse_speed = 1.35`
- `selected_beacon_pulse_strength = 0.10`

The shader is `spatial` with `render_mode unshaded, blend_add, cull_disabled, depth_draw_never`. It uses `TIME` for a soft upward-flowing band and gentle pulse, fades in from the bottom, dissolves near the top, does not use external textures/resources, and clamps final alpha to `0.58`.

### Selected-only visibility and lifecycle results

The beacon visibility matrix is selected-only for both puzzles:

| State | Beacon | Selected particles | Activated ring |
| --- | ---: | ---: | ---: |
| `INACTIVE` | hidden | off | hidden |
| `ACTIVE_ENDPOINT` | hidden | off | hidden |
| `SELECTED` | visible | on | hidden |
| `COMPLETED` | hidden | off | visible |
| `RESETTING` | hidden | off | hidden |

Initial Level 01 beacon counts remain `0` for Moon and `0` for Sun because the start lantern is `COMPLETED`, node 1 is `ACTIVE_ENDPOINT`, and all remaining configured lanterns are `INACTIVE`. Selecting the current active endpoint produces exactly one visible beacon, keeps the selected particles emitting, and keeps the completion ring hidden. Repeating interaction with the selected source cancels selection and returns the visible beacon count to `0` with selected particles off. Correct connections hide the source beacon, switch the source to its completion ring, and leave the new target without a beacon until it is explicitly selected. Wrong target cleanup hides the source beacon immediately after leaving `SELECTED`, keeps visible beacon count at `0` during the wrong hold/fade/reset, and does not leave stale beacons. Full Moon completion ends with `0` visible Moon beacons and `5` visible Moon completion rings; full Sun completion ends with `0` visible Sun beacons and `6` visible Sun completion rings.

### Regression notes

Selected particle regression was preserved: amount remains `24`, lifetime `0.85`, randomness `0.35`, and direction `Vector3.UP`. Completion ring geometry, material setup, and completed-only visibility from Slice 6 remain unchanged. Halo constants remain unchanged: `ACTIVE_ENDPOINT` alpha `0.42` / scale `1.08`, `SELECTED` alpha `0.72` / scale `1.22`, `COMPLETED` alpha `0.30`, and `RESETTING` alpha `0.14`.

Scene/controller/stream/barrier/coordinator regression was kept in scope: `Level_01.tscn`, both puzzle controllers, both ray particle stream scripts, the celestial barrier gate, the light puzzle coordinator, progression controller, and finale controller were not modified. `sun_ray_lantern_node_5` remains outside the configured Sun sequence and receives no wrapper or beacon.

### Validation and QA

Static validation for this slice includes `git diff --check`, Godot editor parse, Godot check-only, the targeted selected beacon validator, and explicit zero-diff checks for the scene, controllers, stream scripts, barrier, coordinator, progression controller, and finale controller.

Targeted validation covers Level 01 loading, configured wrapper discovery, one direct beacon child per wrapper, CylinderMesh geometry, disabled caps/shadows, ShaderMaterial uniforms and `TIME`, Moon/Sun colors, state visibility matrix, initial counts, selection/cancel, correct connection cleanup, wrong reset cleanup, full completion ring counts, duplicate prevention, maximum simultaneous beacon count, particle/halo/ring regressions, and excluded Sun node 5.

Rendered gameplay QA is `PARTIAL` in headless validation environments. Visual risks to verify in a normal renderer are beacon height/readability, blend strength, edge softness, and whether particles remain distinguishable inside the column. Performance risk is low because each configured wrapper adds one simple unlit cylinder mesh and shader-driven animation only; no CPU `_process()`, recurring tweens, timers, signals, external textures, or real Light3D nodes were added.
