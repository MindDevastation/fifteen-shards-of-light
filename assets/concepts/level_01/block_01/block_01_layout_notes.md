# Block_01_01_StartClearing — Layout Notes

## Purpose

Block_01_01_StartClearing is the first playable art block of Level_01 — First Light Forest.

The block introduces:
- the heroine awakening in the world;
- a safe open clearing;
- the first visual route;
- SoulOrb_World;
- the sealed ruined arch;
- AncientStoneBarrier opening after Soul Orb pickup.

This is not a disposable MVP block.  
It is a playable art foundation intended to be polished further.

## Visual Target

Use `block_01_concept_main.png` as the main visual reference.

The image is a mood and layout reference, not a pixel-perfect blueprint.

The scene should feel:
- warm;
- safe;
- ancient;
- magical;
- forest-like;
- softly ruined;
- inviting.

Recommended node structure:

Block_01_01_StartClearing
├── EnvironmentRoot
│   ├── GroundRoot
│   ├── StartTerraceRoot
│   ├── PathRoot
│   ├── RuinsRoot
│   ├── CliffBoundaryRoot
│   ├── FoliageRoot
│   ├── DebrisRoot
│   └── LightingPropsRoot
│
├── GameplayRoot
│   ├── AwakeningMarker
│   ├── SoulOrbPlacementMarker
│   ├── AncientStoneBarrier
│   └── BarrierOpenController
│
├── Markers
│   ├── EntryMarker
│   ├── ExitMarker
│   └── CameraPreviewMarker
│
└── BlockBounds

Do not place Player, MainCamera, LevelManager, GameState, PoemRewardUI, or FinalScene inside this block unless the existing project architecture already requires it.

Scale

Use Godot units as meters.

Approximate block footprint:

Width: 28 units
Depth: 24 units
Playable central area: 20 x 16 units

Coordinate convention:

Origin (0, 0, 0) = center of main clearing
+X = right side of the scene / toward arch side
-X = left side
+Z = back side / raised starting terrace
-Z = front/lower edge
Y = height
Height Levels
Main clearing ground: Y = 0.0
Start terrace: Y = +1.8 to +2.2
Soul Orb pedestal top: Y = +0.25 to +0.4
Lower front edge: Y = 0.0 or slightly below
Main Layout
Main Clearing

Approximate size:

14–16 units wide
10–12 units deep
centered around (0, 0, 0)

Keep the center mostly free for movement and camera safety.

Start Terrace

Position:

Center: approximately (-6.0, +2.0, +8.0)
Size: 6.5–7.5 units wide, 5.0–5.5 units deep

Contains:

Awakening_Platform_01;
safe spawn area;
moss/soft ground dressing;
nearby cliff and foliage dressing.

Keep at least 2.0–2.5 units of free radius around the spawn point.

Stairs From Start Terrace

Position:

Center: approximately (-3.5, +1.0, +5.2)
Width: 2.8–3.2 units
Steps: 4–5
Step height: 0.35–0.45 units
Total height change: about 1.8–2.0 units

Use existing stone path / step assets where possible.

Main Route

Readable path:

Start terrace
→ stairs down
→ central clearing
→ Soul Orb pedestal
→ sealed ruined arch

Path width:

2.2–3.0 units

Use stone slabs and moss/flower/debris dressing.

The path can curve slightly. It should not be perfectly straight or too corridor-like.

Ruined Arch

Position:

Center: approximately (+8.0, 0.0, +6.5)

Approximate dimensions:

Width: 6.5–7.5 units
Height: 7.5–8.5 units
Depth: 1.2–1.8 units

The arch is the main visual landmark and the blocked exit from this block.

AncientStoneBarrier

Place inside the ruined arch.

Approximate dimensions:

Width: 4.8–5.5 units
Height: 5.5–6.2 units
Thickness: 0.6–0.9 units

Initial state:

visible;
collision enabled;
blocks the passage.

Open state:

moves downward over 3–4 seconds;
opens a walkable passage;
collision moves with the visual or disables after opening.

Approximate movement:

Closed local position: Vector3(0, 0, 0)
Open local position: Vector3(0, -3.5 to -4.5, 0)

Adjust exact value after checking asset scale.

Soul Orb Pedestal

Position:

Center: approximately (+5.5, +0.3, +3.8)
Diameter: 2.2–2.8 units
Height: 0.25–0.4 units

The Soul Orb itself will be added manually by the user.

Codex must not create or place Soul Orb visuals unless explicitly requested.

Leave 1.5–1.8 units of free interaction space around the pedestal.

Front Lower Steps

Position:

Center: approximately (0.0, 0.0, -8.5)
Width: 3.0–3.8 units
Steps: 2–3

Mostly decorative/compositional, useful for closing the front edge of the block.

Boundary / Decoration Rules
Cliff Ring

Use cliffs and rocks to create a soft boundary around the playable area.

Approximate cliff boundary:

Thickness: 2.0–4.0 units
Height: 2.0–5.0 units

Important areas:

behind start terrace;
behind arch;
left/right sides of the clearing.
Trees

Recommended count:

8–10 trees

Distribution:

2–3 near start terrace;
2–3 near/behind arch;
2–4 along side boundaries.

Do not place large trees in the center of the main route.

Bushes

Recommended count:

10–16 bushes

Place:

near cliff boundaries;
around ruin fragments;
near path edges;
not in the main movement lane.
Moss / Flower Patches / Debris

Recommended count:

Moss patches: 12–20
Flower moss patches: 6–10
Small debris clusters: 8–14

Place mostly:

around path slabs;
near cliff bases;
around arch base;
around ruin pillar clusters;
near the pedestal.
Ruin Pillars / Small Ruin Fragments

Recommended count:

8–12 small ruin groups

Distribution:

2–3 around start stairs;
2–3 along central path;
2–4 near arch/pedestal;
1–2 near front lower steps.
Lanterns / Guiding Lights

Recommended count:

6–8 lanterns

Distribution:

2 near front lower steps;
2 near start terrace/stairs;
2 near Soul Orb pedestal / arch;
0–2 optional along the path.
Floor / Ground

Do not require a custom ground asset.

Create a simple technical walkable ground directly in Godot if no suitable ground wrapper exists.

Ground should be:

mostly flat in the playable central area;
stable for movement;
simple collision;
visually dressed with moss, slabs, flower patches, debris, and rocks.

Do not create complex collision from decorative moss, flowers, or small debris.

Collision Rules
Ground/path: stable walkable collision.
Cliff/rocks: simple blocking collision.
Trees: trunk-only collision.
Bushes: no collision unless already established by existing wrapper convention.
Moss/flowers/small debris: no collision.
Large ruin fragments: simple collision only when used as blockers.
AncientStoneBarrier: blocking collision before opening; collision moves down or disables after opening.
Gameplay Logic

Soul Orb state:

SoulOrb_World = sphere placed in world.
SoulOrb_Follow = sphere follows player after pickup.

Behavior:

While SoulOrb_World is not picked up:
- AncientStoneBarrier is closed.

When SoulOrb_World is picked up and/or SoulOrb_Follow becomes active:
- AncientStoneBarrier slowly opens.

Codex should:

inspect the current SoulOrb implementation;
find real scene paths and signal names;
connect to existing pickup/collected/follow activation logic if available;
add minimal signal only if needed and only inside existing SoulOrb architecture.

Do not invent a new inventory, quest, dialogue, or global progression system for this.

Asset Usage Rules
First search for existing wrapper .tscn scenes.
Use existing wrapper scenes where available.
Do not duplicate existing wrappers.
Do not instance raw .glb files directly if a wrapper scene exists.
If a wrapper scene is missing, create a minimal wrapper scene following existing conventions.
Do not modify raw .glb files.
Do not modify .import files.
If collision/passability is unclear, mark NEEDS_MANUAL_REVIEW.
Out of Scope

Do not add:

enemies;
combat;
inventory;
dialogue system;
cinematic;
final poem;
final message;
save/progress system;
full Level_01 multi-block assembly;
new large architecture system;
unrelated player/camera changes;
visual polish beyond necessary placement and basic readable lighting.
Manual Test Checklist

After implementation, verify:

Block scene opens in Godot without missing dependencies.
Player can walk from start terrace to central clearing.
Player can reach Soul Orb pedestal.
Arch is visibly blocked at start.
Barrier opens after SoulOrb pickup/follow activation.
Barrier collision does not remain as invisible blocker after opening.
Camera does not clip badly into cliffs/trees on the main route.
No decorative moss/flowers/debris blocks movement.
Scene uses wrapper .tscn assets where available.
No duplicate wrapper scenes were created unnecessarily.

---

# 4. `assets/concepts/level_01/block_01/asset_reference_manifest.md`

```md
# Block_01_01_StartClearing — Asset Reference Manifest

## Purpose

This file maps Block_01 concept references to intended gameplay/environment usage.

Concept images are visual references only.  
Implementation must use actual Godot assets/scenes from the project.

## Main Visual Reference

```text
block_01_concept_main.png

Usage:

Main mood and layout reference.
Use for overall composition, not exact geometry.
Required Gameplay/Environment Assets
Ground / Path
stone_path_slab_01
Usage: broken stone path slabs through the clearing.
Collision: usually none or simple, depending on wrapper convention.
Notes: should sit on technical ground, not define movement collision.
stone_path_step_01
Usage: stairs from start terrace and decorative lower steps.
Collision: walkable if used as actual stairs.
Start Area
Awakening_Platform_01
Usage: calm starting point on raised terrace.
Collision: simple walkable top surface if player can stand on it.
Approx scale: 3.0–4.0 units diameter.
Soul Orb Area
SoulOrb_Pedestal_01
Usage: pedestal/focal platform where user will manually place SoulOrb_World.
Collision: simple low platform collision.
Approx scale: 2.2–2.8 units diameter.

Important:

Codex must not create or place SoulOrb visuals unless explicitly requested.
Soul Orb is handled by existing scenes:
SoulOrb_World
SoulOrb_Follow / actual follow scene name in project
Ruined Arch / Barrier
ruined_arch_01 or ruined_arch_02
Usage: main sealed arch landmark.
Collision: simple blocking collision around solid parts; passage should be controlled by barrier.
Ancient_Stone_Barrier_01
Usage: animated barrier blocking the arch.
Collision: blocking before open; moves/disables after opening.
Notes: must be animated downward.
Cliffs / Boundary
cliff_rock_01
Usage: perimeter rocky boundary.
medium_rock_01
Usage: medium boundary rocks and decoration.
CliffBoundary_Module_01
Usage: modular soft cliff wall around clearing.
Collision: simple blocker.
Foliage
tree_01
Usage: perimeter tree dressing.
Collision: trunk only.
tree_02
Usage: perimeter tree dressing.
Collision: trunk only.
Bush_01
Bush_02
Bush_03
Bush_04
Bush_05
Bush_06
Usage: decorative foliage, soft edges.
Collision: no collision unless existing convention says otherwise.
Moss / Flowers / Ground Dressing
moss_01
moss_02
Usage: moss patches around path, stones, cliffs.
Collision: none.
Flower_Moss_01
Flower_Moss_02
Flower_Moss_03
Flower_Moss_04
Flower_Moss_05
Usage: small warm decorative patches.
Collision: none.
Debris / Ruin Fragments
debris_01
debris_02
Usage: small ruin debris around arch/path/cliff base.
Collision: none unless used as blocker.
Ruin_Pillar_01
Ruin_Pillar_02
Ruin_Pillar_03
Ruin_Pillar_04
Ruin_Pillar_05
Usage: small broken ruin fragments and low pillar accents.
Collision: simple only if used as blocker.
Lights / Navigation Helpers
lantern_01
lantern_02
Usage: visual guidance and warm route lighting.
Collision: simple or none, depending on wrapper convention.
help_stone_01
Usage: movement tutorial marker near start.
help_stone_02
Usage: interaction tutorial marker near Soul Orb.
Wrapper Scene Rule

For every asset:

Search for an existing matching .tscn wrapper scene.
Use existing wrapper scene if found.
Do not create duplicate wrappers.
If no wrapper exists, create a minimal wrapper in the established environment asset folder.
Do not instance raw .glb directly when wrapper exists.
Do not modify raw .glb or .import files.
Collision Rule Summary
Ground / stairs / platforms: walkable simple collision
Cliffs / big rocks / barrier: simple blocking collision
Trees: trunk-only collision
Bushes / moss / flowers / small debris: no collision
Unclear cases: mark NEEDS_MANUAL_REVIEW
Implementation Priority

P0:

ground;
start terrace;
stairs;
readable main path;
ruined arch;
AncientStoneBarrier;
SoulOrb pedestal marker;
cliff boundary.

P1:

trees;
bushes;
moss;
debris;
ruin pillars;
lanterns;
help stones.

P2:

extra flowers;
extra small dressing;
final aesthetic balancing.

---

## Финальный вывод

Да, твоя структура рабочая.  
Главное: `.gdignore` кладём в `assets/concepts/`, а `.md` файлы делают так, чтобы Codex понимал:

```text
картинки = референсы
текст = требования
игровые сцены = только через wrapper .tscn
Block_01 = отдельная block-scene
Level_01 потом собирается из блоков
Avoid:
- dark dungeon mood;
- horror atmosphere;
- large open world scale;
- dense visual noise;
- complex platforming;
- dangerous-looking spikes or traps.

## Scene Structure

Target scene path:

```text
scenes/levels/level_01/blocks/Block_01_01_StartClearing.tscn
Recommended node structure:

Block_01_01_StartClearing
├── EnvironmentRoot
│   ├── GroundRoot
│   ├── StartTerraceRoot
│   ├── PathRoot
│   ├── RuinsRoot
│   ├── CliffBoundaryRoot
│   ├── FoliageRoot
│   ├── DebrisRoot
│   └── LightingPropsRoot
│
├── GameplayRoot
│   ├── AwakeningMarker
│   ├── SoulOrbPlacementMarker
│   ├── AncientStoneBarrier
│   └── BarrierOpenController
│
├── Markers
│   ├── EntryMarker
│   ├── ExitMarker
│   └── CameraPreviewMarker
│
└── BlockBounds

Do not place Player, MainCamera, LevelManager, GameState, PoemRewardUI, or FinalScene inside this block unless the existing project architecture already requires it.

Scale

Use Godot units as meters.

Approximate block footprint:

Width: 28 units
Depth: 24 units
Playable central area: 20 x 16 units

Coordinate convention:

Origin (0, 0, 0) = center of main clearing
+X = right side of the scene / toward arch side
-X = left side
+Z = back side / raised starting terrace
-Z = front/lower edge
Y = height
Height Levels
Main clearing ground: Y = 0.0
Start terrace: Y = +1.8 to +2.2
Soul Orb pedestal top: Y = +0.25 to +0.4
Lower front edge: Y = 0.0 or slightly below
Main Layout
Main Clearing

Approximate size:

14–16 units wide
10–12 units deep
centered around (0, 0, 0)

Keep the center mostly free for movement and camera safety.

Start Terrace

Position:

Center: approximately (-6.0, +2.0, +8.0)
Size: 6.5–7.5 units wide, 5.0–5.5 units deep

Contains:

Awakening_Platform_01;
safe spawn area;
moss/soft ground dressing;
nearby cliff and foliage dressing.

Keep at least 2.0–2.5 units of free radius around the spawn point.

Stairs From Start Terrace

Position:

Center: approximately (-3.5, +1.0, +5.2)
Width: 2.8–3.2 units
Steps: 4–5
Step height: 0.35–0.45 units
Total height change: about 1.8–2.0 units

Use existing stone path / step assets where possible.

Main Route

Readable path:

Start terrace
→ stairs down
→ central clearing
→ Soul Orb pedestal
→ sealed ruined arch

Path width:

2.2–3.0 units

Use stone slabs and moss/flower/debris dressing.

The path can curve slightly. It should not be perfectly straight or too corridor-like.

Ruined Arch

Position:

Center: approximately (+8.0, 0.0, +6.5)

Approximate dimensions:

Width: 6.5–7.5 units
Height: 7.5–8.5 units
Depth: 1.2–1.8 units

The arch is the main visual landmark and the blocked exit from this block.

AncientStoneBarrier

Place inside the ruined arch.

Approximate dimensions:

Width: 4.8–5.5 units
Height: 5.5–6.2 units
Thickness: 0.6–0.9 units

Initial state:

visible;
collision enabled;
blocks the passage.

Open state:

moves downward over 3–4 seconds;
opens a walkable passage;
collision moves with the visual or disables after opening.

Approximate movement:

Closed local position: Vector3(0, 0, 0)
Open local position: Vector3(0, -3.5 to -4.5, 0)

Adjust exact value after checking asset scale.

Soul Orb Pedestal

Position:

Center: approximately (+5.5, +0.3, +3.8)
Diameter: 2.2–2.8 units
Height: 0.25–0.4 units

The Soul Orb itself will be added manually by the user.

Codex must not create or place Soul Orb visuals unless explicitly requested.

Leave 1.5–1.8 units of free interaction space around the pedestal.

Front Lower Steps

Position:

Center: approximately (0.0, 0.0, -8.5)
Width: 3.0–3.8 units
Steps: 2–3

Mostly decorative/compositional, useful for closing the front edge of the block.

Boundary / Decoration Rules
Cliff Ring

Use cliffs and rocks to create a soft boundary around the playable area.

Approximate cliff boundary:

Thickness: 2.0–4.0 units
Height: 2.0–5.0 units

Important areas:

behind start terrace;
behind arch;
left/right sides of the clearing.
Trees

Recommended count:

8–10 trees

Distribution:

2–3 near start terrace;
2–3 near/behind arch;
2–4 along side boundaries.

Do not place large trees in the center of the main route.

Bushes

Recommended count:

10–16 bushes

Place:

near cliff boundaries;
around ruin fragments;
near path edges;
not in the main movement lane.
Moss / Flower Patches / Debris

Recommended count:

Moss patches: 12–20
Flower moss patches: 6–10
Small debris clusters: 8–14

Place mostly:

around path slabs;
near cliff bases;
around arch base;
around ruin pillar clusters;
near the pedestal.
Ruin Pillars / Small Ruin Fragments

Recommended count:

8–12 small ruin groups

Distribution:

2–3 around start stairs;
2–3 along central path;
2–4 near arch/pedestal;
1–2 near front lower steps.
Lanterns / Guiding Lights

Recommended count:

6–8 lanterns

Distribution:

2 near front lower steps;
2 near start terrace/stairs;
2 near Soul Orb pedestal / arch;
0–2 optional along the path.
Floor / Ground

Do not require a custom ground asset.

Create a simple technical walkable ground directly in Godot if no suitable ground wrapper exists.

Ground should be:

mostly flat in the playable central area;
stable for movement;
simple collision;
visually dressed with moss, slabs, flower patches, debris, and rocks.

Do not create complex collision from decorative moss, flowers, or small debris.

Collision Rules
Ground/path: stable walkable collision.
Cliff/rocks: simple blocking collision.
Trees: trunk-only collision.
Bushes: no collision unless already established by existing wrapper convention.
Moss/flowers/small debris: no collision.
Large ruin fragments: simple collision only when used as blockers.
AncientStoneBarrier: blocking collision before opening; collision moves down or disables after opening.
Gameplay Logic

Soul Orb state:

SoulOrb_World = sphere placed in world.
SoulOrb_Follow = sphere follows player after pickup.

Behavior:

While SoulOrb_World is not picked up:
- AncientStoneBarrier is closed.

When SoulOrb_World is picked up and/or SoulOrb_Follow becomes active:
- AncientStoneBarrier slowly opens.

Codex should:

inspect the current SoulOrb implementation;
find real scene paths and signal names;
connect to existing pickup/collected/follow activation logic if available;
add minimal signal only if needed and only inside existing SoulOrb architecture.

Do not invent a new inventory, quest, dialogue, or global progression system for this.

Asset Usage Rules
First search for existing wrapper .tscn scenes.
Use existing wrapper scenes where available.
Do not duplicate existing wrappers.
Do not instance raw .glb files directly if a wrapper scene exists.
If a wrapper scene is missing, create a minimal wrapper scene following existing conventions.
Do not modify raw .glb files.
Do not modify .import files.
If collision/passability is unclear, mark NEEDS_MANUAL_REVIEW.
Out of Scope

Do not add:

enemies;
combat;
inventory;
dialogue system;
cinematic;
final poem;
final message;
save/progress system;
full Level_01 multi-block assembly;
new large architecture system;
unrelated player/camera changes;
visual polish beyond necessary placement and basic readable lighting.
Manual Test Checklist

After implementation, verify:

Block scene opens in Godot without missing dependencies.
Player can walk from start terrace to central clearing.
Player can reach Soul Orb pedestal.
Arch is visibly blocked at start.
Barrier opens after SoulOrb pickup/follow activation.
Barrier collision does not remain as invisible blocker after opening.
Camera does not clip badly into cliffs/trees on the main route.
No decorative moss/flowers/debris blocks movement.
Scene uses wrapper .tscn assets where available.
No duplicate wrapper scenes were created unnecessarily.

---

# 4. `assets/concepts/level_01/block_01/asset_reference_manifest.md`

```md
# Block_01_01_StartClearing — Asset Reference Manifest

## Purpose

This file maps Block_01 concept references to intended gameplay/environment usage.

Concept images are visual references only.  
Implementation must use actual Godot assets/scenes from the project.

## Main Visual Reference

```text
block_01_concept_main.png

Usage:

Main mood and layout reference.
Use for overall composition, not exact geometry.
Required Gameplay/Environment Assets
Ground / Path
stone_path_slab_01
Usage: broken stone path slabs through the clearing.
Collision: usually none or simple, depending on wrapper convention.
Notes: should sit on technical ground, not define movement collision.
stone_path_step_01
Usage: stairs from start terrace and decorative lower steps.
Collision: walkable if used as actual stairs.
Start Area
Awakening_Platform_01
Usage: calm starting point on raised terrace.
Collision: simple walkable top surface if player can stand on it.
Approx scale: 3.0–4.0 units diameter.
Soul Orb Area
SoulOrb_Pedestal_01
Usage: pedestal/focal platform where user will manually place SoulOrb_World.
Collision: simple low platform collision.
Approx scale: 2.2–2.8 units diameter.

Important:

Codex must not create or place SoulOrb visuals unless explicitly requested.
Soul Orb is handled by existing scenes:
SoulOrb_World
SoulOrb_Follow / actual follow scene name in project
Ruined Arch / Barrier
ruined_arch_01 or ruined_arch_02
Usage: main sealed arch landmark.
Collision: simple blocking collision around solid parts; passage should be controlled by barrier.
Ancient_Stone_Barrier_01
Usage: animated barrier blocking the arch.
Collision: blocking before open; moves/disables after opening.
Notes: must be animated downward.
Cliffs / Boundary
cliff_rock_01
Usage: perimeter rocky boundary.
medium_rock_01
Usage: medium boundary rocks and decoration.
CliffBoundary_Module_01
Usage: modular soft cliff wall around clearing.
Collision: simple blocker.
Foliage
tree_01
Usage: perimeter tree dressing.
Collision: trunk only.
tree_02
Usage: perimeter tree dressing.
Collision: trunk only.
Bush_01
Bush_02
Bush_03
Bush_04
Bush_05
Bush_06
Usage: decorative foliage, soft edges.
Collision: no collision unless existing convention says otherwise.
Moss / Flowers / Ground Dressing
moss_01
moss_02
Usage: moss patches around path, stones, cliffs.
Collision: none.
Flower_Moss_01
Flower_Moss_02
Flower_Moss_03
Flower_Moss_04
Flower_Moss_05
Usage: small warm decorative patches.
Collision: none.
Debris / Ruin Fragments
debris_01
debris_02
Usage: small ruin debris around arch/path/cliff base.
Collision: none unless used as blocker.
Ruin_Pillar_01
Ruin_Pillar_02
Ruin_Pillar_03
Ruin_Pillar_04
Ruin_Pillar_05
Usage: small broken ruin fragments and low pillar accents.
Collision: simple only if used as blocker.
Lights / Navigation Helpers
lantern_01
lantern_02
Usage: visual guidance and warm route lighting.
Collision: simple or none, depending on wrapper convention.
help_stone_01
Usage: movement tutorial marker near start.
help_stone_02
Usage: interaction tutorial marker near Soul Orb.
Wrapper Scene Rule

For every asset:

Search for an existing matching .tscn wrapper scene.
Use existing wrapper scene if found.
Do not create duplicate wrappers.
If no wrapper exists, create a minimal wrapper in the established environment asset folder.
Do not instance raw .glb directly when wrapper exists.
Do not modify raw .glb or .import files.
Collision Rule Summary
Ground / stairs / platforms: walkable simple collision
Cliffs / big rocks / barrier: simple blocking collision
Trees: trunk-only collision
Bushes / moss / flowers / small debris: no collision
Unclear cases: mark NEEDS_MANUAL_REVIEW
Implementation Priority

P0:

ground;
start terrace;
stairs;
readable main path;
ruined arch;
AncientStoneBarrier;
SoulOrb pedestal marker;
cliff boundary.

P1:

trees;
bushes;
moss;
debris;
ruin pillars;
lanterns;
help stones.

P2:

extra flowers;
extra small dressing;
final aesthetic balancing.

---

## Финальный вывод

Да, твоя структура рабочая.  
Главное: `.gdignore` кладём в `assets/concepts/`, а `.md` файлы делают так, чтобы Codex понимал:

```text
картинки = референсы
текст = требования
игровые сцены = только через wrapper .tscn
Block_01 = отдельная block-scene
Level_01 потом собирается из блоков