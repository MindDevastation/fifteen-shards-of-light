
# FIFTEEN SHARDS OF LIGHT
# Level_05 - «То, что остается»
## Greybox Development Reference

| Control | Value |
|---|---|
| Repository | `MindDevastation/fifteen-shards-of-light` |
| Target scene | `res://scenes/levels/Level_05.tscn` |
| Reference version | 1.1 |
| Repository Markdown target | `docs/design/Level_05_Greybox_Development_Reference_v1.1.md` |
| Producer DOCX target | `Level_05_Greybox_Development_Reference_v1.1.docx` |
| Implementation branch after APPLY | `feature/implement-level-05-greybox` |
| Portal target | `res://scenes/levels/Level_06.tscn` |
| Mode | Documentation only - no runtime files, branches, commits or PRs |
| Prepared | 27 June 2026 |

> **Emotional safety contract**  
> The heroine and the garden are already alive and valuable. The light belongs to her. Progress records the author's attention and memory; it never repairs, captures, catalogues, surveils, proves knowledge, creates obligation or claims access to Alena's inner state.

# Version 1.1 Change Log

- **V11-01** - restored the exact approved CP0-CP9 Camera QA registry, including Player floor positions, viewing targets and required/prohibited readings.
- **V11-02** - synchronized all canonical environment-block paths with Technical Architecture under `scenes/levels/level_05/blocks/`, including the sole boundaries path `scenes/levels/level_05/blocks/Level05Boundaries.tscn`.
- **V11-03** - added an explicit `Stop conditions` section to every Slice 0-11; a triggered stop condition prevents execution of the next slice.
- **V11-04** - closed Slice 11 runtime write authority, made its READ ONLY scope literal, and listed conditional matching `.gd.uid` sidecars path-by-path in every runtime slice.
- **V11-05** - extended Slice 0 inspection to the actual `SceneTransition` autoload, scene/script behavior, LevelPortal fallback/loading chain and active-PR intersections.
- **V11-06** - regenerated Markdown and DOCX from one semantic source and repeated semantic-equivalence and full-page render QA.

# Version 1.0 Change Log

- Created the first unified Level_05 Greybox Development Reference from all five approved source documents.
- Locked the exact inward-spiral topology, P00-P24 coordinates, CP0-CP9 camera QA points, recovery registry, RA0-RA9 anchors, canonical IDs and exact texts.
- Defined Level-local ownership, root composition, exact NodePaths, APIs, signals, macro and puzzle state models.
- Decomposed implementation into twelve safe slices: Slice 0 inspection-only plus Slices 1-11 implementation/stabilization.
- Locked one explicit APPLY, post-APPLY branch creation, internal acceptance gates and hard-stop conditions.
- Added literal per-slice CREATE/MODIFY/READ ONLY/FORBIDDEN scopes and matching Level-local `.gd.uid` policy.
- Added unit-like, static, P0/P1, acceptance and no-softlock matrices.
- Added mandatory content-equivalent Markdown and user-facing DOCX implementation summaries.

# 1. Source-of-truth hierarchy

1. `Level_05_Narrative_and_Level_Scenario_Package_v1.1.docx` - title, exact copy, three-shard fixed order, emotional function and forbidden readings.
2. `Level_05_Visual_Master_Concept_Package.docx` - inward spiral, blue-hour close-up garden, landmark hierarchy, puzzle visual verbs and environment-state intent.
3. `Level_05_Gameplay_Map_and_Level_Design_Spec_v1.2.docx` - exact P00-P24 coordinates, topology, traversal dimensions, target footprints, recovery registry, CP0-CP9 and playtest requirements.
4. `Level_05_Technical_Architecture_and_State_Model.docx` - Level-local ownership, root hierarchy, APIs, signals, state machines, NodePaths, recovery and shared-system boundaries.
5. `Level_05_Art_Production_Bible_v1.1.docx` - boundary map, layer ownership, primitive-first greybox handoff and deferred art constraints.
6. Current repository main and active PR stack - factual integration authority only. Repository facts may require a narrow prerequisite or base decision but may not silently replace approved design.

# 2. Repository snapshot and preflight assumptions

The documentation audit found:

- default branch: `main`;
- current inspected main SHA: `a9380f7afce1c0bb0727ccaf6e3f0e76a13df78d`;
- open PRs at this documentation pass: none;
- `AGENTS.md` still contains stale 15-micro-level/couplet language, but its narrow-scope, greybox-first and one-slice-at-a-time workflow remains applicable;
- `Level_05.tscn` is a factual legacy placeholder: 12 x 12 floor, one SoulShard, legacy LevelManager, PoemRewardUI and a portal targeting Level_06;
- placeholder blob SHA: `43d29b9e8b486e56584e89169675b12ea2d7bddd`;
- placeholder content is not canon and must be replaced during authorized implementation;
- shared Player, Camera, SoulShard, ShardRewardSequenceController, ShardRewardOverlay, LevelFinaleOverlay, SoulOrb_Follow and LevelPortal are reuse candidates and read-only by default.

This snapshot is not permission to skip Slice 0. Slice 0 must refresh every fact against current main and the active PR stack.

# 3. Scope

## Included

- complete playable primitive greybox of Level_05;
- continuous inward spiral and ten environment blocks;
- Player, camera and shared SoulOrb_Follow integration;
- three local puzzles with any-order subtargets;
- Shard_10, Shard_11 and Shard_12;
- exact reward texts and exact main text;
- shared reward lifecycle;
- E0-E4 non-blocking environment presentation;
- Quiet Assembly as non-interactive synthesis;
- fail-closed final text;
- shared LevelPortal activation toward Level_06;
- exact recovery volumes and RA0-RA9 anchor architecture;
- no-softlock, duplicate, race, reload, traversal and accessibility validation;
- final implementation summaries in Markdown and content-equivalent DOCX.

## Excluded

- final 3D assets, Blender, GLB, custom collision exports, textures, final materials, final shaders;
- final particles, final sound, music, voiceover or cinematics;
- final typography;
- save system, GameState, checkpoints persisted across scene reload;
- Level_06 development;
- shared-system refactor unless a named P0 gate proves a separately approved narrow prerequisite;
- project settings or autoload changes;
- Level_01-Level_04 or Level_06+ cleanup;
- final confession scene or acrostic work.

# 4. Hard technical rules

- No `project.godot` change without a proven blocker and explicit approval.
- No implementation directly on `main`.
- Slice 0 is inspection-only, produces zero diff and ends `WAITING FOR APPLY`.
- Only one explicit APPLY is required. After APPLY, create `feature/implement-level-05-greybox` from the exact approved base and continue sequentially while each internal gate passes.
- Stop only for P0 failure, shared-system blocker, scope deviation, unresolved active-PR/base conflict, Producer-only decision, or mandatory evidence that cannot be verified.
- No broad refactor, global node-name scan, group-based Player discovery, nearest-anchor guess, per-frame world-position scan or child-order identity.
- No gameplay script on raw GLB imports.
- No GameState, save system, new autoload or LevelManager expansion.
- No random puzzle sequences, hidden mandatory objects, camera-facing puzzle, audio dependency, timing challenge, mandatory jump or precision traversal.
- Environment transitions never lock Player.
- Main text is fail-closed.
- Shared LevelPortal is the sole owner of activation state, InteractionArea, AUTO_ENTER transition latch and scene loading.
- Temporary harnesses live outside the repository worktree or are removed before commit.
- Runtime slices may add/change only the literal matching `.gd.uid` sidecars listed in the active slice. A sidecar is allowed only with its exact sibling `.gd`; unrelated UID/import/generated churn is forbidden.


# 5. Canonical IDs and exact player-facing copy

| Type | Canonical ID | Exact value |
|---|---|---|
| Puzzle | `&"DEW_SCRIPT"` | Dew Script |
| Puzzle | `&"LITTLE_REACTIONS"` | Little Reactions |
| Puzzle | `&"ORDINARY_MOSAIC"` | Ordinary Mosaic |
| Shard | `&"Shard_10"` | Я до сих пор улыбаюсь, когда вспоминаю твое «понимяу». |
| Shard | `&"Shard_11"` | Я до сих пор помню, как ты на несколько секунд включила камеру и улыбнулась. |
| Shard | `&"Shard_12"` | Мне дорога твоя искренность в наших разговорах. |
| Main text | `&"LEVEL_05_MAIN_TEXT"` | Я помню твое «понимяу», ту короткую улыбку в камеру и то, как искренне ты говоришь со мной. В тот момент это могло казаться мелочами, но именно они возвращаются в память снова и снова. Из них постепенно сложилось понимание: мое чувство к тебе глубже, чем один легкий разговор или яркий момент. |
| Portal target | String path | `res://scenes/levels/Level_06.tscn` |

Runtime strings are stored without decorative outer quotation marks. Character spelling and punctuation are exact and must be tested character-for-character.

# 6. Exact spatial layout

## 6.1 Global geometry contract

- Level root transform: identity.
- Envelope: X -45..+45, Z -52..+52.
- One continuous inward spiral; no hub, branch choice, mandatory backtracking or direct Seed Basin shortcut.
- Centerline length: 177.71 m including P23-P24.
- Mandatory route width: 5.5 m minimum; 6-7 m at major curves, pocket entries, shard spaces and outlook.
- Legal shoulder: 1.25 m minimum beyond mandatory route edge.
- Camera-safe corridor: 8.5 m centered on mandatory route.
- Preferred slope <=8 degrees; isolated absolute maximum 10 degrees over <=4 m.
- Cross-slope <=3 degrees.
- Mandatory step height <=0.15 m.
- No mandatory gaps or jumps.
- Target clear radius: 3.0 m.
- Shard clear radius: 3.5 m.
- Portal visual/camera clear radius: 4.5 m.
- Seed Basin center: `Vector3(-9.00,0.00,0.00)`.
- Visual radius: 5.5 m; no-walk radius: 7.5 m; legal viewing-rim inner radius: 8.5 m.
- Final route centerline must remain at least 11.50 m from basin center.

## 6.2 Exact P00-P24 route

| Point | Exact scene-local floor position |
|---|---|
| P00 Spawn / Outer Threshold | Vector3(-9.000, 2.400, -46.440) |
| P01 Dew Arc 1 | Vector3(1.790, 2.480, -43.490) |
| P02 Dew Arc 2 | Vector3(11.140, 2.580, -37.670) |
| P03 Dew Arc 3 | Vector3(18.460, 2.680, -29.650) |
| P04 Shard_10 Rest Ledge | Vector3(23.360, 2.760, -20.180) |
| P05 Moss Bend East | Vector3(25.650, 2.720, -10.030) |
| P06 Basin Glimpse East | Vector3(25.370, 2.620, 0.000) |
| P07 Seed Turn Station | Vector3(22.730, 2.520, 9.180) |
| P08 Pollen Puff Station | Vector3(18.130, 2.420, 16.920) |
| P09 Folding Glow Station | Vector3(12.060, 2.320, 22.750) |
| P10 Shard_11 Rest Stone | Vector3(5.120, 2.220, 26.420) |
| P11 Descent Start | Vector3(-2.090, 2.080, 27.840) |
| P12 Descent North | Vector3(-9.000, 1.880, 27.140) |
| P13 Descent West | Vector3(-15.100, 1.680, 24.580) |
| P14 Mosaic Entry | Vector3(-20.000, 1.480, 20.570) |
| P15 Mosaic Pad 1 | Vector3(-23.430, 1.280, 15.590) |
| P16 Mosaic Pad 2 | Vector3(-25.310, 1.080, 10.170) |
| P17 Mosaic Pad 3 | Vector3(-25.650, 0.900, 4.820) |
| P18 Shard_12 Inner Terrace | Vector3(-24.650, 0.820, 0.000) |
| P19 Quiet Assembly West | Vector3(-23.095, 0.760, -5.130) |
| P20 Quiet Assembly Mid | Vector3(-20.108, 0.720, -9.319) |
| P21 Final Approach West | Vector3(-16.000, 0.680, -12.124) |
| P22 Main Text Gate | Vector3(-11.344, 0.680, -13.295) |
| P23 Portal Approach | Vector3(-6.742, 0.740, -12.802) |
| P24 LevelPortalRoot | Vector3(-2.500, 0.820, -11.258) |

## 6.3 Puzzle, shard, finale and portal anchors

| Identity | Exact position | Footprint / rule |
|---|---|---|
| DEW_ARC_1 | Vector3(1.79,2.48,-43.49) | 4.5 x 2.5 m broad grounded footprint; 0.35 s |
| DEW_ARC_2 | Vector3(11.14,2.58,-37.67) | 4.5 x 2.5 m broad grounded footprint; 0.35 s |
| DEW_ARC_3 | Vector3(18.46,2.68,-29.65) | 4.5 x 2.5 m broad grounded footprint; 0.35 s |
| REACTION_SEED_TURN | Vector3(22.73,2.52,9.18) | radius 2.4 m; 0.45 s |
| REACTION_POLLEN_PUFF | Vector3(18.13,2.42,16.92) | radius 2.4 m; 0.45 s |
| REACTION_FOLDING_GLOW | Vector3(12.06,2.32,22.75) | radius 2.4 m; 0.45 s |
| MOSAIC_FOREGROUND | Vector3(-23.43,1.28,15.59) | radius 2.8 m; 0.65 s |
| MOSAIC_MIDGROUND | Vector3(-25.31,1.08,10.17) | radius 2.8 m; 0.65 s |
| MOSAIC_BACKGROUND | Vector3(-25.65,0.90,4.82) | radius 2.8 m; 0.65 s |
| Shard_10_FloorAnchor | Vector3(23.36,2.76,-20.18) | dry 10 x 8 m ledge; slot identity-local |
| Shard_11_FloorAnchor | Vector3(5.12,2.22,26.42) | dry 10 x 8 m rest stone; slot identity-local |
| Shard_12_FloorAnchor | Vector3(-24.65,0.82,0.00) | dry inner terrace; slot identity-local |
| FinalTextGate | Vector3(-11.344,0.68,-13.295) | Area3D radius 4.5 m; exact Player only |
| PortalFloorAnchor | Vector3(-2.500,0.82,-11.258) | shared LevelPortal root identity-local |

## 6.4 Camera QA points

Each CP identity is fixed. Do not add a CP at P07, renumber CP0-CP9 or move a canonical CP to another route point. Every CP authoring node records both the Player floor position and the approved viewing target.

| ID | Player floor position | Viewing target |
|---|---|---|
| CP0 Arrival | `Vector3(-9.00, 2.40, -46.44)` | `Vector3(5.00, 2.55, -37.00)` |
| CP1 Dew Entrance | `Vector3(-0.50, 2.47, -44.50)` | `Vector3(13.50, 2.60, -35.00)` |
| CP2 Shard_10 Ledge | `Vector3(23.36, 2.76, -20.18)` | `Vector3(25.40, 2.65, -2.00)` |
| CP3 Reactions Entry | `Vector3(25.37, 2.62, 0.00)` | `Vector3(18.00, 2.42, 17.00)` |
| CP4 Shard_11 Stone | `Vector3(5.12, 2.22, 26.42)` | `Vector3(-10.00, 1.75, 24.00)` |
| CP5 Mosaic Entrance | `Vector3(-20.00, 1.48, 20.57)` | `Vector3(-24.50, 1.05, 8.50)` |
| CP6 Shard_12 Terrace | `Vector3(-24.65, 0.82, 0.00)` | `Vector3(-20.10, 0.72, -9.32)` |
| CP7 Final Approach | `Vector3(-16.00, 0.68, -12.124)` | `Vector3(-11.344, 0.68, -13.295)` |
| CP8 Main Text Gate | `Vector3(-11.344, 0.68, -13.295)` | `Vector3(-2.500, 0.82, -11.258)` |
| CP9 Portal Outlook | `Vector3(-6.742, 0.74, -12.802)` | `Vector3(-2.500, 1.90, -11.258)` |

| ID | Required reading | Prohibited reading / obstruction |
|---|---|---|
| CP0 | Dew entrance, Arc 1 silhouette and partial Basin glimpse. | No tall-grass route wall. |
| CP1 | All three Dew arcs. | No arc hidden. |
| CP2 | Persistent traces and Moss Bend; reward remains readable. | Reward not occluded. |
| CP3 | All three reaction stations. | No mascot framing. |
| CP4 | Descent and all Mosaic pads. | Basin shortcut not readable. |
| CP5 | All pads and the shared field. | No alignment implication. |
| CP6 | Quiet Assembly arc outside Basin. | No direct Basin crossing. |
| CP7 | FinalTextGate and Outlook continuation. | Retaining edge unobstructed. |
| CP8 | Portal Outlook visible; portal dormant before and during text. | No early active-portal reading. |
| CP9 | Shared LevelPortal with R4.5 clearance. | No severe foreground occlusion. |

# 7. Recovery registry

## 7.1 Exact recovery volumes

| Volume ID | Shape | Position | Rotation | Exact size | Covered risk | Destination |
|---|---|---|---|---|---|---|
| RV_FALL_GLOBAL | Box | Vector3(0.00,-8.00,0.00) | Vector3(0,0,0) | Vector3(100,8,116) | All below-world falls; top face Y=-4.00 | RA_LATEST_VALID |
| RV_PERIM_N | Box | Vector3(0.00,3.00,56.00) | Vector3(0,0,0) | Vector3(100,12,8) | North same-height OOB; Z 52..60 | RA_LATEST_VALID |
| RV_PERIM_S | Box | Vector3(0.00,3.00,-56.00) | Vector3(0,0,0) | Vector3(100,12,8) | South same-height OOB; Z -60..-52 | RA_LATEST_VALID |
| RV_PERIM_W | Box | Vector3(-49.00,3.00,0.00) | Vector3(0,0,0) | Vector3(8,12,120) | West same-height OOB; X -53..-45 | RA_LATEST_VALID |
| RV_PERIM_E | Box | Vector3(49.00,3.00,0.00) | Vector3(0,0,0) | Vector3(8,12,120) | East same-height OOB; X 45..53 | RA_LATEST_VALID |
| RV_BASIN_DISK | Cylinder | Vector3(-9.00,-0.50,0.00) | Vector3(0,0,0) | radius 7.50 m; height 5.00 m | Complete Seed Basin no-walk disk | RA_LATEST_VALID |
| RV_OUTLOOK_S | Box | Vector3(-7.00,2.00,-21.00) | Vector3(0,0,0) | Vector3(30,10,5) | Final-approach outer edge; X -22..8, Z -23.5..-18.5 | RA8 if valid, otherwise RA_LATEST_VALID |

## 7.2 Exact recovery anchors

Each `Level05RecoveryAnchorZone` has a `FloorAnchor` at the exact floor coordinate and an `ArrivalZone` local position `Vector3(0,1.25,0)` with `CylinderShape3D radius=2.25 m, height=2.50 m`. Acceptance requires continuous grounded dwell >=0.20 s, exact Player binding and current-overlap reevaluation.

| Anchor ID | Exact floor position | Earliest allowed state / predicate |
|---|---|---|
| RA0_Arrival | Vector3(-9.000, 2.400, -46.440) | L05_INIT+ |
| RA1_DewComplete | Vector3(18.460, 2.680, -29.650) | all 3 Dew IDs complete / SHARD_10 reveal path+ |
| RA2_Shard10Ledge | Vector3(23.360, 2.760, -20.180) | SHARD_10_AVAILABLE+ |
| RA3_LittleReactions | Vector3(25.370, 2.620, 0.000) | SHARD_10_REWARD_COMPLETE / REACTIONS_ACTIVE+ |
| RA4_Shard11Stone | Vector3(5.120, 2.220, 26.420) | SHARD_11_AVAILABLE+ |
| RA5_MosaicEntry | Vector3(-20.000, 1.480, 20.570) | SHARD_11_REWARD_COMPLETE / MOSAIC_ACTIVE+ |
| RA6_Shard12Terrace | Vector3(-24.650, 0.820, 0.000) | SHARD_12_AVAILABLE+ |
| RA7_QuietAssembly | Vector3(-20.108, 0.720, -9.319) | ALL_REWARDS_COMPLETE+ |
| RA8_MainTextGate | Vector3(-11.344, 0.680, -13.295) | ALL_REWARDS_COMPLETE / MAIN_TEXT+ |
| RA9_PortalApproach | Vector3(-6.742, 0.740, -12.802) | EXIT / portal activation+ |

## 7.3 Recovery invariants

- First valid recovery-volume entry creates one internal token and one pending event.
- Duplicate/overlapping entries do not create another token.
- `shard_reward` and `main_text` are source-keyed suspension owners.
- Pending recovery survives source-volume exit and continued fall below Y=-12.
- It executes once after the last suspension is removed unless a proven safe return to legal space already occurred.
- Destination is latest valid authored RA; `RV_OUTLOOK_S` may use RA8 only when RA8 is valid, otherwise latest valid RA.
- Teleport sets `Player.velocity = Vector3.ZERO`.
- Additional transient movement may be cleared only through a proven public Player API. Private step-climb, floor or movement fields are forbidden.
- If safe teleport cannot be achieved through public behavior, the owning slice stops for a separately approved narrow shared prerequisite.
- Recovery remains disarmed until the Player exits the destination ArrivalZone and one physics frame confirms the Player is outside every recovery volume.
- No invisible catch floor is introduced.

# 8. Proposed repository file tree

```text
scenes/levels/Level_05.tscn
scenes/levels/level_05/
  blocks/
    Block_05_00_OuterThreshold.tscn
    Block_05_01_DewScriptWalk.tscn
    Block_05_02_Shard10RestLedge.tscn
    Block_05_03_MossBend.tscn
    Block_05_04_LittleReactions.tscn
    Block_05_05_Shard11RestStone.tscn
    Block_05_06_InnerSpiralDescent.tscn
    Block_05_07_OrdinaryMosaic.tscn
    Block_05_08_Shard12QuietAssembly.tscn
    Block_05_09_PortalOutlook.tscn
    Level05Boundaries.tscn
  gameplay/
    Level05PresenceFootprint.tscn
    DewScriptPuzzle.tscn
    LittleReactionsPuzzle.tscn
    OrdinaryMosaicPuzzle.tscn
    Level05ShardSlot.tscn
    Level05RecoveryAnchorZone.tscn
    Level05RecoveryVolume.tscn
    Level05RouteAuthority.tscn
  state/
    Level05EnvironmentState.tscn
  vfx/
    Level05DewPresentation.tscn
    Level05ReactionsPresentation.tscn
    Level05MosaicPresentation.tscn
    Level05Guidance.tscn
    Level05QuietAssemblyVFX.tscn
    Level05PortalAccentVFX.tscn
scripts/levels/level_05/
  level_05_progress_controller.gd
  level_05_presence_footprint.gd
  dew_script_controller.gd
  little_reactions_controller.gd
  ordinary_mosaic_controller.gd
  level_05_shard_slot.gd
  level_05_environment_state_controller.gd
  level_05_finale_controller.gd
  level_05_portal_adapter.gd
  level_05_recovery_controller.gd
  level_05_recovery_anchor_zone.gd
  level_05_recovery_volume.gd
docs/development/Level_05_Greybox_Implementation_Summary.md
```

The final user-facing artifact `Level_05_Greybox_Implementation_Summary.docx` is mandatory, generated outside the runtime repository worktree and not committed unless a separate explicit PR-scope decision authorizes it.

# 9. Proposed root node tree

```text
Level_05 (Node3D; identity)
├── EnvironmentRoot
│   ├── Block_05_00_OuterThreshold
│   ├── Block_05_01_DewScriptWalk
│   ├── Block_05_02_Shard10RestLedge
│   ├── Block_05_03_MossBend
│   ├── Block_05_04_LittleReactions
│   ├── Block_05_05_Shard11RestStone
│   ├── Block_05_06_InnerSpiralDescent
│   ├── Block_05_07_OrdinaryMosaic
│   ├── Block_05_08_Shard12QuietAssembly
│   ├── Block_05_09_PortalOutlook
│   └── Boundaries
├── GameplayRoot
│   ├── PuzzleRoot
│   │   ├── DewScriptPuzzle
│   │   ├── LittleReactionsPuzzle
│   │   └── OrdinaryMosaicPuzzle
│   ├── ShardRoot
│   │   ├── Shard_10_FloorAnchor / ShardSlot_10
│   │   ├── Shard_11_FloorAnchor / ShardSlot_11
│   │   └── Shard_12_FloorAnchor / ShardSlot_12
│   ├── RouteAuthorityRoot / FinalTextGate
│   ├── PortalRoot / PortalFloorAnchor / LevelPortal
│   └── SafetyRoot
│       ├── RecoveryVolumes / RV_FALL_GLOBAL ... RV_OUTLOOK_S
│       └── RecoveryAnchors / RA0_Arrival ... RA9_PortalApproach
├── EnvironmentStateRoot
│   ├── Level05EnvironmentStateController
│   ├── WorldEnvironment
│   └── LightingRoot
├── VFXRoot
│   ├── DewPresentationRoot
│   ├── ReactionsPresentationRoot
│   ├── MosaicPresentationRoot
│   ├── GuidanceRoot
│   ├── QuietAssemblyVFX
│   └── PortalAccentVFX
├── PlayerRoot
│   ├── PlayerFloorSpawnMarker
│   ├── Player
│   └── SoulOrb_Follow
├── CameraRoot / FollowCamera
├── LevelRuntimeRoot
│   ├── Level05ProgressController
│   ├── ShardRewardSequenceController
│   ├── Level05FinaleController
│   ├── Level05PortalAdapter
│   └── Level05RecoveryController
├── MarkerRoot
│   ├── RouteCenterline / P00 ... P24
│   └── CameraQA / CP0 ... CP9 (each CP stores approved Player floor position and ViewingTarget marker)
└── UILayer
    ├── ShardRewardOverlay
    └── LevelFinaleOverlay
```

# 10. Exact NodePath registry

| Owner | Export | Exact relative NodePath |
|---|---|---|
| Level05ProgressController | dew_controller_path | `../../GameplayRoot/PuzzleRoot/DewScriptPuzzle/DewScriptController` |
| Level05ProgressController | reactions_controller_path | `../../GameplayRoot/PuzzleRoot/LittleReactionsPuzzle/LittleReactionsController` |
| Level05ProgressController | mosaic_controller_path | `../../GameplayRoot/PuzzleRoot/OrdinaryMosaicPuzzle/OrdinaryMosaicController` |
| Level05ProgressController | shard_slot_10_path | `../../GameplayRoot/ShardRoot/Shard_10_FloorAnchor/ShardSlot_10` |
| Level05ProgressController | shard_slot_11_path | `../../GameplayRoot/ShardRoot/Shard_11_FloorAnchor/ShardSlot_11` |
| Level05ProgressController | shard_slot_12_path | `../../GameplayRoot/ShardRoot/Shard_12_FloorAnchor/ShardSlot_12` |
| Level05ProgressController | environment_controller_path | `../../EnvironmentStateRoot/Level05EnvironmentStateController` |
| Level05ProgressController | finale_controller_path | `../Level05FinaleController` |
| Level05ProgressController | portal_adapter_path | `../Level05PortalAdapter` |
| Level05ProgressController | recovery_controller_path | `../Level05RecoveryController` |
| DewScriptController | footprint_root_path | `../FootprintRoot` |
| DewScriptController | presentation_controller_path | `../../../../VFXRoot/DewPresentationRoot` |
| DewScriptController | player_path | `../../../../PlayerRoot/Player` |
| LittleReactionsController | footprint_root_path | `../FootprintRoot` |
| LittleReactionsController | presentation_controller_path | `../../../../VFXRoot/ReactionsPresentationRoot` |
| LittleReactionsController | player_path | `../../../../PlayerRoot/Player` |
| OrdinaryMosaicController | footprint_root_path | `../FootprintRoot` |
| OrdinaryMosaicController | presentation_controller_path | `../../../../VFXRoot/MosaicPresentationRoot` |
| OrdinaryMosaicController | player_path | `../../../../PlayerRoot/Player` |
| All Level05PresenceFootprint | player_path | `../../../../../PlayerRoot/Player` |
| ShardSlot_10/11/12 | player_path | `../../../../PlayerRoot/Player` |
| ShardSlot_10/11/12 | soul_shard_path | `SoulShard` |
| ShardSlot_10/11/12 | reveal_vfx_path | `RevealVFXRoot` |
| ShardRewardSequenceController | overlay_path | `../../UILayer/ShardRewardOverlay` |
| ShardRewardSequenceController | player_path | `../../PlayerRoot/Player` |
| ShardRewardSequenceController | shard_search_root_path | `../../GameplayRoot/ShardRoot` |
| Level05EnvironmentStateController | world_environment_path | `../WorldEnvironment` |
| Level05EnvironmentStateController | lighting_root_path | `../LightingRoot` |
| Level05EnvironmentStateController | reactions_guidance_path | `../../VFXRoot/GuidanceRoot/ReactionsGuidance` |
| Level05EnvironmentStateController | mosaic_guidance_path | `../../VFXRoot/GuidanceRoot/MosaicGuidance` |
| Level05EnvironmentStateController | quiet_assembly_vfx_path | `../../VFXRoot/QuietAssemblyVFX` |
| Level05FinaleController | player_path | `../../PlayerRoot/Player` |
| Level05FinaleController | final_text_gate_path | `../../GameplayRoot/RouteAuthorityRoot/FinalTextGate` |
| Level05FinaleController | finale_overlay_path | `../../UILayer/LevelFinaleOverlay` |
| Level05FinaleController | recovery_controller_path | `../Level05RecoveryController` |
| Level05PortalAdapter | portal_path | `../../GameplayRoot/PortalRoot/PortalFloorAnchor/LevelPortal` |
| Level05PortalAdapter | portal_accent_vfx_path | `../../VFXRoot/PortalAccentVFX` |
| Level05RecoveryController | player_path | `../../PlayerRoot/Player` |
| Level05RecoveryController | progress_controller_path | `../Level05ProgressController` |
| RA0-RA9 Level05RecoveryAnchorZone | player_path | `../../../../PlayerRoot/Player` |
| FollowCamera | target_path | `../../PlayerRoot/Player` |
| SoulOrb_Follow | target_path | `../Player` |
| SoulOrb_Follow | orientation_source_path | `../Player/CharacterVisualRoot` |

# 11. Ownership and API contracts

## 11.1 Level05ProgressController

Sole owner of the exact twelve macro states. It accepts semantic puzzle, shard, finale and portal facts; it never infers identity from node names or positions.

- `get_state() -> MacroState`
- `get_collected_shard_ids() -> Array[StringName]`
- `report_puzzle_completed(puzzle_id: StringName) -> bool`
- `report_puzzle_presentation_terminal(puzzle_id: StringName, source: StringName) -> bool`
- `report_shard_available(shard_id: StringName) -> bool`
- `report_shard_collected(shard_id: StringName) -> bool`
- `can_activate_recovery_anchor(anchor_id: StringName) -> bool`
- `request_debug_snapshot() -> Dictionary`

## 11.2 Puzzle controller common contract

- `activate() -> bool`
- `report_presence_accepted(target_id: StringName) -> bool`
- `is_target_completed(target_id: StringName) -> bool`
- `is_complete() -> bool`
- `request_current_hint() -> void`
- `debug_validate_identity_map() -> bool`

## 11.3 Level05ShardSlot

- `prepare_hidden() -> void`
- `request_reveal() -> bool`
- `is_available() -> bool`
- signals: `shard_available(shard_id)`, `shard_collection_started(shard_id)`, `shard_collected(shard_id)`, `configuration_error(component,message)`

## 11.4 Environment, finale, portal and recovery

- Environment: `request_phase(phase) -> bool`, `start_quiet_assembly() -> int`, `get_phase()`, `validate_local_resources() -> bool`.
- Finale: `arm_finale(text_id: StringName, exact_text: String) -> bool`, `is_armed()`, `is_main_text_active()`.
- Portal adapter: `request_activation() -> bool`; owns one request, optional local accent and diagnostics only.
- Recovery: explicit registration APIs, source-keyed suspend/resume, latest-valid anchor and one-token recovery.

# 12. Signal and exact event-order contract

| Signal | Emitter | Receiver | Mandatory order / invariant |
|---|---|---|---|
| `presence_accepted(target_id)` | Level05PresenceFootprint | owning puzzle | grounded dwell; one occupancy generation |
| `puzzle_completed(puzzle_id)` | puzzle controller | Progress | logical 3/3 once |
| `puzzle_presentation_terminal(puzzle_id,source)` | puzzle controller | Progress | real/fallback first-terminal-wins |
| `shard_available(shard_id)` | Level05ShardSlot | Progress | only after effective collectability |
| `shard_collection_started(shard_id)` | Level05ShardSlot | Progress + Recovery | shared reward requested; no macro advance |
| `shard_collected(shard_id)` | Level05ShardSlot | Progress + Recovery | after shared reward completes; only macro commit event |
| `main_text_started(text_id)` | FinaleController | Progress | overlay accepted exact text |
| `main_text_closed(text_id)` | FinaleController | Progress | actual shared closed event |
| `portal_activation_requested()` | PortalAdapter | QA | immediately before sole shared activate() |
| `portal_activated()` | PortalAdapter | Progress/QA | semantic forwarding of actual shared activation_completed |
| `recovery_performed(anchor_id,volume_id,token)` | RecoveryController | QA | one teleport for current token |

For each puzzle-to-shard transition the exact order is:

1. puzzle logical completion latch;
2. emit `puzzle_completed(puzzle_id)`;
3. puzzle presentation real/fallback terminal;
4. Progress calls `ShardSlot.request_reveal()` once;
5. slot enters packed hidden -> revealing -> enable pending;
6. slot enables visible, monitoring, monitorable and collision state;
7. verify effective collectability and current-overlap behavior;
8. emit `shard_available(shard_id)`;
9. shared reward lifecycle begins on Player interaction;
10. after shared reward completion, slot emits `shard_collected(shard_id)`;
11. Progress commits the next canonical macro state.

# 13. State models

## 13.1 Exact macro states

| State | Invariant | Only valid forward event |
|---|---|---|
| L05_INIT | startup validation; three packed hidden shards; E0; portal inactive | deferred successful initialization |
| DEW_ACTIVE | only Dew IDs accepted | Dew logical + presentation terminal, then actual Shard_10 availability |
| SHARD_10_AVAILABLE | only Shard_10 collectable | slot shard_collected(Shard_10) |
| SHARD_10_REWARD_COMPLETE | reward committed; E1 requested | deferred REACTIONS_ACTIVE, no environment wait |
| REACTIONS_ACTIVE | only Reaction IDs accepted | Reaction logical + terminal, then Shard_11 availability |
| SHARD_11_AVAILABLE | only Shard_11 collectable | slot shard_collected(Shard_11) |
| SHARD_11_REWARD_COMPLETE | reward committed; E2 requested | deferred MOSAIC_ACTIVE |
| MOSAIC_ACTIVE | only Mosaic IDs accepted | Mosaic logical + terminal, then Shard_12 availability |
| SHARD_12_AVAILABLE | only Shard_12 collectable | slot shard_collected(Shard_12) |
| ALL_REWARDS_COMPLETE | all rewards committed; E3 and Quiet Assembly requested; finale armed immediately | accepted main_text_started |
| MAIN_TEXT | exact text visible; portal dormant | actual LevelFinaleOverlay.closed |
| EXIT | E4 requested; adapter requests shared activation once | terminal local state; shared portal loads Level_06 |

## 13.2 Dew Script

- Fixed IDs: DEW_ARC_1, DEW_ARC_2, DEW_ARC_3.
- Local any-order, unique persistent set.
- 0.35 s grounded dwell.
- Hints at 20 s and 35 s; repeat interval 6 s.
- Third unique ID emits logical completion immediately.
- Final trace terminal uses real callback or 1.20 s fallback.
- No reset, wrong order, timer fail, thin beam, alignment or audio requirement.

## 13.3 Little Reactions

- Fixed IDs: REACTION_SEED_TURN, REACTION_POLLEN_PUFF, REACTION_FOLDING_GLOW.
- Local any-order, unique persistent set.
- 0.45 s grounded dwell.
- Presentation starts after logical acceptance and may overlap.
- Final active motion callback or 1.30 s fallback.
- No chase, random waiting, speed reaction, mascot behavior, face, eyes, wings or required sound.

## 13.4 Ordinary Mosaic

- Fixed IDs: MOSAIC_FOREGROUND, MOSAIC_MIDGROUND, MOSAIC_BACKGROUND.
- Local any-order, unique persistent set.
- 0.65 s grounded dwell.
- Each accepted pad adds one persistent layer.
- Third ID emits logical completion; final layer callback or 1.25 s fallback.
- No camera angle, screenshot, lens, composition score or visual recognition.

## 13.5 Environment phases

- E0_INITIAL: garden already alive, natural 75-85% richness.
- E1_AFTER_SHARD_10: Dew traces persist; Reactions route clarifies over target 4 s.
- E2_AFTER_SHARD_11: completed motions persist; Mosaic descent clarifies over target 4 s.
- E3_AFTER_SHARD_12: all motifs coexist; Quiet Assembly primary over target 5 s; finale does not wait.
- E4_AFTER_MAIN_TEXT: stable garden and restrained horizon support.
- Independent tween owners; no transition locks Player; resources are scene-local/deep-duplicated.

## 13.6 Finale and portal

- FinalTextGate records exact Player occupancy before and after arming.
- `arm_finale()` reevaluates current overlap after one physics frame.
- Missing overlay, missing API or false `show_finale_text()` result is fail-closed and leaves portal dormant.
- Only actual `closed` advances to EXIT.
- Portal configuration:
  - `target_scene_path = "res://scenes/levels/Level_06.tscn"`
  - `entry_mode = LevelPortal.EntryMode.AUTO_ENTER`
  - `require_entry_confirmation = false`
- Adapter calls shared `activate()` exactly once after main text closes.
- Adapter does not duplicate shared formation, own InteractionArea, transition latch or scene loading.
- Adapter waits for actual `activation_completed`; timeout emits blocker diagnostics only and never fabricates success.

# 14. Startup validation

Final production startup validation must verify:

- all exact NodePaths resolve to expected types;
- exact puzzle IDs, target IDs, shard IDs and texts;
- exact one-to-one ID/path mappings;
- packed hidden shard states before first frame;
- exactly one visible SoulOrb_Follow and correct target/orientation paths;
- shared reward registration for all three SoulShard children;
- all P00-P24 transforms and every CP0-CP9 Player floor position plus approved ViewingTarget position within approved epsilon;
- CP0-CP9 required readings and prohibited occlusions are manually evidenced at the approved camera framing;
- all puzzle, shard, gate, portal, RV and RA transforms within approved epsilon;
- route widths, clearances and Seed Basin exclusion;
- seven unique recovery volume IDs and ten unique RA IDs;
- environment resource locality and no PortalAccent ownership;
- FinaleOverlay API and `closed` signal;
- shared LevelPortal API, `activation_completed`, exact AUTO_ENTER configuration and identity-local root;
- Level_06 target exists;
- no legacy LevelManager or PoemRewardUI in expected Level_05 runtime flow;
- no final art/GLB dependency;
- no unapproved `.gd.uid`, `.import` or generated-file churn.

# 15. Execution contract and Producer gates

## 15.1 Slice 0

Slice 0 is fully inspection-only. It must inspect AGENTS, current main SHA, active PR stack, Level_05 placeholder, Level_06 target, shared APIs, current file conflicts and exact base decision. It must produce zero diff and end `WAITING FOR APPLY`.

Slice 0 handoff must contain `Commit SHA: N/A`.

## 15.2 After APPLY

After the one explicit APPLY:

1. reconfirm clean status;
2. reconfirm approved base SHA and PR-stack decision;
3. create `feature/implement-level-05-greybox` from that exact base;
4. verify current branch and HEAD;
5. execute Slice 1;
6. validate and commit Slice 1;
7. continue automatically through Slice 11 while internal gates pass.

G1-G10 are internal acceptance gates and do not require additional user confirmation.

## 15.3 Hard stops

Stop only for:

- any P0 failure;
- shared Player/SoulShard/reward/finale/portal compatibility blocker;
- file-scope deviation;
- unresolved active-PR or base conflict;
- required Producer-only design choice;
- mandatory manual evidence that cannot be verified;
- inability to preserve exact copy, spatial contract, recovery safety or portal ownership.

# 16. Master file ownership matrix

| Area | Authority |
|---|---|
| `docs/design/Level_05_Greybox_Development_Reference_v1.1.md` | documentation source; this task only |
| `scenes/levels/Level_05.tscn` | root composition; replace legacy placeholder only in authorized runtime slices |
| `scenes/levels/level_05/blocks/` | Canonical Level_05 primitive environment block directory; exact slice whitelists only. |
| `scenes/levels/level_05/blocks/Level05Boundaries.tscn` | Sole canonical Level_05 boundaries scene path. |
| `scenes/levels/level_05/gameplay/` | Level_05-local gameplay scenes, exact slice whitelists only. |
| `scenes/levels/level_05/state/` | Level_05-local environment-state scene, exact slice whitelist only. |
| `scenes/levels/level_05/vfx/` | Primitive placeholder VFX scenes, exact slice whitelists only. |
| `scripts/levels/level_05/` | Level_05-local scripts only; authority is granted only through exact literal paths in the active slice. |
| Level-local `.gd.uid` sidecars | Conditional only when the exact sibling `.gd` is in the active slice CREATE/MODIFY list; see the literal inventory below. |
| shared Player/Camera/SoulShard/reward/finale/portal | READ ONLY unless separate approved prerequisite |
| `project.godot` | FORBIDDEN without approved blocker |
| Level_01-Level_04 and Level_06+ | FORBIDDEN |
| raw GLB / Blender / final art | FORBIDDEN |
| temporary harnesses | outside worktree or removed before commit |
| `docs/development/Level_05_Greybox_Implementation_Summary.md` | mandatory Slice 11 repository summary |
| `Level_05_Greybox_Implementation_Summary.docx` | mandatory user artifact outside runtime worktree; not committed without explicit decision |



## 16.1 Literal matching Level_05 UID inventory

These are the only possible Level_05 script sidecars across the complete implementation. A sidecar is authorized only in a slice whose CREATE or MODIFY list contains its exact sibling `.gd` file.

- `scripts/levels/level_05/level_05_progress_controller.gd.uid`
- `scripts/levels/level_05/level_05_presence_footprint.gd.uid`
- `scripts/levels/level_05/dew_script_controller.gd.uid`
- `scripts/levels/level_05/little_reactions_controller.gd.uid`
- `scripts/levels/level_05/ordinary_mosaic_controller.gd.uid`
- `scripts/levels/level_05/level_05_shard_slot.gd.uid`
- `scripts/levels/level_05/level_05_environment_state_controller.gd.uid`
- `scripts/levels/level_05/level_05_finale_controller.gd.uid`
- `scripts/levels/level_05/level_05_portal_adapter.gd.uid`
- `scripts/levels/level_05/level_05_recovery_controller.gd.uid`
- `scripts/levels/level_05/level_05_recovery_anchor_zone.gd.uid`
- `scripts/levels/level_05/level_05_recovery_volume.gd.uid`

Unrelated `.gd.uid`, scene UID metadata, `.import`, `.godot/imported`, cache and generated-file churn are forbidden.

# Slice 0 - Full Preflight

## Goal
Refresh repository facts and produce the exact implementation/base plan without changing any file.

## Preconditions
- Current documentation reference approved.
- No APPLY yet.

## Exact file scope

### CREATE
- None.

### MODIFY
- None.

### READ ONLY
- `AGENTS.md`
- `project.godot`
- `scenes/levels/Level_05.tscn`
- `scenes/levels/Level_06.tscn`
- `scenes/core/Player.tscn`
- `scripts/player/player_controller.gd`
- `scripts/player/camera_controller.gd`
- `scenes/core/SoulShard.tscn`
- `scripts/soul/soul_shard.gd`
- `scripts/core/shard_reward_sequence_controller.gd`
- `scenes/ui/ShardRewardOverlay.tscn`
- `scripts/ui/shard_reward_overlay.gd`
- `scenes/ui/LevelFinaleOverlay.tscn`
- `scripts/ui/level_finale_overlay.gd`
- `scenes/core/SoulOrb_Follow.tscn`
- `scripts/core/soul_orb_follow.gd`
- `scenes/core/LevelPortal.tscn`
- `scripts/core/level_portal.gd`
- `scenes/core/SceneTransition.tscn`
- `scripts/core/scene_transition.gd`

### CONDITIONAL MATCHING .gd.uid
- None. This slice grants no `.gd.uid` write authority.
- Unrelated `.gd.uid`, scene UID, `.import`, `.godot/imported`, cache and generated-file churn are forbidden.

### FORBIDDEN
- Every repository path not listed under CREATE, MODIFY or READ ONLY for this slice is forbidden even for inspection; every path listed only under READ ONLY is forbidden from modification.
- Modification of `project.godot`, Level_01-Level_04 and Level_06+ runtime files, shared-system scripts/scenes, raw GLB, Blender files, final materials, textures, audio and unrelated documentation is forbidden unless the exact path is explicitly listed under MODIFY after a separately approved prerequisite decision.
- No wildcard file authority. A defect requiring another path is a hard stop: reopen the owning slice or issue an explicit defect-fix whitelist before editing.
- UID authority is defined only by the literal `CONDITIONAL MATCHING .gd.uid` subsection of this slice. Unrelated `.gd.uid`, scene UID, `.import`, `.godot/imported`, cache or generated-file churn is forbidden.

## Nodes, scenes and scripts
- Inspect current Level_05 and target Level_06.
- Inspect all shared APIs and actual node trees.
- Inspect the actual SceneTransition autoload scene/script and its public transition behavior used by LevelPortal.
- Inspect open PRs and changed-file intersections.

## APIs and signals
- Record exact current APIs/signals and blockers.
- Record `project.godot` SceneTransition autoload mapping, the LevelPortal fallback/loading chain and whether any Level_05-local scene loading is unnecessary.
- Record exact base choice; do not invent compatibility.

## Implementation steps
- Resolve main SHA and open PRs, including intersections with `scenes/core/SceneTransition.tscn` and `scripts/core/scene_transition.gd`.
- Compare approved design with placeholder.
- Trace the actual `LevelPortal.activate()` -> activation completion -> SceneTransition/fallback loading behavior and verify the Level_05 adapter needs no local loading API.
- List exact expected files for all slices.
- Produce zero-diff plan and test-impact report.

## Automated and static checks
- `git status --short` empty before and after.
- `git diff --check` empty.
- No `.gd.uid`, scene UID, import file or generated file is allowed.
- Verify the `project.godot` autoload mapping and read-only SceneTransition public chain without changing either file.

## Manual runtime checks
- None - no runtime execution is required beyond read-only scene/API inspection if available.

## Acceptance criteria
- All facts refreshed, including actual SceneTransition autoload/public behavior and the LevelPortal loading fallback chain.
- No conflicts unresolved.
- Zero diff.
- Handoff ends `WAITING FOR APPLY`.
- Commit SHA: N/A.

## Stop conditions
- Any global hard stop occurs: P0 failure, shared-system blocker, scope deviation, unresolved active-PR/base conflict, required Producer-only decision, or mandatory evidence that cannot be verified.
- Any diff, `.gd.uid`, scene UID, `.import`, `.godot/imported`, cache or generated file appears.
- Main/PR/base conflict remains unresolved, including an active PR intersection with SceneTransition.
- Any mandatory shared API or the actual LevelPortal -> SceneTransition loading chain remains NOT VERIFIED or incompatible.
- The factual handoff cannot end with `WAITING FOR APPLY`.
- When any stop condition triggers, stop immediately, do not commit an invalid slice and do not execute the next slice.

## Rollback plan
- No rollback needed because no changes are permitted.

## Risks
- Main/PR drift may invalidate source snapshot.
- Shared portal, SceneTransition or shard availability may require a narrow prerequisite.
- An active PR touching SceneTransition is a base-decision trigger.

## Out of scope
- All implementation, branch creation, commits, PRs and runtime edits.

## Required handoff
- Branch, approved base SHA, slice-start SHA, final head SHA.
- Exact `git diff --name-only` and matching `.gd.uid` mapping.
- Commands/checks with factual outputs.
- Manual checks marked PASS / FAIL / NOT VERIFIED.
- Known risks, blockers, rollback point and recommendation to continue or stop.
- Commit SHA for this slice and PR link when created.


# Slice 1 - Spatial Shell and Primitive Environment

## Goal
Replace the legacy placeholder with the complete walkable primitive spiral, exact blocks, boundaries, markers, Player/camera and dormant portal placement.

## Preconditions
- Explicit APPLY received.
- Clean status reconfirmed.
- Approved base SHA reconfirmed.
- Create `feature/implement-level-05-greybox` from exact approved base and verify HEAD before writes.

## Exact file scope

### CREATE
- `scenes/levels/level_05/blocks/Block_05_00_OuterThreshold.tscn`
- `scenes/levels/level_05/blocks/Block_05_01_DewScriptWalk.tscn`
- `scenes/levels/level_05/blocks/Block_05_02_Shard10RestLedge.tscn`
- `scenes/levels/level_05/blocks/Block_05_03_MossBend.tscn`
- `scenes/levels/level_05/blocks/Block_05_04_LittleReactions.tscn`
- `scenes/levels/level_05/blocks/Block_05_05_Shard11RestStone.tscn`
- `scenes/levels/level_05/blocks/Block_05_06_InnerSpiralDescent.tscn`
- `scenes/levels/level_05/blocks/Block_05_07_OrdinaryMosaic.tscn`
- `scenes/levels/level_05/blocks/Block_05_08_Shard12QuietAssembly.tscn`
- `scenes/levels/level_05/blocks/Block_05_09_PortalOutlook.tscn`
- `scenes/levels/level_05/blocks/Level05Boundaries.tscn`

### MODIFY
- `scenes/levels/Level_05.tscn`

### READ ONLY
- `AGENTS.md`
- `project.godot`
- `scenes/core/Player.tscn`
- `scripts/player/player_controller.gd`
- `scripts/player/camera_controller.gd`
- `scenes/core/SoulOrb_Follow.tscn`
- `scenes/core/LevelPortal.tscn`

### CONDITIONAL MATCHING .gd.uid
- None. This slice grants no `.gd.uid` write authority.
- Unrelated `.gd.uid`, scene UID, `.import`, `.godot/imported`, cache and generated-file churn are forbidden.

### FORBIDDEN
- Every repository path not listed under CREATE, MODIFY or READ ONLY for this slice is forbidden even for inspection; every path listed only under READ ONLY is forbidden from modification.
- Modification of `project.godot`, Level_01-Level_04 and Level_06+ runtime files, shared-system scripts/scenes, raw GLB, Blender files, final materials, textures, audio and unrelated documentation is forbidden unless the exact path is explicitly listed under MODIFY after a separately approved prerequisite decision.
- No wildcard file authority. A defect requiring another path is a hard stop: reopen the owning slice or issue an explicit defect-fix whitelist before editing.
- UID authority is defined only by the literal `CONDITIONAL MATCHING .gd.uid` subsection of this slice. Unrelated `.gd.uid`, scene UID, `.import`, `.godot/imported`, cache or generated-file churn is forbidden.

## Nodes, scenes and scripts
- Ten primitive environment blocks with StaticBody3D collision.
- P00-P24 route markers and exact CP0-CP9 CameraQA nodes; each CP stores the approved Player floor position and explicit ViewingTarget marker from Section 6.4.
- Seed Basin visual/no-walk primitive and boundary belt.
- PlayerFloorSpawnMarker, shared Player, SoulOrb_Follow, FollowCamera.
- PortalFloorAnchor and dormant shared LevelPortal.

## APIs and signals
- FollowCamera target_path exact.
- SoulOrb_Follow target/orientation paths exact.
- LevelPortal target Level_06; activation remains dormant.

## Implementation steps
- Create branch and record base/head.
- Replace placeholder root composition.
- Build broad route surfaces from primitives only.
- Add exact P00-P24 markers and exact CP0-CP9 Player/ViewingTarget marker pairs without adding a CP at P07 or renumbering canonical IDs.
- Add physical boundaries without reducing legal shoulder/camera corridor.
- Place Player through floor marker; derive safe Player-root Y from actual grounding evidence and record it.
- Configure camera and shared orb.
- Place portal anchor identity-local and inactive.

## Automated and static checks
- Godot parse/resource load.
- Static scan for legacy LevelManager/PoemRewardUI absence.
- Coordinate table comparison for P00-P24 and both vectors of every CP0-CP9 registry row.
- Static check that no extra CP is authored and canonical CP IDs remain unchanged.
- No final asset references.
- Changed-file whitelist.

## Manual runtime checks
- Walk P00-P24 continuously without jump.
- Check no snag, gap, shortcut or route ambiguity.
- Fall/edge behavior not yet recovery-authoritative but no invisible floor.
- Inspect every CP0-CP9 at 16:9 against its exact viewing target, required reading and prohibited obstruction from Section 6.4.
- Verify portal does not load.

## Acceptance criteria
- Complete route walkable.
- Exact X/Z and approved floor anchors preserved.
- Route width/shoulder/camera corridor pass.
- Every CP0-CP9 Player position, viewing target and required/prohibited reading passes; no CP is added at P07.
- No mandatory jump.
- Player grounded and camera stable.
- No puzzle logic yet.
- G1 PASS.

## Stop conditions
- Any global hard stop occurs: P0 failure, shared-system blocker, scope deviation, unresolved active-PR/base conflict, required Producer-only decision, or mandatory evidence that cannot be verified.
- Current branch, HEAD or base SHA does not match the Slice 0 approved decision.
- Player root-to-floor grounding cannot be proven through actual CharacterBody behavior.
- Exact route, shoulder, camera corridor, boundary, Seed Basin exclusion or Level_06 portal target fails.
- Any CP0-CP9 Player position, viewing target or required/prohibited reading cannot be preserved.
- When any stop condition triggers, stop immediately, do not commit an invalid slice and do not execute the next slice.

## Rollback plan
- Revert Slice 1 commit to restore legacy placeholder.

## Risks
- Primitive seams/snags.
- Player-root Y cannot be inferred from floor Y.
- Boundary may accidentally create basin shortcut or camera occlusion.

## Out of scope
- Puzzles, shards, recovery logic, environment transitions, finale and portal activation.

## Required handoff
- Branch, approved base SHA, slice-start SHA, final head SHA.
- Exact `git diff --name-only` and matching `.gd.uid` mapping.
- Commands/checks with factual outputs.
- Manual checks marked PASS / FAIL / NOT VERIFIED.
- Known risks, blockers, rollback point and recommendation to continue or stop.
- Commit SHA for this slice and PR link when created.
- CP0-CP9 registry evidence: exact Player/ViewingTarget vectors, required readings, prohibited obstructions and confirmation that no CP was added at P07.


# Slice 2 - Recovery and Traversal Safety

## Goal
Implement exact recovery volumes, RA0-RA9 zones and token/latch/suspension behavior before gameplay progression.

## Preconditions
- Slice 1 accepted and committed.
- Exact Player public teleport behavior re-inspected.

## Exact file scope

### CREATE
- `scenes/levels/level_05/gameplay/Level05RecoveryAnchorZone.tscn`
- `scenes/levels/level_05/gameplay/Level05RecoveryVolume.tscn`
- `scripts/levels/level_05/level_05_recovery_anchor_zone.gd`
- `scripts/levels/level_05/level_05_recovery_volume.gd`
- `scripts/levels/level_05/level_05_recovery_controller.gd`

### MODIFY
- `scenes/levels/Level_05.tscn`

### READ ONLY
- `scripts/player/player_controller.gd`
- `scenes/core/Player.tscn`
- `scenes/levels/level_05/blocks/Level05Boundaries.tscn`

### CONDITIONAL MATCHING .gd.uid
- `scripts/levels/level_05/level_05_recovery_anchor_zone.gd.uid`
- `scripts/levels/level_05/level_05_recovery_volume.gd.uid`
- `scripts/levels/level_05/level_05_recovery_controller.gd.uid`
- Each sidecar is allowed only together with its exact sibling `.gd` in this slice CREATE or MODIFY list.
- A UID for any script absent from the active slice CREATE/MODIFY list is forbidden.
- Unrelated `.gd.uid`, scene UID, `.import`, `.godot/imported`, cache and generated-file churn are forbidden.

### FORBIDDEN
- Every repository path not listed under CREATE, MODIFY or READ ONLY for this slice is forbidden even for inspection; every path listed only under READ ONLY is forbidden from modification.
- Modification of `project.godot`, Level_01-Level_04 and Level_06+ runtime files, shared-system scripts/scenes, raw GLB, Blender files, final materials, textures, audio and unrelated documentation is forbidden unless the exact path is explicitly listed under MODIFY after a separately approved prerequisite decision.
- No wildcard file authority. A defect requiring another path is a hard stop: reopen the owning slice or issue an explicit defect-fix whitelist before editing.
- UID authority is defined only by the literal `CONDITIONAL MATCHING .gd.uid` subsection of this slice. Unrelated `.gd.uid`, scene UID, `.import`, `.godot/imported`, cache or generated-file churn is forbidden.

## Nodes, scenes and scripts
- RecoveryController under LevelRuntimeRoot.
- Seven exact Area3D volumes.
- Ten exact anchor zones.
- Explicit arrays/NodePaths, not scans.

## APIs and signals
- source-keyed `suspend(source)` / `resume(source)`.
- `recovery_anchor_reached(anchor_id)` and departed.
- `recovery_performed(anchor_id,volume_id,token)`.

## Implementation steps
- Create dumb typed volume/anchor scenes.
- Register exact IDs and paths.
- Implement one-token pending recovery and suspension.
- Use explicit progress predicate callback shell for RA gates; Slice 3 supplies real owner.
- Teleport to floor anchors and set Player.velocity zero.
- Validate safe-return cancellation and rearm.

## Automated and static checks
- Registry count/ID/path unit-like harness outside worktree.
- Transform/shape/size assertions.
- Duplicate/overlap token tests.
- Static search for nearest-node/per-frame scan/private Player fields.

## Manual runtime checks
- Trigger every RV.
- Overlap two RVs.
- Fall during simulated suspension and continue below Y=-12.
- Return safely before unlock.
- Remain in destination then exit and fall again.
- Validate all RA gates with temporary staged predicate.

## Acceptance criteria
- One recovery per fall.
- No progress mutation.
- No repeated teleport.
- No legal-route false recovery.
- All exact transforms pass.
- Safe public Player recovery proven or hard stop.
- G2 PASS.

## Stop conditions
- Any global hard stop occurs: P0 failure, shared-system blocker, scope deviation, unresolved active-PR/base conflict, required Producer-only decision, or mandatory evidence that cannot be verified.
- Safe teleport requires private Player state or an unapproved shared edit.
- Any recovery volume intersects legal route, shoulder, target, shard floor, viewing rim, gate or outlook.
- Token, pending suspension, safe-return cancellation or rearm behavior fails.
- When any stop condition triggers, stop immediately, do not commit an invalid slice and do not execute the next slice.

## Rollback plan
- Revert Slice 2 commit; primitive shell remains.

## Risks
- Shared Player lacks safe public teleport cleanup.
- Recovery volumes accidentally overlap legal route.
- Staged predicate must not become final disabled validation.

## Out of scope
- Puzzle progression, shards, reward, environment, finale and portal.

## Required handoff
- Branch, approved base SHA, slice-start SHA, final head SHA.
- Exact `git diff --name-only` and matching `.gd.uid` mapping.
- Commands/checks with factual outputs.
- Manual checks marked PASS / FAIL / NOT VERIFIED.
- Known risks, blockers, rollback point and recommendation to continue or stop.
- Commit SHA for this slice and PR link when created.


# Slice 3 - Progress Shell and Staged Startup Contract

## Goal
Create the macro-state owner and exact staged configuration mode so candidate arbitration and RA predicates can be tested before later dependencies exist.

## Preconditions
- Slice 2 accepted.
- No puzzle/shard/finale/portal dependencies exist yet.

## Exact file scope

### CREATE
- `scripts/levels/level_05/level_05_progress_controller.gd`

### MODIFY
- `scenes/levels/Level_05.tscn`
- `scripts/levels/level_05/level_05_recovery_controller.gd`

### READ ONLY
- None.

### CONDITIONAL MATCHING .gd.uid
- `scripts/levels/level_05/level_05_progress_controller.gd.uid`
- `scripts/levels/level_05/level_05_recovery_controller.gd.uid`
- Each sidecar is allowed only together with its exact sibling `.gd` in this slice CREATE or MODIFY list.
- A UID for any script absent from the active slice CREATE/MODIFY list is forbidden.
- Unrelated `.gd.uid`, scene UID, `.import`, `.godot/imported`, cache and generated-file churn are forbidden.

### FORBIDDEN
- Every repository path not listed under CREATE, MODIFY or READ ONLY for this slice is forbidden even for inspection; every path listed only under READ ONLY is forbidden from modification.
- Modification of `project.godot`, Level_01-Level_04 and Level_06+ runtime files, shared-system scripts/scenes, raw GLB, Blender files, final materials, textures, audio and unrelated documentation is forbidden unless the exact path is explicitly listed under MODIFY after a separately approved prerequisite decision.
- No wildcard file authority. A defect requiring another path is a hard stop: reopen the owning slice or issue an explicit defect-fix whitelist before editing.
- UID authority is defined only by the literal `CONDITIONAL MATCHING .gd.uid` subsection of this slice. Unrelated `.gd.uid`, scene UID, `.import`, `.godot/imported`, cache or generated-file churn is forbidden.

## Nodes, scenes and scripts
- Level05ProgressController in `STAGED_SLICE_3` configuration mode.
- Exact twelve-state enum and canonical ID maps.
- Recovery predicate integration.

## APIs and signals
- `report_puzzle_completed(puzzle_id: StringName) -> bool`.
- Read-only snapshot/state APIs.
- `can_activate_recovery_anchor(anchor_id) -> bool`.

## Implementation steps
- Attach Progress with explicit `validation_mode = STAGED_SLICE_3`.
- In staged mode require only RecoveryController and canonical constants; missing future dependencies are declared expected and cannot emit production-ready success.
- Implement strict forward macro-state transitions as inert facts for harness use.
- Implement RA predicate table.
- Define mandatory gate: Slice 10 switches to `PRODUCTION`, resolves every final dependency and performs full startup validation.

## Automated and static checks
- State/invalid-event harness outside worktree.
- RA predicate UTs.
- Static assertion that PRODUCTION validation exists and staged mode cannot be final DoD.

## Manual runtime checks
- Load scene without uncontrolled configuration errors.
- Exercise staged puzzle terminal facts and RA gates through debug snapshot only.
- Confirm no shard, finale or portal action occurs.

## Acceptance criteria
- Scene loads honestly in staged mode.
- Candidate/state arbitration testable.
- No final validation silently disabled.
- Mandatory production switch documented and enforced.
- G3 PASS.

## Stop conditions
- Any global hard stop occurs: P0 failure, shared-system blocker, scope deviation, unresolved active-PR/base conflict, required Producer-only decision, or mandatory evidence that cannot be verified.
- `STAGED_SLICE_3` hides a dependency that is already mandatory for honest Slice 3 operation.
- Canonical macro transitions or RA predicates are ambiguous, non-deterministic or cannot be tested honestly.
- When any stop condition triggers, stop immediately, do not commit an invalid slice and do not execute the next slice.

## Rollback plan
- Revert Slice 3 commit and restore temporary staged RA shell.

## Risks
- Staged mode accidentally shipped.
- Debug method mutates production state.
- Future dependency behavior invented.

## Out of scope
- Puzzle scenes, shards, environment, finale and portal.

## Required handoff
- Branch, approved base SHA, slice-start SHA, final head SHA.
- Exact `git diff --name-only` and matching `.gd.uid` mapping.
- Commands/checks with factual outputs.
- Manual checks marked PASS / FAIL / NOT VERIFIED.
- Known risks, blockers, rollback point and recommendation to continue or stop.
- Commit SHA for this slice and PR link when created.


# Slice 4 - Shared Presence Footprint and Dew Script

## Goal
Implement reusable grounded dwell sensing, Dew Script local FSM and the Shard_10 slot/reward path.

## Preconditions
- Slice 3 accepted.
- Shared SoulShard/reward APIs confirmed.

## Exact file scope

### CREATE
- `scenes/levels/level_05/gameplay/Level05PresenceFootprint.tscn`
- `scripts/levels/level_05/level_05_presence_footprint.gd`
- `scenes/levels/level_05/gameplay/DewScriptPuzzle.tscn`
- `scripts/levels/level_05/dew_script_controller.gd`
- `scenes/levels/level_05/gameplay/Level05ShardSlot.tscn`
- `scripts/levels/level_05/level_05_shard_slot.gd`
- `scenes/levels/level_05/vfx/Level05DewPresentation.tscn`

### MODIFY
- `scenes/levels/Level_05.tscn`
- `scripts/levels/level_05/level_05_progress_controller.gd`

### READ ONLY
- `scenes/core/SoulShard.tscn`
- `scripts/soul/soul_shard.gd`
- `scripts/core/shard_reward_sequence_controller.gd`
- `scenes/ui/ShardRewardOverlay.tscn`

### CONDITIONAL MATCHING .gd.uid
- `scripts/levels/level_05/level_05_presence_footprint.gd.uid`
- `scripts/levels/level_05/dew_script_controller.gd.uid`
- `scripts/levels/level_05/level_05_shard_slot.gd.uid`
- `scripts/levels/level_05/level_05_progress_controller.gd.uid`
- Each sidecar is allowed only together with its exact sibling `.gd` in this slice CREATE or MODIFY list.
- A UID for any script absent from the active slice CREATE/MODIFY list is forbidden.
- Unrelated `.gd.uid`, scene UID, `.import`, `.godot/imported`, cache and generated-file churn are forbidden.

### FORBIDDEN
- Every repository path not listed under CREATE, MODIFY or READ ONLY for this slice is forbidden even for inspection; every path listed only under READ ONLY is forbidden from modification.
- Modification of `project.godot`, Level_01-Level_04 and Level_06+ runtime files, shared-system scripts/scenes, raw GLB, Blender files, final materials, textures, audio and unrelated documentation is forbidden unless the exact path is explicitly listed under MODIFY after a separately approved prerequisite decision.
- No wildcard file authority. A defect requiring another path is a hard stop: reopen the owning slice or issue an explicit defect-fix whitelist before editing.
- UID authority is defined only by the literal `CONDITIONAL MATCHING .gd.uid` subsection of this slice. Unrelated `.gd.uid`, scene UID, `.import`, `.godot/imported`, cache or generated-file churn is forbidden.

## Nodes, scenes and scripts
- Three typed Dew footprints.
- Dew controller and placeholder traces.
- ShardSlot_10 with packed disabled SoulShard.
- Shared reward controller/overlay root wiring.

## APIs and signals
- Grounded dwell generation and current-overlap reevaluation.
- Dew logical + presentation terminal signals.
- ShardSlot hidden/reveal/available/collected signals.

## Implementation steps
- Implement exact Player binding and airborne exclusion.
- Implement all six local orders, persistence and hints.
- Implement first-terminal-wins trace fallback.
- Create generic slot with packed hidden child and effective availability verification.
- Configure Shard_10 exact ID/text.
- Register shared shard and wire reward lifecycle.
- Advance macro only on slot shard_collected.

## Automated and static checks
- All six Dew permutations.
- Duplicate and same-frame callbacks.
- Airborne/other-body rejection.
- Presentation-disabled fallback.
- Shard pre-overlap harness.
- Exact-copy static test.

## Manual runtime checks
- Complete Dew in multiple orders.
- Leave/re-enter partial progress.
- Stand inside future shard radius before reveal.
- Read exact reward and verify normal SoulOrb return.
- Disable placeholder presentation callback.

## Acceptance criteria
- One Dew completion/reveal/reward.
- No early interaction.
- No exit/re-entry required after availability.
- Exact Shard_10 text.
- REACTIONS state reached only after shared reward completes.
- G4 PASS.

## Stop conditions
- Any global hard stop occurs: P0 failure, shared-system blocker, scope deviation, unresolved active-PR/base conflict, required Producer-only decision, or mandatory evidence that cannot be verified.
- SoulShard stationary pre-overlap availability fails.
- Implementation requires private SoulShard access or an unapproved shared edit.
- Shared reward ordering, slot-level collection or exact Shard_10 progression is violated.
- When any stop condition triggers, stop immediately, do not commit an invalid slice and do not execute the next slice.

## Rollback plan
- Revert Slice 4 commit; staged progress/recovery remain.

## Risks
- SoulShard overlap refresh may be insufficient - P0 hard stop for narrow prerequisite.
- Slot may rely on private shared state.
- Reward lock and recovery suspension race.

## Out of scope
- Reactions, Mosaic, environment, finale, portal.

## Required handoff
- Branch, approved base SHA, slice-start SHA, final head SHA.
- Exact `git diff --name-only` and matching `.gd.uid` mapping.
- Commands/checks with factual outputs.
- Manual checks marked PASS / FAIL / NOT VERIFIED.
- Known risks, blockers, rollback point and recommendation to continue or stop.
- Commit SHA for this slice and PR link when created.


# Slice 5 - Little Reactions and Shard_11

## Goal
Implement the second any-order puzzle, autonomous placeholder presentations and the Shard_11 reward path.

## Preconditions
- Slice 4 accepted.
- REACTIONS_ACTIVE reachable after Shard_10 reward.

## Exact file scope

### CREATE
- `scenes/levels/level_05/gameplay/LittleReactionsPuzzle.tscn`
- `scripts/levels/level_05/little_reactions_controller.gd`
- `scenes/levels/level_05/vfx/Level05ReactionsPresentation.tscn`

### MODIFY
- `scenes/levels/Level_05.tscn`
- `scripts/levels/level_05/level_05_progress_controller.gd`

### READ ONLY
- `scenes/levels/level_05/gameplay/Level05PresenceFootprint.tscn`
- `scenes/levels/level_05/gameplay/Level05ShardSlot.tscn`
- `scripts/levels/level_05/level_05_shard_slot.gd`

### CONDITIONAL MATCHING .gd.uid
- `scripts/levels/level_05/little_reactions_controller.gd.uid`
- `scripts/levels/level_05/level_05_progress_controller.gd.uid`
- Each sidecar is allowed only together with its exact sibling `.gd` in this slice CREATE or MODIFY list.
- A UID for any script absent from the active slice CREATE/MODIFY list is forbidden.
- Unrelated `.gd.uid`, scene UID, `.import`, `.godot/imported`, cache and generated-file churn are forbidden.

### FORBIDDEN
- Every repository path not listed under CREATE, MODIFY or READ ONLY for this slice is forbidden even for inspection; every path listed only under READ ONLY is forbidden from modification.
- Modification of `project.godot`, Level_01-Level_04 and Level_06+ runtime files, shared-system scripts/scenes, raw GLB, Blender files, final materials, textures, audio and unrelated documentation is forbidden unless the exact path is explicitly listed under MODIFY after a separately approved prerequisite decision.
- No wildcard file authority. A defect requiring another path is a hard stop: reopen the owning slice or issue an explicit defect-fix whitelist before editing.
- UID authority is defined only by the literal `CONDITIONAL MATCHING .gd.uid` subsection of this slice. Unrelated `.gd.uid`, scene UID, `.import`, `.godot/imported`, cache or generated-file churn is forbidden.

## Nodes, scenes and scripts
- Three exact Reaction footprints.
- Autonomous primitive seed-turn, pollen and folding-glow placeholders.
- ShardSlot_11 instance.

## APIs and signals
- Unique ID acceptance.
- Overlapping presentation allowed.
- 1.30 s final-motion fallback.

## Implementation steps
- Configure exact IDs/positions/dwell.
- Implement any-order persistent set and hints.
- Implement no-random-wait presentation contract.
- Configure Shard_11 exact ID/text.
- Wire slot events to progress and recovery.

## Automated and static checks
- All six permutations.
- Concurrent visits/duplicate callbacks.
- Final motion race.
- Future-pocket early overlap.
- Exact-copy test.

## Manual runtime checks
- Complete every order.
- Walk through without waiting for random event.
- Disable final callback.
- Stand in future Shard_11 radius before reveal.
- Verify reward and state transition.

## Acceptance criteria
- One logical and presentation terminal.
- No timing challenge.
- Exact Shard_11 text.
- MOSAIC_ACTIVE only after reward completion.
- G5 PASS.

## Stop conditions
- Any global hard stop occurs: P0 failure, shared-system blocker, scope deviation, unresolved active-PR/base conflict, required Producer-only decision, or mandatory evidence that cannot be verified.
- Reaction any-order acceptance, persistence, autonomous/no-wait behavior or first-terminal contract fails.
- Shard_11 reveal/reward ordering cannot remain slot-owned and idempotent.
- When any stop condition triggers, stop immediately, do not commit an invalid slice and do not execute the next slice.

## Rollback plan
- Revert Slice 5 commit.

## Risks
- Presentation mistaken for required timing.
- Duplicate final callback.
- Future station accepted early.

## Out of scope
- Mosaic, environment, finale, portal.

## Required handoff
- Branch, approved base SHA, slice-start SHA, final head SHA.
- Exact `git diff --name-only` and matching `.gd.uid` mapping.
- Commands/checks with factual outputs.
- Manual checks marked PASS / FAIL / NOT VERIFIED.
- Known risks, blockers, rollback point and recommendation to continue or stop.
- Commit SHA for this slice and PR link when created.


# Slice 6 - Ordinary Mosaic and Shard_12

## Goal
Implement the third any-order grounded-pad puzzle, persistent placeholder layers and Shard_12 reward completion.

## Preconditions
- Slice 5 accepted.
- MOSAIC_ACTIVE reachable after Shard_11 reward.

## Exact file scope

### CREATE
- `scenes/levels/level_05/gameplay/OrdinaryMosaicPuzzle.tscn`
- `scripts/levels/level_05/ordinary_mosaic_controller.gd`
- `scenes/levels/level_05/vfx/Level05MosaicPresentation.tscn`

### MODIFY
- `scenes/levels/Level_05.tscn`
- `scripts/levels/level_05/level_05_progress_controller.gd`

### READ ONLY
- `scenes/levels/level_05/gameplay/Level05PresenceFootprint.tscn`
- `scenes/levels/level_05/gameplay/Level05ShardSlot.tscn`
- `scripts/levels/level_05/level_05_shard_slot.gd`

### CONDITIONAL MATCHING .gd.uid
- `scripts/levels/level_05/ordinary_mosaic_controller.gd.uid`
- `scripts/levels/level_05/level_05_progress_controller.gd.uid`
- Each sidecar is allowed only together with its exact sibling `.gd` in this slice CREATE or MODIFY list.
- A UID for any script absent from the active slice CREATE/MODIFY list is forbidden.
- Unrelated `.gd.uid`, scene UID, `.import`, `.godot/imported`, cache and generated-file churn are forbidden.

### FORBIDDEN
- Every repository path not listed under CREATE, MODIFY or READ ONLY for this slice is forbidden even for inspection; every path listed only under READ ONLY is forbidden from modification.
- Modification of `project.godot`, Level_01-Level_04 and Level_06+ runtime files, shared-system scripts/scenes, raw GLB, Blender files, final materials, textures, audio and unrelated documentation is forbidden unless the exact path is explicitly listed under MODIFY after a separately approved prerequisite decision.
- No wildcard file authority. A defect requiring another path is a hard stop: reopen the owning slice or issue an explicit defect-fix whitelist before editing.
- UID authority is defined only by the literal `CONDITIONAL MATCHING .gd.uid` subsection of this slice. Unrelated `.gd.uid`, scene UID, `.import`, `.godot/imported`, cache or generated-file churn is forbidden.

## Nodes, scenes and scripts
- Three exact Mosaic footprints.
- Three persistent primitive layers.
- ShardSlot_12 instance.

## APIs and signals
- No camera-facing API.
- 1.25 s final layer fallback.
- Exact shard lifecycle.

## Implementation steps
- Configure exact IDs/positions/dwell.
- Implement persistent any-order layers and hints.
- Reject any camera orientation dependency.
- Configure Shard_12 exact ID/text.
- On slot collection enter ALL_REWARDS_COMPLETE.

## Automated and static checks
- All six permutations.
- Camera-independence static scan.
- Presentation race.
- Exact-copy test.
- Duplicate shard events.

## Manual runtime checks
- Complete while camera faces arbitrary directions.
- Leave/re-enter partial state.
- Disable final layer callback.
- Pre-overlap Shard_12.
- Verify exact reward.

## Acceptance criteria
- One completion/reveal/reward.
- No camera alignment.
- Exact Shard_12 text.
- ALL_REWARDS_COMPLETE after shared reward only.
- G6 PASS.

## Stop conditions
- Any global hard stop occurs: P0 failure, shared-system blocker, scope deviation, unresolved active-PR/base conflict, required Producer-only decision, or mandatory evidence that cannot be verified.
- Mosaic any-order, camera-independence, persistence, fallback or Shard_12 contract fails.
- Any camera-facing/alignment dependency appears.
- When any stop condition triggers, stop immediately, do not commit an invalid slice and do not execute the next slice.

## Rollback plan
- Revert Slice 6 commit.

## Risks
- Accidental visual-recognition logic.
- Layer callback blocks reveal.
- Duplicate slot collection.

## Out of scope
- Environment, finale and portal.

## Required handoff
- Branch, approved base SHA, slice-start SHA, final head SHA.
- Exact `git diff --name-only` and matching `.gd.uid` mapping.
- Commands/checks with factual outputs.
- Manual checks marked PASS / FAIL / NOT VERIFIED.
- Known risks, blockers, rollback point and recommendation to continue or stop.
- Commit SHA for this slice and PR link when created.


# Slice 7 - Environment Progression, Guidance and Quiet Assembly

## Goal
Implement non-blocking E0-E4 presentation, next-pocket guidance and optional Quiet Assembly diagnostics.

## Preconditions
- Slice 6 accepted.
- All three reward paths proven.

## Exact file scope

### CREATE
- `scenes/levels/level_05/state/Level05EnvironmentState.tscn`
- `scripts/levels/level_05/level_05_environment_state_controller.gd`
- `scenes/levels/level_05/vfx/Level05Guidance.tscn`
- `scenes/levels/level_05/vfx/Level05QuietAssemblyVFX.tscn`

### MODIFY
- `scenes/levels/Level_05.tscn`
- `scripts/levels/level_05/level_05_progress_controller.gd`

### READ ONLY
- None.

### CONDITIONAL MATCHING .gd.uid
- `scripts/levels/level_05/level_05_environment_state_controller.gd.uid`
- `scripts/levels/level_05/level_05_progress_controller.gd.uid`
- Each sidecar is allowed only together with its exact sibling `.gd` in this slice CREATE or MODIFY list.
- A UID for any script absent from the active slice CREATE/MODIFY list is forbidden.
- Unrelated `.gd.uid`, scene UID, `.import`, `.godot/imported`, cache and generated-file churn are forbidden.

### FORBIDDEN
- Every repository path not listed under CREATE, MODIFY or READ ONLY for this slice is forbidden even for inspection; every path listed only under READ ONLY is forbidden from modification.
- Modification of `project.godot`, Level_01-Level_04 and Level_06+ runtime files, shared-system scripts/scenes, raw GLB, Blender files, final materials, textures, audio and unrelated documentation is forbidden unless the exact path is explicitly listed under MODIFY after a separately approved prerequisite decision.
- No wildcard file authority. A defect requiring another path is a hard stop: reopen the owning slice or issue an explicit defect-fix whitelist before editing.
- UID authority is defined only by the literal `CONDITIONAL MATCHING .gd.uid` subsection of this slice. Unrelated `.gd.uid`, scene UID, `.import`, `.godot/imported`, cache or generated-file churn is forbidden.

## Nodes, scenes and scripts
- EnvironmentStateRoot child controller, WorldEnvironment, LightingRoot.
- GuidanceRoot placeholders.
- QuietAssemblyVFX.

## APIs and signals
- `request_phase(phase) -> bool`.
- `start_quiet_assembly() -> int`.
- Independent domain tweens and diagnostic terminal.

## Implementation steps
- Deep-duplicate environment resources.
- Implement monotonic E0-E4.
- Use independent color/fog/light/guidance/assembly tweens.
- Start next active puzzle without waiting for E1/E2.
- Start E3, Quiet Assembly and finale eligibility in parallel.
- Keep PortalAccent absent.

## Automated and static checks
- Race E2 before E1 completion.
- Disable callbacks.
- Static scan for control locks and PortalAccent references.
- Resource-locality check.

## Manual runtime checks
- Move/solve remaining puzzle during transitions.
- Trigger rapid phase requests.
- Disable Quiet Assembly callback.
- Verify garden alive at E0 and completed motifs persist.

## Acceptance criteria
- No Player lock.
- No state regression.
- No callback softlock.
- Quiet Assembly never gates finale.
- G7 PASS.

## Stop conditions
- Any global hard stop occurs: P0 failure, shared-system blocker, scope deviation, unresolved active-PR/base conflict, required Producer-only decision, or mandatory evidence that cannot be verified.
- Environment presentation locks Player, mutates a shared resource, gates progression on a callback or obtains PortalAccent ownership.
- Phase/tween ownership cannot remain monotonic, local and independent.
- When any stop condition triggers, stop immediately, do not commit an invalid slice and do not execute the next slice.

## Rollback plan
- Revert Slice 7 commit; puzzles/rewards remain functional.

## Risks
- Tween cancellation across domains.
- Shared Environment resource mutation.
- Visual transition used as gameplay gate.

## Out of scope
- Main text and portal.

## Required handoff
- Branch, approved base SHA, slice-start SHA, final head SHA.
- Exact `git diff --name-only` and matching `.gd.uid` mapping.
- Commands/checks with factual outputs.
- Manual checks marked PASS / FAIL / NOT VERIFIED.
- Known risks, blockers, rollback point and recommendation to continue or stop.
- Commit SHA for this slice and PR link when created.


# Slice 8 - Finale, Exact Main Text and Fail-Closed Gate

## Goal
Implement current-overlap-aware FinalTextGate, exact main text and owned lock/recovery suspension.

## Preconditions
- Slice 7 accepted.
- ALL_REWARDS_COMPLETE reachable.

## Exact file scope

### CREATE
- `scenes/levels/level_05/gameplay/Level05RouteAuthority.tscn`
- `scripts/levels/level_05/level_05_finale_controller.gd`

### MODIFY
- `scenes/levels/Level_05.tscn`
- `scripts/levels/level_05/level_05_progress_controller.gd`

### READ ONLY
- `scenes/ui/LevelFinaleOverlay.tscn`
- `scripts/ui/level_finale_overlay.gd`
- `scripts/player/player_controller.gd`

### CONDITIONAL MATCHING .gd.uid
- `scripts/levels/level_05/level_05_finale_controller.gd.uid`
- `scripts/levels/level_05/level_05_progress_controller.gd.uid`
- Each sidecar is allowed only together with its exact sibling `.gd` in this slice CREATE or MODIFY list.
- A UID for any script absent from the active slice CREATE/MODIFY list is forbidden.
- Unrelated `.gd.uid`, scene UID, `.import`, `.godot/imported`, cache and generated-file churn are forbidden.

### FORBIDDEN
- Every repository path not listed under CREATE, MODIFY or READ ONLY for this slice is forbidden even for inspection; every path listed only under READ ONLY is forbidden from modification.
- Modification of `project.godot`, Level_01-Level_04 and Level_06+ runtime files, shared-system scripts/scenes, raw GLB, Blender files, final materials, textures, audio and unrelated documentation is forbidden unless the exact path is explicitly listed under MODIFY after a separately approved prerequisite decision.
- No wildcard file authority. A defect requiring another path is a hard stop: reopen the owning slice or issue an explicit defect-fix whitelist before editing.
- UID authority is defined only by the literal `CONDITIONAL MATCHING .gd.uid` subsection of this slice. Unrelated `.gd.uid`, scene UID, `.import`, `.godot/imported`, cache or generated-file churn is forbidden.

## Nodes, scenes and scripts
- FinalTextGate Area3D at exact P22.
- Level05FinaleController.
- Shared LevelFinaleOverlay.

## APIs and signals
- `arm_finale(text_id, exact_text) -> bool`.
- `main_text_started` and `main_text_closed`.
- Source-keyed recovery suspension.

## Implementation steps
- Validate exact overlay/API/signal at startup.
- Record exact Player occupancy before arming.
- Arm immediately after Shard_12 reward.
- Reevaluate overlap after one physics frame.
- Acquire/release only owned Player lock and recovery source.
- Advance only on actual `closed`.
- Fail closed on error.

## Automated and static checks
- Early-overlap gate harness.
- Missing overlay/API/false return tests.
- Duplicate close test.
- Exact-copy assertion.

## Manual runtime checks
- Stand in gate before final reward.
- Close normally and duplicate close.
- Simulate UI failure.
- Fall during main text and verify pending recovery after close.

## Acceptance criteria
- Exact text once.
- No re-entry required.
- Portal remains dormant on UI failure.
- Owned lock released safely.
- One MAIN_TEXT -> EXIT transition.
- G8 PASS.

## Stop conditions
- Any global hard stop occurs: P0 failure, shared-system blocker, scope deviation, unresolved active-PR/base conflict, required Producer-only decision, or mandatory evidence that cannot be verified.
- Actual LevelFinaleOverlay API does not accept the exact main text or the text cannot be presented readably.
- Any failure path opens/arms the portal, or owned control lock/recovery suspension is not released.
- Early gate overlap still requires exit/re-entry.
- When any stop condition triggers, stop immediately, do not commit an invalid slice and do not execute the next slice.

## Rollback plan
- Revert Slice 8 commit.

## Risks
- Overlay overlap with shard reward.
- Lock ownership conflict.
- Timer incorrectly marks text complete.

## Out of scope
- Portal activation and Level_06 transition.

## Required handoff
- Branch, approved base SHA, slice-start SHA, final head SHA.
- Exact `git diff --name-only` and matching `.gd.uid` mapping.
- Commands/checks with factual outputs.
- Manual checks marked PASS / FAIL / NOT VERIFIED.
- Known risks, blockers, rollback point and recommendation to continue or stop.
- Commit SHA for this slice and PR link when created.


# Slice 9 - Portal Adapter and Level_06 Handoff

## Goal
Configure the shared AUTO_ENTER portal and add a Level-local one-request adapter with optional primitive accent and diagnostics.

## Preconditions
- Slice 8 accepted.
- Actual shared LevelPortal API and signal reconfirmed.

## Exact file scope

### CREATE
- `scripts/levels/level_05/level_05_portal_adapter.gd`
- `scenes/levels/level_05/vfx/Level05PortalAccentVFX.tscn`

### MODIFY
- `scenes/levels/Level_05.tscn`
- `scripts/levels/level_05/level_05_progress_controller.gd`

### READ ONLY
- `scenes/core/LevelPortal.tscn`
- `scripts/core/level_portal.gd`
- `scenes/levels/Level_06.tscn`

### CONDITIONAL MATCHING .gd.uid
- `scripts/levels/level_05/level_05_portal_adapter.gd.uid`
- `scripts/levels/level_05/level_05_progress_controller.gd.uid`
- Each sidecar is allowed only together with its exact sibling `.gd` in this slice CREATE or MODIFY list.
- A UID for any script absent from the active slice CREATE/MODIFY list is forbidden.
- Unrelated `.gd.uid`, scene UID, `.import`, `.godot/imported`, cache and generated-file churn are forbidden.

### FORBIDDEN
- Every repository path not listed under CREATE, MODIFY or READ ONLY for this slice is forbidden even for inspection; every path listed only under READ ONLY is forbidden from modification.
- Modification of `project.godot`, Level_01-Level_04 and Level_06+ runtime files, shared-system scripts/scenes, raw GLB, Blender files, final materials, textures, audio and unrelated documentation is forbidden unless the exact path is explicitly listed under MODIFY after a separately approved prerequisite decision.
- No wildcard file authority. A defect requiring another path is a hard stop: reopen the owning slice or issue an explicit defect-fix whitelist before editing.
- UID authority is defined only by the literal `CONDITIONAL MATCHING .gd.uid` subsection of this slice. Unrelated `.gd.uid`, scene UID, `.import`, `.godot/imported`, cache or generated-file churn is forbidden.

## Nodes, scenes and scripts
- Shared LevelPortal under PortalFloorAnchor.
- Level05PortalAdapter.
- Optional local PortalAccentVFX.

## APIs and signals
- `request_activation() -> bool`.
- One shared `activate()` call.
- Semantic forwarding of actual `activation_completed`.

## Implementation steps
- Set exact Level_06 target, AUTO_ENTER and no confirmation.
- Keep portal identity-local under anchor.
- Call adapter only after actual main-text close.
- Start optional accent independently.
- Call shared activate once.
- Wait for actual activation_completed; timeout is blocker diagnostic only.
- Never call scene change locally.

## Automated and static checks
- Static scan for scene-loading APIs in adapter.
- Duplicate request test.
- Timeout test.
- Early-overlap capability test.

## Manual runtime checks
- Stand in portal volume before activation.
- Verify no early load and one transition after activation without re-entry.
- Rapid enter/exit.
- Disable local accent.
- Simulate missing completion signal.

## Acceptance criteria
- One activation request.
- No duplicate formation ownership.
- One Level_06 transition.
- Timeout never fabricates success.
- Shared portal solely owns loading.
- G9 PASS.

## Stop conditions
- Any global hard stop occurs: P0 failure, shared-system blocker, scope deviation, unresolved active-PR/base conflict, required Producer-only decision, or mandatory evidence that cannot be verified.
- Stationary portal early-overlap does not transition after activation.
- Adapter requires private portal access, local scene loading or duplicate shared formation ownership.
- Actual shared `activation_completed` signal is absent/incompatible.
- When any stop condition triggers, stop immediately, do not commit an invalid slice and do not execute the next slice.

## Rollback plan
- Revert Slice 9 commit; finale remains fail-closed with no exit.

## Risks
- Shared portal stationary overlap not supported - hard stop for prerequisite.
- Adapter duplicates shared visual sequence.
- Multiple transitions.

## Out of scope
- Level_06 content.

## Required handoff
- Branch, approved base SHA, slice-start SHA, final head SHA.
- Exact `git diff --name-only` and matching `.gd.uid` mapping.
- Commands/checks with factual outputs.
- Manual checks marked PASS / FAIL / NOT VERIFIED.
- Known risks, blockers, rollback point and recommendation to continue or stop.
- Commit SHA for this slice and PR link when created.


# Slice 10 - Production Wiring and Full Startup Validation

## Goal
Replace staged Slice 3 configuration with mandatory PRODUCTION validation and prove complete dependency wiring.

## Preconditions
- Slices 1-9 accepted.
- All final-path dependencies exist.

## Exact file scope

### CREATE
- None.

### MODIFY
- `scenes/levels/Level_05.tscn`
- `scripts/levels/level_05/level_05_progress_controller.gd`
- `scripts/levels/level_05/level_05_recovery_controller.gd`
- `scripts/levels/level_05/level_05_finale_controller.gd`
- `scripts/levels/level_05/level_05_portal_adapter.gd`

### READ ONLY
- None.

### CONDITIONAL MATCHING .gd.uid
- `scripts/levels/level_05/level_05_progress_controller.gd.uid`
- `scripts/levels/level_05/level_05_recovery_controller.gd.uid`
- `scripts/levels/level_05/level_05_finale_controller.gd.uid`
- `scripts/levels/level_05/level_05_portal_adapter.gd.uid`
- Each sidecar is allowed only together with its exact sibling `.gd` in this slice CREATE or MODIFY list.
- A UID for any script absent from the active slice CREATE/MODIFY list is forbidden.
- Unrelated `.gd.uid`, scene UID, `.import`, `.godot/imported`, cache and generated-file churn are forbidden.

### FORBIDDEN
- Every repository path not listed under CREATE, MODIFY or READ ONLY for this slice is forbidden even for inspection; every path listed only under READ ONLY is forbidden from modification.
- Modification of `project.godot`, Level_01-Level_04 and Level_06+ runtime files, shared-system scripts/scenes, raw GLB, Blender files, final materials, textures, audio and unrelated documentation is forbidden unless the exact path is explicitly listed under MODIFY after a separately approved prerequisite decision.
- No wildcard file authority. A defect requiring another path is a hard stop: reopen the owning slice or issue an explicit defect-fix whitelist before editing.
- UID authority is defined only by the literal `CONDITIONAL MATCHING .gd.uid` subsection of this slice. Unrelated `.gd.uid`, scene UID, `.import`, `.godot/imported`, cache or generated-file churn is forbidden.

## Nodes, scenes and scripts
- All LevelRuntimeRoot controllers and exact parent-scene overrides.
- PRODUCTION validation mode.

## APIs and signals
- Full dependency/type/ID/path/transform/API validation.
- Configuration errors fail closed.

## Implementation steps
- Switch Progress from STAGED_SLICE_3 to PRODUCTION.
- Resolve and validate every final NodePath.
- Connect all signals exactly once.
- Register all shards, volumes and anchors.
- Validate exact portal/UI/shared APIs.
- Remove/disable temporary debug displays.
- Ensure no staged missing-dependency bypass remains.

## Automated and static checks
- Full startup validation harness.
- Signal connection count checks.
- All exact NodePath checks.
- Legacy-node absence.
- Whitelist/UID/import checks.

## Manual runtime checks
- Cold-load scene repeatedly.
- Exercise clean initialization.
- Inspect configuration logs.
- Verify no uncontrolled errors/warnings and no gameplay side effects before input.

## Acceptance criteria
- PRODUCTION validation passes.
- No staged bypass remains.
- All dependencies exact.
- No duplicate signal connections.
- G10 PASS.

## Stop conditions
- Any global hard stop occurs: P0 failure, shared-system blocker, scope deviation, unresolved active-PR/base conflict, required Producer-only decision, or mandatory evidence that cannot be verified.
- PRODUCTION validation fails or a staged bypass remains.
- Any required NodePath, API, ID, CP registry, volume, anchor or signal registration is invalid.
- Duplicate signal connection or unresolved configuration warning remains.
- When any stop condition triggers, stop immediately, do not commit an invalid slice and do not execute the next slice.

## Rollback plan
- Revert Slice 10 commit to staged mode only for debugging; do not accept final.

## Risks
- Validation too permissive.
- Duplicate connections.
- Optional presentation confused with required dependency.

## Out of scope
- Final stabilization, broad tests and summary.

## Required handoff
- Branch, approved base SHA, slice-start SHA, final head SHA.
- Exact `git diff --name-only` and matching `.gd.uid` mapping.
- Commands/checks with factual outputs.
- Manual checks marked PASS / FAIL / NOT VERIFIED.
- Known risks, blockers, rollback point and recommendation to continue or stop.
- Commit SHA for this slice and PR link when created.


# Slice 11 - Stabilization, Acceptance and Final Handoff

## Goal
Execute the full acceptance/no-softlock matrix, correct only owned defects, clean repository state and produce final implementation summaries.

## Preconditions
- Slice 10 accepted in PRODUCTION mode.
- No unresolved P0 blocker.

## Exact file scope

### CREATE
- `docs/development/Level_05_Greybox_Implementation_Summary.md`

### MODIFY
- None.

### READ ONLY
- `AGENTS.md`
- `project.godot`
- `scenes/levels/Level_05.tscn`
- `scenes/levels/Level_06.tscn`
- `scenes/core/Player.tscn`
- `scripts/player/player_controller.gd`
- `scripts/player/camera_controller.gd`
- `scenes/core/SoulShard.tscn`
- `scripts/soul/soul_shard.gd`
- `scripts/core/shard_reward_sequence_controller.gd`
- `scenes/ui/ShardRewardOverlay.tscn`
- `scripts/ui/shard_reward_overlay.gd`
- `scenes/ui/LevelFinaleOverlay.tscn`
- `scripts/ui/level_finale_overlay.gd`
- `scenes/core/SoulOrb_Follow.tscn`
- `scripts/core/soul_orb_follow.gd`
- `scenes/core/LevelPortal.tscn`
- `scripts/core/level_portal.gd`
- `scenes/core/SceneTransition.tscn`
- `scripts/core/scene_transition.gd`
- `scenes/levels/level_05/blocks/Block_05_00_OuterThreshold.tscn`
- `scenes/levels/level_05/blocks/Block_05_01_DewScriptWalk.tscn`
- `scenes/levels/level_05/blocks/Block_05_02_Shard10RestLedge.tscn`
- `scenes/levels/level_05/blocks/Block_05_03_MossBend.tscn`
- `scenes/levels/level_05/blocks/Block_05_04_LittleReactions.tscn`
- `scenes/levels/level_05/blocks/Block_05_05_Shard11RestStone.tscn`
- `scenes/levels/level_05/blocks/Block_05_06_InnerSpiralDescent.tscn`
- `scenes/levels/level_05/blocks/Block_05_07_OrdinaryMosaic.tscn`
- `scenes/levels/level_05/blocks/Block_05_08_Shard12QuietAssembly.tscn`
- `scenes/levels/level_05/blocks/Block_05_09_PortalOutlook.tscn`
- `scenes/levels/level_05/blocks/Level05Boundaries.tscn`
- `scenes/levels/level_05/gameplay/Level05PresenceFootprint.tscn`
- `scenes/levels/level_05/gameplay/DewScriptPuzzle.tscn`
- `scenes/levels/level_05/gameplay/LittleReactionsPuzzle.tscn`
- `scenes/levels/level_05/gameplay/OrdinaryMosaicPuzzle.tscn`
- `scenes/levels/level_05/gameplay/Level05ShardSlot.tscn`
- `scenes/levels/level_05/gameplay/Level05RecoveryAnchorZone.tscn`
- `scenes/levels/level_05/gameplay/Level05RecoveryVolume.tscn`
- `scenes/levels/level_05/gameplay/Level05RouteAuthority.tscn`
- `scenes/levels/level_05/state/Level05EnvironmentState.tscn`
- `scenes/levels/level_05/vfx/Level05DewPresentation.tscn`
- `scenes/levels/level_05/vfx/Level05ReactionsPresentation.tscn`
- `scenes/levels/level_05/vfx/Level05MosaicPresentation.tscn`
- `scenes/levels/level_05/vfx/Level05Guidance.tscn`
- `scenes/levels/level_05/vfx/Level05QuietAssemblyVFX.tscn`
- `scenes/levels/level_05/vfx/Level05PortalAccentVFX.tscn`
- `scripts/levels/level_05/level_05_progress_controller.gd`
- `scripts/levels/level_05/level_05_presence_footprint.gd`
- `scripts/levels/level_05/dew_script_controller.gd`
- `scripts/levels/level_05/little_reactions_controller.gd`
- `scripts/levels/level_05/ordinary_mosaic_controller.gd`
- `scripts/levels/level_05/level_05_shard_slot.gd`
- `scripts/levels/level_05/level_05_environment_state_controller.gd`
- `scripts/levels/level_05/level_05_finale_controller.gd`
- `scripts/levels/level_05/level_05_portal_adapter.gd`
- `scripts/levels/level_05/level_05_recovery_controller.gd`
- `scripts/levels/level_05/level_05_recovery_anchor_zone.gd`
- `scripts/levels/level_05/level_05_recovery_volume.gd`
- `scripts/levels/level_05/level_05_progress_controller.gd.uid`
- `scripts/levels/level_05/level_05_presence_footprint.gd.uid`
- `scripts/levels/level_05/dew_script_controller.gd.uid`
- `scripts/levels/level_05/little_reactions_controller.gd.uid`
- `scripts/levels/level_05/ordinary_mosaic_controller.gd.uid`
- `scripts/levels/level_05/level_05_shard_slot.gd.uid`
- `scripts/levels/level_05/level_05_environment_state_controller.gd.uid`
- `scripts/levels/level_05/level_05_finale_controller.gd.uid`
- `scripts/levels/level_05/level_05_portal_adapter.gd.uid`
- `scripts/levels/level_05/level_05_recovery_controller.gd.uid`
- `scripts/levels/level_05/level_05_recovery_anchor_zone.gd.uid`
- `scripts/levels/level_05/level_05_recovery_volume.gd.uid`

### CONDITIONAL MATCHING .gd.uid
- None. This slice grants no `.gd.uid` write authority.
- Unrelated `.gd.uid`, scene UID, `.import`, `.godot/imported`, cache and generated-file churn are forbidden.

### FORBIDDEN
- Every repository path not listed under CREATE, MODIFY or READ ONLY for this slice is forbidden even for inspection; every path listed only under READ ONLY is forbidden from modification.
- Modification of `project.godot`, Level_01-Level_04 and Level_06+ runtime files, shared-system scripts/scenes, raw GLB, Blender files, final materials, textures, audio and unrelated documentation is forbidden unless the exact path is explicitly listed under MODIFY after a separately approved prerequisite decision.
- No wildcard file authority. A defect requiring another path is a hard stop: reopen the owning slice or issue an explicit defect-fix whitelist before editing.
- UID authority is defined only by the literal `CONDITIONAL MATCHING .gd.uid` subsection of this slice. Unrelated `.gd.uid`, scene UID, `.import`, `.godot/imported`, cache or generated-file churn is forbidden.

## Nodes, scenes and scripts
- All prior Level_05 nodes/scripts.
- Mandatory user artifact outside worktree: `Level_05_Greybox_Implementation_Summary.docx`.

## APIs and signals
- No new gameplay API and no runtime write authority. A discovered defect must be handled by the owning prior slice under a separate explicit literal whitelist.

## Implementation steps
- Run UT/ST/P0/P1 matrices.
- Run full route, all local permutations, duplicate/race/reload/recovery/portal cases.
- Measure duration and camera/accessibility/performance.
- A runtime defect stops Slice 11 immediately.
- Identify the owning prior slice.
- Create a separate explicit defect-fix whitelist containing only literal paths.
- Execute the owning slice tests and rollback contract.
- Create a separate corrective commit.
- Re-run every subsequent gate and then restart Slice 11 from the beginning.
- Remove temporary harnesses and verbose debug UI.
- Create factual Markdown summary.
- Generate content-equivalent DOCX outside worktree.

## Automated and static checks
- Godot parse/resource loads.
- All unit-like/static harnesses outside worktree.
- `git diff --check`.
- Changed-file whitelist proves that Slice 11 changed only `docs/development/Level_05_Greybox_Implementation_Summary.md`; the required DOCX is outside the worktree.
- Matching `.gd.uid` mapping.
- No temporary harness in repo.

## Manual runtime checks
- Complete full P0/P1 matrix.
- Record video/evidence for normal route, recovery during reward/text and stationary portal early overlap.
- Run exact-copy checks.
- Run duration and the complete 16:9 CP0-CP9 QA registry, including exact Player positions, viewing targets and required/prohibited readings.

## Acceptance criteria
- All mandatory P0 PASS.
- Mandatory manual evidence cannot remain NOT VERIFIED.
- No softlock.
- No new errors/warnings.
- 5:30-7:00 first play and 3:15-4:15 repeat target or documented Producer decision.
- Both summaries exist and are content-equivalent.
- No runtime defect was edited inside Slice 11; any corrective work has its own prior-slice whitelist, commit and repeated downstream gates.
- Final DoD verdict factual.

## Stop conditions
- Any global hard stop occurs: P0 failure, shared-system blocker, scope deviation, unresolved active-PR/base conflict, required Producer-only decision, or mandatory evidence that cannot be verified.
- Any mandatory P0 or mandatory manual result is FAIL or NOT VERIFIED.
- Any parser/runtime warning, out-of-scope diff, temporary harness, summary mismatch or unresolved blocker remains.
- Markdown and DOCX implementation summaries are not content-equivalent or omit a mandatory field.
- When any stop condition triggers, stop immediately, do not commit an invalid slice and do not execute the next slice.

## Rollback plan
- Slice 11 itself has no runtime corrective commit. Revert the summary commit for documentation defects; runtime corrections follow the separately reopened owning-slice rollback plan.

## Risks
- Late broad refactor.
- Mandatory evidence unavailable.
- Performance issue caused by final-art assumptions rather than greybox.

## Out of scope
- Final art, sound, save system, Level_06 implementation.

## Required handoff
- Branch, approved base SHA, slice-start SHA, final head SHA.
- Exact `git diff --name-only` and matching `.gd.uid` mapping.
- Commands/checks with factual outputs.
- Manual checks marked PASS / FAIL / NOT VERIFIED.
- Known risks, blockers, rollback point and recommendation to continue or stop.
- Commit SHA for this slice and PR link when created.


# 17. Unit-like and static checks

## 17.1 Unit-like matrix

| ID | Check | Expected evidence |
|---|---|---|
| UT-01 | Initial state | L05_INIT/E0; three slots packed hidden; portal inactive. |
| UT-02 | Deferred init | Successful validation advances once to DEW_ACTIVE. |
| UT-03 | Future target rejection | Reaction/Mosaic events before active state rejected. |
| UT-04 | All Dew permutations | All six orders; 3 unique IDs; one logical and one presentation terminal. |
| UT-05 | Dew duplicates | No overcount. |
| UT-06 | Shard_10 gating | Only slot shard_available enters availability. |
| UT-07 | Shard_10 progression | Only slot shard_collected commits reward. |
| UT-08 | E1 failure | REACTIONS_ACTIVE not delayed. |
| UT-09 | All Reaction permutations | All six orders produce one terminal. |
| UT-10 | Reaction race | Real callback vs 1.30 s fallback emits once. |
| UT-11 | Shard_11 progression | Wrong/duplicate IDs ignored. |
| UT-12 | E2 failure | MOSAIC_ACTIVE continues. |
| UT-13 | All Mosaic permutations | All six orders produce one terminal. |
| UT-14 | Mosaic race | Real callback vs fallback emits once. |
| UT-15 | Shard_12 progression | Actual collected enters ALL_REWARDS_COMPLETE. |
| UT-16 | Quiet Assembly failure | Cannot block gate/text. |
| UT-17 | Main text fail-closed | Missing overlay/API/false return keeps portal dormant. |
| UT-18 | Duplicate main close | One EXIT and one portal request. |
| UT-19 | Portal timeout | No success, repeat activate or local scene load. |
| UT-20 | Slot pre-overlap | Each shard interactable once without exit/re-entry. |
| UT-21 | SoulOrb continuity | Exactly one visible SoulOrb_Follow; normal return x3. |
| UT-22 | Recovery registry | Seven volumes and ten anchors; unique exact bindings. |
| UT-23 | One token per fall | Duplicate/overlap entries do not duplicate. |
| UT-24 | Pending across source exit | Pending survives continued fall. |
| UT-25 | Safe return proof | Valid RA outside RV clears pending. |
| UT-26 | Pending applies once | One recovery after last suspension. |
| UT-27 | Rearm | No new token until destination exit and physics frame. |
| UT-28 | Unknown/stale rejection | No mutation. |
| UT-29 | RA transforms | FloorAnchor identity-local; globals approximate exact values. |
| UT-30 | RA gates | Ignored before predicate; accepted after. |
| UT-31 | Presence Player binding | All nine exact paths resolve. |
| UT-32 | Non-Player rejection | Other CharacterBody cannot satisfy dwell. |
| UT-33 | Airborne dwell | Airborne contributes zero. |
| UT-34 | Current-overlap activation | Footprint/RA/gate works without re-entry. |
| UT-35 | Reload | Fresh L05_INIT/E0; no stale state. |

## 17.2 Static matrix

| ID | Check | Expected evidence |
|---|---|---|
| ST-01 | Changed-file whitelist | Only approved slice paths. |
| ST-02 | Project settings | No project.godot change. |
| ST-03 | Shared systems | No shared runtime edits without approved prerequisite. |
| ST-04 | Legacy removal | No LevelManager or PoemRewardUI in Level_05 runtime. |
| ST-05 | Global scans | No broad node-name/group search. |
| ST-06 | Scene loading | Only shared LevelPortal owns load. |
| ST-07 | Private Player fields | No access. |
| ST-08 | Camera puzzle | No facing/alignment query. |
| ST-09 | Random/timer failure | No random sequence or fail timer. |
| ST-10 | Control locks | Environment scripts never disable controls. |
| ST-11 | Exact copy | Canonical texts exact. |
| ST-12 | Coordinates and Camera QA | P00-P24 exact; all CP0-CP9 Player floor positions and ViewingTarget vectors exact; canonical IDs unchanged; required/prohibited readings recorded. |
| ST-13 | Recovery transforms | Seven exact volumes and legal-space non-overlap. |
| ST-14 | Portal config | Level_06, AUTO_ENTER, no confirmation. |
| ST-15 | Staged mode | Final scene uses PRODUCTION validation. |
| ST-16 | UID sidecars | Only matching approved Level_05 `.gd.uid`. |
| ST-17 | Import churn | No unrelated `.import` or `.godot/imported` changes. |
| ST-18 | Harness cleanup | No temporary harness in worktree. |
| ST-19 | Diff hygiene | `git diff --check` passes. |

# 18. P0/P1 acceptance matrix

| ID | Scenario | Expected evidence |
|---|---|---|
| P0-01 | Clean full route | Dew -> Shard_10 -> Reactions -> Shard_11 -> Mosaic -> Shard_12 -> text -> Level_06; exact copy; one transition. |
| P0-02 | Dew permutations | All six orders; one reveal; persistence. |
| P0-03 | Reaction permutations | All six; no random waiting; one reveal. |
| P0-04 | Mosaic permutations | All six; no camera-facing check; one reveal. |
| P0-05 | Future pocket early | No early ID; activation reevaluates without re-entry. |
| P0-06 | Presence binding | Exact Player, non-Player and airborne rejection. |
| P0-07 | Dew presentation disabled | Fallback reveals once. |
| P0-08 | Reaction presentation disabled | 1.30 s fallback reveals once. |
| P0-09 | Mosaic presentation disabled | Fallback reveals once. |
| P0-10 | Shard pre-overlap x3 | No early interaction; available once without re-entry. |
| P0-11 | Duplicate shard lifecycle | One macro advance per ID. |
| P0-12 | Normal reward return x3 | One SoulOrb and return pulse per reward. |
| P0-13 | E1 callback missing | REACTIONS_ACTIVE begins. |
| P0-14 | E2 callback missing | MOSAIC_ACTIVE begins. |
| P0-15 | E3/Quiet Assembly missing | FinalTextGate remains eligible. |
| P0-16 | FinalTextGate early overlap | Exact text starts after eligibility without re-entry. |
| P0-17 | Main text UI failure | Portal dormant; owned lock/suspension released. |
| P0-18 | Duplicate text close | One EXIT and activation request. |
| P0-19 | Portal anchor audit | P24/portal coincident; internal transforms untouched. |
| P0-20 | Portal stationary overlap | No early load; one Level_06 transition after activation without re-entry. |
| P0-21 | Portal timeout | Blocker diagnostic only. |
| P0-22 | Portal rapid enter/exit | At most one transition. |
| P0-23 | All recovery volumes | Exact transforms/shapes/sizes/registration. |
| P0-24 | Overlapping recovery volumes | One token/recovery. |
| P0-25 | Duplicate body_entered | No second token. |
| P0-26 | Fall during reward | Pending survives and recovers once after unlock. |
| P0-27 | Fall during main text | Same; overlay not interrupted. |
| P0-28 | Safe return before unlock | Pending clears; no teleport. |
| P0-29 | Destination rearm | No repeat until exit; next fall works. |
| P0-30 | Unknown/mismatched/stale | No mutation. |
| P0-31 | RA0-RA9 before gate | No latest-anchor change. |
| P0-32 | RA0-RA9 after gate | Each updates once. |
| P0-33 | RA current-overlap | Accepted after gate without re-entry. |
| P0-34 | RV_OUTLOOK_S before RA8 | Uses latest valid; never forward. |
| P0-35 | RV_OUTLOOK_S after RA8 | May use RA8 exactly once. |
| P0-36 | Spawn | Repeated loads grounded, stable, non-overlapping. |
| P0-37 | Stale movement | No residual velocity/transient public movement. |
| P0-38 | Seed Basin coverage | Exact r<=7.5 coverage; no overshoot. |
| P0-39 | Full reload | Every state reloads clean. |
| P0-40 | Exact copy | Three rewards and main text character-for-character. |
| P0-41 | Continuous grounded traversal | No mandatory jump, gap, precision edge, timing gate, waiting challenge or audio. |
| P0-42 | Backtracking through completed pockets | No reset, duplicate reward or route closure; fixed macro order remains completable. |
| P1-01 | Blind first play | 5:30-7:00; no UI arrows. |
| P1-02 | Repeat play | 3:15-4:15. |
| P1-03 | Camera QA | At every canonical CP0-CP9, place Player at the exact floor position, aim at the exact ViewingTarget, and record all approved required readings plus absence of every prohibited obstruction; no additional CP at P07. |
| P1-04 | Accessibility | Muted/reduced-color play fully readable. |
| P1-05 | Performance | Stable 60 FPS target; no per-frame scans. |

# 19. No-softlock matrix

| Risk | Prevention | Required evidence |
|---|---|---|
| Player inside footprint before activation | one-frame current-overlap reevaluation | P0-05 |
| Airborne or wrong body accepted | exact Player + grounded dwell | P0-06 |
| Presentation callback missing | bounded first-terminal fallback | P0-07/08/09 |
| Shard hidden but interactable | packed disabled state and effective verification | P0-10 |
| Shard reveal while Player already inside | overlap-refresh P0 gate | P0-10 |
| Duplicate reward advances twice | slot-level collected latch | P0-11 |
| Environment callback blocks next puzzle | semantic state independent of VFX | P0-13/14/15 |
| Quiet Assembly becomes fourth gate | finale armed independently | P0-15 |
| Main text UI failure opens portal | fail-closed | P0-17 |
| Early gate requires re-entry | occupancy reevaluation | P0-16 |
| Portal early overlap misses transition | shared stationary-overlap gate | P0-20 |
| Portal timeout fakes success | diagnostic only | P0-21 |
| Overlapping RV creates multiple teleports | one token/latch | P0-24 |
| Fall during overlay lost after leaving RV | pending retained across source exit | P0-26/27 |
| Safe return still teleports | proven legal RA cancellation | P0-28 |
| Recovery loops at destination | destination exit rearm | P0-29 |
| Future RA skips progress | state-gated anchors | P0-31/32/33 |
| Outlook recovery teleports forward | RA8 valid-only rule | P0-34/35 |
| Reload restores partial stale state | fresh-scene MVP policy | P0-39 |
| Mandatory jump/precision route | continuous grounded route contract | P0-41 |
| Backtracking resets local progress | persistent unique-ID sets | P0-42 |
| Camera QA drift implies a false route, hidden target or premature portal reading | exact CP0-CP9 Player/ViewingTarget registry plus required/prohibited reading evidence | P1-03 |

# 20. Producer gates

| Gate | After slice | Internal PASS condition |
|---|---|---|
| G0 | Slice 0 | facts refreshed, exact base selected, zero diff, WAITING FOR APPLY |
| G1 | Slice 1 | walkable exact shell and branch/base evidence |
| G2 | Slice 2 | recovery geometry/token/public Player safety proven |
| G3 | Slice 3 | honest STAGED_SLICE_3 mode and RA predicates |
| G4 | Slice 4 | Dew + Shard_10 + reward path |
| G5 | Slice 5 | Reactions + Shard_11 path |
| G6 | Slice 6 | Mosaic + Shard_12 path |
| G7 | Slice 7 | non-blocking E0-E4 and Quiet Assembly |
| G8 | Slice 8 | fail-closed exact main text |
| G9 | Slice 9 | shared portal ownership and one Level_06 transition |
| G10 | Slice 10 | full PRODUCTION startup validation |
| G11 | Slice 11 | all mandatory evidence PASS and summaries delivered |

# 21. Definition of Done

Level_05 greybox is done only when:

- all approved source contracts remain intact;
- exact P00-P24, every CP0-CP9 Player floor position and ViewingTarget, puzzle/shard/gate/portal anchors, RVs and RAs are implemented;
- all CP0-CP9 required readings and prohibited-obstruction checks pass at 16:9; no extra CP is added at P07;
- complete route is grounded, broad, safe and has no mandatory jump, gap, precision placement, timing challenge or audio dependency;
- exact fixed macro order and local any-order subtargets work;
- Shard_10, Shard_11, Shard_12 and main text are exact;
- progression advances only on slot-level `shard_collected`;
- all environment phases are non-blocking;
- Quiet Assembly is non-interactive;
- main text is fail-closed;
- shared LevelPortal solely owns scene loading and performs one Level_06 transition;
- stationary portal early-overlap evidence passes;
- recovery registry, token/latch, suspension, RA gates and rearm pass;
- PRODUCTION startup validation passes;
- UT-01 through UT-35, ST-01 through ST-19 and all mandatory P0 tests pass;
- mandatory manual evidence is never reported PASS when NOT VERIFIED;
- no forbidden/shared/project/other-level/art files changed;
- only matching approved `.gd.uid` sidecars exist;
- no temporary harness remains in the worktree;
- one commit exists per Slice 1-11;
- `docs/development/Level_05_Greybox_Implementation_Summary.md` exists;
- content-equivalent `Level_05_Greybox_Implementation_Summary.docx` exists outside the runtime worktree unless explicitly authorized for PR;
- final summary includes exact base SHA, active PR/base decision, shared prerequisites and exact approved head SHAs, branch/PR, per-slice commits, exact created/modified files including canonical `scenes/levels/level_05/blocks/` paths, UID mapping, complete UT/ST/P0/P1 results, proven Player spawn and RA root-Y values, exact CP0-CP9 Player/ViewingTarget vectors and required/prohibited reading evidence, recovery evidence, full normal-route execution trace, exact-copy evidence, finale fail-closed evidence, portal ownership and early-overlap evidence, one-transition evidence, warnings, limitations, blockers/NOT VERIFIED items, remaining art-stage work and final DoD verdict.

# 22. Final Codex implementation prompt requirements

The implementation prompt must instruct Codex to:

- use this reference as the controlling implementation contract;
- perform Slice 0 only, make zero changes and wait for explicit APPLY;
- after APPLY create `feature/implement-level-05-greybox` from the exact approved base;
- implement exactly one slice at a time;
- validate and commit every slice;
- continue automatically to the next slice only after internal PASS;
- stop under the documented hard-stop conditions;
- obey each literal slice whitelist and matching `.gd.uid` rule;
- use temporary harnesses only outside worktree or remove them before commit;
- never modify shared systems without separately approved prerequisite;
- never claim mandatory NOT VERIFIED evidence as PASS;
- create both final implementation summaries and ensure content equivalence.

# 23. Final implementation handoff requirements

Both summaries must explicitly contain:

- exact implementation base SHA;
- active PR/base decision;
- every shared prerequisite, status and exact approved head SHA;
- branch and PR;
- one commit entry per Slice 1-11;
- exact files created, including canonical `scenes/levels/level_05/blocks/` paths and the sole `scenes/levels/level_05/blocks/Level05Boundaries.tscn`;
- exact files modified;
- exact matching `.gd.uid` mapping;
- complete UT/ST/P0/P1 results with PASS / FAIL / NOT VERIFIED;
- proven Player spawn and RA root-Y values;
- exact CP0-CP9 Player floor positions, ViewingTarget vectors, required readings, prohibited-obstruction results and 16:9 evidence;
- exact recovery registry evidence;
- full route and puzzle sequence execution trace;
- exact-copy evidence for Shard_10, Shard_11, Shard_12 and LEVEL_05_MAIN_TEXT;
- finale fail-closed evidence;
- portal ownership evidence;
- stationary portal early-overlap evidence;
- one-transition evidence;
- known warnings;
- known limitations;
- blockers and NOT VERIFIED items;
- remaining art-stage work, including all deferred Art Bible families and post-greybox production;
- final Definition of Done verdict.

# 24. Suggested branch and PR naming

- Branch: `feature/implement-level-05-greybox`
- PR title: `Implement Level 05 greybox - То, что остается`
- Base: exact Slice 0 approved base SHA.
- A stacked prerequisite is permitted only when Slice 0 identifies it, Producer approves it and the exact prerequisite head SHA is recorded.
