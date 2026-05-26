# Global Concept Asset Reference Manifest

This manifest lists concept references used for visual planning.

Important:
- These are reference images only.
- They are not runtime assets.
- Actual gameplay scenes must use existing `.tscn` wrapper scenes where available.
- Do not instance raw `.glb` files directly if a matching wrapper scene exists.
- If a wrapper scene is missing, create a minimal wrapper scene following the existing project convention.

## Level 01 / First Light Forest References

### Main Level Block References

- `level_01/block_01/block_01_concept_main.png`
  - Purpose: main visual reference for Block_01_01_StartClearing.
  - Use as mood/layout reference, not pixel-perfect blueprint.

### Individual Prop References

- `Awakening_Platform_01.png`
  - Purpose: starting awakening platform on the raised terrace.

- `SoulOrb_Pedestal_01.png`
  - Purpose: low pedestal / platform where the Soul Orb will be placed manually.

- `CliffBoundary_Module_01.png`
  - Purpose: modular cliff boundary segment for enclosing the clearing.

- `Ruin_Pillar_01.png`
  - Purpose: small ruin pillar / broken stone fragment dressing.

- `Flower_Moss_01.png`
  - Purpose: decorative moss/flower patch for ground dressing.

Add more concept files here as they are added to the folder.

## Source of Truth

For gameplay implementation, use:
- written layout notes;
- current Godot scene architecture;
- existing wrapper `.tscn` scenes;
- existing player / SoulOrb / interaction systems.

Do not invent new systems from concept art alone.