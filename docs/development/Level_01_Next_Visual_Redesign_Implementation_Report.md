# Level 01 Next Visual Redesign Implementation Report

## Baseline
- Branch: `work`
- Starting SHA: `0e20adf7421ee4a8caf8f25672b4b220d4d8374e`
- Required design files read fully: `docs/design/Level_01_Next_Visual_Redesign_Slices.md`, `docs/design/Level_01_Next_Visual_Redesign_Codex_Prompt.md`.
- Initial working tree: clean.
- Baseline preservation checked by repository search/code inspection: Help Stone baked-only decision in reports/scenes, portal coherence pass present, finale whole-line reveal baseline present, Soul Orb prompt baseline present, cloud corrective pass present.

## Slice Results

### Slice 0 — Preflight + baseline lock
Completed. Branch, starting SHA, and working tree state were recorded before edits. No local conflicts were present.

### Slice 1 — Soul Orb separate scene and prompt wording
Completed. Added `scenes/core/SoulOrbInteractionPrompt.tscn` as a reusable Soul Orb-specific presentation scene inheriting the shared world prompt style and overriding the action text to exactly `Поднять сферу`. `SoulOrb_World` now instances that presentation scene, and `soul_orb_world.gd` targets the new node while preserving collection flow.

### Slice 2 — Finale text layout from frame geometry
Completed. `LevelFinaleOverlay` now computes a frame rect from the vine frame geometry, derives an inner rect, and places text within a centered safe rect equal to 75% of the inner frame size. This replaces the prior approximate viewport-centered offset.

### Slice 3 — Finale text reveal / pacing / close timing
Completed. Text reveal duration and stagger were shortened, and reveal now uses a soft left-to-right mask combined with alpha and subtle vertical settling. Close timing was slowed by about 2.5x (`0.40 -> 1.00`, `0.62 -> 1.55`, `0.58 -> 1.45`).

### Slice 4 — Portal architecture redesign
Completed. The portal surface shader was reworked from thin lines toward six broad clustered sleeves using sleeve bodies plus procedural mote clusters. Portal material parameters were adjusted for denser, warmer clustered light.

### Slice 5 — Portal motion / density / readability polish
Completed by parameter pass after Slice 4. Portal sleeve motion speed, alpha/density, emission, and orbit mote amount/lifetime/velocity/scale were adjusted to read as denser and faster while avoiding a full white fill in code-level configuration.

### Slice 6 — Clouds structural volume pass
Completed. The cloud shader now adds a broad lobe/depth term, separate depth shadow and lobe highlight, reduced grain contribution, and stronger warm cream body/crown shaping through material parameters.

### Slice 7 — Finale frame branch/leaf attachment pass
Completed. Leaf placement now computes a rotated base-anchor offset so each sprite's stem-side edge is placed at the sampled branch coordinate, making leaves read as growing from branches rather than centered on top of them.

### Slice 8 — Manual QA support / report / final audit
Completed in this report. Automated validation, graphical QA, performance, remaining manual QA, and review passes are separated below.

## Review Pass 1 — Against Source MD
- Slice 0: Completed; baseline locked and clean state recorded.
- Slice 1: Completed; separate reusable Soul Orb prompt scene and exact text implemented.
- Slice 2: Completed; text safe area is computed from frame geometry and uses 75% of the inner frame.
- Slice 3: Completed; reveal is faster and uses soft left-to-right masking, close is slowed by approximately 2.5x.
- Slice 4: Completed; shader architecture now targets six clustered light sleeves rather than only thin lines.
- Slice 5: Completed; post-redesign motion/density/readability parameters adjusted.
- Slice 6: Completed; cloud volume pass changes are structural shader/material changes, not only a tiny parameter tweak.
- Slice 7: Completed; leaf stem/base anchoring to branch sample points implemented.
- Slice 8: Completed; report and honest QA/performance status provided.

## Review Pass 2 — Against Actual Code/Resources
- `SoulOrb_World.tscn` references `SoulOrbInteractionPrompt.tscn`; the script references `$SoulOrbInteractionPrompt` and still calls the same prompt API.
- `SoulOrbInteractionPrompt.tscn` inherits `WorldInteractionPrompt.tscn` and overrides `ActionLabel.text` to `Поднять сферу`.
- `level_finale_overlay.gd` computes `_frame_rect` and `_text_safe_rect`, uses `_text_safe_rect` for wrapping/placement, enables mask clipping, and slows close tweens.
- `level_portal_surface.gdshader` contains six-arm coordinate logic with clustered mote helpers; `LevelPortal.tscn` keeps the six vertical layers/rim/veil and denser orbit motes.
- `stylized_cloud.gdshader` and `stylized_cloud_material.tres` contain the lobe/depth pass while preserving warm cream colors.
- No Help Stone scene/script changes were made; the baked-only baseline was preserved.
- Gameplay flow scripts were not changed except Soul Orb prompt presentation node lookup; no combat/inventory/dialogue/open-world systems were added.

## Review Pass 3 — Review of Reviews
- Rechecked the source MD slice list against this report: all Slice 0–8 items are represented.
- Rechecked changed file list against implementation claims: all created/modified files are accounted for.
- Confirmed final handoff must not claim graphical QA or performance measurements; those remain manual/not measured in the headless environment.

## Automated Validation
- Per-slice quick validation was performed with `git status --short --branch --untracked-files=all`, `git diff --check`, and `git diff --stat` after implementation groups/slices.
- `godot --headless --path . --quit --check-only` passed.
- `timeout 180s godot --headless --editor --path . --quit` was run; first run performed a large import pass. Final status is recorded in the handoff.

## Graphical QA Actually Performed
No rendered viewport/gameplay graphical QA was performed in this headless container. Portal visual density/readability, cloud volume, finale text aesthetics, and leaf attachment must be checked in an actual rendered gameplay/video pass.

## Performance Actually Measured
No average FPS, 1% low, p95 frame time, or portal-adjacent performance benchmark was measured in this pass.

## Remaining Manual QA
A gameplay/video pass should verify:
1. both Help Stones;
2. Soul Orb prompt shows exactly `Поднять сферу`;
3. clouds on open sections;
4. portal materialization;
5. portal from front;
6. portal from side angle;
7. player silhouette in front of active portal;
8. full final frame appearance;
9. full final text appearance;
10. closing final window;
11. transition to Level_02.

Performance QA should capture average FPS, 1% low, p95 frame time, and subjective smoothness near the active portal.

## Project Structure / Gameplay Scope
- Godot project structure preserved.
- No new gameplay systems were implemented; changes are presentation/UI/VFX-oriented and preserve Level_01 progression flow.
- Merge performed: no.
- Auto-merge enabled: no.

---

## Corrective Review After PR #93

PR #93 first pass contained:
- runtime portal parameter override conflict: `LevelPortal.tscn` authored broad-arm values were overwritten by old `level_portal.gd` arrays near radial density `40`;
- planar clustered-light approximation: the shader drew bead-like clusters on portal planes, but no real 3D sleeve streams existed;
- scale-independent leaf offset: the first pass used a hardcoded `10 px` branch offset and did not include texture size or animated scale;
- shading-only cloud volume approximation: the cloud pass changed UV shading but did not add depth layers or lobe geometry.

## Portal runtime parameter source of truth

Runtime layer parameters are now the source of truth in `scripts/core/level_portal.gd`; `LevelPortal.tscn` keeps safe defaults only. The runtime values applied during `_duplicate_runtime_materials()` are:

```gdscript
PORTAL_LAYER_RADIAL_DENSITIES = [15.6, 15.9, 15.4, 16.1, 15.5, 15.8]
PORTAL_LAYER_ROTATION_SPEEDS = [0.670, 0.680, 0.660, 0.690, 0.665, 0.675]
PORTAL_LAYER_ALPHAS = [0.30, 0.38, 0.48, 0.48, 0.38, 0.30]
```

This removes the old radial-density `~40` runtime override and keeps six runtime layers mapped to six broad sleeves.

## Volumetric light sleeve architecture

Added `scenes/vfx/PortalLightSleeve3D.tscn` and `scripts/vfx/portal_light_sleeve_3d.gd`.

Architecture:
- 6 sleeve streams, one `MultiMeshInstance3D` per sleeve;
- 64 motes per sleeve;
- 384 total sleeve motes;
- spiral turn count: `1.55`;
- depth range: `0.62` world units;
- mote size range: `0.055` to `0.145`;
- flow speed: `0.68`;
- additive unshaded emission material with compact sphere motes;
- each sleeve uses phase `index / 6.0` and updates along an outer-to-inner spiral path.

The older planar shader remains only as a supporting inner veil and is no longer the primary sleeve representation.

## Portal performance integration

The old duplicate load was reduced:
- ambient `OrbitMotes.amount` reduced from `240` to `48`;
- ambient mote size and velocity reduced;
- planar surface shader was simplified by removing the procedural bead-cluster helper;
- planar alpha/emission defaults were lowered;
- the new sleeve root receives activation through `_set_surface_activation()` and is set to `0.0` on deactivation;
- no per-frame material duplication was added; material duplication remains in `_ready()` only.

## Texture-relative leaf stem anchoring

Texture inspected: `assets/ui/shard_reward_overlay/vine_leaf.png`, PNG `1024 x 1024`.

Stem anchor:
- normalized UV: `Vector2(0.235, 0.855)`;
- local texture anchor: `(Vector2(0.235, 0.855) - Vector2(0.5, 0.5)) * Vector2(1024, 1024) = Vector2(-271.36, 363.52)`.

Each leaf stores:
- `branch_position`;
- `local_texture_anchor`;
- `rotation` on the sprite;
- animated `target_scale` through existing scale factor.

During decoration updates, the final position is recalculated after animated scale:

```gdscript
var scaled_anchor := Vector2(local_texture_anchor.x * final_scale.x, local_texture_anchor.y * final_scale.y)
leaf.scale = final_scale
leaf.position = branch_position - scaled_anchor.rotated(leaf.rotation)
```

This applies both component-wise scale and rotation to the texture-relative stem anchor every frame of the growth animation.

## Layered cloud volume architecture

Added `scripts/environment/stylized_cloud_volume_cluster.gd` and wired it into `scenes/environment/assets/cloud_001.tscn`.

The reusable cloud scene now builds a `VolumeLobes` child with five structural lobe meshes:
- `BackLobe`: z `+0.26`;
- `MiddleLobe`: z `0.0`;
- `FrontLobe`: z `-0.22`;
- `LeftPuff`: z `-0.10`;
- `RightPuff`: z `+0.16`.

This creates front/middle/back depth separation and soft parallax from actual geometry, not only UV shading. Each lobe duplicates the shared warm cream cloud material with modest shadow/highlight variation and lower noise influence to avoid grain regression.

## Finale responsive-layout validation

Static validation was performed against the current formula:
- frame rect: `(0.17w, 0.16h, 0.66w, 0.56h)`;
- inner margin: `(0.055w, 0.065h)` on each side;
- text safe rect: centered `75%` of the inner frame;
- word wrapping uses `_safe_text_width()`, which returns `_text_safe_rect.size.x` once computed;
- line masks are positioned within `_text_safe_rect` and clip left-to-right reveal;
- max line count remains 3;
- close durations remain `1.00`, `1.55`, `1.45`.

Viewport checks:
- `1920x1080`: safe rect stays inside frame, max text width equals safe width, masks are horizontally centered inside safe rect.
- `1280x720`: same formula scales down and preserves safe rect containment.

No finale code changes were needed during this corrective audit beyond the leaf-anchor fix.

## Corrective Review Pass 1 — Source requirements

- Portal parameter source of truth: COMPLETED.
- Six volumetric clustered-light sleeves: COMPLETED by actual `PortalLightSleeve3D` geometry streams, not shader-only beads.
- Portal performance and integration cleanup: COMPLETED by lowering ambient motes and simplifying/supporting the planar veil.
- Texture-relative leaf stem anchor: COMPLETED with texture-size UV anchor, scale, and rotation math.
- Structural cloud volume pass: COMPLETED with real lobe geometry and depth offsets.
- Finale regression audit: COMPLETED statically; no additional finale layout timing changes needed.
- Soul Orb accepted fix preservation: COMPLETED; not changed in corrective pass.
- Help Stone baked-only preservation: COMPLETED; no Help Stone files changed.

## Corrective Review Pass 2 — Actual runtime integration

- Runtime portal radial densities after `_ready()`: `[15.6, 15.9, 15.4, 16.1, 15.5, 15.8]`.
- Authored `LevelPortal.tscn` shader values are safe defaults and are intentionally overwritten by the runtime source of truth.
- Real 3D sleeves exist as six `MultiMeshInstance3D` streams under `PortalLightSleeve3D`.
- Sleeve activation is driven from `LevelPortal._set_surface_activation()` and disabled on `_deactivate()`.
- Ambient `OrbitMotes` remain but are reduced to 48 and are not the sleeve representation.
- Leaf anchors use the actual 1024x1024 texture size, component scale, and sprite rotation.
- Clouds have actual lobe meshes in `VolumeLobes`, and Level_01 instances the reusable `cloud_001.tscn` scene.

## Corrective Review Pass 3 — Review the review

- The portal redesign is no longer claimed complete based only on a shader helper; it now has six real 3D streams.
- The leaf anchor is no longer claimed correct based only on a visual offset; it is texture-relative and recalculated with scale/rotation.
- Clouds are no longer claimed volumetric based only on shading; structural lobe geometry is now generated.
- Runtime portal overrides were explicitly checked and corrected.
- Handoff must still avoid claiming rendered graphical QA or measured performance because neither was captured in this headless pass.

## Remaining graphical QA

Still required in a rendered gameplay/video pass:
1. verify six portal sleeves from front view;
2. verify sleeve depth from side view;
3. verify player silhouette in front of active portal;
4. verify portal is not a white blob;
5. verify cloud lobe depth/parallax during camera motion;
6. verify leaf stem attachment during finale frame growth;
7. verify Soul Orb prompt remains `Поднять сферу`;
8. verify finale text layout/reveal at 1920x1080 and 1280x720.

## Performance status

Performance not measured. No average FPS, 1% low, p95 frame time, or active-portal regression percentage was captured in this environment.

## Portal Sleeve Material and Runtime Validation

Follow-up corrective review found that the sleeve `MultiMesh` streams already enabled `use_colors`, but the previous `StandardMaterial3D` did not explicitly consume the instance/vertex color channel. The mote material is now a dedicated `ShaderMaterial` using `shaders/vfx/portal_light_mote.gdshader`.

Material behavior:
- `MultiMesh.use_colors = true` remains enabled for every sleeve stream.
- `multimesh.set_instance_color()` writes per-mote RGB brightness variation and per-mote alpha.
- The shader reads `COLOR` and multiplies it into `ALBEDO`, `ALPHA`, and `EMISSION`.
- `base_color` is white in the material so the per-instance sleeve color is not double-tinted.
- `emission_strength = 1.65` remains the shared intensity control.

Activation behavior:
- scale uses `smoothstep(0.0, 1.0, _activation)` and `lerpf(0.04, 1.0, activation_eased)`, so the first visible activation samples start near zero instead of roughly 45% of final size.
- alpha uses `sleeve_color.a * activation_eased * lerpf(0.58, 1.0, pulse)`, so fade-in and fade-out follow the same eased activation curve as scale.
- visibility/process gating now uses `activation > 0.0001`, keeping the sleeve active through the final near-zero fade samples and disabling processing once fully inactive.

Validation result:
- `/tmp/validate_portal_sleeve_material.gd` loaded `res://scenes/vfx/PortalLightSleeve3D.tscn`, found 6 `MultiMeshInstance3D` streams, 64 motes per stream, `use_colors = true`, and the `ShaderMaterial` path `res://shaders/vfx/portal_light_mote.gdshader`.
- The validation confirmed the shader source consumes `COLOR` in the alpha/emission path and sampled the activation curves: scale at activation `0.10` was `0.00495` versus `0.07400` at activation `1.00`; alpha at activation `0.10` was `0.02045` versus `0.73046` at activation `1.00`.
- Note: Godot 4.6.2 headless uses a dummy renderer for `MultiMesh` readback, so `get_instance_transform()`/`get_instance_color()` do not return the written render-server values in this environment. The validation therefore verifies scene wiring, material type, shader source consumption of `COLOR`, lifecycle visibility/process state, and the same activation formulas used by runtime code.

## Cloud Quality Controller Compatibility

The old `scripts/environment/cloud_quality_controller.gd` was fully audited against the new `scripts/environment/stylized_cloud_volume_cluster.gd` and `scenes/environment/assets/cloud_001.tscn`.

| Responsibility | Still needed | Preserved by new script | Action |
| --- | --- | --- | --- |
| Assign shared stylized cloud material | yes | yes | `StylizedCloudVolumeCluster` now extends `CloudQualityController` and calls `super._ready()`. |
| Disable shadows on cloud geometry | yes | yes | Inherited recursive traversal applies `SHADOW_CASTING_SETTING_OFF`. |
| Disable GI on mesh instances | yes | yes | Inherited traversal preserves `gi_mode = GI_MODE_DISABLED`. |
| Traverse child mesh hierarchy | yes | yes | Inherited recursive traversal is reused for imported GLB children. |
| Runtime/editor initialization in `_ready()` | yes | yes | New script calls `super._ready()` before building volume lobes. |
| Distance/LOD behavior | no | not applicable | Old controller did not implement distance or LOD behavior. |
| Visibility control | no | not applicable | Old controller did not implement custom visibility control. |
| Platform-specific optimization | no | not applicable | Old controller did not implement platform-specific branches. |
| Build 5 structural lobes | yes, new requirement | yes | New script builds `VolumeLobes` after inherited material/quality setup. |

Compatibility action: inheritance was chosen so the imported GLB child traversal, material assignment, shadow disabling, and GI disabling remain centralized in `CloudQualityController` while the new volume builder only owns the five-lobe structural cloud geometry.

## Godot Import and Targeted Runtime Validation

Godot editor import:
- command: `timeout 300s godot --headless --editor --path . --quit`
- exit code: `0`
- result: completed asset scan, reimport, post-reimport operations, and editor layout load without parse errors, shader compilation errors, or failed loads in the observed output.

Targeted scene load:
- `/tmp/targeted_load_pr93.gd` loaded and instantiated:
  - `res://scenes/vfx/PortalLightSleeve3D.tscn`;
  - `res://scenes/core/LevelPortal.tscn`;
  - `res://scenes/environment/assets/cloud_001.tscn`;
  - `res://scenes/core/SoulOrbInteractionPrompt.tscn`;
  - `res://scenes/core/SoulOrb_World.tscn`;
  - `res://scenes/ui/LevelFinaleOverlay.tscn`;
  - `res://scenes/levels/Level_01.tscn`.
- LevelPortal targeted activation check found 6 sleeve streams and verified sleeve visibility at activation `1.0` and clean visibility/process shutdown at activation `0.0`.
- Cloud targeted load found `VolumeLobes`, 5 lobe meshes, and 5 unique z offsets.
- Finale responsive validation checked 1920x1080 and 1280x720 safe-width formulas with 3 lines inside the 75% safe area.

## Corrective Follow-up Review Pass 1 — Requirements

- MultiMesh material honors instance RGB: COMPLETED; the mote shader consumes `COLOR.rgb` into albedo/emission.
- MultiMesh material honors instance alpha: COMPLETED; the mote shader consumes `COLOR.a` into `ALPHA` and emission strength.
- Activation fade visible in data/formula: COMPLETED; activation `0.10` alpha is much lower than activation `1.0`.
- Activation scale starts near zero: COMPLETED; activation scale starts at `0.04` of the eased final size.
- 6 streams × 64 motes preserved: COMPLETED.
- Cloud controller responsibility checked: COMPLETED.
- Editor import completed with exit code 0: COMPLETED.
- Targeted scene load completed: COMPLETED.
- PR body update: COMPLETED via final PR metadata update in this handoff.

## Corrective Follow-up Review Pass 2 — Actual runtime code

- `portal_light_sleeve_3d.gd` creates six `MultiMeshInstance3D` streams and assigns one shader-backed mote material to their sphere mesh.
- `portal_light_mote.gdshader` explicitly uses `COLOR` for per-instance RGB/alpha.
- `level_portal.gd` still drives sleeve activation from `_set_surface_activation()` and deactivates sleeves from `_deactivate()`.
- `LevelPortal.tscn` still instances `PortalLightSleeve3D` under `VisualRoot` and keeps `OrbitMotes.amount = 48`.
- `stylized_cloud_volume_cluster.gd` now inherits old cloud quality behavior and then builds five volume lobes.
- `cloud_quality_controller.gd` remains the single recursive material/shadow/GI controller for imported cloud meshes.
- `cloud_001.tscn` still uses the volumetric cluster script.
- `level_finale_overlay.gd` retains the 75% safe text rect, faster reveal timings, slower close timings, and texture-relative leaf anchor.

## Corrective Follow-up Review Pass 3 — Review the review

- The instance-color fix is not claimed merely from `use_colors = true`; the shader source consumes `COLOR` directly.
- The editor import pass is only claimed for the run that exited with code `0`.
- Targeted scenes were actually loaded and instanced by `/tmp/targeted_load_pr93.gd`.
- Cloud quality behavior was not assumed; the old controller was read and inherited to preserve recursive material/shadow/GI logic.
- No rendered graphical QA or performance measurements were performed in this headless pass, so both remain manual/NOT MEASURED.

## Cloud Lobe GI Follow-up Validation

A final PR #93 follow-up found that `CloudQualityController` runs before `VolumeLobes` are generated. The inherited controller therefore configures only imported GLB geometry before generated lobes exist. Each generated lobe now explicitly sets `gi_mode = GeometryInstance3D.GI_MODE_DISABLED` immediately after `cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF`, while preserving its own duplicated per-lobe `ShaderMaterial` and shadow/highlight variation.

Validation results from `/tmp/validate_cloud_volume_lobes.gd`:
- 5 generated lobes found under `VolumeLobes`.
- 5 shadows disabled.
- 5 GI modes disabled.
- 5 `ShaderMaterial` overrides preserved.
- Material variation preserved: 5 distinct `body_shadow_strength` values and 5 distinct `crown_highlight_strength` values.
- Z offsets preserved: `+0.26`, `0.0`, `-0.22`, `-0.10`, `+0.16`.
- Targeted cloud load passed.
- Targeted `Level_01` load passed after successful editor import.

Follow-up review status:
- Review Pass 1: COMPLETED for explicit generated-lobe GI disable, shadow disable, per-lobe material preservation, 5-lobe count, cloud scene load, Level_01 load, and report update. Remote PR body verification remains NOT VERIFIED in this checkout because no `origin` remote is configured.
- Review Pass 2: COMPLETED locally by reopening the old controller, generated cloud cluster script, cloud scene, and report. The actual runtime path is `super._ready()` for imported geometry first, then `_build_volume_lobes()`, with each generated lobe setting its own shadow, GI, and duplicated material values.
- Review Pass 3: COMPLETED locally; no recursive material reassignment was added after lobe material duplication, validation instantiated the scene, editor import exited with code `0`, and no graphical or performance QA is claimed.
