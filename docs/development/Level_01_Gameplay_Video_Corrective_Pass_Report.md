# Level 01 Gameplay Video Corrective Pass Report

- Date: 2026-06-17
- Current PR number: 89
- Current PR URL: https://github.com/MindDevastation/fifteen-shards-of-light/pull/89
- Base branch: `feature/implement-level-01-finale-and-portal-transitions`
- Base SHA from PR #89 review context: `cf9d3dc73b6e7762e6f38570011c342efbaa0fe5`
- Remote head branch: `feature/-level_01`
- Initial reviewed remote head: `2bb86d40bb26a2c2b636f46e4a5d9b464a8710c1`
- Local pre-correction baseline in this checkout: `8e3a30c` (`Level 01 gameplay video corrective pass`)
- Final verified remote SHA: `NOT VERIFIED` until push/`git ls-remote` succeeds.
- Remote commit count: `NOT VERIFIED` until push/PR refresh succeeds; last provided remote count was `1` before this targeted corrective pass.
- PR #88 presence proof: baseline contains `maxi()`/`maxf()` in `scripts/vfx/firefly_cluster_3d.gd`, `_configure_line_group()` and `FoxConfirmButtonType` preload in `scripts/ui/level_finale_overlay.gd`, and `FoxConfirmButtonType` preload in `scripts/ui/shard_reward_overlay.gd`.
- No-merge confirmation: no merge was performed.
- Auto-merge confirmation: auto-merge was not enabled.

## Files Changed

Created:
- `scenes/ui/world/HelpStoneTextPanel3D.tscn`
- `scripts/ui/world/help_stone_text_panel_3d.gd`
- `docs/development/Level_01_Gameplay_Video_Corrective_Pass_Report.md`

Modified by the original corrective pass:
- `scenes/environment/assets/help_stone_01.tscn`
- `scenes/environment/assets/help_stone_02.tscn`
- `scripts/player/camera_controller.gd`
- `resources/environment/stylized_cloud_material.tres`
- `shaders/environment/stylized_cloud.gdshader`
- `scripts/soul/soul_shard.gd`
- `scripts/levels/level_01_progression_controller.gd`
- `scripts/levels/level_01_finale_controller.gd`
- `scenes/levels/Level_01.tscn`
- `scenes/core/LevelPortal.tscn`
- `scripts/core/level_portal.gd`
- `shaders/vfx/level_portal_surface.gdshader`
- `shaders/vfx/level_portal_back_veil.gdshader`
- `shaders/vfx/level_portal_ring.gdshader`
- `scripts/ui/level_finale_overlay.gd`
- `scripts/ui/shard_reward_overlay.gd`

Modified by this targeted PR #89 follow-up:
- `scenes/core/LevelPortal.tscn`
- `scripts/core/level_portal.gd`
- `shaders/vfx/level_portal_ring.gdshader`
- `scenes/ui/world/HelpStoneTextPanel3D.tscn`
- `scripts/ui/world/help_stone_text_panel_3d.gd`
- `docs/development/Level_01_Gameplay_Video_Corrective_Pass_Report.md`

## Original Corrective Pass Notes

### Help Stone implementation
Reusable `HelpStoneTextPanel3D` has a `Node3D` root, `MeshInstance3D` backing plane, and `Label3D`. It exposes multiline text, panel size, font size, text color, and panel color. The backing is non-emissive cream/stone material and the label is centered dark text.

Exact texts:

Help Stone 01:
```text
WASD - движение
Мышь - обзор
Space - прыжок
Shift - бег
```

Help Stone 02:
```text
E - взаимодействие

Нажми E, чтобы подобрать
или активировать объект.
```

### Camera before/after sensitivity
- Before: `0.003`
- After: exported range `0.0005..0.005` with default `0.002`
- Level_01 override audit: no Level_01 override to `0.003` remains.

### Cloud before/after colors
- Top: `Color(0.91, 0.93, 0.95, 1)` -> `Color(0.95, 0.92, 0.85, 1)`
- Middle: `Color(0.8, 0.84, 0.88, 1)` -> `Color(0.87, 0.83, 0.76, 1)`
- Bottom: `Color(0.64, 0.7, 0.76, 1)` -> `Color(0.72, 0.68, 0.64, 1)`
- `noise_influence` remains `0.045`; cloud shader remains unshaded and low-frequency.

### SoulShard radius before/after
- Before reusable scene shape: `SphereShape3D radius = 0.50625`
- After runtime default: `interaction_radius = 1.15`, duplicated from the shape before mutation.

### Barrier duration before/after
- Before: `2.5`
- After: `5.0`
- Signal timing remains tied to tween `finished`.

### Authoritative finale text source
- `Level01FinaleController.finale_text` is the only Level_01 authoritative final text source.
- Level_01 explicitly sets `Ты появилась как тёплый первый свет` on `Level01FinaleController`.

### Legacy LevelManager decision
The legacy `LevelManager` node and its Level_01 `level_manager.gd` ext_resource were removed from `Level_01.tscn`; the Stage 1D placeholder `reward_text` wiring was obsolete for Level_01 and would duplicate final text ownership.

### Cursor ownership
`ShardRewardOverlay` and `LevelFinaleOverlay` join `mouse_blocking_ui`. `CameraController` uses the group to show the cursor and ignore mouse look while visible Control overlays are open. `LevelFinaleOverlay` no longer closes from `interact`/`E`; `ui_accept` remains for keyboard accessibility.

## Targeted PR #89 Follow-Up Corrections

### Portal ring geometry correction
`OuterRing` and `InnerRing` no longer use `TorusMesh` resources with near-zero `inner_radius`. They are now vertical `QuadMesh` layers in the portal plane, preserving the existing node names for script references while avoiding solid torus/disc geometry.

### Elliptical outline implementation
`shaders/vfx/level_portal_ring.gdshader` now computes a thin ring mask in UV space using `ring_radius`, `ring_width`, and `edge_softness`. Because the ring meshes are vertical rectangular quads, the circular UV outline reads as a vertical oval in world space.

### Ring brightness reduction
Runtime duplicated ring materials are parameterized as:
- OuterRing: `ring_radius = 0.92`, `ring_width = 0.035`, `ring_alpha = 0.12`, `emission_strength = 0.16`, `edge_softness = 0.025`.
- InnerRing: `ring_radius = 0.76`, `ring_width = 0.022`, `ring_alpha = 0.08`, `emission_strength = 0.12`, `edge_softness = 0.025`.

The strand layers remain the primary internal portal structure. `BackVeil` remains at alpha `0.10`, `PortalLight` target energy remains `0.28`, and `PortalLight` range remains `3.4`.

### Strand target scale preservation
`LevelPortal` captures scene-authored target scales for `PortalStrandLayerBack`, `PortalStrandLayerMiddle`, and `PortalStrandLayerFront` once during `_ready()`. Activation starts each layer from `target_scale * start_multiplier` and tweens it back to the authored target scale, preserving the Back/Middle/Front scale differences after materialization.

### Help Stone instance-local resources
`PlaneMesh_backing` is marked `resource_local_to_scene = true`, and `HelpStoneTextPanel3D` defensively duplicates the backing mesh once per instance with a `_mesh_localized` guard. The backing material is also localized once per instance. Text/font/color/panel-size changes do not allocate a new mesh every setter call.

### Help Stone editor preview
`HelpStoneTextPanel3D` is now a `@tool` script with an Inspector category. Inspector setters call `_update_panel()` safely after node readiness, so `Label3D.text`, `Label3D.font_size`, `Label3D.modulate`, `Label3D.width`, backing `PlaneMesh.size`, backing material albedo, and outline color update in the Godot editor without running the game.

### Portal visual hierarchy static review
Static checks confirm: three strand layers only, two lightweight outline layers only, no new particles, no per-frame material duplication, no per-frame resource creation, no `TorusMesh` portal rings, no ring geometry rotation, `BackVeil` alpha `<= 0.10`, `PortalLight` target energy `0.28`, and `PortalLight` range `3.4`.

## Automated Tests Performed

- `git status --short --branch --untracked-files=all` (preflight and post-commit checks)
- `git log -15 --oneline --decorate` (preflight)
- `git branch -avv` (preflight)
- `git remote -v` (preflight)
- `git diff --check` (preflight and after edits)
- `git diff --stat` (after commits)
- `godot --headless --path . --quit --check-only` passed.
- `timeout 180s godot --headless --editor --path . --quit` first timed out during asset import/reimport at ~88%; this was treated as import-cache warmup, not a parse failure.
- A second `timeout 180s godot --headless --editor --path . --quit` completed successfully.
- `/tmp/validate_pr89_corrective.gd` targeted validation passed: affected scripts/resources loaded, `LevelPortal` strand scales returned to authored target scales after activation, and two `HelpStoneTextPanel3D` instances used independent `PlaneMesh` sizes.
- Structural validation performed with `rg` confirmed no `TorusMesh`, `inner_radius`, or `outer_radius` portal ring resources remain in `scenes/core/LevelPortal.tscn`; the only remaining `inner_radius`-style match is `emission_ring_inner_radius` for `OrbitMotes` particles.

## Graphical Tests Not Performed

No rendered viewport/gameplay graphical QA was performed in this headless non-interactive container. The following remain manual QA items and are not claimed as visually approved:
- Portal doorway shape, side-angle readability, non-lollipop read, ring/strand hierarchy, player silhouette, and activation appearance.
- Help Stone baked-text coverage, decorative-frame clearance, text readability at 2–3 meters, and z-fighting check.
- Final overlay visual hierarchy over the redesigned portal.

## Performance Not Measured

No average FPS, 1% low, p95 frame time, or portal sustained-regression benchmark was captured. Performance must still be measured on the target machine. Static performance review found no additional strand layers beyond three, no new particles, no per-frame material allocations, and no recursive editor update loops.

## Remaining Manual QA

- Help Stone baked-text coverage from gameplay angles.
- Camera feel comparison against prior manual video.
- Cloud separation on long bridges.
- Shard prompt distance in both collection orders.
- Barrier observed duration `5.0 ± 0.2s` and collision movement.
- Portal 3m/10m readability, side-angle visibility, and materialization timing.
- Finale overlay cursor, fox hover/click, and failed-transition cursor recovery.
- Regression cases: empty target path, invalid target path, failed transition retry, repeated E/click, 1280×720, 1920×1080.
- Performance measurements on target machine.
- Audio was not verified.
