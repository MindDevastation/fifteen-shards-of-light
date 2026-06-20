# Level 01 Moon Ray and Text Fix Report

## Scope
- Removed the legacy Level 01 `LightRoute` mini-game runtime from `Level_01.tscn` and deleted its obsolete scripts/resources.
- Implemented only `ray_id = moon` using reusable Moon Ray controller, lantern interaction anchors, particle stream, and celestial barrier scripts.
- Did not implement Sun Ray gameplay.
- Did not change portal, clouds, main level geometry, player collision, Help Stone, Soul Orb, approved text content, or other levels.

## Removed legacy runtime
- Removed node tree: `Level_01/SideIslandLampPuzzle` including `SourceWarm`, `SourceMoon`, `WarmRelay01-04`, `MoonRelay01-03`, `WarmDestination`, `MoonDestination`, sockets, old `LampBarrierGate`, old `RuntimeBeams`, old `SelectionColumn`, old `GlowLight`, old `InteractionArea`, and old `WorldInteractionPrompt` additions.
- Removed scene sub-resources for legacy lamp meshes/columns/interactions/barrier.
- Deleted scripts: `light_route_puzzle_controller.gd`, `light_route_lamp.gd`, `light_route_beam.gd`, `light_route_barrier_gate.gd` and their `.uid` files.
- Runtime old-reference search in `scenes/` and `scripts/`: zero remaining matches for `LightRoute`, `SourceWarm`, `SourceMoon`, `WarmRelay`, `MoonRelay`, `WarmDestination`, `MoonDestination`, `LampBarrierGate`, `orange beam`, `cyan beam`.

## Required Moon Ray visual node paths
- `/root/Level_01/Moon Ray/moon_ray_lantern_start`
- `/root/Level_01/Moon Ray/moon_ray_lantern_node_1`
- `/root/Level_01/Moon Ray/moon_ray_lantern_node_2`
- `/root/Level_01/Moon Ray/moon_ray_lantern_node_3`
- `/root/Level_01/Moon Ray/moon_ray_lantern_end`

## Moon Ray route
- Correct route: `moon_ray_lantern_start -> moon_ray_lantern_node_1 -> moon_ray_lantern_node_2 -> moon_ray_lantern_node_3 -> moon_ray_lantern_end`.
- Initial segment: `moon_ray_lantern_start -> moon_ray_lantern_node_1` exists immediately.
- Initial active endpoint: `moon_ray_lantern_node_1`.
- Start is never selectable as a new target.
- Previously activated route nodes are not valid new targets during normal interaction.

## Wrong-route reset behavior
- Wrong segment is created and held for `0.28s`.
- Non-initial segments fade for `0.82s`.
- Interaction is locked during reset.
- After reset only the initial stream remains and `moon_ray_lantern_node_1` is restored as the active endpoint.
- Barrier remains closed during all wrong-route resets.

## Particle implementation
- `MoonRayParticleStream` uses `MultiMeshInstance3D` with `48` small sphere particles per segment.
- Palette is silver/cool light gray with occasional soft white sparkle particles.
- Stream follows a moving arced path with size variation, flicker, and sine taper near endpoints.
- It is not a tube mesh and does not add dynamic `Light3D`.
- Visibility behavior: distance fade starts at `38m` and fades out over the next `14m` from camera distance to source anchor.

## Barrier
- Node path: `/root/Level_01/Moon Ray/moon_ray_celestial_barrier`.
- Before completion: visible and collision enabled.
- Visual implementation: translucent procedural quad wall plus shader-based rotating sun/moon sigil.
- Rotation: clockwise, `-0.28 rad/s` around local forward axis.
- Dissolve duration: `2.2s`.
- Completion result: collision disables immediately, alpha/emission dissolve over duration, then barrier hides; one-shot `_opened` protection prevents reactivation.

## Finale text sizing
- Previous selected font size could fall to about `10` because `_layout_finale_text()` iterated `[60, 56, 52, ... 10]`, multiplied every candidate by viewport `scale_factor`, then used a separate `10 * scale_factor` fallback.
- New candidate range: `[72, 68, 64, 60]`.
- Minimum finale font size: `60`.
- No finale fallback below `60` remains.
- Runtime diagnostics are available behind `FINALE_LAYOUT_DIAGNOSTICS = false` and print: text length, candidate font size, line count, fit by width, fit by height, selected font size.
- Level 01 real finale text selected size in validation: `60` at `1920x1080` and `60` at `1280x720`.

## Shard reward text sizing
- Runtime call chain: `SoulShard.reward_sequence_requested` -> `ShardRewardSequenceController._on_reward_sequence_requested()` -> `ShardRewardOverlay.play_reward()` -> `$TextRoot/RewardText` (`RichTextLabel`) -> `_apply_responsive_layout()` font-size overrides.
- UI path: `/root/Level_01/UILayer/ShardRewardOverlay/TextRoot/RewardText`.
- Runtime font size source of truth: `SHARD_REWARD_FONT_SIZE = 54`.
- Size is not multiplied by viewport scale.

## Validation results
- Preflight status/diff checks: passed before edits.
- `git diff --check`: passed.
- `timeout 300s godot --headless --editor --path . --quit`: passed.
- `godot --headless --path . --quit --check-only`: passed.
- `/tmp/validate_moon_ray_puzzle.gd`: passed for initial segment, correct route, barrier open only after full route, and wrong routes `node_1 -> node_3`, `node_1 -> end`, `node_2 -> end`.
- `/tmp/validate_text_sizes.gd`: passed for finale size range and shard reward size `54` at `1920x1080` and `1280x720` with short, real Level 01, 4-line, 5-line, and 6-line samples.

## QA and risks
- Graphical QA performed: no screenshot/video capture; headless validation only.
- Performance measured: not with a profiler; particle count is documented at `48` per stream and runtime test passed.
- Remaining manual QA: inspect in Godot/player for exact barrier placement, readability inside vine frame, and subjective silver-particle look near puzzle island.

## Corrective review update

### Visual Target Binding Fix
- The controller now creates each `MoonRayLanternNode` wrapper and binds it with a direct `Node3D` reference via `bind_visual_target(visual)` instead of passing a controller-relative `NodePath` that would later be resolved from the wrapper's reference frame.
- `visual_target_path` remains only as an inspector/debug fallback; runtime wrappers use `_visual_target` for global position sync and beam-anchor calculation.
- The five validated visual target paths are:
  - `/root/Level_01/Moon Ray/moon_ray_lantern_start`
  - `/root/Level_01/Moon Ray/moon_ray_lantern_node_1`
  - `/root/Level_01/Moon Ray/moon_ray_lantern_node_2`
  - `/root/Level_01/Moon Ray/moon_ray_lantern_node_3`
  - `/root/Level_01/Moon Ray/moon_ray_lantern_end`

### Wrapper and Lantern Position Validation
- `moon_ray_lantern_start_interaction_anchor`: position delta `0.0`, beam anchor `(-36.6754, 4.727562, 152.5835)`.
- `moon_ray_lantern_node_1_interaction_anchor`: position delta `0.0`, beam anchor `(-36.65438, 1.336296, 159.1538)`.
- `moon_ray_lantern_node_2_interaction_anchor`: position delta `0.0`, beam anchor `(-36.74087, 1.303426, 173.7254)`.
- `moon_ray_lantern_node_3_interaction_anchor`: position delta `0.0`, beam anchor `(-39.83521, 1.303426, 181.9941)`.
- `moon_ray_lantern_end_interaction_anchor`: position delta `0.0`, beam anchor `(-38.28106, 2.81885, 193.0053)`.
- Initial stream length: `7.39395236968994` world units.
- Validation confirmed all five `Area3D` interaction nodes share their wrapper global positions and all prompt targets point at the real wrapper nodes.

### Completed Node Reuse Prevention
- `can_lantern_be_interacted()` now requires the current endpoint to be in `ACTIVE_ENDPOINT` state before selection and requires a selected target to be `INACTIVE`.
- `_try_connect()` repeats the inactive-target check so completed nodes cannot be reused through direct calls or stale prompts.
- Forbidden reuse validation passed for `node_2 -> node_1`, `node_3 -> node_1`, `node_3 -> node_2`, and start-as-target.
- Wrong forward route validation remains allowed for `node_1 -> node_3`, `node_1 -> end`, and `node_2 -> end`; these routes still trigger the soft reset with the barrier closed.

### Selected Vertical Particle Configuration
- `MoonRaySelectedVerticalParticles` now has a real `ParticleProcessMaterial`.
- Configuration: amount `24`, lifetime `0.85`, direction `Vector3.UP`, spread `10.0`, initial velocity `0.55-0.95`, gravity `Vector3.ZERO`, sphere emission radius `0.10`, scale `0.45-1.20`, silver color `Color(0.82, 0.88, 0.96, 0.78)`.
- Draw pass: small `SphereMesh` with transparent unshaded emissive silver material; no `Light3D` was added.
- State validation confirmed `SELECTED -> emitting true`, cancel/success/reset -> `emitting false`.

### Finale Invalid Layout Rejection
- The unsafe fallback that merged overflow text into a sixth line was removed.
- `_layout_finale_text()` now returns a valid layout only when line count is at most `6` and both width and height fit.
- Invalid oversized text returns `valid = false`, `lines = []`, and `font_size = 60`; it logs an error instead of returning a clipping layout.
- Finale responsive safe-area proportions were widened/tallened and padding was reduced so the approved Level 01 text can fit while keeping font size in `[72, 68, 64, 60]`.

### Real Level 01 Finale Line Breaks
- Real text source: `scenes/levels/Level_01.tscn`, `Level01FinaleController.finale_text`.
- The approved words were preserved and split into `6` meaningful lines.
- Validation result at `1920x1080`: selected font size `72`, width fit `true`, height fit `true`.
- Validation result at `1280x720`: selected font size `64`, width fit `true`, height fit `true`.
