# Level 01 Gameplay Video Corrective Pass Report

- Date: 2026-06-17
- Branch: `feature/level-01-gameplay-video-corrective-pass`
- Baseline SHA: `cf9d3dc` (`Merge pull request #88 from MindDevastation/feature/-gdscript-parse-errors`)
- PR #88 presence proof: baseline contains `maxi()`/`maxf()` in `scripts/vfx/firefly_cluster_3d.gd`, `_configure_line_group()` and `FoxConfirmButtonType` preload in `scripts/ui/level_finale_overlay.gd`, and `FoxConfirmButtonType` preload in `scripts/ui/shard_reward_overlay.gd`.
- Remote PR state: not verified in this container because no `origin` remote is configured and `gh` is unavailable.
- No-merge confirmation: no merge was performed.

## Files Changed

Created:
- `scenes/ui/world/HelpStoneTextPanel3D.tscn`
- `scripts/ui/world/help_stone_text_panel_3d.gd`
- `docs/development/Level_01_Gameplay_Video_Corrective_Pass_Report.md`

Modified:
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

## Implementation Notes

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

### Portal hierarchy
`LevelPortal` now uses three strand layers:
- `PortalStrandLayerBack`
- `PortalStrandLayerMiddle`
- `PortalStrandLayerFront`

It keeps `BackVeil`, `OuterRing`, `InnerRing`, `GroundRing`, `OrbitMotes`, `PortalLight`, `InteractionArea`, and `WorldInteractionPrompt`.

### Portal shader parameters
The strand shader now supports `phase_offset`, `strand_density`, `radial_density`, `rotation_speed`, and `layer_alpha`. Runtime layer defaults are density `8.6/9.3/10.0`, radial density `11.4/11.95/12.5`, rotation speed `0.034/0.040/0.046`, and alpha `0.46/0.54/0.62`. Base/body alpha is `0.016`; veil alpha is `0.10`; portal light energy is `0.28`; portal light range is `3.4`.

### Cursor ownership
`ShardRewardOverlay` and `LevelFinaleOverlay` join `mouse_blocking_ui`. `CameraController` uses the group to show the cursor and ignore mouse look while visible Control overlays are open. `LevelFinaleOverlay` no longer closes from `interact`/`E`; `ui_accept` remains for keyboard accessibility.

## Automated tests
- `git status --short --branch --untracked-files=all` (preflight)
- `git log -15 --oneline --decorate` (preflight)
- `git diff --check` (preflight and after edits)
- `git diff --stat` (after edits)
- `godot --headless --path . --quit --check-only` passed.
- `timeout 120s godot --headless --editor --path . --quit` timed out at 120 seconds during asset import/reimport at 87%; no parse or script-load errors appeared before timeout.

## Graphical tests actually performed
No interactive graphical QA was performed in this headless non-interactive container. Help Stone bleed-through, exact portal readability, final overlay backdrop hierarchy, and environment shadow readability remain manual QA items.

## Performance measurements
No FPS, 1% low, or p95 frame-time benchmark was captured in this headless container. Performance regression is not verified.

## Remaining manual QA
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
