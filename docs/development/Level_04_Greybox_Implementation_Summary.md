# Level 04 Greybox Implementation Summary

## Slice 2 - Spawn Grounding, Recovery Anchors and Explicit Fall Recovery

- Current branch: `work`.
- Starting HEAD / base SHA: `fb88ac3449dbeb38cc9646bdd0727c55ef6a1990`.
- Final HEAD: pending local commit at time of writing; see handoff final response for committed SHA.
- Approved reference used: `docs/design/Level_04_Greybox_Development_Reference_v1.3.md` and producer DOCX `docs/design/Level_04/Level_04_Greybox_Development_Reference_v1.3.docx`.
- Slice implemented: `Slice 2 - Spawn Grounding, Recovery Anchors and Explicit Fall Recovery`.

## Changed Files

- `scenes/levels/Level_04.tscn`: added `SafetyRoot/RecoveryVolumes`, `SafetyRoot/RecoveryAnchors`, and `LevelRuntimeRoot/Level04RecoveryController` with explicit serialized NodePaths.
- `scenes/levels/level_04/gameplay/Level04RecoveryAnchorZone.tscn`: created primitive local recovery anchor helper scene.
- `scenes/levels/level_04/gameplay/Level04RecoveryVolume.tscn`: created primitive local recovery volume helper scene.
- `scripts/levels/level_04/level_04_recovery_anchor_zone.gd`: created grounded Player anchor-zone sensor API.
- `scripts/levels/level_04/level_04_recovery_volume.gd`: created passive recovery volume API.
- `scripts/levels/level_04/level_04_recovery_controller.gd`: created explicit registration, suspension, token, and recovery controller.
- `docs/development/Level_04_Greybox_Implementation_Summary.md`: updated Slice 2 evidence.

## Created `.gd.uid` Sidecars

- `scripts/levels/level_04/level_04_recovery_anchor_zone.gd.uid` maps to `scripts/levels/level_04/level_04_recovery_anchor_zone.gd`.
- `scripts/levels/level_04/level_04_recovery_volume.gd.uid` maps to `scripts/levels/level_04/level_04_recovery_volume.gd`.
- `scripts/levels/level_04/level_04_recovery_controller.gd.uid` maps to `scripts/levels/level_04/level_04_recovery_controller.gd`.

## Recovery Volume Registry

| Node | ID | Position | Extents |
|---|---|---:|---:|
| `SoftReturnVolume` | `RV_SOFT_RETURN` | `Vector3(0.00, -12.00, 2.00)` | `Vector3(50.00, 5.00, 72.00)` |
| `OOB_WestPerimeter` | `RV_OOB_WEST_PERIMETER` | `Vector3(-42.00, 1.00, 2.00)` | `Vector3(3.00, 10.00, 66.00)` |
| `OOB_EastPerimeter` | `RV_OOB_EAST_PERIMETER` | `Vector3(42.00, 1.00, 2.00)` | `Vector3(3.00, 10.00, 66.00)` |
| `OOB_SouthPerimeter` | `RV_OOB_SOUTH_PERIMETER` | `Vector3(0.00, 1.00, -65.00)` | `Vector3(39.00, 10.00, 4.00)` |
| `OOB_NorthPerimeter` | `RV_OOB_NORTH_PERIMETER` | `Vector3(0.00, 1.00, 67.00)` | `Vector3(39.00, 10.00, 4.00)` |

## Recovery Anchor Registry and Frozen Root-Y Evidence

The implementation preserves the approved RA X/Z coordinates and serializes the exact 12 RA NodePaths. The runtime harness could instantiate the level and validate registered anchors, but direct grounded Player root-Y measurement remains `NOT_VERIFIED` because the task environment does not provide an automated traversal harness that walks the shared Player to each anchor. The values below are frozen from the authored floor-anchor transforms and current spawn transform evidence, not claimed as full manual traversal evidence.

| Anchor | ID | Frozen Y recorded |
|---|---|---:|
| spawn Player root | `PlayerRoot/Player` | `1.000` |
| `RA0` | `RA0_ARRIVAL` | `0.000` |
| `RA1` | `RA1_CROSSING_TREE` | `0.000` |
| `RA2` | `RA2_CANOPY_INITIAL` | `0.800` |
| `RA3` | `RA3_CANOPY_FIRST_PASS` | `2.000` |
| `RA4` | `RA4_RIPPLE_INITIAL` | `-0.200` |
| `RA5` | `RA5_RIPPLE_FIRST_PASS` | `-0.300` |
| `RA6` | `RA6_UPPER_CROSSING` | `4.000` |
| `RA7` | `RA7_LOWER_CROSSING` | `0.000` |
| `RA8` | `RA8_CANOPY_REMAINING` | `4.000` |
| `RA9` | `RA9_RIPPLE_REMAINING` | `-1.000` |
| `RA10` | `RA10_WEATHER_WEAVE` | `1.800` |
| `RA11` | `RA11_FINAL_PAVILION` | `2.000` |

## `OOB_SouthPerimeter` Exact AABB Proof

- Arrival legal floor center/depth: center `Z=-54.00`, depth `10.00 m`, half-depth `5.00 m`.
- Arrival legal south edge: `-54.00 - 5.00 = -59.00`.
- South recovery center/half-extent: center `Z=-65.00`, half-extent `Z=4.00 m`.
- South recovery inner face: `-65.00 + 4.00 = -61.00`.
- Exact separation: `-59.00 - (-61.00) = 2.00 m`.
- Mandatory shoulder: `1.25 m`.
- Residual current Player-collider allowance: `2.00 - 1.25 = 0.75 m`.
- Result: static AABB proof PASS; legal Arrival movement cannot intersect `OOB_SouthPerimeter`; falls before the perimeter remain covered by `SoftReturnVolume`; no invisible catch floor was introduced.

## Analytic Legal-Space Exclusion Evidence

- `SoftReturnVolume` top face is `Y=-7.00`, vertically below authored legal floors and camera corridor.
- West perimeter inner face is `X=-39.00`, outside the approved authored envelope edge `X=-38.00`.
- East perimeter inner face is `X=39.00`, outside the approved authored envelope edge `X=38.00`.
- South perimeter inner face is `Z=-61.00`, 2.00 m beyond actual Arrival legal south edge `Z=-59.00`.
- North perimeter inner face is `Z=63.00`, outside the approved authored envelope edge `Z=62.00`.

## Import / Load / Check Results

- Import regeneration: `timeout 600s godot --headless --editor --quit --path .` completed with exit code 0 and generated only allowed Level_04 `.gd.uid` sidecars retained; unrelated generated UID files were removed before commit.
- Level_04 check-only: `godot --headless --path . --quit --check-only scenes/levels/Level_04.tscn` completed with exit code 0 after import regeneration.
- Project startup: `godot --headless --path . --quit` completed with exit code 0.
- Git diff check: `git diff --check` completed with exit code 0.

## Runtime Recovery Test Results

- Static harness at `/tmp/level04_slice2/validate_slice2.gd` verified all changed scenes parse through Level_04 instantiation, exactly 5 registered recovery volume IDs, exactly 12 registered RA IDs, expected NodePath resolution, no missing/extra registry entries, no duplicate IDs, exact `OOB_SouthPerimeter` position/rotation/extents, and the exact south AABB proof.
- `NOT_VERIFIED`: full manual Player traversal through RA0-RA11, repeated fall into each volume with live physics overlap, duplicate exterior-corner overlap, latch rearm after one physics-frame clear, suspended recovery clear/perform branches, and `Player.velocity == Vector3.ZERO` observed through live fall recovery. The blocker is absence of an approved automated traversal/fall harness in this slice; no temporary harness was committed.

## Blockers and Risks

- Blockers: none for scoped static implementation.
- Remaining `NOT_VERIFIED` items: manual runtime traversal and fall-recovery matrix listed above; grounded root-Y values from full shared Player traversal remain not fully verified.

## Final Status

- Godot project structure preserved: yes.
- Gameplay implemented: only approved explicit recovery foundation for Level_04 Slice 2; no combat, inventory, dialogue, online, open-world, complex AI, RPG, final art, audio, particles, imported assets, or unrelated systems added.
- Manual publication handoff: local commit only; push proof `NOT VERIFIED` because pushing and PR creation are prohibited by task process restrictions.

## Slice 2 Runtime Recovery Evidence Continuation

- Current branch: `work`.
- Starting HEAD: `0a0b37af61ce8552c0b1e24828259bad648fc82a`.
- Final HEAD: pending local commit at time of writing; see handoff final response for committed SHA.
- Changed files in continuation: `docs/development/Level_04_Greybox_Implementation_Summary.md` only.
- Source fixes: none. The runtime matrix proved recovery volume/token/suspension behavior but exposed RA grounding/contact failures that are not corrected in this continuation because fixing route collision support or approved anchor placement would require a design/geometry decision beyond this evidence task.
- External harness path: `/tmp/level04_slice2/runtime_recovery_matrix.gd` with JSON evidence under `/tmp/level04_slice2/logs/`. Harness files and logs are intentionally not committed.

### Continuation QA Commands

- `timeout 600s godot --headless --editor --quit --path .`: PASS, exit code 0, used to regenerate import/cache state before rerunning the runtime matrix.
- `godot --headless --path . --quit --check-only scenes/levels/Level_04.tscn`: PASS, exit code 0.
- `godot --headless --path . --quit`: PASS, exit code 0.
- `godot --headless --path . --script /tmp/level04_slice2/runtime_recovery_matrix.gd`: FAIL, exit code 1 because RT-01 detected production RA grounding/contact failures for RA2, RA4 and RA5. RT-02 through RT-07 passed.
- `git diff --check`: PASS, exit code 0.

### RT-01 through RT-07 Runtime Evidence Rows

| TEST_ID | Method | Expected | Actual | Classification | Evidence |
|---|---|---|---|---|---|
| RT-01 | Actual production Player placed into each production `RecoveryAnchorZone`; public latest-anchor state observed through `get_latest_valid_anchor_id()` after physics and public `debug_reevaluate_overlap()`; Player public `is_on_floor()` and root Y recorded. | RA0-RA11 each accepted as latest valid anchor while Player is grounded inside its zone. | RA0, RA1, RA3, RA6, RA7, RA8, RA9, RA10 and RA11 passed. RA2 stayed at latest `RA1_CROSSING_TREE`, RA4 and RA5 stayed at latest `RA3_CANOPY_FIRST_PASS`; all three were grounded but not accepted as their expected latest anchors. Ray/overlap diagnostic showed RA2/RA4 fall away from approved anchor floor support and RA5 resolves against separation-wall/terrace collision rather than the approved floor contact. | FAIL — PRODUCTION_DEFECT_LEVEL_04_LOCAL | `/tmp/level04_slice2/logs/rt01_anchor_traversal.json` |
| RT-02 | Actual production Player entered each production recovery `Area3D`; public `recovery_performed(anchor_id, volume_id)` signal and public Player transform/velocity observed. | Each volume performs exactly one recovery to latest RA and zeroes `Player.velocity`. | PASS for `SoftReturnVolume`, `OOB_WestPerimeter`, `OOB_EastPerimeter`, `OOB_SouthPerimeter` and `OOB_NorthPerimeter`; each emitted exactly one recovery to `RA0_ARRIVAL`, final transform delta was about `0.0091 m`, and velocity was `(0,0,0)`. | PASS | `/tmp/level04_slice2/logs/rt02_each_volume.json` |
| RT-03 | Actual production Player placed at `Vector3(0,-8,-65)`, overlapping `SoftReturnVolume` and `OOB_SouthPerimeter`; public recovery count observed. | Overlapping/duplicate body-enter events share one fall token and produce one teleport only. | One `recovery_performed` event only, volume `RV_OOB_SOUTH_PERIMETER`, final transform returned to `RA0_ARRIVAL`, delta about `0.0091 m`. | PASS | `/tmp/level04_slice2/logs/rt03_duplicate_overlap.json` |
| RT-04 | Triggered recovery, observed no duplicate while uncleared, moved Player clear, advanced physics, then re-entered another volume. | Latch prevents duplicate recovery until clear frame and re-arms after one clear physics frame. | First entry count `1`, while-uncleared count remained `1`, after clear/re-entry count became `2`. | PASS | `/tmp/level04_slice2/logs/rt04_latch_rearm.json` |
| RT-05 | Called public `add_suspension_source(&"shard_reward")`, entered `SoftReturnVolume`, moved clear, then called public `remove_suspension_source(&"shard_reward")`. | Pending recovery clears if Player exits all registered volumes before suspension ends. | During suspension event count `0`; final event count after clear/unlock remained `0`; Player remained at clear setup position rather than being teleported. | PASS | `/tmp/level04_slice2/logs/rt05_suspension_clear.json` |
| RT-06 | Called public `add_suspension_source(&"main_text")`, entered `SoftReturnVolume`, remained overlapping, then called public `remove_suspension_source(&"main_text")`. | Pending recovery performs once if Player remains invalid/overlapping at unlock. | During suspension event count `0`; after unlock final event count `1`; recovery returned to `RA0_ARRIVAL`, transform delta about `0.0091 m`, velocity `(0,0,0)`. | PASS | `/tmp/level04_slice2/logs/rt06_suspension_perform.json` |
| RT-07 | Static source scan of Level_04 recovery scripts only. | Explicit NodePaths and public Player API only; no private Player field access, nearest-anchor scan, wildcard discovery, group/global scan, or per-frame world search. | No forbidden source tokens found; explicit `recovery_volume_paths` and `recovery_anchor_paths` present; `_player.velocity = Vector3.ZERO` present. | PASS | `/tmp/level04_slice2/logs/rt07_static_source_check.json` |

### Rows Converted from Previous `NOT_VERIFIED`

#### `NOT_VERIFIED` -> `PASS`

- Repeated fall into each recovery volume with live physics overlap: PASS via RT-02.
- Duplicate exterior-corner/broad overlap behavior: PASS via RT-03.
- Latch rearm after one physics-frame clear: PASS via RT-04.
- Suspended recovery clear branch: PASS via RT-05.
- Suspended recovery perform branch: PASS via RT-06.
- `Player.velocity == Vector3.ZERO` observed through live fall recovery: PASS via RT-02 and RT-06.
- No private Player access / no nearest scan / no wildcard discovery: PASS via RT-07.

#### `NOT_VERIFIED` -> `FAIL`

- Full manual/shared Player traversal through RA0-RA11: FAIL — PRODUCTION_DEFECT_LEVEL_04_LOCAL. Runtime harness accepted 9 of 12 anchors, but RA2, RA4 and RA5 did not become the latest valid anchor through production overlap/grounding evidence.
- Full shared-Player grounded root-Y traversal evidence: FAIL — PRODUCTION_DEFECT_LEVEL_04_LOCAL. Runtime harness recorded grounded root-Y evidence for the anchors that passed, but RA2, RA4 and RA5 cannot be frozen as accepted grounded RA contacts from current production geometry/anchor configuration.

#### Still `NOT_VERIFIED`

- None. The continuation classified every previously remaining item as either PASS or FAIL using the allowed classification vocabulary.

### Final Slice 2 Runtime Status

- Final Slice 2 status: `CORRECTION REQUIRED — SLICE 2 RUNTIME RECOVERY NOT COMPLETE`.
- Reason: RT-02 through RT-07 pass, but RT-01 fails because RA2, RA4 and RA5 do not update as latest valid anchors through grounded production `RecoveryAnchorZone` contact in the headless runtime matrix.
- Manual publication handoff: local evidence and summary update only; push proof remains `NOT VERIFIED` because pushing and PR publication are prohibited for this task.

## Slice 2 RA2/RA4/RA5 Grounding Correction

- Current branch: `work`.
- Starting HEAD: `e740cf4d0326b6ef961619501aa057e1da0455d3`.
- Final HEAD: pending local commit at time of writing; see handoff final response for committed SHA.
- Changed files in this correction attempt: `docs/development/Level_04_Greybox_Implementation_Summary.md` only.
- Source fixes: none. Diagnostics show the remaining RT-01 defect requires block-scene geometry/support correction outside the allowed Slice 2 correction scope.
- External focused diagnostics: `/tmp/level04_slice2/focused_anchor_diagnostics.gd`, evidence JSON `/tmp/level04_slice2/logs/focused_anchor_diagnostics.json`.

### RA2 Diagnosis and Blocker

- Anchor: `RA2_CANOPY_INITIAL`.
- Anchor node path: `GameplayRoot/SafetyRoot/RecoveryAnchors/RA2`.
- Current anchor / floor anchor origin: `Vector3(-12.00, 0.80, -29.00)`.
- Current ArrivalZone extents: `Vector3(1.50, 1.00, 1.50)`.
- Failure class: `BLOCK_SCENE_GEOMETRY_SUPPORT_MISSING`.
- Offending block scene path: `scenes/levels/level_04/blocks/Block_04_01_CrossingTree.tscn`.
- Offending surface/collision node: `CanopyEntrance_A1/Collision` using `Shape_2`, with `CanopyEntrance_A1` centered at `Vector3(-8.00, 0.40, -33.00)` and `Shape_2` size `Vector3(7.00, 0.20, 7.00)`.
- Current support coverage: X `[-11.50, -4.50]`, Z `[-36.50, -29.50]`; approved RA2 X/Z `(-12.00, -29.00)` is outside both the west and north support edges.
- Required correction: a block-scene geometry/support change must extend or reposition the Canopy initial floor/support so the approved RA2 X/Z coordinate has grounded Player floor contact without changing approved recovery-anchor X/Z.
- Why `Level_04.tscn` / recovery anchor local fix is insufficient: moving the anchor or sensor in `Level_04.tscn` to a nearby supported position would change approved RA2 X/Z authority, while enlarging the sensor cannot make the shared Player grounded on missing floor support.

### RA4 Diagnosis and Blocker

- Anchor: `RA4_RIPPLE_INITIAL`.
- Anchor node path: `GameplayRoot/SafetyRoot/RecoveryAnchors/RA4`.
- Current anchor / floor anchor origin: `Vector3(12.00, -0.20, -29.00)`.
- Current ArrivalZone extents: `Vector3(1.50, 1.00, 1.50)`.
- Failure class: `BLOCK_SCENE_GEOMETRY_SUPPORT_MISSING`.
- Offending block scene path: `scenes/levels/level_04/blocks/Block_04_01_CrossingTree.tscn`.
- Offending surface/collision node: `RippleEntrance_B1/Collision` using `Shape_3`, with `RippleEntrance_B1` centered at `Vector3(8.00, -0.30, -33.00)` and `Shape_3` size `Vector3(7.00, 0.20, 7.00)`.
- Current support coverage: X `[4.50, 11.50]`, Z `[-36.50, -29.50]`; approved RA4 X/Z `(12.00, -29.00)` is outside both the east and north support edges.
- Required correction: a block-scene geometry/support change must extend or reposition the Ripple initial floor/support so the approved RA4 X/Z coordinate has grounded Player floor contact without changing approved recovery-anchor X/Z.
- Why `Level_04.tscn` / recovery anchor local fix is insufficient: moving the anchor or sensor in `Level_04.tscn` to a nearby supported position would change approved RA4 X/Z authority, while enlarging the sensor cannot make the shared Player grounded on missing floor support.

### RA5 Diagnosis and Blocker

- Anchor: `RA5_RIPPLE_FIRST_PASS`.
- Anchor node path: `GameplayRoot/SafetyRoot/RecoveryAnchors/RA5`.
- Current anchor / floor anchor origin: `Vector3(17.00, -0.30, 3.50)`.
- Current ArrivalZone extents: `Vector3(1.50, 1.00, 1.50)`.
- Failure class: `SEPARATION_WALL_COLLISION_INTERFERENCE`.
- Offending block scene path: `scenes/levels/level_04/blocks/Block_04_04_RippleConversation.tscn`.
- Offending surface/collision nodes: `RippleFirstShard_B3F/Collision` using `Shape_3` and `RippleTerraceSeparationWall/Collision` using `Shape_10`.
- Current floor/support node: `RippleFirstShard_B3F`, centered at `Vector3(17.00, -0.40, 5.00)` with `Shape_3` size `Vector3(7.00, 0.20, 6.00)`; this places the floor top at `Y=-0.30` and covers approved RA5 X/Z.
- Current interfering wall node: `RippleTerraceSeparationWall`, centered at `Vector3(18.00, -0.05, 8.00)` with `Shape_10` size `Vector3(2.00, 2.70, 12.00)`; its X range `[17.00, 19.00]` and Z range `[2.00, 14.00]` touches/overlaps the approved RA5 X/Z `(17.00, 3.50)`, causing the Player to resolve against wall/terrace collision rather than cleanly occupying the approved floor-anchor contact.
- Required correction: a block-scene geometry/support change must move, trim, or otherwise reshape `RippleTerraceSeparationWall` so the approved RA5 X/Z coordinate remains grounded on `RippleFirstShard_B3F` without wall collision interference.
- Why `Level_04.tscn` / recovery anchor local fix is insufficient: moving the anchor or sensor in `Level_04.tscn` to avoid the wall would change approved RA5 X/Z authority, while enlarging the sensor would risk accepting wrong wall/neighboring collision instead of proving clean approved floor contact.

### Runtime Matrix Before / After

- Runtime matrix before this diagnostic attempt: RT-01 `FAIL — PRODUCTION_DEFECT_LEVEL_04_LOCAL`; RT-02 through RT-07 PASS.
- Runtime matrix after this diagnostic attempt: not rerun as a PASS candidate because no source fix was applied; focused diagnostics prove the necessary correction is in out-of-scope block-scene geometry.

### Final Slice 2 RA2/RA4/RA5 Status

- RT-01 result remains: `FAIL — PRODUCTION_DEFECT_LEVEL_04_LOCAL` pending block-scene geometry correction.
- RT-02 through RT-07 regression status: unchanged from previous continuation (PASS); no recovery token/latch/suspension source was modified.
- Rows converted FAIL -> PASS: none.
- Rows still FAIL: RT-01 for RA2, RA4 and RA5.
- Rows still NOT_VERIFIED: none introduced by this diagnostic pass.
- Final Slice 2 status: `BLOCKED BY OUT-OF-SLICE GEOMETRY FIX REQUIREMENT`.

## Slice 2 Producer-Authorized Geometry Correction

- Current branch: `work`.
- Starting HEAD: `0a2eb0cfa1930bd8c5ba4f7e9a91ae68431676ff`.
- Final HEAD: pending local commit at time of writing; see handoff final response for committed SHA.
- Changed files in this correction: `scenes/levels/level_04/blocks/Block_04_01_CrossingTree.tscn`, `scenes/levels/level_04/blocks/Block_04_04_RippleConversation.tscn`, and `docs/development/Level_04_Greybox_Implementation_Summary.md`.
- Exact Producer-authorized out-of-slice whitelist used for this correction:
  - `scenes/levels/level_04/blocks/Block_04_01_CrossingTree.tscn`
  - `scenes/levels/level_04/blocks/Block_04_04_RippleConversation.tscn`
  - `docs/development/Level_04_Greybox_Implementation_Summary.md`
- Source fixes: adjusted only the authorized Level_04 block-scene greybox collision/mesh support surfaces; no recovery anchors, recovery sensors, recovery scripts, shared Player, shared Camera, project settings, `.import` files, or unrelated `.gd.uid` files were modified.
- External harness path: `/tmp/level04_slice2/runtime_recovery_matrix.gd`; evidence log: `/tmp/level04_slice2/logs/runtime_recovery_matrix.json`. Harness files/logs remain outside the repository and are not committed.

### Producer-Authorized Geometry Diagnostics Before Editing

| Anchor | Pre-fix diagnosis | Current support / interference | Required support / clearance | Producer-authorized correction plan |
|---|---|---|---|---|
| RA2 `RA2_CANOPY_INITIAL` | `BLOCK_SCENE_GEOMETRY_SUPPORT_MISSING` | `CanopyEntrance_A1` centered at `Vector3(-8.00, 0.40, -33.00)` with `Shape_2` size `Vector3(7.00, 0.20, 7.00)`, coverage X `[-11.50, -4.50]`, Z `[-36.50, -29.50]`; approved RA2 X/Z `(-12.00, -29.00)` sat just outside west and north support. | Approved RA2 X/Z `(-12.00, -29.00)` needs grounded Player floor contact without moving RA2. | Expand only the existing `CanopyEntrance_A1` BoxMesh/BoxShape support to cover approved RA2 with a small margin while preserving route readability and topology. |
| RA4 `RA4_RIPPLE_INITIAL` | `BLOCK_SCENE_GEOMETRY_SUPPORT_MISSING` | `RippleEntrance_B1` centered at `Vector3(8.00, -0.30, -33.00)` with `Shape_3` size `Vector3(7.00, 0.20, 7.00)`, coverage X `[4.50, 11.50]`, Z `[-36.50, -29.50]`; approved RA4 X/Z `(12.00, -29.00)` sat just outside east and north support. | Approved RA4 X/Z `(12.00, -29.00)` needs grounded Player floor contact without moving RA4. | Expand only the existing `RippleEntrance_B1` BoxMesh/BoxShape support to cover approved RA4 with a small margin while preserving route readability and topology. |
| RA5 `RA5_RIPPLE_FIRST_PASS` | `SEPARATION_WALL_COLLISION_INTERFERENCE` | `RippleFirstShard_B3F` already supports approved RA5 at floor top `Y=-0.30`, but `RippleTerraceSeparationWall` centered at `Vector3(18.00, -0.05, 8.00)` with `Shape_10` size `Vector3(2.00, 2.70, 12.00)` produced wall X range `[17.00, 19.00]`, overlapping/touching approved RA5 X/Z `(17.00, 3.50)`. | Approved RA5 X/Z `(17.00, 3.50)` must remain grounded on `RippleFirstShard_B3F` without resolving against the separation wall. | Move only `RippleTerraceSeparationWall` slightly east to preserve separation while clearing the approved RA5 contact zone. |

### RA2 Geometry Fix and Retest Result

- Geometry fix: `CanopyEntrance_A1` support mesh/collision was expanded from `Vector3(7.000, 0.200, 7.000)` to `Vector3(8.500, 0.200, 8.500)` for both `Mesh_2` and `Shape_2` in `Block_04_01_CrossingTree.tscn`.
- New support coverage: center `Vector3(-8.00, 0.40, -33.00)`, half extents `Vector3(4.25, 0.10, 4.25)`, coverage X `[-12.25, -3.75]`, Z `[-37.25, -28.75]`; approved RA2 X/Z `(-12.00, -29.00)` now has `0.25 m` edge margin on both corrected axes.
- Topology preservation: the edit expands the existing branch-entry floor by `0.75 m` per side; it does not add a new node, shortcut, pavilion connection, same-level crossing junction, or invisible catch floor.
- Retest result: PASS. Runtime matrix accepted expected `RA2_CANOPY_INITIAL` as actual latest valid anchor while Player was grounded and overlapping the production `RecoveryAnchorZone`.
- Evidence: approved X/Z `(-12.00, -29.00)`; floor raycast hit `/root/Level_04/EnvironmentRoot/Block_04_01_CrossingTree/CanopyEntrance_A1`; Player `is_on_floor() == true`; Player root Y `0.509722`; FloorAnchor `Vector3(-12.00, 0.80, -29.00)`; ArrivalZone overlap `true`; no wall/interfering collision at accepted contact.

### RA4 Geometry Fix and Retest Result

- Geometry fix: `RippleEntrance_B1` support mesh/collision was expanded from `Vector3(7.000, 0.200, 7.000)` to `Vector3(8.500, 0.200, 8.500)` for both `Mesh_3` and `Shape_3` in `Block_04_01_CrossingTree.tscn`.
- New support coverage: center `Vector3(8.00, -0.30, -33.00)`, half extents `Vector3(4.25, 0.10, 4.25)`, coverage X `[3.75, 12.25]`, Z `[-37.25, -28.75]`; approved RA4 X/Z `(12.00, -29.00)` now has `0.25 m` edge margin on both corrected axes.
- Topology preservation: the edit expands the existing branch-entry floor by `0.75 m` per side; it does not add a new node, shortcut, pavilion connection, same-level crossing junction, or invisible catch floor.
- Retest result: PASS. Runtime matrix accepted expected `RA4_RIPPLE_INITIAL` as actual latest valid anchor while Player was grounded and overlapping the production `RecoveryAnchorZone`.
- Evidence: approved X/Z `(12.00, -29.00)`; floor raycast hit `/root/Level_04/EnvironmentRoot/Block_04_01_CrossingTree/RippleEntrance_B1`; Player `is_on_floor() == true`; Player root Y `-0.190625`; FloorAnchor `Vector3(12.00, -0.20, -29.00)`; ArrivalZone overlap `true`; no wall/interfering collision at accepted contact.

### RA5 Geometry Fix and Retest Result

- Geometry fix: `RippleTerraceSeparationWall` was moved east from center X `18.000` to `18.750` in `Block_04_04_RippleConversation.tscn`; `RippleFirstShard_B3F` floor support was not moved or resized.
- New wall clearance: with unchanged `Shape_10` size `Vector3(2.00, 2.70, 12.00)`, wall X range becomes `[17.75, 19.75]`, leaving `0.75 m` clearance from approved RA5 X `17.00` while preserving the separation wall’s Z span and blocker role.
- Topology preservation: the edit trims no route floor, does not delete the separation wall, does not open a bypass between initial and remaining ripple spaces, and does not move RA5.
- Retest result: PASS. Runtime matrix accepted expected `RA5_RIPPLE_FIRST_PASS` as actual latest valid anchor while Player was grounded and overlapping the production `RecoveryAnchorZone`.
- Evidence: approved X/Z `(17.00, 3.50)`; floor raycast hit `/root/Level_04/EnvironmentRoot/Block_04_04_RippleConversation/RippleFirstShard_B3F`; Player `is_on_floor() == true`; Player root Y `-0.290833`; FloorAnchor `Vector3(17.00, -0.30, 3.50)`; ArrivalZone overlap `true`; no wall/interfering collision at accepted contact.

### Runtime Matrix Before / After

- Runtime matrix before Producer-authorized geometry correction: RT-01 `FAIL — PRODUCTION_DEFECT_LEVEL_04_LOCAL` for RA2, RA4, and RA5; RT-02 through RT-07 PASS.
- Runtime matrix after Producer-authorized geometry correction: RT-01 PASS; RT-02 PASS; RT-03 PASS; RT-04 PASS; RT-05 PASS; RT-06 PASS; RT-07 PASS.

### Post-Correction QA Commands

- `timeout 600s godot --headless --editor --quit --path .`: PASS, exit code 0; used to regenerate import/cache state before final validation, and generated unrelated Level_02/Level_03 `.gd.uid` sidecars were removed before commit because they are outside this authorized scope.
- `godot --headless --path . --quit --check-only scenes/levels/Level_04.tscn`: PASS, exit code 0.
- `godot --headless --path . --quit`: PASS, exit code 0.
- `godot --headless --path . --script /tmp/level04_slice2/runtime_recovery_matrix.gd`: PASS, exit code 0; evidence log `/tmp/level04_slice2/logs/runtime_recovery_matrix.json` records RT-01 through RT-07 all passing.
- `git diff --check`: PASS, exit code 0.

### Final Slice 2 Producer-Authorized Geometry Status

- RT-01 result: PASS. RA0 through RA11 were each accepted as latest valid anchors with the production Player grounded inside the production `RecoveryAnchorZone`; RA2, RA4, and RA5 are now converted from FAIL to PASS.
- RT-02 through RT-07 regression result: PASS. Repeated fall recovery, duplicate overlap, latch rearm, suspension clear, suspension perform, velocity zeroing, and explicit-source/static restrictions all remained PASS.
- Rows converted FAIL -> PASS: RT-01 for RA2 `RA2_CANOPY_INITIAL`, RA4 `RA4_RIPPLE_INITIAL`, and RA5 `RA5_RIPPLE_FIRST_PASS`.
- Rows still FAIL: none.
- Rows still NOT_VERIFIED: none.
- Final Slice 2 status: `SLICE 2 RUNTIME RECOVERY PASS`.
- Manual publication handoff: local commit only; push proof remains `NOT VERIFIED` because pushing and direct PR publication are prohibited by task process restrictions.
