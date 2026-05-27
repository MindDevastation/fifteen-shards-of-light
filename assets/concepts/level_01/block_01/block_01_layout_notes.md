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

