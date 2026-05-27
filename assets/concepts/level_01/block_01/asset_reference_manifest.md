# Block_01_01_StartClearing — Asset Reference Manifest

## Purpose

This file maps Block_01 concept references to intended gameplay and environment usage.

Concept images are visual references only.  
Implementation must use actual Godot assets, existing `.tscn` wrapper scenes, and current project architecture.

## Main Visual Reference

- `block_01_concept_main.png`
  - Purpose: main mood and layout reference for `Block_01_01_StartClearing`.
  - Use for overall composition, not exact geometry.
  - Written layout notes remain the source of truth for dimensions, gameplay logic, and implementation rules.

## Required Gameplay / Environment Assets

### Ground / Path

- `stone_path_slab_01`
  - Usage: broken stone path slabs through the clearing.
  - Collision: usually none or simple, depending on wrapper convention.
  - Notes: should sit on technical ground and should not define the main movement collision by itself.

- `stone_path_step_01`
  - Usage: stairs from the start terrace and decorative lower steps.
  - Collision: walkable if used as actual stairs.

### Start Area

- `Awakening_Platform_01`
  - Usage: calm starting point on the raised terrace.
  - Collision: simple walkable top surface if the player can stand on it.
  - Approximate scale: 3.0–4.0 units diameter.

### Soul Orb Area

- `SoulOrb_Pedestal_01`
  - Usage: low pedestal / focal platform where the user will manually place `SoulOrb_World`.
  - Collision: simple low platform collision.
  - Approximate scale: 2.2–2.8 units diameter.

Important:
- Codex must not create or place Soul Orb visuals unless explicitly requested.
- Soul Orb is handled by existing scenes:
  - `SoulOrb_World`
  - `SoulOrb_Follow` / actual follow scene name in the project.

### Ruined Arch / Barrier

- `ruined_arch_01`
  - Usage: main sealed arch landmark option.
  - Collision: simple blocking collision around solid parts.
  - Notes: passage should be controlled by `Ancient_Stone_Barrier_01`.

- `ruined_arch_02`
  - Usage: alternate sealed arch landmark option.
  - Collision: simple blocking collision around solid parts.
  - Notes: passage should be controlled by `Ancient_Stone_Barrier_01`.

- `Ancient_Stone_Barrier_01`
  - Usage: animated barrier blocking the ruined arch passage.
  - Collision: blocking before opening; moves down with the visual or disables after opening.
  - Notes: must be animated downward after Soul Orb pickup / follow activation.

### Cliffs / Boundary

- `cliff_rock_01`
  - Usage: perimeter rocky boundary.
  - Collision: simple blocker.

- `medium_rock_01`
  - Usage: medium boundary rocks and scene dressing.
  - Collision: simple blocker only when used to block movement.

- `CliffBoundary_Module_01`
  - Usage: modular soft cliff wall around the clearing.
  - Collision: simple blocker.

### Foliage

- `tree_01`
  - Usage: perimeter tree dressing.
  - Collision: trunk-only collision.

- `tree_02`
  - Usage: perimeter tree dressing.
  - Collision: trunk-only collision.

- `Bush_01`
- `Bush_02`
- `Bush_03`
- `Bush_04`
- `Bush_05`
- `Bush_06`
  - Usage: decorative foliage and soft boundary dressing.
  - Collision: no collision unless existing wrapper convention says otherwise.

### Moss / Flowers / Ground Dressing

- `moss_01`
- `moss_02`
  - Usage: moss patches around path slabs, stones, cliffs, and ruin bases.
  - Collision: none.

- `Flower_Moss_01`
- `Flower_Moss_02`
- `Flower_Moss_03`
- `Flower_Moss_04`
- `Flower_Moss_05`
  - Usage: small warm decorative flower/moss patches.
  - Collision: none.

### Debris / Small Ruin Fragments

- `debris_01`
- `debris_02`
  - Usage: small ruin debris around arch, path, cliff bases, and ruin clusters.
  - Collision: none unless intentionally used as a blocker.

### Ruin Pillars / Low Remnants

- `Ruin_Pillar_01`
- `Ruin_Pillar_02`
- `Ruin_Pillar_03`
- `Ruin_Pillar_04`
- `Ruin_Pillar_05`
  - Usage: small broken ruin fragments, low pillar accents, and visual route dressing.
  - Collision: simple only if used as a blocker.

### Lights / Navigation Helpers

- `lantern_01`
- `lantern_02`
  - Usage: visual guidance and warm route lighting.
  - Collision: simple or none, depending on wrapper convention.

- `help_stone_01`
  - Usage: movement tutorial marker near the start area.

- `help_stone_02`
  - Usage: interaction tutorial marker near the Soul Orb area.

## Wrapper Scene Rule

For every asset used in Block_01:

1. Search for an existing matching `.tscn` wrapper scene.
2. Use the existing wrapper scene if found.
3. Do not create duplicate wrapper scenes.
4. If no wrapper exists, create a minimal wrapper in the established environment asset folder.
5. Do not instance raw `.glb` directly when a wrapper exists.
6. Do not modify raw `.glb` files.
7. Do not modify `.import` files.
8. If collision or passability is unclear, mark `NEEDS_MANUAL_REVIEW`.

## Collision Rule Summary

- Ground / stairs / platforms: stable walkable simple collision.
- Cliffs / big rocks / barrier: simple blocking collision.
- Trees: trunk-only collision.
- Bushes / moss / flowers / small debris: no collision.
- Large ruin fragments: simple collision only if used as blockers.
- `Ancient_Stone_Barrier_01`: blocking collision before opening; collision moves down or disables after opening.

## Implementation Priority

### P0

- Technical ground.
- Start terrace.
- Stairs from start terrace.
- Readable main path.
- Ruined arch.
- `Ancient_Stone_Barrier_01`.
- Soul Orb pedestal marker.
- Cliff boundary.

### P1

- Trees.
- Bushes.
- Moss patches.
- Flower moss patches.
- Debris.
- Ruin pillars.
- Lanterns.
- Help stones.

### P2

- Extra flowers.
- Extra small dressing.
- Final aesthetic balancing.

## Block_01 Gameplay Notes

The user will manually place the Soul Orb.

Codex should implement only the logic connection:

```text
SoulOrb_World picked up / SoulOrb_Follow becomes active
→ Ancient_Stone_Barrier_01 opens downward