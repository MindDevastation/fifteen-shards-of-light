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
