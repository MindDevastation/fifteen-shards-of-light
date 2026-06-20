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
- Level 01 real finale text selected size in the earlier text-size-only validation was `60` at `1920x1080` and `60` at `1280x720`; the later safe-layout correction below supersedes the final layout metrics.

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
- The earlier widened/tallened finale safe-area proportions were superseded by the later safe-layout correction below, which restores the safe-area ratio to `0.80` and reserves the fox-emblem zone.

### Real Level 01 Finale Line Breaks
- Real text source: `scenes/levels/Level_01.tscn`, `Level01FinaleController.finale_text`.
- The approved words were preserved and split into `6` meaningful lines.
- Earlier validation result at `1920x1080`: selected font size `72`, width fit `true`, height fit `true`; superseded by the safe-layout correction metrics below.
- Earlier validation result at `1280x720`: selected font size `64`, width fit `true`, height fit `true`; superseded by the safe-layout correction metrics below.

## Finale Rendered Safe Layout Correction
- Old safe area ratio: `0.98`.
- New safe area ratio: `0.80` of the vine-frame inner rect before the fox-emblem reserved zone is subtracted.
- Old frame rect: `Rect2(Vector2(vp.x * 0.02, vp.y * 0.02), Vector2(vp.x * 0.96, vp.y * 0.88))`.
- New frame rect: `Rect2(Vector2(vp.x * 0.045, vp.y * 0.045), Vector2(vp.x * 0.91, vp.y * 0.85))`.
- Emblem reserved height: `maxf(90.0, vp.y * 0.14)`; validated values were `95.76 px` at `1216x684`, `100.8 px` at `1280x720`, and `151.2 px` at `1920x1080`.
- Text vertical offset: previous `TEXT_BLOCK_VERTICAL_OFFSET_RATIO = -0.05` is superseded by the real-metrics correction below, which uses `-0.02`.
- Line gap: the previous `LINE_GAP_RATIO = -0.14` value is superseded by the real-metrics correction below; negative line gaps are no longer used.
- Horizontal italic margin: `ITALIC_VISUAL_MARGIN = 28.0`; horizontal padding also includes outline and shadow X offset. The previous `MIN_TEXT_WIDTH_SCALE`/horizontal label scaling approach is superseded by the real-metrics correction below.
- Previous selected font size at `1216x684`: `60`; superseded by the real-metrics correction below.
- Previous selected font size at `1280x720`: `60`; superseded by the real-metrics correction below.
- Previous selected font size at `1920x1080`: `72`; superseded by the real-metrics correction below.
- Six line mask rects at `1216x684`:
  - line 1: `Rect2(Vector2(271.9062, 94.39201), Vector2(672.1877, 67.24))`
  - line 2: `Rect2(Vector2(249.3318, 152.2184), Vector2(717.3366, 67.24001))`
  - line 3: `Rect2(Vector2(180.078, 210.0448), Vector2(855.8441, 67.23999))`
  - line 4: `Rect2(Vector2(175.104, 267.8712), Vector2(865.7921, 67.23999))`
  - line 5: `Rect2(Vector2(318.2029, 325.6976), Vector2(579.5944, 67.23999))`
  - line 6: `Rect2(Vector2(284.15, 383.524), Vector2(647.7003, 67.23999))`
- Six line mask rects at `1280x720`:
  - line 1: `Rect2(Vector2(286.5964, 99.36), Vector2(706.8073, 67.24001))`
  - line 2: `Rect2(Vector2(262.7454, 157.1864), Vector2(754.5093, 67.23999))`
  - line 3: `Rect2(Vector2(189.5753, 215.0128), Vector2(900.8495, 67.24001))`
  - line 4: `Rect2(Vector2(184.32, 272.8392), Vector2(911.36, 67.23999))`
  - line 5: `Rect2(Vector2(335.5112, 330.6656), Vector2(608.9777, 67.23999))`
  - line 6: `Rect2(Vector2(299.5326, 388.492), Vector2(680.9349, 67.23999))`
- Six line mask rects at `1920x1080`:
  - line 1: `Rect2(Vector2(442.9999, 159.375), Vector2(1034.0, 82.5))`
  - line 2: `Rect2(Vector2(407.4999, 230.325), Vector2(1105.0, 82.49998))`
  - line 3: `Rect2(Vector2(299.4999, 301.275), Vector2(1321.0, 82.5))`
  - line 4: `Rect2(Vector2(290.9999, 372.225), Vector2(1338.0, 82.5))`
  - line 5: `Rect2(Vector2(514.9999, 443.175), Vector2(890.0001, 82.50003))`
  - line 6: `Rect2(Vector2(461.9999, 514.125), Vector2(996.0001, 82.5))`
- Previous targeted geometry validation with synthetic line-height/scaling assumptions is superseded by the real-metrics correction below.
- Rendered screenshot QA performed: no. A headless screenshot attempt could not read a viewport texture in this environment because Godot used dummy rendering storage, so visual completion is not claimed.


## Finale Real Font Metrics and Non-Overlapping Line Geometry
- Removed horizontal scaling: `MIN_TEXT_WIDTH_SCALE`, `_text_width_scale()`, `width_scale`, and `label.scale = Vector2(width_scale, 1.0)` were removed from `LevelFinaleOverlay`.
- Labels now use `label.scale = Vector2.ONE`; no line passes width fit by compressed font proportions.
- Old visual line-height formula superseded: `float(font_size) + outline * 0.5 + shadow + reveal + padding`.
- New font-height formula: `_glyph_visual_height(font_size, scale_factor)` uses `REWARD_FONT.get_height(font_size) + outline * 2.0 + abs(shadow_y) + vertical_padding * 2.0`.
- Glyph visual height, mask height, and line advance are now separated:
  - `glyph_height = _glyph_visual_height(font_size, scale_factor)`
  - `mask_height = glyph_height + reveal_offset`
  - `line_gap = maxf(1.0, glyph_height * LINE_GAP_RATIO)` with `LINE_GAP_RATIO = 0.02`
  - `line_advance = glyph_height + line_gap`
  - `total_mask_height = mask_height + line_advance * (line_count - 1)`
- The approved Level 01 finale words/order were preserved, but line breaks were redistributed into six balanced lines to avoid width clipping without horizontal scaling.
- Selected size at `1216x684`: no valid candidate under the combined constraints. At minimum font size `60`, real font metrics require a mask block taller than the current `0.80` safe rect after the fox-emblem reservation.
- Selected size at `1280x720`: no valid candidate under the combined constraints. At minimum font size `60`, real font metrics require a mask block taller than the current `0.80` safe rect after the fox-emblem reservation.
- Selected size at `1920x1080`: `60`; validation metrics: font height `74.00`, outline `6`, shadow `(3, 3)`, glyph visual height `92.00`, reveal offset `1.50`, mask height `93.50`, line gap `1.84`, line advance `93.84`, total mask height `562.70`, safe rect `Rect2(Vector2(276.48, 149.04), Vector2(1367.04, 565.92))`.
- Mask overlap validation: passed at `1920x1080`; blocked at `1216x684` and `1280x720` because no valid six-line layout exists without violating the preserved safe-area/emblem/font-size/no-scaling constraints.
- Rendered screenshot QA status: not performed. A normal graphical Godot editor/player renderer is not available in this non-interactive headless environment; visual completion is not claimed.
- Screenshot path: none.

## Dynamic Resolution-Based Finale Text Sizing
- Removed fixed-size constraints superseded by this pass: `FINALE_FONT_CANDIDATES = [72, 68, 64, 60]`, `FINALE_MIN_FONT_SIZE = 60`, the whole-frame `FINALE_TEXT_SAFE_AREA_RATIO`, the full-width `FOX_EMBLEM_RESERVED_HEIGHT_RATIO` subtraction, the fixed `ITALIC_VISUAL_MARGIN`, and the ratio-based negative/legacy line-gap approach.
- Responsive frame ratios: `FRAME_WIDTH_RATIO = 0.84`, `FRAME_HEIGHT_RATIO = 0.84`; the vine frame is centered and occupies `84%` of viewport width and height.
- Responsive text-area ratios: `TEXT_AREA_WIDTH_RATIO = 0.84`, `TEXT_AREA_HEIGHT_RATIO = 0.82`, with `TEXT_AREA_VERTICAL_BIAS_RATIO = -0.025` to keep the text field slightly above the lower fox emblem without subtracting a hard `90-100 px` band from the whole text rectangle.
- Font sizing base: `BASE_VIEWPORT_HEIGHT = 1080.0`, `BASE_MAX_FONT_SIZE = 72.0`, `ABSOLUTE_MIN_FONT_SIZE = 24`, `ABSOLUTE_MAX_FONT_SIZE = 96`.
- Responsive maximum formula: `BASE_MAX_FONT_SIZE * min(viewport.x / 1920.0, viewport.y / BASE_VIEWPORT_HEIGHT)`, clamped to the absolute min/max.
- Largest-fit search algorithm: starting at the responsive maximum, test every integer font size down to `ABSOLUTE_MIN_FONT_SIZE`; the first size whose real width and full mask-block height fit is selected.
- Width fit uses real font metrics plus responsive italic/outline/shadow padding; horizontal text scaling remains removed and every finale label uses `label.scale = Vector2.ONE`.
- Height fit uses `REWARD_FONT.get_height(font_size)`, responsive outline on both sides, shadow, vertical padding, reveal offset, and positive line gap. Mask height and line advance are separate and masks do not overlap.
- Selected sizes from `/tmp/validate_dynamic_finale_layout.gd`:
  - `960x540`: responsive max `36`, selected `36`, frame `84% x 84%`, text field `84% x 82%`, total mask block `336.30 px`.
  - `1216x684`: responsive max `46`, selected `46`, frame `84% x 84%`, text field `84% x 82%`, total mask block `418.75 px`.
  - `1280x720`: responsive max `48`, selected `48`, frame `84% x 84%`, text field `84% x 82%`, total mask block `444.00 px`.
  - `1600x900`: responsive max `60`, selected `60`, frame `84% x 84%`, text field `84% x 82%`, total mask block `553.50 px`.
  - `1920x1080`: responsive max `72`, selected `72`, frame `84% x 84%`, text field `84% x 82%`, total mask block `651.00 px`.
  - `2560x1440`: responsive max `96`, selected `96`, frame `84% x 84%`, text field `84% x 82%`, total mask block `850.20 px`.
- Resize handling: `get_viewport().size_changed` is connected in `LevelFinaleOverlay._ready()` and triggers responsive frame/text/button relayout, text relayout, vine rebuild while visible, and redraw.
- Rendered QA status: PARTIAL. Responsive geometry validation passed; ordinary graphical Godot player screenshot QA was not performed because this container cannot initialize X11 or Wayland display drivers (`libXcursor.so.1` and `libwayland-client.so.0` are unavailable).
- Screenshot paths: none.
- Superseded earlier statements: the previous minimum font size `60`, fixed candidate list `[72, 68, 64, 60]`, and “layout impossible at 720p” conclusion no longer apply; `1216x684` and `1280x720` now select dynamic sizes `46` and `48` respectively and pass geometry validation.

## Finale Resize-Safe Reveal State and Semantic Line Layout
- `TextRevealState` now explicitly separates `HIDDEN`, `REVEALING`, and `REVEALED` states for the finale text reveal lifecycle.
- Initial layout behavior: first show uses hidden labels, places each label at `settled_y + reveal_offset`, sets alpha to `0.0`, then starts the reveal sequence with a new generation id.
- Resize behavior after `REVEALED`: relayout uses `initially_hidden = false`, restores each visible label to alpha `1.0`, and snaps each label to its stored `settled_y` without replaying the reveal animation.
- Resize behavior during `REVEALING`: only text reveal tweens are cancelled, a new responsive layout is created hidden, and the text reveal sequence restarts from the beginning without restarting atmosphere, vine opening, fox button, portal, or any unrelated finale sequence.
- Text tween cancellation: `_text_reveal_tweens` tracks text reveal tweens separately from general finale tweens; `_cancel_text_reveal_tweens()` kills only those tweens and advances `_text_reveal_generation`.
- Generation/stale callback protection: `_start_text_reveal_sequence()` captures the active generation, and async continuations return early if their generation no longer matches `_text_reveal_generation`.
- Deferred resize coalescing: `_on_viewport_size_changed()` sets `_resize_relayout_pending` and uses `_apply_deferred_viewport_relayout()` so repeated resize events collapse into one relayout per frame.
- Semantic six-line text restored:
  1. `Когда ты появилась в моей жизни,`
  2. `мир не стал громче - он стал теплее.`
  3. `В этом не было драмы или резкого поворота,`
  4. `просто рядом с мыслью о тебе стало светлее.`
  5. `Мне дорого это первое тепло,`
  6. `потому что с него все и началось`
- Words changed: no. Word order changed: no. Punctuation changed: no.
- Superseded technical line breaks: the previous `В этом не было драмы или резкого / поворота...` and `стало светлее. Мне дорого... / тепло...` split is no longer used.
- Selected font sizes after semantic-line restoration from `/tmp/validate_dynamic_finale_layout.gd`:
  - `960x540`: responsive max `36`, selected `36`, widest line `просто рядом с мыслью о тебе стало светлее.`, visual width `661.00 px`, text safe width `677.38 px`.
  - `1216x684`: responsive max `46`, selected `46`, widest visual width `837.24 px`, text safe width `858.01 px`.
  - `1280x720`: responsive max `48`, selected `48`, widest visual width `877.12 px`, text safe width `903.17 px`.
  - `1600x900`: responsive max `60`, selected `60`, widest visual width `1093.40 px`, text safe width `1128.96 px`.
  - `1920x1080`: responsive max `72`, selected `72`, widest visual width `1311.68 px`, text safe width `1354.75 px`.
  - `2560x1440`: responsive max `96`, selected `96`, widest visual width `1744.00 px`, text safe width `1806.34 px`.
- Resize validation results: `/tmp/validate_finale_resize_state.gd` passed hidden-overlay resize, fully revealed resize to larger/smaller viewports, resize during reveal with text-only tween cancellation/restart, and rapid resize coalescing.
- Reveal geometry validation: initial hidden layout keeps each label at `settled_y + reveal_offset`; fully revealed layout keeps each label at `settled_y`, alpha `1.0`, `label.scale = Vector2.ONE`, and non-overlapping masks.
- Rendered QA status: PARTIAL. Responsive geometry and resize-state validation passed; ordinary graphical Godot player screenshot QA was not performed because this container cannot initialize X11 or Wayland display drivers.

## Finale Vine Progress Preservation and Tween Registry Cleanup
- Old `_build_vines()` behavior: rebuilding responsive vine geometry always ended with `_set_left_progress(0.0)` and `_set_right_progress(0.0)`, so a viewport resize could make a fully open frame disappear or make opening/closing vines jump back to the start.
- New progress-preserving behavior: `_build_vines()` snapshots `_left_progress` and `_right_progress` before clearing branch/leaf geometry, rebuilds the viewport-dependent paths, branches, and leaves, then reapplies each side's preserved progress to the new `Line2D` point arrays.
- Initial build behavior: `_reset_visuals()` still sets both progress values to `0.0` before the first build, so the first opening sequence starts from the same hidden frame state.
- Opening resize behavior: a partial opening state such as left/right `0.43` remains `0.43` after responsive geometry rebuild; the existing opening tween continues driving progress toward `1.0` without restarting the finale overlay or atmosphere.
- Open resize behavior: fully open progress `1.0 / 1.0` remains fully visible after resizing to larger and smaller viewports; new left/right paths receive visible points immediately after rebuild.
- Closing resize behavior: partial closing progress such as `0.58 / 0.58` is preserved across rebuild, and subsequent close values `0.40`, `0.20`, and `0.0` continue shortening the rebuilt paths.
- Left/right asymmetric progress validation: independent values such as left `0.31` and right `0.67` remain independent after resize; one side's progress is not copied to the other.
- Text tween cleanup behavior: completed reveal tweens are removed from both `_text_reveal_tweens` and `_active_tweens` via `_untrack_text_reveal_tween()` before reveal state transitions to `REVEALED`.
- Active tween registry behavior: cancelled text reveal tweens are cancelled from a duplicate list, removed from `_active_tweens`, cleared from `_text_reveal_tweens`, and guarded by an incremented `_text_reveal_generation`; `_kill_tweens()` also clears both registries and invalidates stale reveal continuations.
- Rapid resize validation: repeated viewport changes coalesce into one deferred relayout, preserve vine progress, and do not create unbounded branch, leaf, active tween, or text reveal tween growth.
- Superseded resize-handling note: the earlier resize-safe text reveal section did not yet cover vine progress preservation or active registry cleanup for text reveal tweens; this section completes that remaining runtime fix.
- Targeted validation status: `/tmp/validate_finale_vine_resize_progress.gd` passed open, opening, asymmetric, closing, and rapid-resize vine progress checks; `/tmp/validate_finale_tween_cleanup.gd` passed completed, cancelled, repeated-resize, and full-reset text reveal tween registry cleanup checks.
- Rendered QA status: PARTIAL. Vine-progress and tween-registry validation passed headlessly; ordinary graphical resize QA was not performed because this container cannot initialize X11 or Wayland display drivers.
