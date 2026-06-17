# Level 01 Gameplay Video Corrective Pass Report

- Date: 2026-06-17
- Current PR number: 90
- Current PR URL: https://github.com/MindDevastation/fifteen-shards-of-light/pull/90
- Base branch: `feature/implement-level-01-finale-and-portal-transitions`
- Base SHA: `20a1cc9427dbc98bfbee94729fc15a57607be920`
- Remote head branch: `feature/perform-gameplay-video-corrective-pass-for-level_01`
- Initial reviewed remote head: `708cac8055dc4df0e799c46a70b2118bdaba61cf`
- Final remote SHA: `NOT VERIFIED` until push and `git ls-remote` succeed.
- Remote commit count: `NOT VERIFIED` until push/PR refresh succeeds.
- No-merge confirmation: no merge was performed.
- Auto-merge confirmation: auto-merge was not enabled.
- New PR confirmation: no new PR was created.

## PR #90 Baseline Preservation

Preserved accepted PR #90 fixes:
- Soul Orb continues to use `WorldInteractionPrompt`.
- `SoulShard.interaction_radius` remains `1.30`.
- Camera sensitivity remains `0.002`.
- Barrier duration remains `5.0`.
- Cloud clarity pass remains in place.
- `mouse_blocking_ui` remains in overlay/camera flow.
- Finale text safe area, enriched finale frame, and soft masked reveal remain in place.
- `Level01FinaleController.finale_text` remains the Level_01 finale text owner.
- SceneTransition recovery/callback cleanup remains untouched.

## Help Stone Source Inspection

Inspected:
- `assets/props/help_stone_01/`
- `assets/props/help_stone_02/`
- `scenes/environment/assets/help_stone_01.tscn`
- `scenes/environment/assets/help_stone_02.tscn`

Findings:
- Each Help Stone GLB contains one mesh, one material, three embedded/external texture images, and one node.
- The material uses texture index `0` as `baseColorTexture`, texture index `1` as metallic/roughness, and texture index `2` as normal.
- No separate inscription mesh, node, or material was found in the GLB structure.
- The old inscription is therefore treated as baked into the base-color texture/asset surface rather than a separately hideable mesh.

## Chosen Inscription Replacement Method

Because there was no separate inscription mesh/material to hide, the corrective pass uses a Godot-only fallback designed to fully mask the baked old inscription while avoiding a cream plaque:
- Deleted the temporary `HelpStoneTextPanel3D` Label3D-only overlay resources.
- Added `HelpStoneInscription3D`, which combines an irregular stone-colored mask shader with an engraved-style `Label3D` inscription.
- Replaced both Help Stone scene instances with `CorrectedInscription` using `HelpStoneInscription3D`.
- The irregular mask sits over the baked old text to hide it, while the text reads as aged dark paint/engraving on stone.
- This path did not regenerate GLB or source texture assets; it masks the baked inscription in-scene because no separable inscription mesh was available in the GLB.

## Removed HelpStoneTextPanel3D Resources

Removed obsolete temporary overlay resources:
- `scenes/ui/world/HelpStoneTextPanel3D.tscn`
- `scripts/ui/world/help_stone_text_panel_3d.gd`

Replacement resources:
- `scenes/ui/world/HelpStoneInscription3D.tscn`
- `scripts/ui/world/help_stone_inscription_3d.gd`
- `shaders/ui/world/help_stone_inscription_mask.gdshader`

## Portal Orientation Root Cause

The portal used `QuadMesh` surfaces, which already live in local XY and face along local Z. The previous transform basis mapped local Y into world Z, rotating the doorway surfaces into a horizontal XZ-like plane. This made the portal risk reading as a ground vortex despite tall mesh dimensions.

## Portal Vertical Transform Correction

Corrected all vertical portal elements so:
- world X is doorway width,
- world Y is doorway height,
- world Z is surface normal/depth.

Corrected nodes:
- `PortalStrandLayerBack`
- `PortalStrandLayerMiddle`
- `PortalStrandLayerNearMiddle`
- `PortalStrandLayerFront`
- `BackVeil`
- `OuterRing`
- `InnerRing`
- `OrbitMotes`

`GroundRing` remains horizontal. Strand layer center Y is `1.575`, so the 3.15-high portal doorway rests at approximately ground level.

## Portal Layer Reduction

Reduced active full-size additive strand planes from six to four:
- `PortalStrandLayerBack`
- `PortalStrandLayerMiddle`
- `PortalStrandLayerNearMiddle`
- `PortalStrandLayerFront`

Removed full-size additive strand layers:
- `PortalStrandLayerFarBack`
- `PortalStrandLayerForward`

Depth offsets:
- `-0.12`
- `-0.04`
- `+0.04`
- `+0.12`

Yaw offsets around world Y:
- `-3°`
- `-1°`
- `+1°`
- `+3°`

## Overdraw and Light Safety

Density is now driven by shader parameters and phase offsets rather than six additive planes.

Runtime strand parameters by layer:
- `strand_density = 20.0, 22.1, 24.2, 26.3`
- `radial_density = 25.0, 27.8, 30.6, 33.4`
- `rotation_speed = 0.12, 0.138, 0.156, 0.174`
- `layer_alpha = 0.28, 0.325, 0.37, 0.415`

Shader safety values:
- `base_alpha = 0.018`
- `edge_alpha = 0.045`
- strand alpha multiplier `0.46`
- emission multiplier `0.98`

Lighting/particles:
- `PortalLight` target energy restored to `0.28`.
- Orbit motes reduced to `48`.
- No per-frame material duplication was added; runtime material duplication remains in `_ready()` setup.

## Targeted Portal Transform Validation

Targeted portal validation script:
- loads `res://scenes/core/LevelPortal.tscn`,
- verifies active strand layer count is `<= 4`,
- verifies each vertical portal node keeps local Y aligned with world Y,
- verifies surface normals remain horizontal rather than upward,
- activates the portal,
- verifies each strand returns to its authored transform after activation.

Result is recorded in the final handoff for this pass.

## Help Stone Old-Text Removal Validation

Static validation:
- GLB inspection found no separate inscription mesh/material; old text is treated as baked into the asset surface.
- The corrected `HelpStoneInscription3D` mask is present on both Help Stone scenes and the old `HelpStoneTextPanel3D` resources are removed.

Graphical validation is still required to visually confirm no old baked letters leak through the mask.

## Automated Validation Performed

Performed during this pass:
- `git status --short --branch --untracked-files=all`
- `git log -15 --oneline --decorate`
- `git branch -avv`
- `git remote -v`
- `git diff --check`
- `rg` structural checks for PR #90 baseline preservation.
- `rg` structural checks for portal strand layer count and Help Stone references.

Final Godot check-only, editor import, and targeted scene load/portal validation results are recorded in the final handoff.

## Graphical QA Actually Performed

No rendered viewport/gameplay graphical QA was performed in this headless container. Do not treat Help Stone masking, portal readability, player silhouette, or finale visuals as graphically approved by Codex.

## Performance Measurements Actually Performed

Performance not measured. No average FPS, 1% low, p95 frame time, or target-machine portal arena benchmark was captured.

Static performance checks:
- Active full-size strand layers are `4`.
- Orbit motes are `48`.
- No per-frame resource allocation was added.
- Runtime material duplication remains setup-time only.

## Remaining Manual QA

Help Stones:
- Verify old text fully disappears.
- Verify no double letters remain.
- Verify no cream plaque or rectangular patch silhouette is visible.
- Verify inscription looks like part of the stone.
- Verify text reads from 2–3 meters.
- Verify no z-fighting and no decorative border overlap.

Portal:
- Verify portal stands vertically with the bottom touching the platform.
- Verify it no longer reads as a horizontal vortex.
- Verify it remains dense but not a white/yellow blob.
- Verify individual strands and player silhouette remain readable.
- Verify faster movement and depth/parallax at side angles.
- Verify GroundRing remains secondary.

Regression:
- Verify Soul Orb prompt still works.
- Verify SoulShard radius remains `1.30`.
- Verify camera sensitivity remains `0.002`.
- Verify barrier duration remains `5.0`.
- Verify finale text safe area, enriched frame, and soft line reveal are not reverted.
- Verify mouse cursor flow remains stable.
- Verify E does not close the final overlay.
