# Global Concept Asset Reference Manifest

This manifest lists concept reference files used for visual planning in the project.

Important:
- These files are reference images only.
- They are not runtime/gameplay assets.
- They must not be instantiated directly in Godot scenes.
- Actual gameplay scenes must use existing `.tscn` wrapper scenes where available.
- Do not instance raw `.glb` files directly if a matching wrapper scene already exists.
- If a wrapper scene is missing, create a minimal wrapper scene following the existing project convention.
- Written layout/spec files are the source of truth for gameplay implementation.
- Concept images are visual guidance only.

## Folder Purpose

The `assets/concepts/` folder contains:
- concept art references;
- block-level visual guides;
- planning notes;
- asset manifests.

This folder is ignored by Godot via `.gdignore` and must stay outside the runtime asset pipeline.

## Level 01 / First Light Forest References

### Main Level Block References

- `level_01/block_01/block_01_concept_main.png`
  - Purpose: main visual reference for `Block_01_01_StartClearing`.
  - Use as mood/layout reference, not a pixel-perfect construction blueprint.

- `level_01/block_01/block_01_layout_notes.md`
  - Purpose: written visual/technical layout notes for `Block_01_01_StartClearing`.
  - Source of truth for dimensions, structure, route, and gameplay logic.

- `level_01/block_01/asset_reference_manifest.md`
  - Purpose: block-specific reference mapping for `Block_01_01_StartClearing`.

---

## Individual Prop / Environment Concept References

### Start Area / Gameplay Focus

- `Awakening_Platform_01.png`
  - Purpose: awakening/start platform on the raised terrace.

- `SoulOrb_Pedestal_01.png`
  - Purpose: low pedestal / focal platform where the Soul Orb will be placed manually.

### Arch / Barrier / Route Landmark

- `ruined_arch_01.png`
  - Purpose: main ruined arch option for the sealed gate area.

- `ruined_arch_02.png`
  - Purpose: alternate ruined arch option for the sealed gate area.

- `Ancient_Stone_Barrier_01.png`
  - Purpose: arched barrier slab that seals the ruined arch passage before Soul Orb pickup.

### Ground / Path / Traversal

- `stone_path_slab_01.png`
  - Purpose: modular stone path slab for the main route through the clearing.

- `stone_path_step_01.png`
  - Purpose: modular step piece for terrace stairs and lower decorative stair areas.

### Cliffs / Rocks / Boundary

- `CliffBoundary_Module_01.png`
  - Purpose: modular cliff wall segment for enclosing the clearing.

- `cliff_rock_01.png`
  - Purpose: large cliff rock / edge formation for perimeter shaping.

- `medium_rock_01.png`
  - Purpose: medium-sized rock for scene dressing and route framing.

### Trees / Bushes / Foliage

- `tree_01.png`
  - Purpose: stylized tree variant A for perimeter forest dressing.

- `tree_02.png`
  - Purpose: stylized tree variant B for perimeter forest dressing.

- `Bush_01.png`
  - Purpose: stylized bush variant 01.

- `Bush_02.png`
  - Purpose: stylized bush variant 02.

- `Bush_03.png`
  - Purpose: stylized bush variant 03.

- `Bush_04.png`
  - Purpose: stylized bush variant 04.

- `Bush_05.png`
  - Purpose: stylized bush variant 05.

- `Bush_06.png`
  - Purpose: stylized bush variant 06.

### Moss / Flower Patches / Soft Ground Dressing

- `moss_01.png`
  - Purpose: decorative moss patch variant 01.

- `moss_02.png`
  - Purpose: decorative moss patch variant 02.

- `Flower_Moss_01.png`
  - Purpose: small decorative flower+moss patch variant 01.

- `Flower_Moss_02.png`
  - Purpose: small decorative flower+moss patch variant 02.

- `Flower_Moss_03.png`
  - Purpose: small decorative flower+moss patch variant 03.

- `Flower_Moss_04.png`
  - Purpose: small decorative flower+moss patch variant 04.

- `Flower_Moss_05.png`
  - Purpose: small decorative flower+moss patch variant 05.

### Debris / Small Ruin Fragments

- `debris_01.png`
  - Purpose: small debris cluster variant 01.

- `debris_02.png`
  - Purpose: small debris cluster variant 02.

### Ruin Dressing / Pillars / Low Remnants

- `Ruin_Pillar_01.png`
  - Purpose: ruin fragment / pillar variant 01.

- `Ruin_Pillar_02.png`
  - Purpose: ruin fragment / pillar variant 02.

- `Ruin_Pillar_03.png`
  - Purpose: ruin fragment / pillar variant 03.

- `Ruin_Pillar_04.png`
  - Purpose: ruin fragment / pillar variant 04.

- `Ruin_Pillar_05.png`
  - Purpose: ruin fragment / pillar variant 05.

### Guidance / Tutorial / Lighting Props

- `lantern_01.png`
  - Purpose: floor / route lantern concept for warm guidance lighting.

- `lantern_02.png`
  - Purpose: alternate lantern concept for route lighting / ruin ambience.

- `help_stone_01.png`
  - Purpose: movement tutorial guiding stone.

- `help_stone_02.png`
  - Purpose: interaction tutorial guiding stone.

---

## Intended Use in Implementation

These concept references are used for:
- level block planning;
- environment composition;
- asset selection;
- wrapper scene mapping;
- Codex scene-building prompts;
- visual consistency checks.

These concept references are not used for:
- direct Godot runtime loading;
- direct placement as textures or sprites;
- collision generation;
- gameplay logic definition by themselves.

---

## Wrapper Scene Rule

For every environment asset used in implementation:

1. Search for an existing matching `.tscn` wrapper scene.
2. Use the existing wrapper scene if found.
3. Do not create duplicate wrappers.
4. If no wrapper scene exists, create a minimal wrapper scene following the established project convention.
5. Do not instance raw `.glb` directly when a wrapper exists.
6. Do not modify raw `.glb` files.
7. Do not modify `.import` files unless explicitly required for a separate technical task.

---

## Source of Truth for Codex / Agents

For gameplay/environment implementation, use the following priority:

1. Written block spec / layout notes.
2. Existing project scene architecture.
3. Existing wrapper `.tscn` scenes.
4. Existing player / SoulOrb / interaction systems.
5. Concept images as visual references.

Do not invent new gameplay systems from concept art alone.

---

## Current Main Build Target

Current primary target block:

- `Block_01_01_StartClearing`

Target implementation goal:
- create a playable art block scene;
- use the existing environment kit;
- preserve the approved route:
  - awakening area
  - clearing
  - path
  - Soul Orb pedestal
  - sealed ruined arch;
- support the gameplay logic:
  - `SoulOrb_World` present in the world;
  - after pickup / follow activation, `AncientStoneBarrier_01` opens.

The Soul Orb itself is handled by existing Soul Orb scenes and should not be recreated from concept art unless explicitly requested.