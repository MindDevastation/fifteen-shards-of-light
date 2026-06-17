# Level 01 Gameplay Video Corrective Pass Report

- Date: 2026-06-17
- Current PR number: 90
- Current PR URL: https://github.com/MindDevastation/fifteen-shards-of-light/pull/90
- Base branch: `feature/implement-level-01-finale-and-portal-transitions`
- Base SHA: `20a1cc9427dbc98bfbee94729fc15a57607be920`
- Remote head branch: `feature/perform-gameplay-video-corrective-pass-for-level_01`
- Initial reviewed remote head: `0245b8a8103d2dcabe4ad19f848dd3e024306715`
- Initial remote commit count: `2`
- Final remote SHA: `NOT VERIFIED` until push and `git ls-remote` succeed.
- Final remote commit count: `NOT VERIFIED` until push/PR refresh succeeds.
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
- Finale text safe area, 12 branches per side, 24 leaves per side, and soft masked reveal remain in place.
- `Level01FinaleController.finale_text` remains the Level_01 finale text owner.
- SceneTransition recovery/callback cleanup remains untouched.
- Portal architecture remains four vertical full-size strand layers with depth/yaw offsets, authored-transform preservation, `PortalLight` target `0.28`, and `OrbitMotes.amount = 48`.

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

Because there was no separate inscription mesh/material to hide, the corrective pass uses a Godot-only fallback designed to mask the baked old inscription while avoiding a cream plaque:
- Deleted the temporary `HelpStoneTextPanel3D` Label3D-only overlay resources.
- Added `HelpStoneInscription3D`, which combines an irregular stone-colored mask shader with an engraved-style `Label3D` inscription.
- Replaced both Help Stone scene instances with `CorrectedInscription` using `HelpStoneInscription3D`.
- This path did not regenerate GLB or source texture assets; it masks the baked inscription in-scene because no separable inscription mesh was available in the GLB.

## Removed HelpStoneTextPanel3D Resources

Removed obsolete temporary overlay resources:
- `scenes/ui/world/HelpStoneTextPanel3D.tscn`
- `scripts/ui/world/help_stone_text_panel_3d.gd`

Replacement resources:
- `scenes/ui/world/HelpStoneInscription3D.tscn`
- `scripts/ui/world/help_stone_inscription_3d.gd`
- `shaders/ui/world/help_stone_inscription_mask.gdshader`

## Help Stone Mask Smoothstep Correction

The mask shader no longer uses reversed `smoothstep(0.50, 0.50 - edge_softness, ...)` calls. Horizontal and vertical organic edge values now use ascending thresholds via `1.0 - smoothstep(0.50 - edge_softness, 0.50, value)`, avoiding undefined GPU-specific behavior while keeping the center at full opacity and fading only the noisy organic edges.

## Help Stone Full-Opacity Center

The Help Stone mask center is now fully opaque:
- shader default `stone_tint.a = 1.0`,
- `HelpStoneInscription3D` material `stone_tint.a = 1.0`,
- both Help Stone instance `mask_color.a = 1.0`,
- final shader alpha is `ALPHA = organic_mask`, so the center is not multiplied by the previous `0.92` opacity.

## Help Stone Lit Stone-Material Behavior

The mask shader no longer uses `unshaded` rendering and no longer writes non-zero `EMISSION`. It now uses lit spatial shading with:
- `ROUGHNESS = 0.95`,
- `METALLIC = 0.0`,
- `SPECULAR = 0.08`.

This should make the mask respond to scene lighting more like a stone surface instead of a flat glowing UI patch.

## Help Stone Text Whitespace Normalization

Both Help Stone serialized text values were checked and are stored without leading spaces after newline characters:
- Help Stone 01: `WASD - движение`, `Мышь - обзор`, `Space - прыжок`, `Shift - бег`.
- Help Stone 02: `E - взаимодействие`, blank line, `Нажми E, чтобы подобрать`, `или активировать объект.`

No wording, font size, or placement changes were made for this whitespace check.

## Portal Orientation Root Cause

The portal used `QuadMesh` surfaces, which already live in local XY and face along local Z. The earlier problematic transform basis mapped local Y into world Z, rotating doorway surfaces into a horizontal XZ-like plane. PR #90 corrected those scene transforms before this final shader pass.

## Portal Vertical Transform Correction

Corrected vertical portal elements remain:
- `PortalStrandLayerBack`
- `PortalStrandLayerMiddle`
- `PortalStrandLayerNearMiddle`
- `PortalStrandLayerFront`
- `BackVeil`
- `OuterRing`
- `InnerRing`
- `OrbitMotes`

`GroundRing` remains horizontal. Strand layer center Y remains `1.575`, so the 3.15-high portal doorway rests at approximately ground level.

## Portal Layer Reduction

Active full-size additive strand planes remain reduced from six to four:
- `PortalStrandLayerBack`
- `PortalStrandLayerMiddle`
- `PortalStrandLayerNearMiddle`
- `PortalStrandLayerFront`

Depth offsets remain `-0.12`, `-0.04`, `+0.04`, `+0.12`; yaw offsets around world Y remain `-3°`, `-1°`, `+1°`, `+3°`.

## Overdraw and Light Safety

Density remains shader-driven rather than plane-count-driven.

Runtime strand parameters remain:
- `strand_density = 20.0, 22.1, 24.2, 26.3`
- `radial_density = 25.0, 27.8, 30.6, 33.4`
- `rotation_speed = 0.12, 0.138, 0.156, 0.174`
- `layer_alpha = 0.28, 0.325, 0.37, 0.415`

Lighting/particles remain:
- `PortalLight` target energy `0.28`.
- Orbit motes `48`.
- No per-frame material duplication was added; runtime material duplication remains setup-time only.

## Portal Silhouette Edge-Clipping Correction

The portal surface shader no longer applies the old `c.y *= 0.70` vertical stretch. The mask now uses `vec2 c = UV - vec2(0.5)` directly, with tighter thresholds:
- `oval = 1.0 - smoothstep(0.40, 0.48, r)`
- `center_open = smoothstep(0.055, 0.18, r)`
- `edge_alpha = (1.0 - smoothstep(0.32, 0.46, r)) * oval * 0.045`

CPU-side shader-equivalent sampling expects alpha to fade to approximately `0.0` at `UV(0.5, 0.0)`, `UV(0.5, 1.0)`, `UV(0.0, 0.5)`, and `UV(1.0, 0.5)`, preventing strand/body alpha from reaching the QuadMesh edges.

## Targeted Portal Transform Validation

Targeted portal validation verifies:
- `res://scenes/core/LevelPortal.tscn` loads,
- active strand layer count is `<= 4`,
- each vertical portal node keeps local Y aligned with world Y,
- surface normals remain horizontal rather than upward,
- activation preserves each strand layer's authored transform.

## Help Stone Old-Text Removal Validation

Static validation:
- GLB inspection found no separate inscription mesh/material; old text is treated as baked into the asset surface.
- The corrected `HelpStoneInscription3D` mask is present on both Help Stone scenes and the old `HelpStoneTextPanel3D` resources are removed.
- The mask center is now fully opaque, lit, and free of reversed smoothstep calls.

Graphical validation is still required to visually confirm no old baked letters leak through the mask.

## Final Shader Validation

Final shader validation checks:
- Help Stone shader/resource loads.
- `stone_tint.a == 1.0`.
- Help Stone mask shader does not contain `unshaded`.
- Help Stone mask shader does not contain reversed `smoothstep(0.50, 0.50 - ...)`.
- Help Stone mask shader does not contain non-zero `EMISSION`.
- Both Help Stone scenes use `HelpStoneInscription3D`.
- Old `HelpStoneTextPanel3D` production references are absent.
- Portal shader/resource loads.
- Portal shader does not contain `c.y *= 0.70`.
- Portal shader-equivalent edge samples fade to zero at QuadMesh edges.
- Four active strand layers remain in the scene.
- Portal vertical transforms and authored-transform preservation remain valid after activation.

Final pass/fail result is recorded in the final handoff.

## Automated Validation Performed

Performed during this pass:
- `git status --short --branch --untracked-files=all`
- `git log -15 --oneline --decorate`
- `git branch -avv`
- `git remote -v`
- `git diff --check`
- `rg` structural checks for PR #90 baseline preservation.
- `rg` structural checks for shader regressions, portal strand layer count, and Help Stone references.

Final Godot check-only, editor import, targeted resource load, and shader validation results are recorded in the final handoff.

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
- Verify old text does not show through.
- Verify no double letters remain.
- Verify the mask does not read as a rectangle.
- Verify the mask does not glow and responds to scene light like stone.
- Verify patch color matches the stone face.
- Verify no z-fighting.
- Verify text has no leading spaces and reads from 2–3 meters.

Portal:
- Verify portal remains vertical.
- Verify upper and lower silhouettes are rounded.
- Verify no flat clipping or rectangular silhouette appears.
- Verify strands do not terminate against QuadMesh edges.
- Verify center does not become a solid blob.
- Verify player silhouette, volume, and motion remain readable.

Regression:
- Verify Soul Orb prompt still works.
- Verify SoulShard radius remains `1.30`.
- Verify camera sensitivity remains `0.002`.
- Verify barrier duration remains `5.0`.
- Verify finale frame, finale safe text area, and soft reveal are not reverted.
- Verify mouse cursor flow remains stable.
- Verify E does not close the final overlay.
