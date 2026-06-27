# Level_04 Greybox Development Reference

**Project:** Fifteen Shards of Light  
**Level:** Level_04 - «Ты сама»  
**Reference version:** 1.3  
**Mode:** Documentation only - no runtime files, branches, commits or pull requests are authorized by this task  
**Repository:** `MindDevastation/fifteen-shards-of-light`  
**Target repository Markdown:** `docs/design/Level_04_Greybox_Development_Reference_v1.3.md`  
**Target Producer DOCX:** `Level_04_Greybox_Development_Reference_v1.3.docx`  
**Target runtime scene:** `res://scenes/levels/Level_04.tscn`  
**Portal target:** `res://scenes/levels/Level_05.tscn`  
**Engine baseline:** Godot 4.6 / Forward Plus / Jolt Physics / GDScript  
**Prepared:** 27 June 2026

> **Documentation verdict:** READY FOR PRODUCER REVIEW AS A GREYBOX IMPLEMENTATION REFERENCE. This document consolidates the five approved Level_04 source packages into one Codex-ready, slice-by-slice implementation contract. It does not authorize runtime implementation. Slice 0 must be executed later as a fresh inspection-only preflight and must end with `WAITING FOR APPLY`.

## Version 1.3 Change Log

| ID | Version 1.3 result |
|---|---|
| V13-01 | Updated the canonical repository reference path to `docs/design/Level_04_Greybox_Development_Reference_v1.3.md` and the Producer artifact name to `Level_04_Greybox_Development_Reference_v1.3.docx` across the header, proposed tree, source traceability, final Codex prompt requirements and all other filename references. |
| V13-02 | Resolved the Slice 11 file-scope contradiction by granting one exact `CREATE - USER ARTIFACT OUTSIDE REPOSITORY WORKTREE` authority for mandatory `Level_04_Greybox_Implementation_Summary.docx`; the artifact remains uncommitted unless a separate explicit PR-scope decision authorizes it and grants no authority over any other file. |
| V13-03 | Repaired the P0/P1 matrix to one three-column schema by merging the test action and expected result for P0-41 through P0-47 into complete `Expected evidence` cells without removing any recovery evidence or outcome. |
| V13-04 | Added P0-53 for repeated backtracking across Crossing Tree, Braided Crossing and both route contexts before and after the first reward, with matching softlock, Slice 11 and Definition of Done coverage. |
| V13-05 | Added P0-54 for completing both approved sequences through continuous grounded traversal only, proving no mandatory jump, gap, precision edge placement, timing gate, waiting challenge or audio dependency, with matching softlock, Slice 11 and Definition of Done coverage. |
| V13-06 | Expanded the mandatory Markdown/DOCX implementation-summary schema to enumerate base/PR/prerequisite evidence, one commit per Slice 1-11, created/modified files, matching `.gd.uid` mapping, complete test results, grounded root-Y evidence, recovery/AABB evidence, both sequence traces, exact-copy/finale/portal evidence, warnings, limitations, blockers, remaining Art Bible production work and final Definition of Done verdict. |
| V13-07 | Preserved the canonical `OOB_SouthPerimeter` contract exactly: position `Vector3(0.00, 1.00, -65.00)`, rotation `Vector3(0,0,0)`, extents `Vector3(39.00, 10.00, 4.00)`, inner face `Z=-61.00`, Arrival legal south edge `Z=-59.00`, separation `2.00 m`, mandatory shoulder `1.25 m` and residual Player-collider allowance `0.75 m`; all obsolete normative center values were removed. |
| V13-08 | Re-generated Markdown and DOCX from one Version 1.3 semantic source and verified equivalent version, paths, values, APIs, slice scopes, UID rules, tests, matrices, Definition of Done and final-summary requirements. |
| V13-09 | Completed full-page DOCX render QA with focused inspection of all tables, the repaired P0/P1 matrix, recovery registry, AABB proof, Slice 1-11 file scopes, long IDs/NodePaths, headers, footers, page numbers, page breaks, clipping, overlap, table overflow and orphaned headings. |

## Version 1.2 Change Log

| ID | Version 1.2 result |
|---|---|
| V12-01 | Corrected `OOB_SouthPerimeter` to `Vector3(0.00, 1.00, -65.00)` with unchanged `Vector3(39.00, 10.00, 4.00)` half-extents, producing the exact legal-facing inner face `Z=-61.00`. |
| V12-02 | Replaced planning-envelope-only reasoning with an actual Arrival-floor-bound AABB proof: Arrival center `Z=-54.00`, depth `10.00 m`, nominal legal south edge `Z=-59.00`, recovery inner face `Z=-61.00`, exact separation `2.00 m`, required shoulder `1.25 m`, and residual Player-collider allowance `0.75 m`. |
| V12-03 | Synchronized the corrected south-perimeter transform and legal-space proof across the authoritative registry, registry-wide invariants, startup validation, Slice 2 steps/checks/manual acceptance, UT-26 through UT-32 where relevant, ST-13, P0-41 through P0-47 where relevant, the no-softlock matrix, Definition of Done and Appendix B. |
| V12-04 | Normalized the sole candidate-arbitration API signature everywhere to `report_puzzle_completed(branch_id: StringName) -> bool`; no second debug-only candidate-arbitration method is permitted. |
| V12-05 | Corrected Appendix B terminology from the ambiguous environment-root wording to the exact `environment_controller_path = ../../EnvironmentStateRoot/Level04EnvironmentStateController`. |
| V12-06 | Re-generated Markdown and DOCX from one Version 1.2 semantic source and verified Markdown/DOCX content equivalence, including the exact recovery calculations, APIs, slice scopes, tests, matrices, Definition of Done and final summary requirements. |
| V12-07 | Completed full DOCX render QA across every page, with focused review of the recovery registry, AABB proof, exact file-scope tables, UT/ST/P0/P1 matrices, headers, footers and page numbers. |

## Version 1.1 Change Log

| ID | Version 1.1 result |
|---|---|
| V11-01 | Preserved the approved Narrative v1.1, Visual Master v1.2, Gameplay Spec v1.2, Technical Architecture v1.2 and Art Production Bible v1.1 as the unchanged design authority. |
| V11-02 | Restored approved environment ownership: `EnvironmentStateRoot` contains the dedicated `Level04EnvironmentStateController` child plus `WorldEnvironment` and `LightingRoot`; the controller script is not attached to the root. |
| V11-03 | Restored the exact environment controller NodePaths and updated the root tree, Section 12, Section 18, Slices 3 and 8, startup validation, tests and Appendix B consistently. |
| V11-04 | Added a complete literal recovery-volume registry for `SoftReturnVolume` and four authored perimeter OOB volumes, including exact node names, IDs, paths, parents, shapes, transforms, extents, covered risks and legal-space exclusions. |
| V11-05 | Replaced every Slice 1-11 open-ended file authority with literal CREATE, MODIFY, READ ONLY, FORBIDDEN and matching `.gd.uid` tables. Any newly discovered defect outside a slice whitelist now requires reopening the owning slice or approving an explicit defect-fix whitelist before editing. |
| V11-06 | Added the mandatory post-APPLY branch transition: clean-status/base reconfirmation, creation of `feature/implement-level-04-greybox` from the exact approved base, branch/HEAD verification and branch/base recording before Slice 1 writes. |
| V11-07 | Added the Slice 3 staged startup contract through `Level04ProgressController.ConfigurationMode.STAGED_SLICE_3`, exact staged API behavior, incremental dependency validation and mandatory switch to full `PRODUCTION` validation at G10. |
| V11-08 | Corrected UID wording: Slice 0 permits no `.gd.uid`, scene UID, import or generated file; runtime slices permit only matching `scripts/levels/level_04/<approved_script>.gd.uid` sidecars for explicitly approved sibling scripts. |
| V11-09 | Preserved exact Shard_08/Shard_09 IDs and texts, exact main text, coordinates, CP0-CP9, RA0-RA11, static split-level topology, ten macro states, immutable first-terminal candidate, dual-context footprints, dual-anchor slots and slot-level `shard_collected` progression. |
| V11-10 | Preserved fail-closed main text, shared LevelPortal scene-loading ownership, all UT/ST/P0/P1 and softlock requirements, final Markdown/DOCX implementation summaries and the rule that mandatory NOT VERIFIED evidence blocks acceptance. |
| V11-11 | Re-generated Markdown and DOCX from the same Version 1.1 semantic source and completed full-page DOCX render QA for content-equivalence and layout integrity. |

## 1. Purpose and execution contract

This reference is the direct implementation contract for a complete playable primitive-only greybox of Level_04. It is not a design brainstorm and must not reinterpret the approved level. Repository facts determine integration details, but cannot silently replace approved narrative, layout, mechanics, exact texts or emotional-safety rules.

Execution contract:

1. **Slice 0 is always inspection-only.** It inspects `AGENTS.md`, current `main`, active pull requests, current Level_04, target Level_05, shared APIs and repository conventions. It makes zero changes, creates no branch, creates no commit, permits no generated file, and ends with `WAITING FOR APPLY`.
2. **Only Slice 0 waits for explicit user `APPLY`.** No runtime work begins before this one authorization.
3. **Immediately after APPLY and before Slice 1 writes**, Codex must reconfirm clean status and the exact approved base SHA, create `feature/implement-level-04-greybox` from that exact base, switch to it, verify current branch and HEAD, and record branch/base evidence. Implementation directly on `main` is forbidden.
4. If Slice 0 approved a stacked prerequisite, branch creation must use that exact approved prerequisite head SHA and record the dependency. No other stacked base is allowed.
5. After branch verification, implementation runs Slice 1 through Slice 11 sequentially. Each runtime slice is implemented alone, validated, committed and handed off before the next begins.
6. Gates G1-G10 are internal acceptance gates. They do not require user confirmation when PASS.
7. Stop only for a P0 failure, shared-system blocker, scope deviation, unresolved active-PR/base conflict, required Producer-only decision, mandatory evidence that cannot be verified honestly, or a required edit outside the active slice's literal whitelist.
8. A defect requiring a file outside the active slice whitelist must stop implementation until the owning slice is reopened or an explicit narrow defect-fix whitelist is approved.
9. No runtime implementation is authorized by this documentation task.

## 2. Approved source hierarchy and conflict resolution

| Priority | Approved source | Authority |
|---|---|---|
| 1 | `Level_04_Narrative_and_Level_Scenario_Package_v1.1.docx` | Title, emotional function, exact Shard_08 and Shard_09 copy, exact main text, branch equality and forbidden readings. |
| 2 | `Level_04_Visual_Master_Concept_Package_v1.2.docx` | Composition intent, one coherent garden, static braided topology reading, landmark hierarchy, atmosphere and three-family art budget. |
| 3 | `Level_04_Gameplay_Map_and_Level_Design_Spec_v1.2.docx` | Exact scene-local coordinates, route metrics, clearances, deterministic mechanics, progression, recovery and acceptance. |
| 4 | `Level_04_Technical_Architecture_and_State_Model_v1.2.docx` | Node ownership, APIs, signals, NodePaths, state models, shared-system boundaries and integration gates. |
| 5 | `Level_04_Art_Production_Bible_v1.1.docx` | Greybox boundary map, layer ownership and post-greybox production constraints. |
| Factual | Current repository and active PR stack | Existing files, actual public APIs, integration compatibility and base decision only. Repository facts cannot silently redesign approved Level_04. |

Conflict rules:

- Narrative exact text and emotional safety outrank repository placeholders.
- Gameplay exact coordinates and behavior outrank approximate visual proportions.
- Technical Architecture controls implementation ownership and wiring, but may not alter approved gameplay.
- Art Bible contributes greybox clearances and ownership, but final assets remain excluded.
- The old one-shard Level_04 placeholder is factual drift, not canon.
- A current shared API incompatibility is a hard-stop prerequisite, not permission for a local private-field hack.

## 3. Emotional safety and source-of-truth summary

The heroine is not broken. The player does not heal, fix, correct, brighten or reveal a hidden “true” version of her. Sunlight, cloud shadow, drizzle, still water, laughter, seriousness, directness and quiet already belong to the world and to her. Progress records attention and coexistence.

The level expresses one personal realization: the author misses Alena herself, not only the ease, voice or laughter of pleasant conversations. Nothing in the level demands a reply, claims privileged access to her inner state, or creates emotional debt.

Locked visual/narrative reading:

- one coherent rainlit terraced garden;
- one initial choice at Crossing Tree, not a repeat hub;
- two equal mandatory branches;
- completed branches remain alive and valuable;
- only the remaining branch receives stronger guidance after the first reward;
- Weather Weave combines already-living motifs and is not a third puzzle;
- the pavilion is a quiet open shelter, not a shrine, altar or ceremony stage;
- the portal represents continuation, not a trophy.

## 4. Repository preflight snapshot and mandatory refresh

The approved Technical Architecture audited `main` at commit `d84af4e4616d7e2a5375c776fe8be0d8c9cbaabf` and found zero open pull requests at that inspection point. It recorded the current `Level_04.tscn` as a flat 12 x 12 one-shard placeholder using legacy `LevelManager` and `PoemRewardUI` while retaining a valid Level_05 portal target.

This snapshot is **research-time evidence only**. Slice 0 must refresh all of it before implementation:

- current default branch and exact `main` SHA;
- every open PR, its base/head SHA and touched shared files;
- `AGENTS.md` and any nested instruction files;
- current `Level_04.tscn` and `Level_05.tscn`;
- current public contracts of Player, Camera, SoulShard, ShardRewardSequenceController, ShardRewardOverlay, SoulOrb_Follow, LevelFinaleOverlay and LevelPortal;
- current Godot version and project configuration;
- exact branch base decision.

Base decision rule:

- use current `main` when no active PR changes a required shared contract;
- if an approved active prerequisite PR changes a required shared contract, report the dependency and exact approved stacked base;
- never silently stack on an unrelated PR;
- unresolved shared/base conflict is a hard stop;
- Slice 0 creates zero diff and ends `WAITING FOR APPLY`.

## 5. Scope

### 5.1 Included in the playable greybox

- complete Level_04 root replacement using primitives and placeholder materials;
- Arrival terrace, Crossing Tree, Changing Canopy initial/remaining terraces, Ripple Conversation initial/remaining shore lanes, Braided Crossing upper/lower lanes, Weather Weave and Final Pavilion;
- three canonical Canopy targets with dual route-context footprints;
- two canonical Ripple markers with dual route-context footprints;
- immutable first-terminal branch candidate;
- Shard_08 and Shard_09 dual-anchor reveal slots;
- exact short shard texts and exact main text through existing shared UI systems;
- one shared SoulOrb_Follow continuity instance;
- E0-E3 environment presentation using placeholders only;
- persistent primitive/placeholder feedback for targets and contours;
- explicit RA0-RA11 grounded recovery anchors and explicit recovery volumes;
- FinalTextGate, Weather Weave terminal and fail-closed main-text flow;
- upgraded shared LevelPortal integration and Level_05 target;
- either-order completion, duplicate protection and no-softlock behavior;
- development diagnostics needed for implementation and acceptance;
- final implementation summary Markdown and content-equivalent DOCX.

### 5.2 Explicitly excluded

- final 3D assets, Blender files, GLBs, production wrappers or final collision proxies;
- final materials, textures, shaders, water simulation, final fog, final particles or polished rain;
- final sound, music, voiceover or cinematics;
- final typography or UI redesign;
- save system, GameState, global persistence or resume-from-mid-level;
- Level_05 development;
- Level_01-Level_03 changes;
- Level_06-Level_15 cleanup or deletion;
- project-wide puzzle framework, global branch framework or `LevelManager` expansion;
- broad Player, SoulShard, reward, finale or portal refactors;
- final confession or acrostic work;
- post-greybox art-production families from the Art Bible.

## 6. Hard technical rules

1. No `project.godot` changes unless a proven blocker is reported and separately approved.
2. No Level_01-Level_03 runtime changes and no Level_05 development.
3. Do not expand legacy `LevelManager` for Level_04.
4. No GameState, save system, new autoload or global singleton.
5. No global node-name scanning, `/root` gameplay paths, `node_added` discovery or child-index authority.
6. Use explicit exported NodePaths and typed cached references.
7. No gameplay scripts on raw GLB imports or environment-only blocks.
8. No final art in greybox slices.
9. No random branch/target order, no timing challenge, no waiting challenge and no audio dependency.
10. No hardcoded assumption that Canopy or Ripple comes first.
11. No candidate authority from shard collection order. First accepted puzzle terminal wins once.
12. No branch geometry mutation, teleport between branches, closing doors or return-to-hub routing.
13. No Player control lock during environmental transitions or optional puzzle feedback.
14. Main text is fail-closed; it cannot be skipped by a generic timer.
15. Portal activation is forbidden before actual main-text close.
16. Level_04 adapters never own scene loading.
17. Recovery may clear `Player.velocity = Vector3.ZERO`; additional transient movement may be cleared only through a proven public Player API. Never access private movement fields.
18. Across runtime slices, only matching `scripts/levels/level_04/<approved_script>.gd.uid` sidecars may be added or changed, and only when the exact sibling `.gd` is explicitly approved in that slice.
19. Unrelated `.gd.uid`, scene UID, `.import`, asset-import metadata, cache or generated-file churn is forbidden.
20. Temporary harness files must live outside the repository worktree or be removed before commit.
21. Every slice must preserve a clean Godot parser/startup state and contain no unrelated changes.
22. Mandatory acceptance evidence marked NOT VERIFIED blocks final acceptance.

## 7. Existing architecture inventory and reuse decisions

| System | Current role | Level_04 decision |
|---|---|---|
| `Player.tscn` / `player_controller.gd` | Shared CharacterBody3D, locomotion, public `set_controls_enabled()` and public `velocity`. | Reuse unchanged. No private-field access. |
| Follow camera / `camera_controller.gd` | Collision-aware orbit with exported `target_path`. | Reuse unchanged and bind to shared Player. |
| `SoulShard.tscn` / `soul_shard.gd` | Collection interaction and shared reward lifecycle entry. | Reuse inside Level04ShardSlot. Do not let macro logic connect directly to child private state. |
| ShardRewardSequenceController | Serial reward overlay, Player lock, return animation and safe completion. | Reuse unchanged, register both shards and scope search to Level_04 ShardRoot. |
| ShardRewardOverlay | Exact short reward presentation. | Reuse unchanged. |
| SoulOrb_Follow | Normal reward return target and absorb pulse. | Exactly one visible shared instance under PlayerRoot. |
| LevelFinaleOverlay | `show_finale_text(text) -> bool` and `closed`. | Reuse; mandatory fail-closed startup validation. |
| LevelPortal | Activation presentation, InteractionArea, AUTO_ENTER, transition latch and scene loading. | Reuse unchanged; adapter calls public `activate()` once. |
| Legacy LevelManager / PoemRewardUI | One-shard placeholder flow. | Remove from Level_04 composition; do not refactor globally. |
| Current Level_04 placeholder | Flat room, one shard, portal to Level_05. | Replace locally; not design canon. |

## 8. Exact spatial greybox specification

### 8.1 Coordinate convention

- `Level_04` root transform is identity.
- Scene-local origin is `Vector3(0, 0, 0)`.
- Forward from Arrival toward the pavilion is `+Z`.
- Right while facing forward is `+X`.
- Every listed Y value is an authored **floor anchor**, not an assumed Player-root Y.
- Player runtime root Y at spawn and recovery anchors is evidence-derived in Slice 2 from actual CharacterBody grounding and floor-snap behavior.
- After Slice 2 acceptance, proven root-Y values are frozen and recorded in the implementation summary.
- A vertical technical correction that preserves exact floor anchors, camera framing and approved clearances is not a gameplay-layout revision.

### 8.2 Zone schedule

| Zone | Exact center / envelope | Locked role |
|---|---|---|
| Whole gameplay envelope | X `-38..+38`, Z `-58..+62` | 76 x 120 m playable planning envelope. |
| Arrival | `Vector3(0,0,-54)`, 12 x 10 m | Safe spawn and first combined-weather view. |
| Crossing Tree | `Vector3(0,0,-39)`, 18 x 16 m | One initial branch choice, never a repeat hub. |
| Changing Canopy region | `Vector3(-21,2.5,-8)`, 30 x 42 m | Initial and remaining terraces around three shared visual pockets. |
| Ripple Conversation region | `Vector3(23,-0.6,-8)`, 30 x 42 m | Initial and remaining shoreline lanes around two shared markers. |
| Braided Crossing | `Vector3(2,2,14)`, 30 x 30 m | Static over/under connector, upper floor Y=4 and lower floor Y=0. |
| Weather Weave | `Vector3(0,1.8,38)`, 18 x 14 m | Non-interactive synthesis and common approach. |
| Final Pavilion | `Vector3(0,2,52)`, 16 x 14 m | Main text, rest point and side-forward portal. |

### 8.3 Exact route and gameplay anchors

| ID | Exact floor position |
|---|---|
| O | `Vector3(0.00, 0.00, -54.00)` |
| T | `Vector3(0.00, 0.00, -39.00)` |
| A1 | `Vector3(-8.00, 0.50, -33.00)` |
| C1I | `Vector3(-21.00, 1.00, -22.00)` |
| C2I | `Vector3(-21.00, 1.30, -10.00)` |
| C3I | `Vector3(-16.00, 1.70, 1.00)` |
| A3F / Shard_08 first-pass | `Vector3(-11.00, 2.00, 7.00)` |
| A4 | `Vector3(-4.00, 3.00, 10.00)` |
| UC | `Vector3(2.00, 4.00, 16.00)` |
| U1 | `Vector3(10.00, 3.30, 13.00)` |
| U2 | `Vector3(20.00, 1.00, -1.00)` |
| B5 | `Vector3(30.00, -1.00, -26.00)` |
| R1R | `Vector3(29.00, -1.00, -18.00)` |
| R2R | `Vector3(28.00, -0.80, -5.00)` |
| B3R / Shard_09 remaining-pass | `Vector3(17.00, -0.30, 11.00)` |
| B6 | `Vector3(6.00, 0.80, 24.00)` |
| B1 | `Vector3(8.00, -0.20, -33.00)` |
| R1I | `Vector3(21.00, -0.40, -22.00)` |
| R2I | `Vector3(20.00, -0.50, -9.00)` |
| B3F / Shard_09 first-pass | `Vector3(17.00, -0.30, 5.00)` |
| B4 | `Vector3(6.00, 0.00, 10.00)` |
| LC | `Vector3(2.00, 0.00, 16.00)` |
| L1 | `Vector3(-8.00, 0.60, 14.00)` |
| L2 | `Vector3(-20.00, 2.30, -1.00)` |
| A5 | `Vector3(-30.00, 4.00, -26.00)` |
| C1R | `Vector3(-27.00, 4.00, -18.00)` |
| C2R | `Vector3(-27.00, 4.00, -6.00)` |
| C3R | `Vector3(-22.00, 4.00, 5.00)` |
| A3R / Shard_08 remaining-pass | `Vector3(-11.00, 4.00, 11.00)` |
| A6 | `Vector3(-4.00, 3.00, 24.00)` |
| W | `Vector3(0.00, 1.80, 38.00)` |
| P / FinalTextGate center | `Vector3(0.00, 2.00, 52.00)` |
| PR / PortalFloorAnchor | `Vector3(6.00, 2.00, 56.50)` |

### 8.4 Target and marker visual centers

| Canonical ID | Initial / remaining footprints | Visual center |
|---|---|---|
| `CANOPY_TONE_1` | C1I / C1R | `Vector3(-24, 2.5, -20)` |
| `CANOPY_TONE_2` | C2I / C2R | `Vector3(-24, 2.7, -8)` |
| `CANOPY_TONE_3` | C3I / C3R | `Vector3(-19, 2.9, 3)` |
| `RIPPLE_MARKER_1` | R1I / R1R | `Vector3(25, -0.7, -20)` |
| `RIPPLE_MARKER_2` | R2I / R2R | `Vector3(24, -0.65, -7)` |

### 8.5 Camera QA points

| Point | Player floor position | Look target | Required reading |
|---|---|---|---|
| CP0 Arrival | `(0,0,-52)` | `(0,2,-39)` | Crossing Tree primary, both branch entrances, pavilion secondary. |
| CP1 Crossing Tree | `(0,0,-37)` | `(0,1.5,-25)` | Equal Canopy/Ripple prominence; no branch ranking. |
| CP2 Canopy initial | `(-18,1.5,-14)` | `(-19,2.2,-3)` | Three pockets and first-pass shard context. |
| CP3 Canopy remaining | `(-26,4,-10)` | `(-19,2.7,2)` | Remaining footprints; no false connection to initial terrace. |
| CP4 Ripple initial | `(18,-0.4,-17)` | `(23,-0.5,-7)` | Both shoreline markers and dry first-pass bank. |
| CP5 Ripple remaining | `(28,-0.9,-14)` | `(23,-0.5,-6)` | Remaining footprints and dry bank; no shortcut to initial lane. |
| CP6 Crossing upper | `(5,4,11)` | `(2,2,16)` | Upper continuity and visible but unreachable lower underpass. |
| CP7 Crossing lower | `(3,0,13)` | `(2,2,16)` | Clear underpass and no camera clipping or climbable switch. |
| CP8 Weather Weave | `(0,1.8,40)` | `(0,2,52)` | Pavilion primary; no portal guidance before main text. |
| CP9 Final Pavilion | `(-2,2,50)` | `(6,2,56.5)` | Open shelter, horizon and unobstructed portal. |

### 8.6 Traversal, boundary and clearance rules

- mandatory route width: **5.5 m minimum**;
- use **6.0-7.0 m** at branch entrances/exits, major curves, shard approaches and final pavilion approach;
- walkable shoulder: **1.25 m minimum**;
- camera-safe corridor around mandatory centerlines: **8.5 m**;
- preferred slope: `<= 8 degrees`;
- isolated absolute maximum: `10 degrees` over `<= 4 m`, not expected in the approved centerline;
- cross-slope on traversal and puzzle footprints: `<= 3 degrees`;
- mandatory steps: `<= 0.15 m`;
- mandatory gaps/jumps: none;
- Braided Crossing lanes: each at least 5.5 m wide;
- lower underpass clear height: at least 3.4 m;
- no same-level UC/LC connection, side stair, climb shortcut or intentional drop shortcut;
- shallow water is visual, non-hazardous, non-slippery and not mandatory traversal;
- shard floors are dry, below 3-degree slope and at least 2.5 m from recovery boundaries;
- portal interaction/collision clear radius: 3.0 m;
- portal visual/camera clear radius: 4.5 m;
- no invisible catch floor; explicit recovery volumes remain authority.

### 8.7 Recovery anchors

| ID / node | Exact floor coordinate |
|---|---|
| `RA0_ARRIVAL` | `Vector3(0,0,-54)` |
| `RA1_CROSSING_TREE` | `Vector3(0,0,-39)` |
| `RA2_CANOPY_INITIAL` | `Vector3(-12,0.8,-29)` |
| `RA3_CANOPY_FIRST_PASS` | `Vector3(-11,2.0,5.5)` |
| `RA4_RIPPLE_INITIAL` | `Vector3(12,-0.2,-29)` |
| `RA5_RIPPLE_FIRST_PASS` | `Vector3(17,-0.3,3.5)` |
| `RA6_UPPER_CROSSING` | `Vector3(2,4,14)` |
| `RA7_LOWER_CROSSING` | `Vector3(2,0,14)` |
| `RA8_CANOPY_REMAINING` | `Vector3(-28,4,-22)` |
| `RA9_RIPPLE_REMAINING` | `Vector3(29,-1,-22)` |
| `RA10_WEATHER_WEAVE` | `Vector3(0,1.8,38)` |
| `RA11_FINAL_PAVILION` | `Vector3(0,2,50)` |

### 8.8 Authoritative recovery-volume registry

The registry below is complete. No additional authored recovery volume exists in the approved greybox. All five nodes are instances of `Level04RecoveryVolume.tscn`, are passive `Area3D` event sources, export only the stated `volume_id`, and own no destination, token, latch, nearest-anchor, Player reference or world-position logic. Every collision shape is an axis-aligned `BoxShape3D`; listed extents are half-extents.

#### 8.8.1 `SoftReturnVolume`

| Field | Exact value |
|---|---|
| Node name | `SoftReturnVolume` |
| `volume_id` | `&"RV_SOFT_RETURN"` |
| RecoveryController owner-relative NodePath | `../../GameplayRoot/SafetyRoot/RecoveryVolumes/SoftReturnVolume` |
| Parent | `GameplayRoot/SafetyRoot/RecoveryVolumes` |
| Area3D shape type | `BoxShape3D` |
| Scene-local position | `Vector3(0.00, -12.00, 2.00)` |
| Rotation degrees XYZ | `Vector3(0,0,0)` |
| Exact extents | `Vector3(50.00, 5.00, 72.00)` |
| Covered spatial risk | Any fall below the authored terrain envelope; top face is Y=-7.00. |
| Required legal-space exclusions | Vertically separated from every legal floor, shallow-water area, shard alcove, pavilion overlook, both Braided Crossing lanes, mandatory shoulder and camera corridor. No legal Player collider position reaches Y=-7.00. |

#### 8.8.2 `OOB_WestPerimeter`

| Field | Exact value |
|---|---|
| Node name | `OOB_WestPerimeter` |
| `volume_id` | `&"RV_OOB_WEST_PERIMETER"` |
| RecoveryController owner-relative NodePath | `../../GameplayRoot/SafetyRoot/RecoveryVolumes/AuthoredOutOfBoundsVolumes/OOB_WestPerimeter` |
| Parent | `GameplayRoot/SafetyRoot/RecoveryVolumes/AuthoredOutOfBoundsVolumes` |
| Area3D shape type | `BoxShape3D` |
| Scene-local position | `Vector3(-42.00, 1.00, 2.00)` |
| Rotation degrees XYZ | `Vector3(0,0,0)` |
| Exact extents | `Vector3(3.00, 10.00, 66.00)` |
| Covered spatial risk | Escapes beyond the west authored envelope after visible blockers or terrain are bypassed. |
| Required legal-space exclusions | Inner face is X=-39.00, one metre outside the approved envelope edge X=-38.00. The nearest mandatory centerline, 1.25 m shoulder and 8.5 m camera corridor remain inside X>-34.25. It cannot overlap Canopy legal side spaces, shard alcoves or either crossing lane. |

#### 8.8.3 `OOB_EastPerimeter`

| Field | Exact value |
|---|---|
| Node name | `OOB_EastPerimeter` |
| `volume_id` | `&"RV_OOB_EAST_PERIMETER"` |
| RecoveryController owner-relative NodePath | `../../GameplayRoot/SafetyRoot/RecoveryVolumes/AuthoredOutOfBoundsVolumes/OOB_EastPerimeter` |
| Parent | `GameplayRoot/SafetyRoot/RecoveryVolumes/AuthoredOutOfBoundsVolumes` |
| Area3D shape type | `BoxShape3D` |
| Scene-local position | `Vector3(42.00, 1.00, 2.00)` |
| Rotation degrees XYZ | `Vector3(0,0,0)` |
| Exact extents | `Vector3(3.00, 10.00, 66.00)` |
| Covered spatial risk | Escapes beyond the east authored envelope after visible blockers or terrain are bypassed. |
| Required legal-space exclusions | Inner face is X=39.00, one metre outside the approved envelope edge X=38.00. The nearest mandatory centerline, 1.25 m shoulder and 8.5 m camera corridor remain inside X<34.25. It cannot overlap shallow water, Ripple legal side spaces, shard alcoves or either crossing lane. |

#### 8.8.4 `OOB_SouthPerimeter`

| Field | Exact value |
|---|---|
| Node name | `OOB_SouthPerimeter` |
| `volume_id` | `&"RV_OOB_SOUTH_PERIMETER"` |
| RecoveryController owner-relative NodePath | `../../GameplayRoot/SafetyRoot/RecoveryVolumes/AuthoredOutOfBoundsVolumes/OOB_SouthPerimeter` |
| Parent | `GameplayRoot/SafetyRoot/RecoveryVolumes/AuthoredOutOfBoundsVolumes` |
| Area3D shape type | `BoxShape3D` |
| Scene-local position | `Vector3(0.00, 1.00, -65.00)` |
| Rotation degrees XYZ | `Vector3(0,0,0)` |
| Exact extents | `Vector3(39.00, 10.00, 4.00)` |
| Calculated legal-facing inner face | `Z=-61.00` because `-65.00 + 4.00 = -61.00`. |
| Covered spatial risk | Escapes behind or below Arrival beyond the south authored envelope. A fall before the Player reaches the perimeter remains covered by `SoftReturnVolume`. |
| Required legal-space exclusions | The approved planning-envelope minimum `Z=-58.00` is not sufficient by itself for recovery placement. Recovery exclusion is checked against the actual legal Arrival floor bounds: center `Z=-54.00`, depth `10.00 m`, nominal south edge `Z=-59.00`. The corrected recovery inner face is `Z=-61.00`, creating an exact `2.00 m` separation. This exceeds the required `1.25 m` walkable shoulder and leaves `0.75 m` residual clearance for the current Player collider. Legal Arrival movement cannot overlap the volume. No invisible catch floor is introduced. |

##### 8.8.4.1 `OOB_SouthPerimeter` actual-floor AABB proof

| Proof row | Exact calculation and result |
|---|---|
| `OOB_SouthPerimeter` actual-floor AABB proof | Legal floor center and depth: Arrival center `Z=-54.00`, depth `10.00 m`, half-depth `5.00 m`. Calculated legal south edge: `-54.00 - 5.00 = -59.00`. Recovery center and half-extent: center `Z=-65.00`, half-extent `Z=4.00 m`. Calculated recovery inner face: `-65.00 + 4.00 = -61.00`. Exact separation: `-59.00 - (-61.00) = 2.00 m`. Player-collider allowance: `2.00 - 1.25 = 0.75 m` remains beyond the mandatory shoulder and covers the current Player collider allowance. Result: **PASS** - legal Arrival movement cannot intersect the recovery AABB; falls before the perimeter remain covered by `SoftReturnVolume`. |

#### 8.8.5 `OOB_NorthPerimeter`

| Field | Exact value |
|---|---|
| Node name | `OOB_NorthPerimeter` |
| `volume_id` | `&"RV_OOB_NORTH_PERIMETER"` |
| RecoveryController owner-relative NodePath | `../../GameplayRoot/SafetyRoot/RecoveryVolumes/AuthoredOutOfBoundsVolumes/OOB_NorthPerimeter` |
| Parent | `GameplayRoot/SafetyRoot/RecoveryVolumes/AuthoredOutOfBoundsVolumes` |
| Area3D shape type | `BoxShape3D` |
| Scene-local position | `Vector3(0.00, 1.00, 67.00)` |
| Rotation degrees XYZ | `Vector3(0,0,0)` |
| Exact extents | `Vector3(39.00, 10.00, 4.00)` |
| Covered spatial risk | Escapes beyond Final Pavilion and portal overlook after visible blockers are bypassed. |
| Required legal-space exclusions | Inner face is Z=63.00, one metre outside the approved envelope edge Z=62.00. Pavilion overlook, PortalFloorAnchor, portal clear radii, 1.25 m shoulder and 8.5 m camera corridor remain south of Z=62.00. |

#### 8.8.6 Registry-wide invariants

- The four perimeter volumes may overlap one another only in the four exterior corners; such overlap is intentional and must still create one controller-owned fall token and one recovery.
- No volume overlaps legal side spaces, shallow water, either shard alcove, pavilion overlook, either Braided Crossing lane, any mandatory 1.25 m shoulder or any 8.5 m camera corridor.
- `OOB_SouthPerimeter` is validated against the actual Arrival floor AABB rather than the planning-envelope minimum: legal south edge `Z=-59.00`, recovery inner face `Z=-61.00`, exact separation `2.00 m`, mandatory shoulder `1.25 m`, residual current-Player-collider allowance `0.75 m`.
- A fall south of Arrival before reaching the perimeter remains covered by `SoftReturnVolume`; no invisible catch floor, hidden legal-space recovery slab or enlarged legal-floor geometry is allowed.
- Internal terrace drops and Braided Crossing separation are protected by visible static boundaries; a bypassed internal fall reaches `SoftReturnVolume`.
- The exact five literal paths, IDs, transforms and extents are serialized on `Level04RecoveryController`; root scans, wildcard discovery, node-name parsing and inferred IDs are forbidden.

## 9. Proposed repository file tree

```text
scenes/levels/Level_04.tscn                                  # replace local placeholder
scenes/levels/level_04/
├── blocks/
│   ├── Block_04_00_Arrival.tscn
│   ├── Block_04_01_CrossingTree.tscn
│   ├── Block_04_02_ChangingCanopy.tscn
│   ├── Block_04_03_BraidedCrossing.tscn
│   ├── Block_04_04_RippleConversation.tscn
│   ├── Block_04_05_WeatherWeave.tscn
│   └── Block_04_06_FinalPavilion.tscn
├── gameplay/
│   ├── ChangingCanopyPuzzle.tscn
│   ├── RippleConversationPuzzle.tscn
│   ├── Level04PresenceFootprint.tscn
│   ├── Level04ShardSlot.tscn
│   ├── Level04RecoveryAnchorZone.tscn
│   └── Level04RecoveryVolume.tscn
└── vfx/                                                     # exact placeholder scenes assigned by slice tables
    ├── L04_VFX_RainThreads.tscn
    ├── L04_VFX_CloudShadow.tscn
    ├── L04_VFX_CanopyFeedback.tscn
    ├── L04_VFX_RippleContours.tscn
    ├── L04_VFX_RemainingGuidance.tscn
    ├── L04_VFX_WeatherWeave.tscn
    └── L04_VFX_PortalAccent.tscn

scripts/levels/level_04/
├── level_04_progress_controller.gd
├── changing_canopy_controller.gd
├── ripple_conversation_controller.gd
├── level_04_presence_footprint.gd
├── level_04_shard_slot.gd
├── level_04_environment_state_controller.gd
├── level_04_finale_controller.gd
├── level_04_portal_adapter.gd
├── level_04_recovery_controller.gd
├── level_04_recovery_anchor_zone.gd
└── level_04_recovery_volume.gd

# Matching sidecars are allowed only beside approved scripts:
scripts/levels/level_04/*.gd.uid

docs/design/Level_04_Greybox_Development_Reference_v1.3.md

# Created by Slice 11:
docs/development/Level_04_Greybox_Implementation_Summary.md

# User-facing final artifact, generated outside the runtime worktree unless explicitly requested in the PR:
Level_04_Greybox_Implementation_Summary.docx
```

A placeholder VFX scene is created only when the corresponding slice needs a stable scene boundary. Do not pre-create empty files merely to match this tree.

## 10. Proposed root node tree

```text
Level_04 (Node3D; identity transform)
├── EnvironmentRoot (Node3D)
│   ├── Block_04_00_Arrival
│   ├── Block_04_01_CrossingTree
│   ├── Block_04_02_ChangingCanopy
│   ├── Block_04_03_BraidedCrossing
│   ├── Block_04_04_RippleConversation
│   ├── Block_04_05_WeatherWeave
│   ├── Block_04_06_FinalPavilion
│   └── Boundaries
├── GameplayRoot (Node3D)
│   ├── PuzzleRoot
│   │   ├── ChangingCanopyPuzzle
│   │   └── RippleConversationPuzzle
│   ├── ShardRoot
│   │   ├── ShardSlot_08
│   │   └── ShardSlot_09
│   ├── RouteAuthorityRoot
│   │   ├── CanopyRemainingShardZone
│   │   ├── RippleRemainingShardZone
│   │   └── FinalTextGate
│   ├── PortalRoot
│   │   └── PortalFloorAnchor (Marker3D; Vector3(6,2,56.5))
│   │       └── LevelPortal (shared; identity local transform)
│   └── SafetyRoot
│       ├── RecoveryVolumes
│       │   ├── SoftReturnVolume
│       │   └── AuthoredOutOfBoundsVolumes
│       │       ├── OOB_WestPerimeter
│       │       ├── OOB_EastPerimeter
│       │       ├── OOB_SouthPerimeter
│       │       └── OOB_NorthPerimeter
│       └── RecoveryAnchors
│           ├── RA0_Arrival ... RA11_FinalPavilion
├── EnvironmentStateRoot (Node3D; no controller script attached to this root)
│   ├── Level04EnvironmentStateController (Node; controller script owner)
│   ├── WorldEnvironment
│   └── LightingRoot
│       ├── WarmSun
│       ├── CoolCloudFill
│       └── PavilionGuidanceLight
├── VFXRoot (Node3D)
│   ├── NaturalWeatherRoot
│   ├── CanopyPresentationRoot
│   ├── RipplePresentationRoot
│   ├── RemainingBranchGuidanceRoot
│   ├── WeatherWeaveVFX
│   └── PortalAccentVFX
├── PlayerRoot (Node3D)
│   ├── PlayerFloorSpawnMarker
│   ├── Player (shared)
│   └── SoulOrb_Follow (shared; exactly one visible continuity instance)
├── CameraRoot (Node3D)
│   └── FollowCamera
├── LevelRuntimeRoot (Node3D)
│   ├── Level04ProgressController
│   ├── ShardRewardSequenceController (shared)
│   ├── Level04FinaleController
│   ├── Level04PortalAdapter
│   └── Level04RecoveryController
└── UILayer (CanvasLayer)
    ├── ShardRewardOverlay (shared)
    └── LevelFinaleOverlay (shared)
```

### 10.1 Local scene trees

```text
ChangingCanopyPuzzle (Node3D)
├── ChangingCanopyController (Node)
├── FootprintRoot (Node3D)
│   ├── C1I / C1R
│   ├── C2I / C2R
│   └── C3I / C3R
└── MarkerRoot (Node3D)
    ├── CANOPY_TONE_1_VisualMarker
    ├── CANOPY_TONE_2_VisualMarker
    └── CANOPY_TONE_3_VisualMarker

RippleConversationPuzzle (Node3D)
├── RippleConversationController (Node)
├── FootprintRoot (Node3D)
│   ├── R1I / R1R
│   └── R2I / R2R
└── MarkerRoot (Node3D)
    ├── RIPPLE_MARKER_1_VisualMarker
    └── RIPPLE_MARKER_2_VisualMarker

Level04ShardSlot (Node3D)
├── FirstPassAnchor (Marker3D)
├── RemainingPassAnchor (Marker3D)
├── RevealVFXRoot (Node3D)
└── SoulShard (shared; packed hidden/non-collectable)

Level04RecoveryAnchorZone (Node3D; root owns approved floor coordinate)
├── FloorAnchor (Marker3D; identity local transform)
└── ArrivalZone (Area3D)
    └── CollisionShape3D

Level04RecoveryVolume (Area3D; passive event source)
└── CollisionShape3D
```

## 11. Canonical IDs and exact runtime copy

### 11.1 IDs

- Branch IDs: `&"CANOPY"`, `&"RIPPLE"`.
- Shard IDs: `&"Shard_08"`, `&"Shard_09"`.
- Canopy targets: `&"CANOPY_TONE_1"`, `&"CANOPY_TONE_2"`, `&"CANOPY_TONE_3"`.
- Ripple markers: `&"RIPPLE_MARKER_1"`, `&"RIPPLE_MARKER_2"`.
- Main text ID: `&"LEVEL_04_MAIN_TEXT"`.
- RouteContext enum: `INITIAL`, `REMAINING`.
- AnchorContext enum: `FIRST_PASS`, `REMAINING_PASS`.
- Recovery IDs: exact RA0-RA11 IDs listed in Section 8.7.
- Recovery volume IDs: `&"RV_SOFT_RETURN"`, `&"RV_OOB_WEST_PERIMETER"`, `&"RV_OOB_EAST_PERIMETER"`, `&"RV_OOB_SOUTH_PERIMETER"`, `&"RV_OOB_NORTH_PERIMETER"`.

### 11.2 Locked exact texts

**Shard_08:**  
`Ты можешь рассмешить меня, а через минуту сказать что-то так серьёзно, что я просто слушаю.`

**Shard_09:**  
`Мне дороги и наши разговоры, в которых пауз больше, чем слов.`

**Main Level_04 text:**  
`Сначала я думал, что жду наших разговоров ради твоего голоса и смеха. Потом понял, что мне дороги и те минуты, когда ты серьёзна, говоришь прямо или между нами просто становится тихо. Я скучаю не только по лёгким разговорам. Я скучаю по тебе - и поэтому в памяти остаются даже маленькие вещи.`

Runtime strings contain no decorative outer quotation marks and must not be paraphrased.

## 12. Exact owner-relative NodePaths

| Owner | Export | Exact NodePath |
|---|---|---|
| Progress | `canopy_controller_path` | `../../GameplayRoot/PuzzleRoot/ChangingCanopyPuzzle/ChangingCanopyController` |
| Progress | `ripple_controller_path` | `../../GameplayRoot/PuzzleRoot/RippleConversationPuzzle/RippleConversationController` |
| Progress | `shard_slot_08_path` | `../../GameplayRoot/ShardRoot/ShardSlot_08` |
| Progress | `shard_slot_09_path` | `../../GameplayRoot/ShardRoot/ShardSlot_09` |
| Progress | `canopy_remaining_zone_path` | `../../GameplayRoot/RouteAuthorityRoot/CanopyRemainingShardZone` |
| Progress | `ripple_remaining_zone_path` | `../../GameplayRoot/RouteAuthorityRoot/RippleRemainingShardZone` |
| Progress | `environment_controller_path` | `../../EnvironmentStateRoot/Level04EnvironmentStateController` |
| Progress | `finale_controller_path` | `../Level04FinaleController` |
| Progress | `portal_adapter_path` | `../Level04PortalAdapter` |
| Progress | `recovery_controller_path` | `../Level04RecoveryController` |
| Reward controller | `overlay_path` | `../../UILayer/ShardRewardOverlay` |
| Reward controller | `player_path` | `../../PlayerRoot/Player` |
| Reward controller | `shard_search_root_path` | `../../GameplayRoot/ShardRoot` |
| Finale | `player_path` | `../../PlayerRoot/Player` |
| Finale | `final_text_gate_path` | `../../GameplayRoot/RouteAuthorityRoot/FinalTextGate` |
| Finale | `finale_overlay_path` | `../../UILayer/LevelFinaleOverlay` |
| Finale | `recovery_controller_path` | `../Level04RecoveryController` |
| Portal adapter | `portal_path` | `../../GameplayRoot/PortalRoot/PortalFloorAnchor/LevelPortal` |
| Portal adapter | `portal_floor_anchor_path` | `../../GameplayRoot/PortalRoot/PortalFloorAnchor` |
| Portal adapter | `portal_accent_vfx_path` | `../../VFXRoot/PortalAccentVFX` |
| Level04EnvironmentStateController | `world_environment_path` | `../WorldEnvironment` |
| Level04EnvironmentStateController | `lighting_root_path` | `../LightingRoot` |
| Level04EnvironmentStateController | `canopy_guidance_path` | `../../VFXRoot/RemainingBranchGuidanceRoot/CanopyGuidance` |
| Level04EnvironmentStateController | `ripple_guidance_path` | `../../VFXRoot/RemainingBranchGuidanceRoot/RippleGuidance` |
| Level04EnvironmentStateController | `weather_weave_vfx_path` | `../../VFXRoot/WeatherWeaveVFX` |
| Recovery | `player_path` | `../../PlayerRoot/Player` |
| Recovery | `recovery_volumes_root_path` | `../../GameplayRoot/SafetyRoot/RecoveryVolumes` |
| Recovery | `recovery_anchors_root_path` | `../../GameplayRoot/SafetyRoot/RecoveryAnchors` |
| Recovery | `recovery_volume_paths[0]` | `../../GameplayRoot/SafetyRoot/RecoveryVolumes/SoftReturnVolume` |
| Recovery | `recovery_volume_paths[1]` | `../../GameplayRoot/SafetyRoot/RecoveryVolumes/AuthoredOutOfBoundsVolumes/OOB_WestPerimeter` |
| Recovery | `recovery_volume_paths[2]` | `../../GameplayRoot/SafetyRoot/RecoveryVolumes/AuthoredOutOfBoundsVolumes/OOB_EastPerimeter` |
| Recovery | `recovery_volume_paths[3]` | `../../GameplayRoot/SafetyRoot/RecoveryVolumes/AuthoredOutOfBoundsVolumes/OOB_SouthPerimeter` |
| Recovery | `recovery_volume_paths[4]` | `../../GameplayRoot/SafetyRoot/RecoveryVolumes/AuthoredOutOfBoundsVolumes/OOB_NorthPerimeter` |
| Camera | `target_path` | `../../PlayerRoot/Player` |
| SoulOrb_Follow | `target_path` | `../Player` |
| SoulOrb_Follow | `orientation_source_path` | `../Player/CharacterVisualRoot` |
| Canopy controller | `presentation_controller_path` | `../../../../VFXRoot/CanopyPresentationRoot` |
| Canopy controller | `player_path` | `../../../../PlayerRoot/Player` |
| Ripple controller | `presentation_controller_path` | `../../../../VFXRoot/RipplePresentationRoot` |
| Ripple controller | `player_path` | `../../../../PlayerRoot/Player` |
| Every footprint | `player_path` | `../../../../../PlayerRoot/Player` |
| Every RA zone | `floor_anchor_path` | `FloorAnchor` |
| Every RA zone | `arrival_zone_path` | `ArrivalZone` |
| Every RA zone | `player_path` | `../../../../PlayerRoot/Player` |

Recovery controller uses explicit literal arrays for all 12 RA zone paths and exactly the five recovery-volume paths listed above. No scene-wide discovery, wildcard path, `[1..N]` shorthand or inferred volume identity is permitted.

### 12.1 Startup validation invariants

Startup is fail-closed for final production mode and validates:

- every exported path resolves from its owner to the required type;
- `EnvironmentStateRoot/Level04EnvironmentStateController` exists as a dedicated child node with the environment controller script; `EnvironmentStateRoot` itself has no controller script;
- environment paths equal `../WorldEnvironment`, `../LightingRoot`, `../../VFXRoot/RemainingBranchGuidanceRoot/CanopyGuidance`, `../../VFXRoot/RemainingBranchGuidanceRoot/RippleGuidance` and `../../VFXRoot/WeatherWeaveVFX`;
- the exact five recovery-volume paths resolve to `Level04RecoveryVolume` Area3D nodes with the exact non-empty unique IDs, transforms and extents from Section 8.8, including `OOB_SouthPerimeter` at `Vector3(0.00, 1.00, -65.00)` with inner face `Z=-61.00`;
- startup validation recomputes the `OOB_SouthPerimeter` actual-floor AABB proof from Arrival center `Z=-54.00`, depth `10.00 m`, legal south edge `Z=-59.00`, recovery center `Z=-65.00` and half-extent `4.00 m`, and fails closed unless the exact separation is `2.00 m` with the `1.25 m` shoulder plus `0.75 m` Player-collider allowance preserved;
- all 12 RA paths and IDs resolve literally;
- all footprint, shard-slot, finale and portal paths resolve with canonical IDs and types;
- the shared LevelPortal configuration and sole scene-loading ownership are correct;
- runtime Environment/resource instances are scene-local;
- exactly one SoulOrb continuity instance exists;
- no root scan, child-order identity or world-position identity inference is used.

**Slice 3 staged dependency contract:**

- `Level04ProgressController` declares `enum ConfigurationMode { STAGED_SLICE_3, PRODUCTION }` and exported `configuration_mode`.
- Slice 3 attaches it with `configuration_mode = STAGED_SLICE_3`.
- In staged mode, `_ready()` must validate all dependencies that exist in Slice 3: exact canonical branch/shard IDs, `EnvironmentStateRoot/Level04EnvironmentStateController`, RecoveryController, shared reward controller, and macro internal invariants. It may treat the exact future paths for Canopy, Ripple, both ShardSlots, both remaining zones, FinaleController and PortalAdapter as deliberately unresolved, and must emit one concise staged diagnostic rather than uncontrolled configuration errors.
- Candidate arbitration is tested honestly by calling the same production entry point `report_puzzle_completed(branch_id: StringName) -> bool`; no debug-only alternate arbitration implementation is allowed.
- Each later owning slice resolves its exact dependency and calls `validate_available_dependencies()`; this never disables final validation.
- At the end of Slice 10, after all final-path dependencies exist, Codex must set `configuration_mode = PRODUCTION`, call `validate_production_configuration()`, and pass G10. Slice 11 and Definition of Done require full production validation; staged mode in the final scene is a P0 failure.
- Codex may not invent missing-dependency fallback behavior outside this contract.

## 13. Signal and public API contract

### 13.1 Signals

| Signal | Emitter -> receiver | Locked meaning |
|---|---|---|
| `presence_accepted(id, footprint_id, route_context)` | PresenceFootprint -> puzzle controller | Configured grounded Player completed 0.45 s dwell for one explicit mapping. |
| `target_completed(target_id)` | Canopy -> presentation/tests | First unique Canopy target completion. |
| `marker_completed(marker_id)` | Ripple -> presentation/tests | First unique Ripple marker completion. |
| `puzzle_completed(branch_id)` | Puzzle -> Progress | Exactly one logical terminal at 3/3 or 2/2. |
| `shard_available(shard_id)` | ShardSlot -> Progress | Reveal terminal passed and effective collectability verified. |
| `shard_collection_started(shard_id)` | ShardSlot -> Progress/Recovery | Child shared reward lifecycle requested. |
| `shard_collected(shard_id)` | ShardSlot -> Progress/Recovery | Shared reward completed and SoulShard emitted collected. |
| `environment_phase_changed(previous,current)` | Environment -> QA | Semantic phase accepted; visual tweens may continue. |
| `weather_weave_terminal(source)` | Environment -> Progress | Actual optional completion or controller-owned 2.5 s fallback, first-terminal-wins. |
| `main_text_started(text_id)` | Finale -> Progress | Shared overlay accepted exact text. |
| `main_text_closed(text_id)` | Finale -> Progress | Actual shared overlay close only. |
| `portal_activation_requested()` | PortalAdapter -> QA | Immediately before the only shared `activate()` call. |
| `portal_activated()` | PortalAdapter -> Progress/QA | Actual shared `activation_completed` only. |
| `portal_activation_blocked(reason)` | PortalAdapter -> QA | Diagnostic timeout/configuration failure; never success. |
| `recovery_anchor_reached(anchor_id)` | RecoveryAnchorZone -> RecoveryController | First valid grounded arrival generation. |
| `recovery_performed(anchor_id, volume_id)` | RecoveryController -> QA | One accepted recovery for one internally owned fall token. |
| `configuration_error(component,message)` | Any local controller -> QA | Fail-closed configuration blocker. |

### 13.2 Public APIs

**Level04ProgressController**

- `configuration_mode: ConfigurationMode`
- `validate_available_dependencies() -> bool`
- `validate_production_configuration() -> bool`
- `get_state() -> MacroState`
- `get_first_branch_candidate() -> StringName`
- `get_remaining_branch() -> StringName`
- `get_collected_shard_ids() -> Array[StringName]`
- `report_puzzle_completed(branch_id: StringName) -> bool`
- `report_remaining_zone_presence(branch_id, inside)`
- `request_debug_snapshot() -> Dictionary`

**ChangingCanopyController**

- `report_presence_accepted(target_id, footprint_id, route_context: RouteContext)`
- `is_target_completed(target_id) -> bool`
- `is_complete() -> bool`
- `get_completed_target_ids() -> Array[StringName]`
- `request_current_hint()`
- `debug_validate_identity_map() -> bool`

**RippleConversationController**

- `report_presence_accepted(marker_id, footprint_id, route_context: RouteContext)`
- `is_marker_completed(marker_id) -> bool`
- `is_complete() -> bool`
- `get_completed_marker_ids() -> Array[StringName]`
- `request_current_hint()`
- `debug_validate_identity_map() -> bool`

**Level04ShardSlot**

- `prepare_hidden()`
- `reveal_at(context: AnchorContext) -> bool`
- `get_state() -> SlotState`
- `get_selected_anchor_context() -> AnchorContext`
- `get_soul_shard() -> Node`
- `debug_verify_collectability() -> bool`

**Level04EnvironmentStateController**

- `request_phase(phase: EnvironmentPhase) -> bool`
- `start_weather_weave() -> int`
- `get_phase() -> EnvironmentPhase`
- `debug_get_active_tween_domains() -> Array[StringName]`
- `validate_local_resources() -> bool`

**Level04FinaleController**

- `arm_finale(text_id, exact_text) -> bool`
- `is_armed() -> bool`
- `is_main_text_active() -> bool`
- `debug_force_gate_reevaluation()`

**Level04PortalAdapter**

- `request_activation() -> bool`
- `is_activation_requested() -> bool`
- `is_activation_completed() -> bool`

**Level04RecoveryAnchorZone**

- `get_anchor_id() -> StringName`
- `get_floor_anchor_global_transform() -> Transform3D`
- `set_sensor_enabled(enabled: bool)`
- `debug_reevaluate_overlap()`

**Level04RecoveryController**

- `register_recovery_volume(volume, expected_volume_id) -> bool`
- `register_anchor_zone(zone, expected_anchor_id) -> bool`
- `report_recovery_anchor_reached(anchor_id, source_zone)`
- `get_latest_valid_anchor_id() -> StringName`
- `get_latest_valid_anchor_transform() -> Transform3D`
- `add_suspension_source(source_key)`
- `remove_suspension_source(source_key)`
- `debug_get_registered_volume_ids() -> Array[StringName]`
- `debug_get_registered_anchor_ids() -> Array[StringName]`

## 14. Locked event order and macro progression

### 14.1 Exact puzzle/shard order

For both branches, the order is mandatory:

1. Accept the final unique footprint and latch the puzzle solved state.
2. Emit `puzzle_completed(branch_id)` exactly once.
3. Progress accepts the first terminal as immutable candidate, or records the already-fixed remaining puzzle completion.
4. Progress calls the correct `ShardSlot.reveal_at(FIRST_PASS|REMAINING_PASS)` exactly once when reveal authority is satisfied.
5. ShardSlot runs optional reveal presentation with real-callback/timeout first-terminal-wins.
6. ShardSlot enables visible/monitoring/monitorable/collision state using deferred-safe setters.
7. After one physics frame, ShardSlot verifies effective collectability.
8. ShardSlot emits `shard_available(shard_id)` exactly once.
9. Shared SoulShard emits reward request; ShardSlot re-emits `shard_collection_started(shard_id)`.
10. Shared reward sequence completes and calls the shared collection completion path.
11. Shared SoulShard emits `collected`; ShardSlot re-emits `shard_collected(shard_id)` exactly once.
12. Only `shard_collected` advances macro reward progression.

No macro state may advance on puzzle presentation completion, `shard_available` alone, reward request, overlay start or a timeout pretending the shared reward completed.

### 14.2 Macro state model

| MacroState | Invariant | Only valid forward event |
|---|---|---|
| `CANDIDATE_UNSET` | Both puzzles may progress; no shard reveal authority. | First accepted puzzle terminal. |
| `FIRST_CANDIDATE_CANOPY` | Candidate fixed to CANOPY; request Shard_08 first-pass reveal. | Shard_08 actual availability. |
| `FIRST_CANDIDATE_RIPPLE` | Candidate fixed to RIPPLE; request Shard_09 first-pass reveal. | Shard_09 actual availability. |
| `FIRST_SHARD_AVAILABLE` | Exactly one candidate shard collectable. | Candidate `shard_collected`. |
| `FIRST_REWARD_COMPLETE` | First unique reward committed; remaining branch fixed; request E1 non-blockingly. | Immediate idempotent internal progression. |
| `REMAINING_DEFERRED` | Remaining puzzle may be partial or complete; second shard hidden until exact remaining-zone occupancy. | Remaining complete + correct zone occupied + reveal terminal. |
| `SECOND_SHARD_AVAILABLE` | Exactly one remaining-pass shard collectable; anchor frozen. | Second unique `shard_collected`. |
| `BOTH_REWARDS_COMPLETE` | Request E2 and Weather Weave; finale waits for weave terminal and occupancy. | `weather_weave_terminal` plus FinalTextGate occupancy. |
| `MAIN_TEXT` | Exact text visible; recovery suspended; portal dormant. | Actual `LevelFinaleOverlay.closed`. |
| `EXIT` | Request E3 and shared portal activation once. | No further local macro transition required. |

Candidate race:

- if both puzzle terminals arrive in the same frame, the first callback accepted while `CANDIDATE_UNSET` wins;
- candidate assignment is immutable;
- the losing puzzle may remain complete, but its shard stays deferred;
- first reward collection does not choose or change candidate;
- E1 failure/delay cannot block transition to `REMAINING_DEFERRED`.

### 14.3 Invalid events

Unknown IDs, duplicate terminal callbacks, alternate-anchor requests after reveal start, out-of-order shard events, second-shard attempts before first reward, main-text attempts before both rewards and portal attempts before actual close are ignored safely and produce at most one development warning per validation key.

## 15. Changing Canopy state model

- Expected unique IDs: `CANOPY_TONE_1`, `CANOPY_TONE_2`, `CANOPY_TONE_3`.
- Explicit footprint pairs: C1I/C1R, C2I/C2R, C3I/C3R.
- Each pair maps to one unique target; either route context may complete it once.
- All six physical footprint instances exist; child order and position are not identity authority.
- Dwell: configured Player, grounded through public `is_on_floor()`, continuous 0.45 s.
- Leaving before 0.45 s cancels only the current dwell generation.
- At ready/enable, wait one physics frame and re-evaluate current overlaps.
- Same-frame I/R callbacks for one target yield one completion.
- Local state: 0/3 -> 1/3 -> 2/3 -> 3/3.
- At 3/3, solved latch is set before emitting `puzzle_completed(&"CANOPY")`.
- Optional hints after 20 s and 35 s never own logical completion.
- No reset, wrong order, timer failure, audio dependency, gap or precision input.

## 16. Ripple Conversation state model

- Expected unique IDs: `RIPPLE_MARKER_1`, `RIPPLE_MARKER_2`.
- Explicit footprint pairs: R1I/R1R and R2I/R2R.
- Either route context may complete one marker once.
- Grounded configured-Player dwell is 0.45 s.
- Current-overlap re-evaluation after ready/enable is mandatory.
- Persistent contour request is keyed by marker ID; missing contour presentation cannot block logic.
- Local state: 0/2 -> 1/2 -> 2/2.
- At 2/2, solved latch is set before emitting `puzzle_completed(&"RIPPLE")`.
- Optional hints after 20 s and 35 s never create or reorder completion.
- Water is visual, non-hazardous and not a waiting mechanic.

## 17. Level04ShardSlot and reward lifecycle model

Slot states:

`HIDDEN -> REVEALING -> ENABLE_PENDING -> AVAILABLE -> COLLECTION_STARTED -> COLLECTED`

Packed scene requirement before the first runtime frame:

- child SoulShard `visible = false`;
- `monitoring = false`;
- `monitorable = false`;
- CollisionShape3D disabled;
- interaction prompt hidden.

Rules:

- `prepare_hidden()` is idempotent and may only reassert public/serialized disabled properties;
- `reveal_at()` accepts one AnchorContext while HIDDEN and permanently freezes it;
- alternate context requests after reveal start are rejected;
- reveal target is approximately 0.95 s with a 1.20 s bounded fallback;
- real callback and fallback use generation token plus first-terminal latch;
- collectability is enabled using deferred-safe setters and verified after one physics frame;
- `shard_available` emits only after verification;
- Player standing in the future radius must become interactable without exit/re-entry;
- failure of pre-overlap behavior is a P0 shared-system blocker, not permission to read SoulShard private fields;
- exactly one shared reward lifecycle runs per shard ID;
- macro progression advances only after re-emitted `shard_collected`.

## 18. Environment transition model

`EnvironmentStateRoot` uses the approved ownership hierarchy exactly:

```text
EnvironmentStateRoot (Node3D; no controller script)
├── Level04EnvironmentStateController (Node; `level_04_environment_state_controller.gd`)
├── WorldEnvironment
└── LightingRoot
    ├── WarmSun
    ├── CoolCloudFill
    └── PavilionGuidanceLight
```

Exact controller paths:

- `world_environment_path = ../WorldEnvironment`
- `lighting_root_path = ../LightingRoot`
- `canopy_guidance_path = ../../VFXRoot/RemainingBranchGuidanceRoot/CanopyGuidance`
- `ripple_guidance_path = ../../VFXRoot/RemainingBranchGuidanceRoot/RippleGuidance`
- `weather_weave_vfx_path = ../../VFXRoot/WeatherWeaveVFX`

The controller script is never attached directly to `EnvironmentStateRoot`.

| State | Trigger | Required placeholder presentation | Gameplay rule |
|---|---|---|---|
| E0 | Scene startup | Balanced warm/cool light, light drizzle, readable terrain and both equal branches. | Applied before controls; no route ranking. |
| E1 | First slot-level `shard_collected` accepted | Preserve completed branch feedback; strengthen only the remaining branch guidance; weather stays alive. | Non-blocking. Macro commits `REMAINING_DEFERRED` without awaiting VFX. |
| E2 | Second slot-level `shard_collected` accepted | Combine leaf/ripple/rain motifs in Weather Weave and clarify pavilion approach. | Non-blocking; Weather Weave terminal uses actual callback or guarded 2.5 s fallback. |
| E3 | Actual main-text close | Preserve settled weather and pavilion readability. | Environment owns no PortalAccent and cannot activate/load the portal. |

Environment owns only its own tweens/generations. It never disables Player controls, changes puzzle/shard facts, starts PortalAccentVFX, activates LevelPortal or loads scenes. All optional presentation callbacks race through generation/latch guards, and gameplay-safe fallbacks are owned by the requesting controller.

## 19. Finale, main text and portal model

### 19.1 Finale

- `FinalTextGate` center: `Vector3(0,2,52)`, broad radius 4.5 m.
- Gate occupancy is recorded while unarmed.
- `arm_finale()` waits one physics frame and re-evaluates current overlaps.
- Progress arms finale only after both unique `shard_collected` events and Weather Weave terminal.
- Finale controller validates Player, gate, overlay API and recovery controller.
- It acquires only its own control lock and adds suspension source `main_text`.
- It calls `show_finale_text(exact_text)`.
- A false return or missing API is fail-closed: portal stays dormant, owned lock/suspension are released, and configuration error is emitted.
- Actual overlay `closed` emits `main_text_closed` exactly once.
- No timer may mark unread text complete.

### 19.2 Upgraded shared portal configuration and ownership

```gdscript
target_scene_path = "res://scenes/levels/Level_05.tscn"
entry_mode = LevelPortal.EntryMode.AUTO_ENTER
require_entry_confirmation = false
```

- `PortalFloorAnchor` owns `Vector3(6,2,56.5)`.
- Shared LevelPortal is an identity-local child; do not override shared internal child transforms.
- Level04PortalAdapter owns one activation request, optional local accent, diagnostics and semantic forwarding of actual `activation_completed`.
- Adapter calls shared `activate()` once after actual main-text close.
- Adapter starts its own local accent in parallel; accent completion is not portal success.
- Adapter waits for actual shared `activation_completed`; timeout emits blocker diagnostic only.
- Adapter emits local `portal_activated` only after actual shared completion.
- Adapter never enables InteractionArea directly, fabricates active state, repeats `activate()`, calls private methods or loads a scene.
- Shared LevelPortal exclusively owns overlap filtering, AUTO_ENTER, transition latch and scene loading.
- P0 early-overlap test is mandatory: Player already inside before activation must transition exactly once after actual activation without exit/re-entry.

## 20. Recovery and control-lock model

- Every recovery volume is a passive `Level04RecoveryVolume` with unique `volume_id` and Area3D overlap signals only.
- Volumes do not choose destinations, create tokens, inspect Player position or compute nearest anchors.
- RecoveryController registers explicit volume and RA arrays at startup.
- RecoveryController exclusively owns `fall_event_generation`, current token, active registered-overlap set, recovery latch, pending suspended recovery and rearm.
- First valid configured-Player entry while unlatched creates one token.
- Duplicate body-enter and overlapping volumes share one token and one eventual teleport.
- Latest valid anchor changes only on valid grounded RA zone arrival.
- Recovery teleports to `get_floor_anchor_global_transform()` from the latest valid registered zone.
- Set `Player.velocity = Vector3.ZERO` after recovery.
- Additional transient movement may be cleared only through a proven public Player API; private movement fields are forbidden.
- Recovery is suspended by source keys `shard_reward` and `main_text`.
- If Player exits all registered volumes before suspension ends, pending recovery clears after one physics frame.
- If Player remains invalid/overlapping at unlock, the same token performs one recovery without exit/re-entry.
- After teleport, latch remains closed until one physics frame confirms zero registered overlaps.
- Progress, puzzle and environment state persist through recovery.

# 21. Slice decomposition and execution contracts

## Slice 0 - Full Preflight - Inspection Only

### Slice 0.1 Goal

Refresh repository facts and produce a precise implementation plan without creating any diff. This slice is the only slice that waits for explicit APPLY.

### Slice 0.2 Preconditions

- Access to current repository and pull-request metadata.
- All five approved Level_04 source documents and this reference are available.
- No implementation branch is created before the base decision is reported.

### Slice 0.3 Exact files expected to change

- None. Zero repository diff is mandatory.
- No `.gd.uid`, scene UID, import file or generated file is allowed.

### Slice 0.4 Exact files forbidden to change

- Every repository file is forbidden to change.
- No branch, commit, PR, local runtime file, generated UID or harness is created.

### Slice 0.5 Nodes, scenes and scripts

- Inspect `AGENTS.md` and any nested instructions.
- Inspect current `Level_04.tscn`, `Level_05.tscn` and relevant scene directories.
- Inspect shared Player, Camera, SoulShard, reward, SoulOrb, finale and portal scenes/scripts.
- Inspect current main SHA, active PR stack and overlap with required shared files.
- Inspect current Godot version, renderer, physics backend and parser state.

### Slice 0.6 Methods, signals and contracts

- No runtime API is added.
- Record exact existing public APIs, signals, node groups and packed-scene structure.
- Record exact base branch/SHA decision and any approved dependency.

### Slice 0.7 Implementation steps

- Read all instructions and source authorities.
- Record `main` SHA and list every active PR with base/head SHA and touched shared files.
- Compare current shared contracts against this reference.
- Inspect current placeholder and confirm replacement boundary.
- Enumerate exact expected files for Slices 1-11 and files that must remain untouched.
- Run clean-status check and prove zero diff.
- Write the preflight handoff and stop.

### Slice 0.8 Automated or static checks

- Repository status is clean.
- Godot project parser baseline is recorded without changing files.
- No untracked files created in worktree.
- Expected file/UID whitelist is complete.
- Active-PR overlap analysis is explicit.

### Slice 0.9 Manual runtime checks

- No runtime playtest required.
- Opening the existing placeholder for observation is allowed only if it produces no saved/import churn; revert any editor-generated changes before handoff.

### Slice 0.10 Acceptance criteria

- Zero diff.
- Exact current main SHA recorded.
- Active PR stack recorded.
- Shared APIs classified PASS / BLOCKER / NOT VERIFIED.
- Exact base decision recorded.
- No unresolved conflict.
- Handoff ends exactly `WAITING FOR APPLY`.

### Slice 0.11 Rollback plan

- No rollback needed because no changes are allowed.
- Delete any accidental temporary files and restore clean status before handoff.

### Slice 0.12 Risks

- Stale approved repository snapshot.
- Active PR changes a shared contract.
- Godot editor creates unrelated import churn.
- Private API temptation when a public contract differs.

### Slice 0.13 Out of scope

- Any runtime scene/script implementation.
- Branch or PR creation.
- Documentation redesign.

### Slice 0.14 Handoff format

- Slice: 0 - Full Preflight.
- Status: PASS / BLOCKED.
- Commit SHA: N/A.
- Branch: N/A.
- Repository main SHA and active PR table.
- Shared API findings and exact base decision.
- Diff proof: zero files changed.
- Final line: `WAITING FOR APPLY`.

## Slice 1 - Scene Shell and Static Braided Spatial Greybox

### Slice 1.1 Goal

Replace the one-room placeholder with the complete primitive-only static spatial shell while adding no progression, puzzle or reward logic.

### Slice 1.2 Preconditions

- Slice 0 PASS with zero diff and exact approved base SHA recorded.
- Explicit APPLY received.
- Clean status and approved base SHA reconfirmed after APPLY.
- `feature/implement-level-04-greybox` created from the exact approved base, switched to, and current branch/HEAD verified before any write.
- If an approved stacked prerequisite is required, the branch was created from its exact approved head and the dependency recorded.
- Implementation directly on `main` is forbidden.
- Current Level_04 replacement boundary confirmed.

### Slice 1.3 Exact literal file scope

| Authority | Exact path / rule |
|---|---|
| CREATE | `scenes/levels/level_04/blocks/Block_04_00_Arrival.tscn` |
| CREATE | `scenes/levels/level_04/blocks/Block_04_01_CrossingTree.tscn` |
| CREATE | `scenes/levels/level_04/blocks/Block_04_02_ChangingCanopy.tscn` |
| CREATE | `scenes/levels/level_04/blocks/Block_04_03_BraidedCrossing.tscn` |
| CREATE | `scenes/levels/level_04/blocks/Block_04_04_RippleConversation.tscn` |
| CREATE | `scenes/levels/level_04/blocks/Block_04_05_WeatherWeave.tscn` |
| CREATE | `scenes/levels/level_04/blocks/Block_04_06_FinalPavilion.tscn` |
| MODIFY | `scenes/levels/Level_04.tscn` |
| READ ONLY | `AGENTS.md` |
| READ ONLY | `project.godot` |
| READ ONLY | `scenes/core/Player.tscn` |
| READ ONLY | `scripts/player/player_controller.gd` |
| READ ONLY | `scripts/player/camera_controller.gd` |
| READ ONLY | `scenes/levels/Level_05.tscn` |
| MATCHING `.gd.uid` | None. |
| FORBIDDEN | Every repository file not listed above for CREATE or MODIFY; every unrelated `.gd.uid`, scene UID, `.import`, generated/cache file; every temporary harness; `project.godot`; shared systems; other levels; final assets. |

No wildcard grants write authority. A defect requiring any other path must stop the slice and reopen the owning slice or use a separately approved explicit defect-fix whitelist.

### Slice 1.5 Nodes, scenes and scripts

- EnvironmentRoot with seven block scenes and Boundaries.
- Primitive floors, ramps, visible route rims and simple collision.
- Arrival, Crossing Tree, both branch terraces, both crossing lanes, Weather Weave and Pavilion.
- PlayerRoot, CameraRoot and placeholder sockets for Gameplay/VFX/Runtime/UI layers, without scripts.

### Slice 1.6 Methods, signals and contracts

- No gameplay methods or signals.
- Existing shared Player and camera are instantiated only for traversal proof.
- No `LevelManager` or PoemRewardUI in new composition.

### Slice 1.7 Implementation steps

1. Reconfirm clean status and exact Slice 0 approved base SHA after APPLY.
2. Create and switch to `feature/implement-level-04-greybox` from that exact base; verify branch name and HEAD; record both for handoff.
3. Build blocks around exact anchors and route centerlines.
4. Maintain 5.5 m minimum path width and all widening/clearance rules.
5. Create physically separate initial and remaining branch terraces.
6. Build UC at Y=4 and LC at Y=0 with no junction and 3.4 m minimum lower clearance.
7. Block every unintended pavilion bypass and lane-switch climb using visible primitive geometry plus simple boundaries.
8. Add primitive zone labels/debug materials that do not imply final art.
9. Place PlayerFloorSpawnMarker at exact floor anchor; runtime root Y remains provisional until Slice 2.
10. Keep portal as an inactive socket/marker only.



### Slice 1.8 Automated or static checks

- All changed scenes parse.
- No external art/GLB dependencies.
- Static coordinate audit for O/T/W/P/PR and all route anchors.
- Minimum widths/clearances encoded in scene data or documented measurements.
- No LevelManager/PoemRewardUI references.
- Changed-file whitelist exact.

### Slice 1.9 Manual runtime checks

- Walk all legal surfaces in both route directions.
- Attempt direct Arrival/Tree-to-Pavilion bypass.
- Attempt UC/LC lane switch by jumping, edge climbing and camera collision.
- Check CP0-CP9 composition with primitives.
- Check route width and no precision jumps.

### Slice 1.10 Acceptance criteria

- Level opens and Player can traverse every intended surface.
- Static topology supports both approved sequences.
- No same-level crossing junction or pavilion bypass.
- No mandatory jump/gap.
- Camera does not clip severely at crossing.
- No puzzle, shard, environment or finale logic exists yet.
- G1 PASS.

### Slice 1.11 Rollback plan

- Revert Slice 1 commit only.
- Restore placeholder from base if topology cannot be corrected inside approved coordinates.
- Do not compensate with invisible gates or runtime teleport logic.

### Slice 1.12 Risks

- False shortcut through crossing.
- Initial and remaining terraces accidentally connect.
- Slope/step values break shared Player grounding.
- Oversized block scenes obscure exact coordinate authority.

### Slice 1.13 Out of scope

- Recovery logic.
- Puzzles and shards.
- Final lighting, materials, water, fog and particles.
- Portal activation.

### Slice 1.14 Handoff format

- Branch creation proof: `feature/implement-level-04-greybox`, approved base SHA, current HEAD and clean pre-write status.
- Slice number/title and PASS/BLOCKED.
- Commit SHA and branch.
- Changed files.
- Coordinate and topology evidence.
- Manual route results for Sequence A and B shell.
- Risks and NOT VERIFIED items.
- Automatic continuation to Slice 2 on PASS.

## Slice 2 - Spawn Grounding, Recovery Anchors and Explicit Fall Recovery

### Slice 2.1 Goal

Prove shared Player floor-contact semantics, freeze evidence-derived root-Y values and implement explicit no-softlock fall recovery without touching private movement state.

### Slice 2.2 Preconditions

- Slice 1 and G1 PASS.
- Shared Player public movement/grounding APIs verified in Slice 0.
- Spatial shell collisions stable enough for grounded tests.

### Slice 2.3 Exact literal file scope

| Authority | Exact path / rule |
|---|---|
| CREATE | `scenes/levels/level_04/gameplay/Level04RecoveryAnchorZone.tscn` |
| CREATE | `scenes/levels/level_04/gameplay/Level04RecoveryVolume.tscn` |
| CREATE | `scripts/levels/level_04/level_04_recovery_anchor_zone.gd` |
| CREATE | `scripts/levels/level_04/level_04_recovery_volume.gd` |
| CREATE | `scripts/levels/level_04/level_04_recovery_controller.gd` |
| MODIFY | `scenes/levels/Level_04.tscn` |
| READ ONLY | `scenes/core/Player.tscn` |
| READ ONLY | `scripts/player/player_controller.gd` |
| READ ONLY | `scripts/player/camera_controller.gd` |
| MATCHING `.gd.uid` | `scripts/levels/level_04/level_04_recovery_anchor_zone.gd.uid` - permitted only when its exact sibling `.gd` is created or modified by this slice. |
| MATCHING `.gd.uid` | `scripts/levels/level_04/level_04_recovery_volume.gd.uid` - permitted only when its exact sibling `.gd` is created or modified by this slice. |
| MATCHING `.gd.uid` | `scripts/levels/level_04/level_04_recovery_controller.gd.uid` - permitted only when its exact sibling `.gd` is created or modified by this slice. |
| FORBIDDEN | Every repository file not listed above for CREATE or MODIFY; every unrelated `.gd.uid`, scene UID, `.import`, generated/cache file; every temporary harness; `project.godot`; shared systems; other levels; final assets. |

No wildcard grants write authority. A defect requiring any other path must stop the slice and reopen the owning slice or use a separately approved explicit defect-fix whitelist.

### Slice 2.5 Nodes, scenes and scripts

- PlayerFloorSpawnMarker and shared Player.
- `SafetyRoot/RecoveryVolumes/SoftReturnVolume` plus `AuthoredOutOfBoundsVolumes/OOB_WestPerimeter`, `OOB_EastPerimeter`, `OOB_SouthPerimeter`, `OOB_NorthPerimeter` exactly as Section 8.8.
- SafetyRoot/RecoveryAnchors with RA0-RA11.
- Level04RecoveryController under LevelRuntimeRoot.

### Slice 2.6 Methods, signals and contracts

- `recovery_anchor_reached(anchor_id)` and `recovery_performed(anchor_id, volume_id)`.
- Explicit registration APIs and source-bound Area3D handlers.
- `add_suspension_source()` / `remove_suspension_source()`.
- `Player.velocity = Vector3.ZERO` after recovery.
- No private step-climb, floor or movement field access.

### Slice 2.7 Implementation steps

1. Measure actual Player root Y for spawn and each RA floor anchor under shared CharacterBody grounding and floor-snap behavior.
2. Set each RA root to the exact approved floor coordinate; keep FloorAnchor identity-local.
3. Implement grounded ArrivalZone generation and one-physics-frame current-overlap reevaluation.
4. Instantiate exactly the five recovery volumes from Section 8.8 with exact node names, IDs, parents, BoxShape3D transforms and extents. `OOB_SouthPerimeter` must use `Vector3(0.00, 1.00, -65.00)`, `Vector3(0,0,0)` and `Vector3(39.00, 10.00, 4.00)`.
5. Serialize the exact five owner-relative volume paths and all 12 RA paths on RecoveryController; validate exact registry equality and reject every noncanonical south-perimeter center.
6. Implement internally owned fall token, active overlap set, latch, pending suspension and one-frame rearm.
7. Use latest valid registered RA transform as destination.
8. Apply `Player.velocity = Vector3.ZERO` after recovery. Clear additional transient movement only through a proven public Player API; otherwise stop for a separately approved narrow shared prerequisite.
9. Prove analytically and at runtime that no recovery volume overlaps any legal side space, shallow water, shard alcove, pavilion overlook, either Braided Crossing lane, mandatory shoulder or camera corridor. For `OOB_SouthPerimeter`, calculate the actual Arrival south edge as `-54.00 - 5.00 = -59.00`, calculate the recovery inner face as `-65.00 + 4.00 = -61.00`, prove the exact `2.00 m` separation, reserve the required `1.25 m` shoulder and confirm the residual `0.75 m` current-Player-collider allowance.
10. Confirm that legal Arrival movement cannot overlap `OOB_SouthPerimeter`, that falls before the perimeter remain covered by `SoftReturnVolume`, and that no invisible catch floor was introduced.
11. Freeze proven root-Y values in slice handoff for final summary.

### Slice 2.8 Automated or static checks

- Every exact path resolves to the expected type.
- Exactly 12 canonical RA IDs register once.
- The recovery registry equals the five literal paths and IDs in Section 8.8; no extra, omitted, duplicate, wrong-type or wrong-ID source.
- Every recovery BoxShape3D position, rotation and extent equals Section 8.8; `OOB_SouthPerimeter` is exactly `Vector3(0.00, 1.00, -65.00)`, `Vector3(0,0,0)`, `Vector3(39.00, 10.00, 4.00)`.
- The `OOB_SouthPerimeter` static AABB proof yields legal edge `Z=-59.00`, recovery inner face `Z=-61.00`, exact separation `2.00 m`, shoulder `1.25 m`, residual collider allowance `0.75 m` and PASS.
- Analytic AABB exclusions cover all required legal-space categories; the planning-envelope minimum `Z=-58.00` is never used as the sole south-recovery exclusion boundary.
- No nearest-anchor scan, wildcard discovery or per-frame world search.
- No private Player field names.
- Scene parser/startup clean.
- UID whitelist exact.

### Slice 2.9 Manual runtime checks

- Repeated fresh loads: grounded stable spawn with no oscillation.
- Walk through RA0-RA11 and verify exact latest anchor.
- Inspect all five recovery volumes in Remote SceneTree and compare IDs/transforms/extents to Section 8.8; explicitly confirm `OOB_SouthPerimeter` center `Z=-65.00` and inner face `Z=-61.00`.
- Walk the full legal Arrival floor through nominal south edge `Z=-59.00`, the required `1.25 m` shoulder envelope and the current Player-collider allowance: no recovery.
- Walk every legal side space, shallow-water area, shard alcove, pavilion overlook, both crossing lanes, mandatory shoulder and camera corridor: no recovery.
- Fall south of Arrival before reaching `Z=-61.00` and confirm `SoftReturnVolume` still recovers the Player.
- Cross the corrected south perimeter only after leaving legal Arrival space and verify `RV_OOB_SOUTH_PERIMETER`.
- Fall from every route family into SoftReturnVolume.
- Bypass each other exterior perimeter boundary and verify its exact OOB volume.
- Duplicate body-enter and intentional exterior-corner overlap tests.
- Enter during suspension simulation, leave before unlock, remain through unlock and test rearm.
- Recover after step traversal and confirm `Player.velocity == Vector3.ZERO`; any additional stale motion must be cleared only by a proven public API.

### Slice 2.10 Acceptance criteria

- Stable grounded spawn.
- All RA roots preserve approved coordinates and proven Player root-Y values are recorded.
- Exact five-volume registry and transforms PASS, including `OOB_SouthPerimeter = Vector3(0.00, 1.00, -65.00)` with inner face `Z=-61.00`.
- The actual Arrival-floor AABB proof PASS: legal south edge `Z=-59.00`, recovery inner face `Z=-61.00`, separation `2.00 m`, required shoulder `1.25 m`, residual current-Player-collider allowance `0.75 m`.
- Legal Arrival movement cannot overlap the south recovery volume; a fall before the perimeter is recovered by `SoftReturnVolume`; no invisible catch floor exists.
- Zero overlap with every required legal-space exclusion.
- One teleport maximum per fall event, including intentional exterior-corner overlap.
- Progress-neutral recovery.
- No false recovery in legal space.
- `Player.velocity = Vector3.ZERO` after recovery; if additional stale motion cannot be cleared publicly, hard stop for a narrow shared prerequisite.
- G2 PASS.

### Slice 2.11 Rollback plan

- Revert Slice 2 commit.
- Keep accepted Slice 1 shell.
- Do not replace explicit recovery with hidden catch floor or global teleport.

### Slice 2.12 Risks

- Shared Player floor snap differs from expectation.
- Destination remains inside recovery volume.
- South perimeter is positioned from the planning envelope instead of the actual Arrival floor bound, causing false recovery at the legal floor edge.
- Overlapping volumes create duplicate teleports.
- Private-state dependency is required.

### Slice 2.13 Out of scope

- Puzzle progress.
- Shard reward locks beyond test stubs.
- Finale and portal.
- Generic stuck detection.

### Slice 2.14 Handoff format

- Commit SHA and changed files.
- Proven spawn and RA root-Y evidence.
- RA/volume registry evidence.
- Fall/rearm manual matrix.
- Shared blocker status.
- Automatic continuation to Slice 3 on PASS.

## Slice 3 - Macro Progress Shell, Staged Dependency Mode and E0 Environment Root

### Slice 3.1 Goal

Create the authoritative ten-state macro shell, immutable first-terminal candidate arbitration, the exact `STAGED_SLICE_3` dependency mode, approved E0 environment hierarchy and controlled diagnostics without implementing puzzle completion, shard availability, finale or portal behavior.

### Slice 3.2 Preconditions

- Slice 2 and G2 PASS.
- Exact NodePath owners confirmed.
- Recovery controller and shared reward controller available.
- The exact future final paths for puzzle controllers, shard slots, remaining zones, finale and portal are reserved but not yet instantiated.

### Slice 3.3 Exact literal file scope

| Authority | Exact path / rule |
|---|---|
| CREATE | `scripts/levels/level_04/level_04_progress_controller.gd` |
| CREATE | `scripts/levels/level_04/level_04_environment_state_controller.gd` |
| CREATE | `scenes/levels/level_04/vfx/L04_VFX_RainThreads.tscn` |
| CREATE | `scenes/levels/level_04/vfx/L04_VFX_CloudShadow.tscn` |
| MODIFY | `scenes/levels/Level_04.tscn` |
| READ ONLY | `scripts/levels/level_04/level_04_recovery_controller.gd` |
| READ ONLY | `scenes/core/ShardRewardSequenceController.tscn` |
| READ ONLY | `scripts/core/shard_reward_sequence_controller.gd` |
| MATCHING `.gd.uid` | `scripts/levels/level_04/level_04_progress_controller.gd.uid` - permitted only when its exact sibling `.gd` is created or modified by this slice. |
| MATCHING `.gd.uid` | `scripts/levels/level_04/level_04_environment_state_controller.gd.uid` - permitted only when its exact sibling `.gd` is created or modified by this slice. |
| FORBIDDEN | Every repository file not listed above for CREATE or MODIFY; every unrelated `.gd.uid`, scene UID, `.import`, generated/cache file; every temporary harness; `project.godot`; shared systems; other levels; final assets. |

No wildcard grants write authority. A defect requiring any other path must stop the slice and reopen the owning slice or use a separately approved explicit defect-fix whitelist.

### Slice 3.5 Nodes, scenes and scripts

- `Level04ProgressController` under LevelRuntimeRoot with `configuration_mode = ConfigurationMode.STAGED_SLICE_3`.
- `EnvironmentStateRoot` Node3D with no controller script.
- Child `Level04EnvironmentStateController` Node owning `level_04_environment_state_controller.gd`.
- Sibling `WorldEnvironment` and `LightingRoot/WarmSun`, `CoolCloudFill`, `PavilionGuidanceLight`.
- Exact E0 placeholder scenes `L04_VFX_RainThreads.tscn` and `L04_VFX_CloudShadow.tscn` under VFXRoot.
- Deliberately unresolved final dependencies remain absent rather than being invented as untyped nodes.

### Slice 3.6 Methods, signals and contracts

- `enum ConfigurationMode { STAGED_SLICE_3, PRODUCTION }` and exported `configuration_mode`.
- `report_puzzle_completed(branch_id: StringName) -> bool` is the single production candidate-arbitration entry point used by later puzzle controllers and Slice 3 tests.
- `validate_available_dependencies() -> bool` validates every dependency currently owned by completed slices.
- `validate_production_configuration() -> bool` validates every final path/type/ID and is mandatory at G10/final acceptance.
- MacroState enum with ten exact states, candidate/remaining accessors and debug snapshot.
- `request_phase()` idempotent semantic environment handling.
- In staged mode, only the exact absent dependencies named in Section 12.1 may be reported as deliberately unresolved; all present dependencies remain fail-closed.

### Slice 3.7 Implementation steps

1. Create `ConfigurationMode`, ten canonical macro states and canonical ID validation.
2. Attach Progress with `STAGED_SLICE_3` and implement one controlled staged diagnostic for the exact future dependencies named in Section 12.1.
3. Implement first-terminal-wins candidate arbitration only in `report_puzzle_completed(branch_id: StringName) -> bool`; reject unknown/duplicate branches and never add a debug-only alternative.
4. Create `EnvironmentStateRoot` with dedicated child `Level04EnvironmentStateController`, sibling `WorldEnvironment` and `LightingRoot`; do not attach the controller script to the root.
5. Configure exact environment NodePaths: `../WorldEnvironment`, `../LightingRoot`, both `../../VFXRoot/RemainingBranchGuidanceRoot/...` paths and `../../VFXRoot/WeatherWeaveVFX`.
6. Create exact E0 RainThreads and CloudShadow placeholder scenes and local/deep-duplicate environment resources.
7. Implement `validate_available_dependencies()` and prove clean scene load with no uncontrolled configuration errors.
8. Do not reveal shards or synthesize missing controllers; store only authoritative macro facts and diagnostics.
9. Verify environment transitions do not lock Player controls.

### Slice 3.8 Automated or static checks

- Unknown/duplicate branch events rejected.
- CANOPY then RIPPLE keeps CANOPY; reverse keeps RIPPLE.
- Same-frame ordered callback harness calls `report_puzzle_completed(branch_id: StringName) -> bool` and proves first accepted wins.
- `STAGED_SLICE_3` permits only the exact deliberately unresolved dependencies and emits one controlled diagnostic.
- All present Slice 3 dependencies validate fail-closed.
- Environment controller is a child node, not a root script; all exact environment paths resolve.
- E0 resources are local/deep duplicated.
- No PortalAccentVFX path in environment controller.
- No global scans.
- Parser/startup clean.

### Slice 3.9 Manual runtime checks

- Load fresh scene and inspect `CANDIDATE_UNSET`, E0 and the single controlled staged diagnostic.
- Use an external/noncommitted harness or debugger to call the production `report_puzzle_completed(branch_id: StringName) -> bool` in both orders.
- Confirm immutable candidate, no shard/finale/portal activation and no uncontrolled missing-path errors.
- Confirm EnvironmentStateRoot hierarchy and exact NodePaths in Remote SceneTree.
- Confirm Player movement remains enabled.

### Slice 3.10 Acceptance criteria

- Canonical state shell stable and candidate immutable through the production entry point.
- Slice 3 scene loads without uncontrolled configuration errors.
- Staged mode is explicit, narrow and observable; final startup validation is not disabled.
- Approved EnvironmentStateRoot hierarchy and exact paths PASS.
- E0 visually neutral and both branch entrances readable.
- No premature reveal, finale, portal or environment gating.
- G3 PASS.

### Slice 3.11 Rollback plan

- Revert Slice 3 commit.
- Preserve accepted spatial/recovery slices.
- Do not collapse state into blind counters.

### Slice 3.12 Risks

- Premature references to scenes not created yet.
- Environment resource mutation leaks to other levels.
- Candidate accidentally tied to reward order.

### Slice 3.13 Out of scope

- Actual puzzle footprints.
- Shard slots and reward UI.
- E1-E3 presentation.
- Finale and portal.

### Slice 3.14 Handoff format

- State-transition test evidence.
- Environment locality evidence.
- Commit SHA and changed files.
- Automatic continuation to Slice 4 on PASS.

## Slice 4 - Changing Canopy Puzzle

### Slice 4.1 Goal

Implement the three-target any-order Canopy mechanic, dual route-context footprints, persistent placeholder feedback and one logical terminal event.

### Slice 4.2 Preconditions

- Slice 3 and G3 PASS.
- Exact Canopy coordinates and Player path verified.
- Presence footprint public contract accepted.

### Slice 4.3 Exact literal file scope

| Authority | Exact path / rule |
|---|---|
| CREATE | `scenes/levels/level_04/gameplay/ChangingCanopyPuzzle.tscn` |
| CREATE | `scenes/levels/level_04/gameplay/Level04PresenceFootprint.tscn` |
| CREATE | `scripts/levels/level_04/changing_canopy_controller.gd` |
| CREATE | `scripts/levels/level_04/level_04_presence_footprint.gd` |
| CREATE | `scenes/levels/level_04/vfx/L04_VFX_CanopyFeedback.tscn` |
| MODIFY | `scenes/levels/Level_04.tscn` |
| MODIFY | `scripts/levels/level_04/level_04_progress_controller.gd` |
| READ ONLY | `scripts/player/player_controller.gd` |
| READ ONLY | `scripts/levels/level_04/level_04_environment_state_controller.gd` |
| MATCHING `.gd.uid` | `scripts/levels/level_04/changing_canopy_controller.gd.uid` - permitted only when its exact sibling `.gd` is created or modified by this slice. |
| MATCHING `.gd.uid` | `scripts/levels/level_04/level_04_presence_footprint.gd.uid` - permitted only when its exact sibling `.gd` is created or modified by this slice. |
| MATCHING `.gd.uid` | `scripts/levels/level_04/level_04_progress_controller.gd.uid` - permitted only when its exact sibling `.gd` is created or modified by this slice. |
| FORBIDDEN | Every repository file not listed above for CREATE or MODIFY; every unrelated `.gd.uid`, scene UID, `.import`, generated/cache file; every temporary harness; `project.godot`; shared systems; other levels; final assets. |

No wildcard grants write authority. A defect requiring any other path must stop the slice and reopen the owning slice or use a separately approved explicit defect-fix whitelist.

### Slice 4.5 Nodes, scenes and scripts

- C1I/C1R, C2I/C2R, C3I/C3R at exact coordinates.
- Three visual markers and simple persistent completion indicators.
- ChangingCanopyController.
- Shared reusable Level04PresenceFootprint.

### Slice 4.6 Methods, signals and contracts

- Typed `RouteContext` INITIAL/REMAINING.
- `presence_accepted()` after 0.45 s grounded dwell.
- `target_completed()` once per ID.
- `puzzle_completed(&"CANOPY")` once after solved latch.
- Hint methods are optional presentation only.

### Slice 4.7 Implementation steps

- Implement exact ID/footprint/context registry.
- Bind every footprint to `../../../../../PlayerRoot/Player`.
- Reject non-Player and airborne bodies.
- Add current-overlap reevaluation after ready/enable.
- Deduplicate by target ID across I/R pair.
- Persist simple primitive feedback.
- Set solved latch before terminal emit.
- Connect terminal to Progress.

### Slice 4.8 Automated or static checks

- Exactly three IDs and two contexts each.
- All six paths resolve to same Player.
- Wrong mapping/context rejected.
- Every target order accepted.
- Same-frame I/R duplicate yields one completion.
- No shard reveal owned by puzzle.
- Parser/startup clean.

### Slice 4.9 Manual runtime checks

- Complete all six target orders using initial footprints.
- Complete using remaining footprints.
- Mix contexts and backtrack.
- Stand inside disabled/enabled footprint without exit/re-entry.
- Test non-Player and airborne overlap.
- Wait for hint thresholds and confirm no logic dependency.

### Slice 4.10 Acceptance criteria

- 3/3 terminal exactly once.
- Solved latch precedes terminal.
- Progress candidate may become CANOPY but no direct shard manipulation by puzzle.
- No reset or softlock.
- G4 PASS.

### Slice 4.11 Rollback plan

- Revert Slice 4 commit.
- Preserve shared footprint only if independently accepted and no Canopy dependency remains; otherwise revert whole slice.

### Slice 4.12 Risks

- Incorrect owner depth in Player path.
- Footprint overlap misses stationary Player.
- Dual-context duplicate completion.
- Presentation callback tied to logic.

### Slice 4.13 Out of scope

- Ripple mechanic.
- Shard slots.
- Final Canopy art or reactive foliage physics.

### Slice 4.14 Handoff format

- Target-order matrix.
- Exact mapping audit.
- Commit SHA and changed files.
- Automatic continuation to Slice 5 on PASS.

## Slice 5 - Ripple Conversation Puzzle

### Slice 5.1 Goal

Implement the two-marker any-order Ripple mechanic, dual route-context footprints, persistent primitive contours and one logical terminal event.

### Slice 5.2 Preconditions

- Slice 4 and G4 PASS.
- Reusable PresenceFootprint accepted.
- Exact shoreline floors and dry footprints stable.

### Slice 5.3 Exact literal file scope

| Authority | Exact path / rule |
|---|---|
| CREATE | `scenes/levels/level_04/gameplay/RippleConversationPuzzle.tscn` |
| CREATE | `scripts/levels/level_04/ripple_conversation_controller.gd` |
| CREATE | `scenes/levels/level_04/vfx/L04_VFX_RippleContours.tscn` |
| MODIFY | `scenes/levels/Level_04.tscn` |
| MODIFY | `scripts/levels/level_04/level_04_progress_controller.gd` |
| READ ONLY | `scenes/levels/level_04/gameplay/Level04PresenceFootprint.tscn` |
| READ ONLY | `scripts/levels/level_04/level_04_presence_footprint.gd` |
| READ ONLY | `scripts/player/player_controller.gd` |
| MATCHING `.gd.uid` | `scripts/levels/level_04/ripple_conversation_controller.gd.uid` - permitted only when its exact sibling `.gd` is created or modified by this slice. |
| MATCHING `.gd.uid` | `scripts/levels/level_04/level_04_progress_controller.gd.uid` - permitted only when its exact sibling `.gd` is created or modified by this slice. |
| FORBIDDEN | Every repository file not listed above for CREATE or MODIFY; every unrelated `.gd.uid`, scene UID, `.import`, generated/cache file; every temporary harness; `project.godot`; shared systems; other levels; final assets. |

No wildcard grants write authority. A defect requiring any other path must stop the slice and reopen the owning slice or use a separately approved explicit defect-fix whitelist.

### Slice 5.5 Nodes, scenes and scripts

- R1I/R1R and R2I/R2R at exact coordinates.
- Two visual markers and persistent contour placeholders.
- RippleConversationController.

### Slice 5.6 Methods, signals and contracts

- Typed RouteContext.
- `marker_completed()` once per ID.
- `puzzle_completed(&"RIPPLE")` once after solved latch.
- Persistent contour requests are presentation only.

### Slice 5.7 Implementation steps

- Create exact marker/footprint registry.
- Bind all footprints to exact shared Player path.
- Reuse 0.45 s grounded/current-overlap contract.
- Deduplicate I/R pair by marker ID.
- Keep contours visible once completed.
- Set solved latch before terminal emit.
- Connect terminal to Progress.

### Slice 5.8 Automated or static checks

- Exactly two IDs and two contexts each.
- Both marker orders accepted.
- Duplicate I/R callbacks ignored.
- No water hazard or waiting timer.
- No shard reveal owned by puzzle.
- Parser/startup clean.

### Slice 5.9 Manual runtime checks

- Complete both orders in initial context.
- Complete both in remaining context.
- Mix route contexts and backtrack.
- Stand inside before enable.
- Test non-Player/airborne rejection.
- Force missing contour callback and confirm logical completion.

### Slice 5.10 Acceptance criteria

- 2/2 terminal exactly once.
- Solved latch precedes terminal.
- Candidate may become RIPPLE but no direct shard manipulation.
- Persistent contours survive travel.
- G5 PASS.

### Slice 5.11 Rollback plan

- Revert Slice 5 commit.
- Retain accepted shared PresenceFootprint from Slice 4.

### Slice 5.12 Risks

- Water geometry obscures footprint.
- Contour presentation races logic.
- Marker mapping inferred from node order.

### Slice 5.13 Out of scope

- Shard/reward integration.
- Final water shader/simulation.
- Audio cues.

### Slice 5.14 Handoff format

- Marker-order and context matrix.
- Commit SHA and changed files.
- Automatic continuation to Slice 6 on PASS.

## Slice 6 - Dual-Anchor Shard Slots and First Reward Path

### Slice 6.1 Goal

Implement packed-hidden Shard_08/Shard_09 slots, candidate first-pass reveal, verified collectability and shared reward lifecycle through first reward completion.

### Slice 6.2 Preconditions

- Slices 4-5 and G5 PASS.
- Shared SoulShard and reward APIs revalidated.
- Exactly one SoulOrb_Follow can be instantiated and found.

### Slice 6.3 Exact literal file scope

| Authority | Exact path / rule |
|---|---|
| CREATE | `scenes/levels/level_04/gameplay/Level04ShardSlot.tscn` |
| CREATE | `scripts/levels/level_04/level_04_shard_slot.gd` |
| MODIFY | `scenes/levels/Level_04.tscn` |
| MODIFY | `scripts/levels/level_04/level_04_progress_controller.gd` |
| READ ONLY | `scenes/core/SoulShard.tscn` |
| READ ONLY | `scripts/soul/soul_shard.gd` |
| READ ONLY | `scenes/core/ShardRewardSequenceController.tscn` |
| READ ONLY | `scripts/core/shard_reward_sequence_controller.gd` |
| READ ONLY | `scenes/ui/ShardRewardOverlay.tscn` |
| MATCHING `.gd.uid` | `scripts/levels/level_04/level_04_shard_slot.gd.uid` - permitted only when its exact sibling `.gd` is created or modified by this slice. |
| MATCHING `.gd.uid` | `scripts/levels/level_04/level_04_progress_controller.gd.uid` - permitted only when its exact sibling `.gd` is created or modified by this slice. |
| FORBIDDEN | Every repository file not listed above for CREATE or MODIFY; every unrelated `.gd.uid`, scene UID, `.import`, generated/cache file; every temporary harness; `project.godot`; shared systems; other levels; final assets. |

No wildcard grants write authority. A defect requiring any other path must stop the slice and reopen the owning slice or use a separately approved explicit defect-fix whitelist.

### Slice 6.5 Nodes, scenes and scripts

- ShardSlot_08 and ShardSlot_09 with exact dual anchors.
- Shared SoulShard child in packed disabled state.
- Shared ShardRewardSequenceController, ShardRewardOverlay and SoulOrb_Follow wiring.
- Recovery suspension source `shard_reward`.

### Slice 6.6 Methods, signals and contracts

- SlotState and AnchorContext.
- `reveal_at()`, `shard_available`, `shard_collection_started`, `shard_collected`.
- Progress first-candidate -> first availability -> first reward complete.
- E1 request issued after reward commit but not awaited.

### Slice 6.7 Implementation steps

- Create slot packed hidden state.
- Set exact IDs/texts and both anchors.
- Implement reveal generation/terminal latch.
- Deferred-enable shard and verify collectability after physics frame.
- Register child shards with shared reward controller.
- Re-emit semantic child lifecycle signals.
- Wire candidate first-pass reveal only.
- On candidate shard_collected commit first reward, fix remaining branch, request E1 and enter REMAINING_DEFERRED without waiting.
- Wire recovery suspension start/end.

### Slice 6.8 Automated or static checks

- No child private-field access.
- Only candidate slot reveal request occurs.
- Opposite complete early remains hidden.
- Exact texts/IDs serialized.
- Exactly one visible SoulOrb_Follow and orb visual.
- Duplicate slot signals ignored.
- UID whitelist and parser clean.

### Slice 6.9 Manual runtime checks

- Canopy-first first-pass reward.
- Ripple-first first-pass reward.
- Both puzzles complete before collection; only candidate shard active.
- Stand inside future shard radius before reveal and remain stationary.
- Leave candidate shard uncollected and explore crossing/backtrack.
- Force E1 failure and confirm REMAINING_DEFERRED.
- Verify normal orb return and absorb pulse.

### Slice 6.10 Acceptance criteria

- Candidate first-pass shard becomes collectable exactly once.
- Pre-overlap works without exit/re-entry.
- Opposite shard hidden.
- First reward advances only on shared `shard_collected`.
- Remaining branch fixed correctly.
- P0 shard availability gate PASS.
- G6 PASS.

### Slice 6.11 Rollback plan

- Revert Slice 6 commit.
- Preserve accepted puzzle slices.
- If pre-overlap fails because shared API is insufficient, stop for separately approved narrow shared prerequisite.

### Slice 6.12 Risks

- Shared overlap cache cannot refresh publicly.
- Reward controller searches wrong root.
- Duplicate orb or missing normal return.
- Anchor migration after reveal start.

### Slice 6.13 Out of scope

- Second shard reveal.
- Weather Weave/finale/portal.
- Final shard VFX.

### Slice 6.14 Handoff format

- Both first-order reward traces.
- Pre-overlap P0 evidence.
- SoulOrb normal-return evidence.
- Commit SHA and changed files.
- Automatic continuation to Slice 7 on PASS.

## Slice 7 - Remaining-Branch Authority and Second Reward

### Slice 7.1 Goal

Complete either-order progression by implementing remaining-zone occupancy, deferred second reveal and second unique reward without replay requirements or false shortcuts.

### Slice 7.2 Preconditions

- Slice 6 and G6 PASS.
- Both first-order reward paths proven.
- Static crossing topology still valid.

### Slice 7.3 Exact literal file scope

| Authority | Exact path / rule |
|---|---|
| CREATE | `scenes/levels/level_04/vfx/L04_VFX_RemainingGuidance.tscn` |
| MODIFY | `scenes/levels/Level_04.tscn` |
| MODIFY | `scripts/levels/level_04/level_04_progress_controller.gd` |
| MODIFY | `scripts/levels/level_04/level_04_environment_state_controller.gd` |
| READ ONLY | `scripts/levels/level_04/changing_canopy_controller.gd` |
| READ ONLY | `scripts/levels/level_04/ripple_conversation_controller.gd` |
| READ ONLY | `scripts/levels/level_04/level_04_shard_slot.gd` |
| MATCHING `.gd.uid` | `scripts/levels/level_04/level_04_progress_controller.gd.uid` - permitted only when its exact sibling `.gd` is created or modified by this slice. |
| MATCHING `.gd.uid` | `scripts/levels/level_04/level_04_environment_state_controller.gd.uid` - permitted only when its exact sibling `.gd` is created or modified by this slice. |
| FORBIDDEN | Every repository file not listed above for CREATE or MODIFY; every unrelated `.gd.uid`, scene UID, `.import`, generated/cache file; every temporary harness; `project.godot`; shared systems; other levels; final assets. |

No wildcard grants write authority. A defect requiring any other path must stop the slice and reopen the owning slice or use a separately approved explicit defect-fix whitelist.

### Slice 7.5 Nodes, scenes and scripts

- CanopyRemainingShardZone and RippleRemainingShardZone.
- Progress remaining-branch eligibility logic.
- Existing puzzle completion accessors and shard slots.

### Slice 7.6 Methods, signals and contracts

- `report_remaining_zone_presence(branch_id, inside)`.
- Eligibility requires fixed remaining branch + puzzle complete + exact zone occupied.
- Current-overlap reevaluation when entering state/arming zone.
- Second `shard_collected` -> BOTH_REWARDS_COMPLETE.

### Slice 7.7 Implementation steps

- Create broad remaining shard zones at exact route contexts.
- Track occupancy even when not yet eligible.
- Reevaluate when first reward completes, zone state changes or remaining puzzle completes.
- Reveal only remaining branch slot at REMAINING_PASS anchor.
- If puzzle already complete, reveal on exact zone occupancy without replay.
- If Player waits in zone while final target completes, reveal without exit/re-entry.
- Commit second reward only on unique `shard_collected`.

### Slice 7.8 Automated or static checks

- A->B and B->A eligibility matrices.
- Wrong branch zone cannot reveal.
- First-pass anchor cannot reactivate.
- At most one active instance per canonical shard.
- Duplicate occupancy/terminal events idempotent.
- No direct position inference.
- Parser/startup clean.

### Slice 7.9 Manual runtime checks

- Sequence A complete through second reward.
- Sequence B complete through second reward.
- Opposite puzzle complete before first reward.
- Enter remaining zone early while puzzle partial, complete final target while staying inside.
- Backtrack repeatedly across crossing.
- Recover on each side and verify eligibility preserved.

### Slice 7.10 Acceptance criteria

- Both orders reach BOTH_REWARDS_COMPLETE.
- No puzzle replay required.
- Second anchor correct and immutable.
- No shortcut permits finale before two rewards.
- Order time/path parity remains acceptable.
- G7 PASS.

### Slice 7.11 Rollback plan

- Revert Slice 7 commit.
- First reward path remains playable but level is intentionally incomplete until fix.

### Slice 7.12 Risks

- Remaining zone overlaps wrong terrace.
- Current occupancy not reevaluated.
- Candidate or remaining branch mutates.
- Static geometry allows pavilion bypass.

### Slice 7.13 Out of scope

- Environment E2 presentation.
- Main text and portal.
- Final route polish.

### Slice 7.14 Handoff format

- Both full branch-order traces through second reward.
- Zone/anchor evidence.
- Commit SHA and changed files.
- Automatic continuation to Slice 8 on PASS.

## Slice 8 - Environment E1-E3 and Weather Weave

### Slice 8.1 Goal

Implement non-blocking semantic environment progression, remaining-branch guidance and bounded Weather Weave terminal without changing gameplay authority.

### Slice 8.2 Preconditions

- Slice 7 and G7 PASS.
- Approved `EnvironmentStateRoot/Level04EnvironmentStateController` hierarchy and exact paths accepted from Slice 3.
- Both reward orders reach BOTH_REWARDS_COMPLETE.
- Progress remains in staged mode only for still-absent finale/portal dependencies; all environment dependencies must validate.

### Slice 8.3 Exact literal file scope

| Authority | Exact path / rule |
|---|---|
| CREATE | `scenes/levels/level_04/vfx/L04_VFX_WeatherWeave.tscn` |
| MODIFY | `scenes/levels/Level_04.tscn` |
| MODIFY | `scripts/levels/level_04/level_04_progress_controller.gd` |
| MODIFY | `scripts/levels/level_04/level_04_environment_state_controller.gd` |
| MODIFY | `scenes/levels/level_04/vfx/L04_VFX_RainThreads.tscn` |
| MODIFY | `scenes/levels/level_04/vfx/L04_VFX_CloudShadow.tscn` |
| MODIFY | `scenes/levels/level_04/vfx/L04_VFX_RemainingGuidance.tscn` |
| READ ONLY | `scripts/levels/level_04/level_04_shard_slot.gd` |
| READ ONLY | `scripts/levels/level_04/level_04_recovery_controller.gd` |
| MATCHING `.gd.uid` | `scripts/levels/level_04/level_04_progress_controller.gd.uid` - permitted only when its exact sibling `.gd` is created or modified by this slice. |
| MATCHING `.gd.uid` | `scripts/levels/level_04/level_04_environment_state_controller.gd.uid` - permitted only when its exact sibling `.gd` is created or modified by this slice. |
| FORBIDDEN | Every repository file not listed above for CREATE or MODIFY; every unrelated `.gd.uid`, scene UID, `.import`, generated/cache file; every temporary harness; `project.godot`; shared systems; other levels; final assets. |

No wildcard grants write authority. A defect requiring any other path must stop the slice and reopen the owning slice or use a separately approved explicit defect-fix whitelist.

### Slice 8.5 Nodes, scenes and scripts

- `EnvironmentStateRoot` with dedicated child `Level04EnvironmentStateController`, sibling WorldEnvironment and LightingRoot.
- Exact `NaturalWeatherRoot`, `RemainingBranchGuidanceRoot/CanopyGuidance`, `RemainingBranchGuidanceRoot/RippleGuidance` and `WeatherWeaveVFX` paths.
- Exact placeholder scenes listed in Slice 8 file scope.
- No PortalAccentVFX ownership or path in environment controller.

### Slice 8.6 Methods, signals and contracts

- `request_phase()` monotonic/idempotent.
- `start_weather_weave()` generation token.
- `weather_weave_terminal(source)` first-terminal-wins.
- E1 failure cannot block macro progression.

### Slice 8.7 Implementation steps

1. Revalidate the dedicated controller-child hierarchy and all five exact environment NodePaths.
2. Complete neutral E0 placeholders if required within the exact MODIFY list.
3. Implement E1 Canopy-first/Ripple-first local guidance only through the exact guidance nodes.
4. Preserve completed branch feedback.
5. Implement E2 Weather Weave placeholder and pavilion guidance.
6. Implement 2.5 s controller-owned fallback and generation/latch race protection.
7. Implement E3 weather preservation only.
8. Keep separate color/fog/light/guidance/weave tween ownership.
9. Never disable Player controls and never access PortalAccentVFX.

### Slice 8.8 Automated or static checks

- Dedicated controller child and exact five paths resolve from their documented owners.
- EnvironmentStateRoot has no controller script.
- Resource-locality validation.
- No portal accent path/call.
- Phase monotonicity and duplicate no-op tests.
- Tween domains independent.
- Weather callback/timeout race emits one terminal.
- E1 failure continuity test.
- `validate_available_dependencies()` passes for all dependencies introduced through Slice 8.
- Parser/startup clean.

### Slice 8.9 Manual runtime checks

- Observe E0, both E1 variants, E2 and E3.
- Confirm no branch dims or “heals”.
- Force missing Weather Weave callback.
- Race real callback with timeout.
- Move freely through all environment transitions.
- Confirm portal remains dormant.

### Slice 8.10 Acceptance criteria

- Both orders preserve equal branch value.
- Exact environment hierarchy/paths remain intact.
- Environment changes never block traversal/progression.
- Weather Weave terminal once under callback or fallback.
- No portal accent ownership leak.
- G8 PASS.

### Slice 8.11 Rollback plan

- Revert Slice 8 commit.
- Keep logical progression from Slice 7; environment can remain placeholder E0 until repaired.

### Slice 8.12 Risks

- Shared Environment resource mutation.
- One tween kills another.
- Environment callback becomes macro gate before committed state.
- Visual direction implies repair/ranking.

### Slice 8.13 Out of scope

- Final art/weather polish.
- Main text and portal.
- Audio.

### Slice 8.14 Handoff format

- Phase/race evidence.
- Both order screenshots or logs.
- Commit SHA and changed files.
- Automatic continuation to Slice 9 on PASS.

## Slice 9 - Final Pavilion, Weather-Weave Handoff and Main Text

### Slice 9.1 Goal

Implement FinalTextGate occupancy, finale arming after Weather Weave, exact fail-closed main-text presentation and owned control/recovery locks.

### Slice 9.2 Preconditions

- Slice 8 and G8 PASS.
- Shared LevelFinaleOverlay API verified.
- Final pavilion floor and gate clearance stable.

### Slice 9.3 Exact literal file scope

| Authority | Exact path / rule |
|---|---|
| CREATE | `scripts/levels/level_04/level_04_finale_controller.gd` |
| MODIFY | `scenes/levels/Level_04.tscn` |
| MODIFY | `scripts/levels/level_04/level_04_progress_controller.gd` |
| READ ONLY | `scenes/ui/LevelFinaleOverlay.tscn` |
| READ ONLY | `scripts/ui/level_finale_overlay.gd` |
| READ ONLY | `scripts/levels/level_04/level_04_recovery_controller.gd` |
| READ ONLY | `scripts/levels/level_04/level_04_environment_state_controller.gd` |
| MATCHING `.gd.uid` | `scripts/levels/level_04/level_04_finale_controller.gd.uid` - permitted only when its exact sibling `.gd` is created or modified by this slice. |
| MATCHING `.gd.uid` | `scripts/levels/level_04/level_04_progress_controller.gd.uid` - permitted only when its exact sibling `.gd` is created or modified by this slice. |
| FORBIDDEN | Every repository file not listed above for CREATE or MODIFY; every unrelated `.gd.uid`, scene UID, `.import`, generated/cache file; every temporary harness; `project.godot`; shared systems; other levels; final assets. |

No wildcard grants write authority. A defect requiring any other path must stop the slice and reopen the owning slice or use a separately approved explicit defect-fix whitelist.

### Slice 9.5 Nodes, scenes and scripts

- FinalTextGate at exact center/radius.
- Level04FinaleController.
- Shared LevelFinaleOverlay.
- Recovery suspension source `main_text`.

### Slice 9.6 Methods, signals and contracts

- Progress calls `arm_finale()` after both rewards and Weather Weave terminal.
- `main_text_started(text_id)` only after overlay accepts text.
- `main_text_closed(text_id)` only from actual shared close.
- No portal activation in this slice.

### Slice 9.7 Implementation steps

- Wire gate occupancy while unarmed.
- Implement arm and one-physics-frame overlap reevaluation.
- Validate exact text ID/text and overlay API.
- Acquire only FinaleController-owned Player lock and recovery suspension.
- Call shared overlay and handle false return fail-closed.
- Release only owned lock/suspension on close/error.
- Emit started/closed once.
- Leave portal dormant.

### Slice 9.8 Automated or static checks

- Exact text byte/string comparison.
- Missing overlay/API/false return fail-closed.
- Duplicate close ignored.
- Gate early-overlap reevaluation.
- No generic completion timer.
- No portal activate call.
- Parser/startup clean.

### Slice 9.9 Manual runtime checks

- Enter FinalTextGate before both rewards and remain.
- Complete both orders and verify text starts after weave without re-entry.
- Close text normally.
- Force overlay failure and confirm portal dormant plus controls restored.
- Emit duplicate close in noncommitted harness.
- Check text at common aspect ratios.

### Slice 9.10 Acceptance criteria

- Exact main text once.
- Only intentional long control lock is active text.
- Error path releases owned locks and blocks exit.
- Early gate occupancy works.
- G9 PASS.

### Slice 9.11 Rollback plan

- Revert Slice 9 commit.
- Both rewards and environment remain testable without finale.

### Slice 9.12 Risks

- Control lock leak.
- Recovery suspension leak.
- Text opens before weave terminal.
- Overlay layout blocker requires Producer decision.

### Slice 9.13 Out of scope

- Portal activation/scene loading.
- Typography redesign or cinematic.
- Timer-based text skip.

### Slice 9.14 Handoff format

- Normal and failure-path evidence.
- Exact-copy verification.
- Commit SHA and changed files.
- Automatic continuation to Slice 10 on PASS.

## Slice 10 - Shared Portal Activation and Level_05 Exit

### Slice 10.1 Goal

Configure the upgraded shared LevelPortal and implement a narrow adapter that requests activation once after actual main-text close while shared portal retains all transition ownership.

### Slice 10.2 Preconditions

- Slice 9 and G9 PASS.
- Shared LevelPortal current API and early-overlap behavior validated or identified as P0 blocker.
- Level_05 scene path exists and is loadable.

### Slice 10.3 Exact literal file scope

| Authority | Exact path / rule |
|---|---|
| CREATE | `scripts/levels/level_04/level_04_portal_adapter.gd` |
| CREATE | `scenes/levels/level_04/vfx/L04_VFX_PortalAccent.tscn` |
| MODIFY | `scenes/levels/Level_04.tscn` |
| MODIFY | `scripts/levels/level_04/level_04_progress_controller.gd` |
| READ ONLY | `scenes/core/LevelPortal.tscn` |
| READ ONLY | `scripts/core/level_portal.gd` |
| READ ONLY | `scenes/levels/Level_05.tscn` |
| READ ONLY | `scripts/levels/level_04/level_04_finale_controller.gd` |
| MATCHING `.gd.uid` | `scripts/levels/level_04/level_04_portal_adapter.gd.uid` - permitted only when its exact sibling `.gd` is created or modified by this slice. |
| MATCHING `.gd.uid` | `scripts/levels/level_04/level_04_progress_controller.gd.uid` - permitted only when its exact sibling `.gd` is created or modified by this slice. |
| FORBIDDEN | Every repository file not listed above for CREATE or MODIFY; every unrelated `.gd.uid`, scene UID, `.import`, generated/cache file; every temporary harness; `project.godot`; shared systems; other levels; final assets. |

No wildcard grants write authority. A defect requiring any other path must stop the slice and reopen the owning slice or use a separately approved explicit defect-fix whitelist.

### Slice 10.5 Nodes, scenes and scripts

- PortalFloorAnchor and shared LevelPortal identity-local child.
- Level04PortalAdapter.
- PortalAccentVFX under VFXRoot.

### Slice 10.6 Methods, signals and contracts

- Exact target/AUTO_ENTER/no-confirmation configuration.
- `request_activation()` one-shot.
- `portal_activation_requested`, `portal_activated`, `portal_activation_blocked`.
- Actual `activation_completed` is the only success source.
- Adapter never owns Player path or scene loading.

### Slice 10.7 Implementation steps

1. Revalidate the actual shared LevelPortal public contract and exact configuration.
2. Set exact portal properties.
3. Validate anchor coordinate and identity-local child.
4. Connect shared activation_started/completed.
5. After actual main_text_closed, Progress requests E3 then adapter activation once.
6. Adapter starts optional accent and calls shared `activate()` once.
7. Wait for actual shared completion.
8. Use timeout only for diagnostics/accent cleanup.
9. Do not implement duplicate local formation when shared portal owns formation.
10. Do not change scene locally.

11. Set `Level04ProgressController.configuration_mode = ConfigurationMode.PRODUCTION`, run `validate_production_configuration()`, and treat any unresolved final path/type/ID as a P0 blocker.

### Slice 10.8 Automated or static checks

- Exact serialized portal settings.
- One activate call.
- No `change_scene*`, SceneTransition call or InteractionArea manipulation in adapter.
- No portal Player path export.
- Timeout cannot emit success.
- Duplicate close/request ignored.
- Parser/startup clean.

### Slice 10.9 Manual runtime checks

- Normal Level_05 transition after text close.
- Player stands inside future portal area before activation and remains stationary.
- No early load; exactly one transition after actual activation without re-entry.
- Rapid enter/exit and duplicate completion.
- Suppress activation_completed and confirm blocker diagnostic/no fabricated load.
- Verify Environment E3 cannot start accent.

### Slice 10.10 Acceptance criteria

- Portal inactive before actual text close.
- Exact Level_05 target.
- Early-overlap P0 PASS.
- Exactly one shared transition.
- Adapter never owns scene loading.
- `configuration_mode = PRODUCTION`; full production startup validation resolves every final path/type/ID and staged mode is absent from the final scene.
- G10 PASS.

### Slice 10.11 Rollback plan

- Revert Slice 10 commit.
- Level remains playable through main-text close but intentionally cannot exit.
- If shared early-overlap fails, stop for separately approved minimal public prerequisite; do not add local load hack.

### Slice 10.12 Risks

- Shared portal API drift.
- Timeout mistaken for success.
- Duplicate formation or activate.
- Identity transform overridden.

### Slice 10.13 Out of scope

- Level_05 implementation.
- Shared portal visual redesign.
- Confirmation input.

### Slice 10.14 Handoff format

- Portal configuration evidence.
- Early-overlap/timeout/duplicate matrix.
- Commit SHA and changed files.
- Automatic continuation to Slice 11 on PASS.

## Slice 11 - Stabilization, Full Acceptance and Final Summary

### Slice 11.1 Goal

Run complete static and runtime acceptance, remove diagnostics/harness residue, fix only Level_04-local defects and produce final implementation summaries.

### Slice 11.2 Preconditions

- Slices 1-10 and G1-G10 PASS.
- No unresolved P0 blockers.
- Both complete routes available.

### Slice 11.3 Exact literal file scope

| Authority | Exact path / rule |
|---|---|
| CREATE | `docs/development/Level_04_Greybox_Implementation_Summary.md` |
| CREATE - USER ARTIFACT OUTSIDE REPOSITORY WORKTREE | `Level_04_Greybox_Implementation_Summary.docx` |
| MODIFY | None. |
| READ ONLY | `scenes/levels/Level_04.tscn` |
| READ ONLY | `scenes/levels/level_04/blocks/Block_04_00_Arrival.tscn` |
| READ ONLY | `scenes/levels/level_04/blocks/Block_04_01_CrossingTree.tscn` |
| READ ONLY | `scenes/levels/level_04/blocks/Block_04_02_ChangingCanopy.tscn` |
| READ ONLY | `scenes/levels/level_04/blocks/Block_04_03_BraidedCrossing.tscn` |
| READ ONLY | `scenes/levels/level_04/blocks/Block_04_04_RippleConversation.tscn` |
| READ ONLY | `scenes/levels/level_04/blocks/Block_04_05_WeatherWeave.tscn` |
| READ ONLY | `scenes/levels/level_04/blocks/Block_04_06_FinalPavilion.tscn` |
| READ ONLY | `scenes/levels/level_04/gameplay/ChangingCanopyPuzzle.tscn` |
| READ ONLY | `scenes/levels/level_04/gameplay/RippleConversationPuzzle.tscn` |
| READ ONLY | `scenes/levels/level_04/gameplay/Level04PresenceFootprint.tscn` |
| READ ONLY | `scenes/levels/level_04/gameplay/Level04ShardSlot.tscn` |
| READ ONLY | `scenes/levels/level_04/gameplay/Level04RecoveryAnchorZone.tscn` |
| READ ONLY | `scenes/levels/level_04/gameplay/Level04RecoveryVolume.tscn` |
| READ ONLY | `scenes/levels/level_04/vfx/L04_VFX_RainThreads.tscn` |
| READ ONLY | `scenes/levels/level_04/vfx/L04_VFX_CloudShadow.tscn` |
| READ ONLY | `scenes/levels/level_04/vfx/L04_VFX_CanopyFeedback.tscn` |
| READ ONLY | `scenes/levels/level_04/vfx/L04_VFX_RippleContours.tscn` |
| READ ONLY | `scenes/levels/level_04/vfx/L04_VFX_RemainingGuidance.tscn` |
| READ ONLY | `scenes/levels/level_04/vfx/L04_VFX_WeatherWeave.tscn` |
| READ ONLY | `scenes/levels/level_04/vfx/L04_VFX_PortalAccent.tscn` |
| READ ONLY | `scripts/levels/level_04/level_04_progress_controller.gd` |
| READ ONLY | `scripts/levels/level_04/changing_canopy_controller.gd` |
| READ ONLY | `scripts/levels/level_04/ripple_conversation_controller.gd` |
| READ ONLY | `scripts/levels/level_04/level_04_presence_footprint.gd` |
| READ ONLY | `scripts/levels/level_04/level_04_shard_slot.gd` |
| READ ONLY | `scripts/levels/level_04/level_04_environment_state_controller.gd` |
| READ ONLY | `scripts/levels/level_04/level_04_finale_controller.gd` |
| READ ONLY | `scripts/levels/level_04/level_04_portal_adapter.gd` |
| READ ONLY | `scripts/levels/level_04/level_04_recovery_controller.gd` |
| READ ONLY | `scripts/levels/level_04/level_04_recovery_anchor_zone.gd` |
| READ ONLY | `scripts/levels/level_04/level_04_recovery_volume.gd` |
| MATCHING `.gd.uid` | None. |
| FORBIDDEN | Every repository file not listed above for CREATE or MODIFY; every unrelated `.gd.uid`, scene UID, `.import`, generated/cache file; every temporary harness; `project.godot`; shared systems; other levels; final assets. |

No wildcard grants write authority. A defect requiring any other path must stop the slice and reopen the owning slice or use a separately approved explicit defect-fix whitelist.

`Level_04_Greybox_Implementation_Summary.docx` is mandatory, is generated outside the repository worktree, and is not committed unless a separate explicit PR-scope decision authorizes it. This one external-artifact authority grants no write permission to any other external file or repository path.

### Slice 11.5 Nodes, scenes and scripts

- All Level_04-local systems as integrated.
- No new architecture or feature nodes.

### Slice 11.6 Methods, signals and contracts

- No new public API unless required by a documented Level_04-local defect and contained inside approved files.
- All duplicate/race guards and debug accessors finalized.
- Development-only visual debug may remain only when explicitly disabled outside debug builds or approved as greybox signage.

### Slice 11.7 Implementation steps

1. Run the complete UT, ST, P0 and P1 matrices and record every result as `PASS`, `FAIL` or `NOT VERIFIED`.
2. Complete both routes from a clean reload and preserve full Sequence A and Sequence B execution traces.
3. Execute P0-53 repeated backtracking before and after the first reward across Crossing Tree, Braided Crossing and both branch route contexts.
4. Execute P0-54 for both sequences using continuous grounded traversal only.
5. Verify exact copy, route timing, CP0-CP9, RA0-RA11, pre-overlap, recovery, failure paths and portal transition.
6. Remove temporary harnesses from the worktree and remove unrelated import/UID churn.
7. Clean warnings/errors without editing outside the active literal whitelist; reopen the owning slice or obtain an explicit defect-fix whitelist for any runtime correction.
8. Create `docs/development/Level_04_Greybox_Implementation_Summary.md` inside the repository.
9. Create mandatory `Level_04_Greybox_Implementation_Summary.docx` outside the repository worktree. Do not commit it unless a separate explicit PR-scope decision authorizes that exact file. This does not authorize any other external or repository write.
10. Generate both summaries from one semantic source and verify content equivalence.
11. Populate both summaries with every mandatory field below, explicitly rather than through a generic “complete results” statement:
    - exact implementation base SHA;
    - active PR/base decision;
    - every shared prerequisite, its status and exact approved head SHA;
    - branch and PR;
    - one commit entry for each Slice 1 through Slice 11;
    - exact files created;
    - exact files modified;
    - exact matching `.gd.uid` mapping;
    - complete UT/ST/P0/P1 results with `PASS`, `FAIL` or `NOT VERIFIED` for every ID;
    - proven Player spawn and RA root-Y values;
    - exact recovery registry evidence;
    - corrected `OOB_SouthPerimeter` AABB proof;
    - full Sequence A execution trace;
    - full Sequence B execution trace;
    - exact-copy evidence for Shard_08, Shard_09 and `LEVEL_04_MAIN_TEXT`;
    - finale fail-closed evidence;
    - shared LevelPortal ownership evidence;
    - stationary portal early-overlap evidence;
    - one-transition evidence;
    - final node tree and every API deviation, if any;
    - performance and timing evidence;
    - known warnings;
    - known limitations;
    - blockers and every `NOT VERIFIED` item;
    - explicit confirmation that shared files, `project.godot`, other levels and final assets were not changed;
    - remaining art-stage work, explicitly enumerating every still-unimplemented Art Bible family and all post-greybox production work;
    - final Definition of Done verdict.
12. Render the summary DOCX outside the runtime worktree and verify its complete layout before user handoff.

### Slice 11.8 Automated or static checks

- Godot parser/startup clean.
- Static checks ST-01 through ST-22 PASS.
- Only approved files changed.
- Every `.gd.uid` has approved sibling.
- No temporary harness remains.
- No project.godot change.
- No shared file drift.
- No unbounded particle/material/resource creation.

### Slice 11.9 Manual runtime checks

- Sequence A clean run.
- Sequence B clean run.
- All P0 tests, explicitly including P0-53 repeated backtracking and P0-54 continuous grounded traversal in both approved sequences.
- Blind-play timing if tester available; otherwise mark NOT VERIFIED and block final acceptance where mandatory.
- 16:9 CP0-CP9 camera review.
- Muted/reduced-color readability.
- Performance at 60 FPS target on project reference hardware.

### Slice 11.10 Acceptance criteria

- No unresolved P0 failure and no mandatory evidence reported as PASS when it is `NOT VERIFIED`.
- All mandatory evidence is verified, including P0-53 repeated backtracking and P0-54 continuous grounded traversal for both sequences.
- No parser errors or unexpected warnings.
- Both orders converge on the same E2, exact main text and Level_05 portal target.
- No softlock, duplicate puzzle terminal, duplicate shard reveal, duplicate reward or duplicate scene transition.
- `docs/development/Level_04_Greybox_Implementation_Summary.md` exists in the repository.
- Mandatory `Level_04_Greybox_Implementation_Summary.docx` exists outside the repository worktree and remains uncommitted unless a separate explicit PR-scope decision authorizes it.
- The Markdown and DOCX summaries are content-equivalent and each explicitly contains:
    - exact implementation base SHA;
    - active PR/base decision;
    - every shared prerequisite, its status and exact approved head SHA;
    - branch and PR;
    - one commit entry for each Slice 1 through Slice 11;
    - exact files created and exact files modified;
    - exact matching `.gd.uid` mapping;
    - every UT/ST/P0/P1 result as `PASS`, `FAIL` or `NOT VERIFIED`;
    - proven Player spawn and RA root-Y values;
    - exact recovery registry evidence and the corrected south AABB proof;
    - full Sequence A and Sequence B execution traces;
    - exact-copy evidence for Shard_08, Shard_09 and `LEVEL_04_MAIN_TEXT`;
    - finale fail-closed evidence;
    - portal ownership, stationary early-overlap and one-transition evidence;
    - final node tree, API deviations, performance and timing evidence;
    - known warnings, known limitations, blockers and all `NOT VERIFIED` items;
    - confirmation of unchanged shared files, `project.godot`, other levels and final assets;
    - every still-unimplemented Art Bible family and all remaining post-greybox production work;
    - final Definition of Done verdict.
- Definition of Done satisfied.

### Slice 11.11 Rollback plan

- Revert only the smallest stabilization commit causing regression.
- Do not mask failing acceptance with disabled tests or broadened timeouts.
- Preserve earlier accepted commits and report blocked evidence honestly.

### Slice 11.12 Risks

- Late race or overlap defect.
- Manual evidence unavailable.
- Scope creep during cleanup.
- Summary differs from actual commit set.

### Slice 11.13 Out of scope

- Final art/audio/polish.
- New gameplay features.
- Shared-system redesign.
- Level_05 work.

### Slice 11.14 Handoff format

- Final status: `PASS` or `BLOCKED`.
- Exact implementation base SHA.
- Active PR/base decision.
- Every shared prerequisite, its status and exact approved head SHA.
- Branch and PR.
- One commit entry for each Slice 1 through Slice 11.
- Exact files created.
- Exact files modified.
- Exact matching `.gd.uid` mapping.
- Complete UT/ST/P0/P1 results with `PASS`, `FAIL` or `NOT VERIFIED` for every ID, including P0-53 and P0-54.
- Proven Player spawn and RA root-Y values.
- Exact recovery registry evidence.
- Corrected `OOB_SouthPerimeter` AABB proof.
- Full Sequence A execution trace.
- Full Sequence B execution trace.
- Exact-copy evidence for Shard_08, Shard_09 and `LEVEL_04_MAIN_TEXT`.
- Finale fail-closed evidence.
- Shared LevelPortal ownership evidence.
- Stationary portal early-overlap evidence.
- One-transition evidence.
- Final node tree and API deviations, if any.
- Performance and timing evidence.
- Known warnings.
- Known limitations.
- Blockers and every `NOT VERIFIED` item.
- Confirmation that shared files, `project.godot`, other levels and final assets were not changed.
- Remaining art-stage work, explicitly listing every still-unimplemented Art Bible family and all post-greybox production work.
- Final Definition of Done verdict.
- Repository summary path: `docs/development/Level_04_Greybox_Implementation_Summary.md`.
- Mandatory user artifact path: `Level_04_Greybox_Implementation_Summary.docx`, generated outside the repository worktree and uncommitted unless separately authorized.
- Markdown/DOCX content-equivalence confirmation.

# 22. Master file ownership and changed-file whitelist

The following exact paths are the complete planned runtime file inventory. This master inventory does not override per-slice authority.

| Exact path | Owning slice/system | Authority rule |
|---|---|---|
| `scenes/levels/Level_04.tscn` | Level_04 runtime | Write only in the literal slice tables that list this exact path. |
| `scenes/levels/level_04/blocks/Block_04_00_Arrival.tscn` | Slice 1 spatial block | Write only in the literal slice tables that list this exact path. |
| `scenes/levels/level_04/blocks/Block_04_01_CrossingTree.tscn` | Slice 1 spatial block | Write only in the literal slice tables that list this exact path. |
| `scenes/levels/level_04/blocks/Block_04_02_ChangingCanopy.tscn` | Slice 1 spatial block | Write only in the literal slice tables that list this exact path. |
| `scenes/levels/level_04/blocks/Block_04_03_BraidedCrossing.tscn` | Slice 1 spatial block | Write only in the literal slice tables that list this exact path. |
| `scenes/levels/level_04/blocks/Block_04_04_RippleConversation.tscn` | Slice 1 spatial block | Write only in the literal slice tables that list this exact path. |
| `scenes/levels/level_04/blocks/Block_04_05_WeatherWeave.tscn` | Slice 1 spatial block | Write only in the literal slice tables that list this exact path. |
| `scenes/levels/level_04/blocks/Block_04_06_FinalPavilion.tscn` | Slice 1 spatial block | Write only in the literal slice tables that list this exact path. |
| `scenes/levels/level_04/gameplay/ChangingCanopyPuzzle.tscn` | Level_04 runtime | Write only in the literal slice tables that list this exact path. |
| `scenes/levels/level_04/gameplay/Level04PresenceFootprint.tscn` | Level_04 runtime | Write only in the literal slice tables that list this exact path. |
| `scenes/levels/level_04/gameplay/Level04RecoveryAnchorZone.tscn` | Slice 2 recovery | Write only in the literal slice tables that list this exact path. |
| `scenes/levels/level_04/gameplay/Level04RecoveryVolume.tscn` | Slice 2 recovery | Write only in the literal slice tables that list this exact path. |
| `scenes/levels/level_04/gameplay/Level04ShardSlot.tscn` | Slice 6 shard slot | Write only in the literal slice tables that list this exact path. |
| `scenes/levels/level_04/gameplay/RippleConversationPuzzle.tscn` | Level_04 runtime | Write only in the literal slice tables that list this exact path. |
| `scenes/levels/level_04/vfx/L04_VFX_CanopyFeedback.tscn` | Slice 4 Canopy | Write only in the literal slice tables that list this exact path. |
| `scenes/levels/level_04/vfx/L04_VFX_CloudShadow.tscn` | Slices 3/8 environment | Write only in the literal slice tables that list this exact path. |
| `scenes/levels/level_04/vfx/L04_VFX_PortalAccent.tscn` | Slice 10 portal | Write only in the literal slice tables that list this exact path. |
| `scenes/levels/level_04/vfx/L04_VFX_RainThreads.tscn` | Slices 3/8 environment | Write only in the literal slice tables that list this exact path. |
| `scenes/levels/level_04/vfx/L04_VFX_RemainingGuidance.tscn` | Slice 7 remaining guidance | Write only in the literal slice tables that list this exact path. |
| `scenes/levels/level_04/vfx/L04_VFX_RippleContours.tscn` | Slice 5 Ripple | Write only in the literal slice tables that list this exact path. |
| `scenes/levels/level_04/vfx/L04_VFX_WeatherWeave.tscn` | Slices 3/8 environment | Write only in the literal slice tables that list this exact path. |
| `scripts/levels/level_04/changing_canopy_controller.gd` | Slice 4 Canopy | Write only in the literal slice tables that list this exact path. |
| `scripts/levels/level_04/level_04_environment_state_controller.gd` | Slices 3/8 environment | Write only in the literal slice tables that list this exact path. |
| `scripts/levels/level_04/level_04_finale_controller.gd` | Slice 9 finale | Write only in the literal slice tables that list this exact path. |
| `scripts/levels/level_04/level_04_portal_adapter.gd` | Slice 10 portal | Write only in the literal slice tables that list this exact path. |
| `scripts/levels/level_04/level_04_presence_footprint.gd` | Level_04 runtime | Write only in the literal slice tables that list this exact path. |
| `scripts/levels/level_04/level_04_progress_controller.gd` | Slices 3-10 progress | Write only in the literal slice tables that list this exact path. |
| `scripts/levels/level_04/level_04_recovery_anchor_zone.gd` | Slice 2 recovery | Write only in the literal slice tables that list this exact path. |
| `scripts/levels/level_04/level_04_recovery_controller.gd` | Slice 2 recovery | Write only in the literal slice tables that list this exact path. |
| `scripts/levels/level_04/level_04_recovery_volume.gd` | Slice 2 recovery | Write only in the literal slice tables that list this exact path. |
| `scripts/levels/level_04/level_04_shard_slot.gd` | Slice 6 shard slot | Write only in the literal slice tables that list this exact path. |
| `scripts/levels/level_04/ripple_conversation_controller.gd` | Slice 5 Ripple | Write only in the literal slice tables that list this exact path. |
| `scripts/levels/level_04/<approved_script>.gd.uid` | Matching sidecar only | Allowed only when the exact sidecar is named in the active slice and its sibling `.gd` is CREATE or MODIFY in that slice. |
| `docs/development/Level_04_Greybox_Implementation_Summary.md` | Slice 11 | Mandatory committed summary. |
| `Level_04_Greybox_Implementation_Summary.docx` | Slice 11 mandatory user artifact | Exact `CREATE - USER ARTIFACT OUTSIDE REPOSITORY WORKTREE` authority only. Generate outside the repository worktree; do not commit unless a separate explicit PR-scope decision authorizes it; this grants no authority to any other external or repository file. |

### 22.1 Changed-file whitelist enforcement

- Before every write and commit, compare changed paths to the active slice's literal CREATE/MODIFY table.
- READ ONLY paths never grant write authority.
- No wildcard path grants slice-level authority.
- A file outside the active whitelist requires a hard stop, reopening of its owning slice, or a separately approved explicit defect-fix whitelist.
- Only exact matching `.gd.uid` sidecars named in the active slice are allowed.
- No scene UID, `.import`, asset-import metadata, generated/cache file or temporary harness may remain.
- Slice 11 is documentation-only by default; runtime defects found there must reopen the owning slice or use an explicit defect-fix whitelist.

# 23. Test and acceptance matrix

## 23.1 Required unit-like checks

| ID | Check | Expected |
|---|---|---|
| UT-01 | CANOPY terminal then RIPPLE terminal | Candidate remains CANOPY. |
| UT-02 | RIPPLE terminal then CANOPY terminal | Candidate remains RIPPLE. |
| UT-03 | Same-frame terminal callbacks | First accepted wins; one first reveal request. |
| UT-04 | Opposite puzzle complete early | Second slot remains hidden. |
| UT-05 | Candidate collection gate | Only candidate `shard_collected` commits first reward. |
| UT-06 | Remaining eligibility | Requires fixed remaining branch, puzzle complete and zone occupied. |
| UT-07 | Anchor immutability | Alternate reveal request rejected. |
| UT-08 | Shard availability | Emits only after effective collectability verification. |
| UT-09 | Duplicate slot events | No repeated macro advancement. |
| UT-10 | Weather race | Real callback and timeout yield one terminal. |
| UT-11 | Recovery unlock | Pending overlap reevaluates exactly once. |
| UT-12 | Main text fail-closed | Missing/incompatible UI leaves portal dormant and owned lock released. |
| UT-13 | Portal timeout | No `portal_activated`, no second activate call. |
| UT-14 | Full reload | Clean CANDIDATE_UNSET/E0, hidden slots, inactive portal. |
| UT-15 | Exact owner-relative paths | Every path resolves from its real owner to expected type. |
| UT-16 | Four puzzle controller paths | Correct four-level traversal to Player/VFX. |
| UT-17 | Recovery anchor registry | Exactly RA0-RA11. |
| UT-18 | RA update | Each RA event updates exact latest ID/transform. |
| UT-19 | Duplicate/stale RA event | Rejected/no-op. |
| UT-20 | RA current overlap | One event after enable + physics frame without re-entry. |
| UT-21 | Portal placement | Exact anchor, identity-local child and exact configuration. |
| UT-22 | Portal accent isolation | Only adapter owns accent. |
| UT-23 | SoulOrb continuity | Exactly one visible orb target; both rewards return normally. |
| UT-24 | RouteContext typing | All ten mappings explicit; wrong types rejected. |
| UT-25 | E1 failure continuity | Remaining branch still fixed and REMAINING_DEFERRED reached. |
| UT-26 | Exact recovery-volume registry | Serialized path list equals the five literal paths and IDs in Section 8.8, including `RV_OOB_SOUTH_PERIMETER`; missing, extra, duplicate, wrong-type or wrong-ID entries fail startup. |
| UT-27 | Recovery transform registry | All five BoxShape3D positions, rotations and extents equal Section 8.8; south is exactly `Vector3(0.00, 1.00, -65.00)` / `Vector3(0,0,0)` / `Vector3(39.00, 10.00, 4.00)` and no noncanonical south-perimeter center is accepted. |
| UT-28 | Recovery legal-space exclusions | Analytic AABB checks prove no volume intersects legal side spaces, shallow water, shard alcoves, pavilion overlook, either Braided Crossing lane, mandatory shoulder or camera corridor. The south proof uses actual Arrival bounds: edge `Z=-59.00`, inner face `Z=-61.00`, separation `2.00 m`, shoulder `1.25 m`, collider allowance `0.75 m`, PASS. |
| UT-29 | Duplicate body-enter | One registered source creates one token and one recovery path. |
| UT-30 | Intentional corner overlap | Simultaneous overlap of two perimeter volumes shares one token and one recovery. |
| UT-31 | Suspended recovery reevaluation | Exit-before-unlock clears pending; remain-invalid executes exactly once after one physics-frame reevaluation. |
| UT-32 | Invalid recovery events | Wrong source, non-Player body, mismatched volume ID and stale continuation are rejected without progress or teleport mutation. |
| UT-33 | RA transform convention | Root owns coordinate, FloorAnchor identity-local. |
| UT-34 | Footprint Player paths | All ten resolve to exact same Player. |
| UT-35 | Body/grounding rejection | Non-Player and airborne Player cannot complete dwell. |
| UT-36 | Valid portal `.tscn` identity | Transform omission parses and runtime identity validation passes. |
| UT-37 | Slice 3 staged startup | Only the exact documented future dependencies are unresolved; present dependencies fail closed; no uncontrolled configuration error. |
| UT-38 | Production startup transition | G10 switches to `PRODUCTION`; every final path/type/ID resolves and staged mode is rejected in the final scene. |

## 23.2 Static validation matrix

| ID | Static check |
|---|---|
| ST-01 | Only master-whitelisted files changed. |
| ST-02 | `project.godot` unchanged. |
| ST-03 | No Level_01-Level_03 or Level_05+ runtime files changed. |
| ST-04 | No shared Player/Camera/Soul/Reward/Finale/Portal file changed. |
| ST-05 | No raw GLB or final asset in runtime PR. |
| ST-06 | No global node-name scanning, `/root` gameplay path or `node_added` discovery. |
| ST-07 | No gameplay script attached to environment-only block/import. |
| ST-08 | Exact canonical IDs and texts present once in authoritative configuration. |
| ST-09 | Exact portal target/AUTO_ENTER/no-confirmation present. |
| ST-10 | Portal adapter contains no scene-loading call or Player-path export. |
| ST-11 | `EnvironmentStateRoot` has no controller script; dedicated child controller and all five exact environment NodePaths are present; controller contains no PortalAccentVFX ownership. |
| ST-12 | Recovery code contains `Player.velocity = Vector3.ZERO` or proven public equivalent and no private Player field access. |
| ST-13 | All 12 RA paths plus the exact five recovery-volume paths/IDs/transforms/extents from Section 8.8 are literal; `OOB_SouthPerimeter` is centered at `Z=-65.00`, its inner face is `Z=-61.00`, and the actual-floor AABB proof records `2.00 m` separation. No wildcard, `[1..N]`, scan or inferred ID remains. |
| ST-14 | All ten footprint Player paths exact. |
| ST-15 | No child-order/world-position identity inference. |
| ST-16 | No environment transition control lock. |
| ST-17 | Main-text close is actual overlay signal, not timer. |
| ST-18 | Weather fallback cannot activate portal or skip text. |
| ST-19 | Each allowed `.gd.uid` matches an approved sibling `.gd`. |
| ST-20 | No unrelated UID/import regeneration. |
| ST-21 | No temporary harness remains in repository. |
| ST-22 | Final implementation summary changed-file list matches Git diff/commits. |

## 23.3 Manual P0/P1 matrix

| ID | Scenario | Expected evidence |
|---|---|---|
| P0-01 | Fresh Sequence A | Canopy -> Shard_08 -> crossing -> Ripple -> Shard_09 -> same finale -> one Level_05 transition. |
| P0-02 | Fresh Sequence B | Ripple -> Shard_09 -> crossing -> Canopy -> Shard_08 -> same finale -> one transition. |
| P0-03 | All Canopy target orders and contexts | Three unique completions and one terminal. |
| P0-04 | Both Ripple orders and contexts | Two unique completions and one terminal. |
| P0-05 | Both near terminal in same frame | First accepted fixes immutable candidate. |
| P0-06 | Both puzzles complete, no collection | Only candidate first-pass shard available. |
| P0-07 | Candidate shard uncollected, cross early | Candidate unchanged and physical return valid. |
| P0-08 | Opposite already complete | After first reward and exact zone entry, second reveal without replay. |
| P0-09 | Remaining partial while Player stays in zone | Final target causes reveal without exit/re-entry. |
| P0-10 | Duplicate I/R callbacks | One unique target/marker completion. |
| P0-11 | Alternate anchor request after reveal starts | No migration. |
| P0-12 | All states | At most one active instance per canonical shard. |
| P0-13 | Shard pre-overlap | No early collect; available exactly once without re-entry. |
| P0-14 | Crossing exploit attempts | No lane switch or pavilion bypass. |
| P0-15 | Falls from every route family | One recovery; `Player.velocity = Vector3.ZERO`; progress preserved. |
| P0-16 | Fall during reward and remain invalid | No teleport while locked; one recovery at unlock. |
| P0-17 | Enter during lock then leave | No delayed teleport. |
| P0-18 | Legal side spaces/water/blocker contact | No false recovery/damage/slowdown. |
| P0-19 | Duplicate shard lifecycle | One reward-state advancement per ID. |
| P0-20 | Final gate entered early | Text starts after prerequisites without re-entry. |
| P0-21 | Main UI failure | Portal dormant, owned lock released, error logged. |
| P0-22 | Duplicate text close | One EXIT and one activation request. |
| P0-23 | Portal early overlap | No early load; one load after actual activation without re-entry. |
| P0-24 | Suppress activation_completed | Blocker diagnostic, no fabricated success. |
| P0-25 | Rapid portal overlap/duplicate completion | At most one transition. |
| P0-26 | Presentation callback/timeout races | First terminal wins. |
| P0-27 | Reload from each major state | Clean initial scene. |
| P0-28 | Repeated spawn loads | Stable grounded spawn. |
| P0-29 | Recovery after step traversal | No stale motion; otherwise shared prerequisite stop. |
| P0-30 | Exact copy | Both rewards and main text exact, no decorative quotes. |
| P0-31 | Exact path harness | Every owner-relative path resolves. |
| P0-32 | RA0-RA11 walkthrough | Each updates exact latest anchor once. |
| P0-33 | Duplicate RA arrival | No duplicate state/log. |
| P0-34 | RA current-overlap enable | Emits once without re-entry. |
| P0-35 | Unknown/mismatched/stale RA event | Rejected. |
| P0-36 | Portal placement during/after activation | Anchor/root remain exact and coincident. |
| P0-37 | E3 without adapter request | Environment cannot start PortalAccentVFX. |
| P0-38 | Both rewards in both orders | One SoulOrb; normal return and one absorb pulse each. |
| P0-39 | Malformed RouteContext mappings | Rejected without progress. |
| P0-40 | E1 request failure | First reward committed and REMAINING_DEFERRED reached. |
| P0-41 | Recovery registry audit | Enumerate the exact five paths/IDs/nodes and compare them to the serialized registry, including `RV_OOB_SOUTH_PERIMETER`; expected result: exact equality, each source registered once, and no extra or omitted source. |
| P0-42 | Recovery transform/exclusion audit | Inspect every volume at runtime and compare it with Section 8.8. For the south perimeter verify Arrival edge `Z=-59.00`, recovery center `Z=-65.00`, half-extent `4.00 m`, inner face `Z=-61.00`, separation `2.00 m`, shoulder `1.25 m` and collider allowance `0.75 m`; expected result: exact shape/transform, AABB proof PASS, legal Arrival movement never overlaps, falls before the perimeter remain covered by `SoftReturnVolume`, and every listed legal-space exclusion has zero overlap. |
| P0-43 | Duplicate body-enter | Re-emit entry from one registered volume; expected result: one token and one pending/recovery path. |
| P0-44 | Intentional exterior-corner overlap | Enter the overlap of two perimeter volumes; expected result: both sources are tracked while only one token and one recovery are created. |
| P0-45 | Suspended exit before unlock | Enter any exact registry volume during reward/main text and then leave all volumes; expected result: pending recovery clears after one physics frame and no delayed teleport occurs. |
| P0-46 | Suspended remain / destination overlap | Remain invalid through unlock and temporarily keep the destination inside a registered volume; expected result: the same token recovers once and the latch stays closed until a zero-overlap physics frame. |
| P0-47 | Wrong source/non-Player/mismatched ID/stale continuation | Invoke every invalid case; expected result: each is rejected without anchor, token, progress or teleport mutation. |
| P0-48 | RA transform audit | Root exact, FloorAnchor identity-local, global transform exact. |
| P0-49 | All footprint paths | Same shared Player. |
| P0-50 | Other CharacterBody3D in footprint | No progress. |
| P0-51 | Configured Player airborne | No completion until grounded dwell. |
| P0-52 | Portal scene syntax | Omitted identity transform parses and validates. |
| P0-53 | Repeated backtracking across Crossing Tree, Braided Crossing and both branch route contexts before and after the first reward | Immutable candidate does not change; no duplicate puzzle terminal, shard reveal or reward occurs; stored partial/completed puzzle state remains valid; remaining-zone occupancy is reevaluated correctly; no reset, route closure, forced replay or softlock occurs; both approved sequences remain completable. |
| P0-54 | Complete Sequence A and Sequence B using continuous grounded traversal only | No mandatory jump, mandatory gap crossing, precision edge placement, timing gate, waiting challenge or required audio use; all mandatory route widths, slopes, steps and clearances remain valid. |
| P1-01 | Blind first plays | 5:00-6:30, no UI arrows needed. |
| P1-02 | Repeat optimal both orders | 3:00-4:00 and order difference <=10%. |
| P1-03 | CP0-CP9 at 16:9 | Required landmarks/targets readable. |
| P1-04 | Muted/reduced-color play | Mandatory information still readable. |
| P1-05 | Performance profile | Stable 60 FPS target; no unbounded particles/material duplication. |

# 24. Softlock and failure matrix

| Risk | Prevention / required behavior | Hard-stop condition |
|---|---|---|
| Player cannot ground at spawn | Evidence-derived root Y; exact floor anchor unchanged. | Stable grounding cannot be achieved without private Player access. |
| Crossing creates route shortcut | Static visible boundaries, no UC/LC junction, CP6/CP7 review. | Any reliable pavilion bypass or lane switch remains. |
| Candidate changes after both terminals | Immutable first-terminal latch. | Reward/collection order can mutate candidate. |
| Dual footprints count twice | Deduplicate by canonical target/marker ID. | Same-frame I/R callbacks advance twice. |
| Stationary Player misses newly enabled footprint | One-physics-frame overlap reevaluation. | Requires exit/re-entry. |
| Airborne/non-Player satisfies footprint | Exact Player binding and public grounded check. | Any other body or airborne dwell advances progress. |
| Candidate shard reveals but is not interactable | Packed hidden state, deferred enable, physics verification, pre-overlap P0. | No public way to refresh interaction. |
| Alternate shard anchor activates | Immutable selected AnchorContext. | Shard migrates or duplicates. |
| Macro advances on reward start | Only slot-reemitted `shard_collected`. | Reward request/overlay start advances state. |
| Opposite puzzle completes early | Store completion, keep slot hidden until remaining authority. | Opposite first-pass shard becomes active. |
| Remaining Player waits in zone | Occupancy stored and reevaluated on puzzle/state change. | Exit/re-entry required. |
| E1 VFX fails | Commit first reward and enter REMAINING_DEFERRED before/independent of presentation. | Presentation callback blocks gameplay. |
| Weather callback fails | 2.5 s controller fallback. | Finale never arms. |
| Weather fallback races callback | Generation token + terminal latch. | Duplicate finale arm. |
| Main overlay missing/fails | Fail-closed, release owned lock, portal dormant. | Portal opens without actual readable text. |
| Player entered FinalTextGate early | Occupancy retained and rechecked after arm. | Exit/re-entry required. |
| Duplicate close | One close latch and one portal request. | Multiple activate calls. |
| Portal early overlap | Shared portal reevaluation/behavior proven by P0. | Player must exit/re-enter or local adapter loads scene. |
| Portal activation callback missing | Diagnostic timeout only, no success fabrication. | Adapter treats timeout as activated. |
| Recovery registry omitted/misplaced or overlaps legal space | Exact five-volume registry, exact transforms and analytic/runtime exclusion checks from Section 8.8. South placement uses actual Arrival floor bounds: legal edge `Z=-59.00`, recovery inner face `Z=-61.00`, separation `2.00 m`, shoulder `1.25 m`, residual current-Player-collider allowance `0.75 m`; pre-perimeter falls remain covered by `SoftReturnVolume` and no invisible catch floor exists. | Any extra/missing source; any noncanonical south center; south separation below `2.00 m`; or overlap with legal side space, Arrival floor/shoulder, shallow water, shard alcove, pavilion overlook, either crossing lane, mandatory shoulder or camera corridor. |
| Recovery volume duplicates/intentional corner overlaps | Controller-owned token and overlap set. | More than one teleport per fall. |
| Recovery while reward/text active | Source-key suspension and pending reevaluation. | Teleport occurs during lock or never occurs after valid unlock. |
| Player exits invalid area before unlock | One-frame reevaluation clears pending. | Delayed teleport after safe exit. |
| Recovery destination still overlaps | Latch waits for zero-overlap frame. | Immediate retrigger loop. |
| Recovery keeps stale movement | Set `Player.velocity = Vector3.ZERO`; clear any additional transient movement only through a proven public Player API. | Private fields required or stale motion persists. |
| Repeated backtracking corrupts progression | P0-53 repeatedly crosses Crossing Tree, Braided Crossing and both route contexts before and after the first reward while preserving immutable candidate, unique terminals/rewards, stored puzzle state and current remaining-zone reevaluation. | Any candidate mutation, duplicate terminal/reveal/reward, reset, route closure, forced replay or softlock; either approved sequence becomes incompletable. |
| Mandatory jump or precision traversal enters the critical path | P0-54 completes Sequence A and Sequence B through continuous grounded traversal while validating route widths, slopes, steps and clearances. | Any mandatory jump, gap crossing, precision edge placement, timing gate, waiting challenge or required audio dependency. |
| Reload retains state | No GameState/save; fresh scene initializes hidden slots/E0. | Any state leaks across reload. |
| UID/import churn | Exact per-slice whitelist and sibling rule. | Unrelated generated files remain. |
| Temporary harness committed | Harness outside worktree or removed. | Any harness remains at final diff. |

# 25. Producer gates and automatic execution

- **P0 - Preflight gate:** Slice 0 must PASS, have zero diff and end `WAITING FOR APPLY`.
- **APPLY gate:** the user explicitly authorizes implementation once. No later routine confirmation is required. Immediately after APPLY, clean status and approved base are reconfirmed, `feature/implement-level-04-greybox` is created from that exact base, branch/HEAD are verified, and no write occurs on `main`.
- **G1:** static spatial shell/topology PASS.
- **G2:** spawn, grounding and recovery PASS.
- **G3:** macro shell, exact staged dependency mode and approved E0 environment hierarchy PASS.
- **G4:** Changing Canopy PASS.
- **G5:** Ripple Conversation PASS.
- **G6:** first shard/reward and shard pre-overlap P0 PASS.
- **G7:** remaining branch and second reward both orders PASS.
- **G8:** environment and Weather Weave PASS.
- **G9:** fail-closed main text PASS.
- **G10:** portal ownership, early-overlap P0 and mandatory switch from `STAGED_SLICE_3` to full `PRODUCTION` startup validation PASS.
- **Final gate:** Slice 11 complete acceptance and summaries PASS.

G1-G10 are internal. Continue automatically when PASS. Stop only for:

- P0 failure;
- shared-system blocker;
- scope deviation;
- unresolved active-PR/base conflict;
- required Producer-only decision;
- mandatory acceptance evidence that cannot be verified.

# 26. Definition of Done

Level_04 greybox is done only when all conditions below are true:

1. Slice 0 was inspection-only, zero diff and explicit APPLY preceded runtime implementation.
2. After APPLY, `feature/implement-level-04-greybox` was created from the exact Slice 0 approved base, branch/HEAD were verified, and no runtime implementation occurred directly on `main`.
3. Slices 1-11 each have a scoped validation handoff and one commit entry.
4. Only master-whitelisted files changed.
5. `project.godot`, shared systems and other levels remain unchanged unless a separately approved prerequisite exists.
6. Matching `scripts/levels/level_04/<approved_script>.gd.uid` sidecars correspond one-to-one with approved sibling scripts; no unrelated UID/import churn exists.
7. Exact static topology, coordinates, route widths, clearances, CP points and RA anchors are preserved.
8. Both branch orders are fully playable and converge on identical Weather Weave, exact main text and Level_05 portal target.
9. First accepted puzzle terminal fixes immutable candidate; reward order has no candidate authority.
10. Puzzle solved latch precedes terminal emit; shard availability follows verified collectability; macro reward progress follows shared `shard_collected` only.
11. Canopy 3/3 and Ripple 2/2 work in any order and either route context without duplicate counting.
12. First-pass and remaining-pass shard anchors are correct, exclusive and immutable.
13. Shard and portal pre-overlap P0 tests PASS without exit/re-entry.
14. Recovery performs one teleport per fall event, preserves progress, respects locks, sets `Player.velocity = Vector3.ZERO` and uses no private movement state. The exact south registry is `Vector3(0.00, 1.00, -65.00)` / `Vector3(0,0,0)` / `Vector3(39.00, 10.00, 4.00)`; actual Arrival edge `Z=-59.00`, inner face `Z=-61.00`, exact separation `2.00 m`, `1.25 m` shoulder and `0.75 m` residual Player-collider allowance are proven PASS, with pre-perimeter falls covered by `SoftReturnVolume` and no invisible catch floor.
15. Environment transitions are non-blocking, preserve branch equality, use the dedicated controller child and exact NodePaths, and never own portal accent.
16. Main text is exact, shown once and fail-closed on UI error.
17. Portal activates only after actual text close; adapter calls shared `activate()` once and never loads a scene.
18. All UT checks, ST-01 through ST-22 and mandatory P0/P1 tests PASS. The exact recovery registry and actual-floor south AABB proof are present in UT-26 through UT-32 where relevant, ST-13 and P0-41 through P0-47 where relevant.
19. P0-53 PASS proves repeated backtracking before and after the first reward does not mutate the candidate, duplicate a terminal/reveal/reward, invalidate stored puzzle state, break remaining-zone reevaluation, reset/close routes, force replay or softlock either approved sequence.
20. P0-54 PASS proves Sequence A and Sequence B require no mandatory jump, gap, precision edge placement, timing gate, waiting challenge or audio use and preserve all mandatory widths, slopes, steps and clearances.
21. No temporary harness remains in the repository.
22. Final `Level04ProgressController.configuration_mode` is `PRODUCTION`; full startup validation passes; no unresolved parser errors, unexpected warnings, P0 failures or mandatory `NOT VERIFIED` evidence remains.
23. `docs/development/Level_04_Greybox_Implementation_Summary.md` exists in the repository and accurately matches the final implementation evidence.
24. Mandatory `Level_04_Greybox_Implementation_Summary.docx` exists outside the repository worktree, is content-equivalent to the Markdown summary and is not committed unless a separate explicit PR-scope decision authorizes that exact artifact. Its creation grants no authority over any other file.
25. Both final summaries explicitly contain every field below:
    - exact implementation base SHA;
    - active PR/base decision;
    - every shared prerequisite, its status and exact approved head SHA;
    - branch and PR;
    - one commit entry for each Slice 1 through Slice 11;
    - exact files created;
    - exact files modified;
    - exact matching `.gd.uid` mapping;
    - complete UT/ST/P0/P1 results with `PASS`, `FAIL` or `NOT VERIFIED` for every ID;
    - proven Player spawn and RA root-Y values;
    - exact recovery registry evidence;
    - corrected `OOB_SouthPerimeter` AABB proof;
    - full Sequence A execution trace;
    - full Sequence B execution trace;
    - exact-copy evidence for Shard_08, Shard_09 and `LEVEL_04_MAIN_TEXT`;
    - finale fail-closed evidence;
    - shared LevelPortal ownership evidence;
    - stationary portal early-overlap evidence;
    - one-transition evidence;
    - final node tree and API deviations, if any;
    - performance and timing evidence;
    - known warnings;
    - known limitations;
    - blockers and every `NOT VERIFIED` item;
    - confirmation that shared files, `project.godot`, other levels and final assets were not changed;
    - remaining art-stage work, explicitly enumerating every still-unimplemented Art Bible family and all post-greybox production work;
    - final Definition of Done verdict.


# 27. Suggested branch, commit and PR naming

**Branch:** `feature/implement-level-04-greybox`  
Create this branch only after explicit APPLY and before any Slice 1 write, from the exact Slice 0 approved base SHA. Reconfirm clean status/base, create/switch, verify branch and HEAD, and record evidence. Never implement directly on `main`. Use a different base only when Slice 0 identifies an approved stacked prerequisite and records its exact head SHA and dependency; the branch name remains `feature/implement-level-04-greybox` unless a Producer decision explicitly changes it.

Suggested commits:

- `Level 04 slice 1: build static braided greybox shell`
- `Level 04 slice 2: add spawn grounding and explicit recovery`
- `Level 04 slice 3: add macro progress shell and E0`
- `Level 04 slice 4: implement Changing Canopy`
- `Level 04 slice 5: implement Ripple Conversation`
- `Level 04 slice 6: add first-pass shard and reward flow`
- `Level 04 slice 7: add remaining-branch second reward flow`
- `Level 04 slice 8: add environment progression and Weather Weave`
- `Level 04 slice 9: add finale main text`
- `Level 04 slice 10: integrate shared Level 05 portal`
- `Level 04 slice 11: stabilize and document implementation`

**PR title:** `Implement Level_04 greybox - Ты сама`

PR body must state exact base SHA, slice commits, changed-file whitelist, P0/P1 evidence, shared files unchanged, root-Y evidence, known warnings and summary artifact paths.

# 28. Final Codex implementation prompt requirements

The implementation prompt generated from this reference must instruct Codex to:

1. Treat `docs/design/Level_04_Greybox_Development_Reference_v1.3.md` as the primary implementation reference, `Level_04_Greybox_Development_Reference_v1.3.docx` as its content-equivalent Producer artifact, and the five approved Level_04 source documents as design authority.
2. Execute Slice 0 first with zero changes and end `WAITING FOR APPLY`.
3. Wait for one explicit APPLY only.
4. After APPLY and before Slice 1 writes, reconfirm clean status/base, create and switch to `feature/implement-level-04-greybox` from the exact approved base, verify branch/HEAD and record evidence; never implement on `main`.
5. Then implement one slice at a time, validate, commit and automatically continue when its internal gate passes.
6. Stop only under the hard-stop conditions in Section 25.
7. Use the exact base decision from Slice 0 and never touch unrelated active PRs.
8. Enforce each slice's literal CREATE/MODIFY/READ ONLY/FORBIDDEN table before every write and commit; stop/reopen the owning slice or obtain an explicit defect-fix whitelist for any other file.
9. Allow only matching `scripts/levels/level_04/<approved_script>.gd.uid` sidecars named in the active slice; reject every unrelated `.gd.uid`, scene UID, import or generated file.
10. Keep temporary harnesses outside worktree or remove them before commit.
11. Preserve exact coordinates, IDs, texts, event order, literal recovery registry, owner-relative NodePaths and shared ownership boundaries. Preserve the corrected `OOB_SouthPerimeter` transform and actual Arrival-floor AABB proof exactly. Implement `STAGED_SLICE_3` exactly and require full `PRODUCTION` validation at G10/final acceptance.
12. Never use global name scanning, private Player/SoulShard/Portal state or local scene-loading hacks.
13. Run and report required static, automated and manual checks after every slice.
14. Provide commit SHA, branch, changed files, checks, risks and NOT VERIFIED items in every handoff.
15. Produce `docs/development/Level_04_Greybox_Implementation_Summary.md` in the repository and mandatory `Level_04_Greybox_Implementation_Summary.docx` outside the repository worktree in Slice 11. Do not commit the DOCX unless a separate explicit PR-scope decision authorizes that exact artifact; this grants no authority over any other file.
16. Populate both summaries with the complete explicit schema in Sections 26 and 29, including every test result as `PASS`, `FAIL` or `NOT VERIFIED`, both full sequence traces, P0-53/P0-54 evidence and remaining Art Bible/post-greybox work.
17. Never claim PASS when mandatory evidence was not verified.


# 29. Final implementation handoff requirements

Slice 11 must create exactly:

- `docs/development/Level_04_Greybox_Implementation_Summary.md` - mandatory committed runtime-PR evidence;
- `Level_04_Greybox_Implementation_Summary.docx` - mandatory content-equivalent user-facing artifact created under the exact `CREATE - USER ARTIFACT OUTSIDE REPOSITORY WORKTREE` authority.

The DOCX must be generated outside the repository worktree and must not be committed unless a separate explicit PR-scope decision authorizes that exact file. Creating it grants no write authority to any other external file or repository path.

Both summaries must explicitly contain:

- exact implementation base SHA;
- active PR/base decision;
- every shared prerequisite, its status and exact approved head SHA;
- branch and PR;
- one commit entry for each Slice 1 through Slice 11;
- exact files created;
- exact files modified;
- exact matching `.gd.uid` mapping;
- complete UT/ST/P0/P1 results with `PASS`, `FAIL` or `NOT VERIFIED` for every ID, including P0-53 and P0-54;
- proven Player spawn and RA root-Y values;
- exact recovery registry evidence;
- corrected `OOB_SouthPerimeter` AABB proof with position `Vector3(0.00, 1.00, -65.00)`, rotation `Vector3(0,0,0)`, extents `Vector3(39.00, 10.00, 4.00)`, inner face `Z=-61.00`, Arrival legal south edge `Z=-59.00`, separation `2.00 m`, mandatory shoulder `1.25 m` and residual Player-collider allowance `0.75 m`;
- full Sequence A execution trace;
- full Sequence B execution trace;
- exact-copy evidence for Shard_08, Shard_09 and `LEVEL_04_MAIN_TEXT`;
- finale fail-closed evidence;
- shared LevelPortal ownership evidence;
- stationary portal early-overlap evidence;
- one-transition evidence;
- final node tree and every API deviation, if any;
- performance and timing evidence;
- known warnings;
- known limitations;
- blockers and every `NOT VERIFIED` item;
- explicit confirmation that shared files, `project.godot`, other levels and final assets were not changed;
- remaining art-stage work, explicitly enumerating every still-unimplemented Art Bible family and all post-greybox production work;
- final Definition of Done verdict.

The Markdown and DOCX summaries must be generated from one semantic source and remain content-equivalent.

# Appendix A. Source traceability

| Reference section | Primary authority |
|---|---|
| Emotional function and exact copy | Narrative v1.1 |
| Topology reading and visual equality | Visual Master v1.2 |
| Coordinates, routes, clearances, CP/RA and acceptance | Gameplay Spec v1.2 |
| Nodes, APIs, signals, state models and shared ownership | Technical Architecture v1.2 |
| Layer ownership and greybox/final-art boundary | Art Production Bible v1.1 |
| Current shared compatibility and base | Fresh Slice 0 repository inspection |
| Codex implementation reference | `docs/design/Level_04_Greybox_Development_Reference_v1.3.md` |
| Content-equivalent Producer reference | `Level_04_Greybox_Development_Reference_v1.3.docx` |

# Appendix B. Controller property and startup wiring contract

Minimum exported property sets:

**Progress:** controller paths, shard-slot paths, remaining-zone paths, `environment_controller_path = ../../EnvironmentStateRoot/Level04EnvironmentStateController`, finale/portal/recovery paths.  
**Canopy/Ripple:** branch ID, expected IDs, explicit footprint paths, presentation path, Player path, hint delays.  
**PresenceFootprint:** exact Player path, target/marker ID, footprint ID, typed RouteContext, 0.45 s dwell, grounded required.  
**ShardSlot:** shard ID, exact reward text, SoulShard path, Player path, first/remaining anchors, reveal VFX path, reveal duration/timeout.  
**Level04EnvironmentStateController:** dedicated child of `EnvironmentStateRoot`; `world_environment_path = ../WorldEnvironment`; `lighting_root_path = ../LightingRoot`; guidance paths and WeatherWeave path resolve through `../../VFXRoot/...`; no PortalAccent path. The root owns no controller script.  
**Finale:** Player, FinalTextGate, LevelFinaleOverlay and RecoveryController paths.  
**PortalAdapter:** PortalFloorAnchor, shared LevelPortal and PortalAccent paths only; no Player path.  
**RecoveryAnchorZone:** canonical ID, FloorAnchor, ArrivalZone and Player path.  
**RecoveryController:** Player path, the exact five literal volume paths/IDs/transforms/extents from Section 8.8, the corrected `OOB_SouthPerimeter` center `Z=-65.00` and actual-floor AABB proof (`Z=-59.00` legal edge, `Z=-61.00` inner face, `2.00 m` separation, `1.25 m` shoulder, `0.75 m` current-Player-collider allowance), all 12 explicit RA paths and source-key suspension state.

Startup validation is fail-closed in `PRODUCTION` for incorrect IDs, missing paths, wrong types, duplicate registries, incorrect five-volume recovery registry, an obsolete or mismatched south-perimeter transform, failure of the actual-floor AABB proof, missing UI API, wrong portal configuration, non-local runtime resources, missing SoulOrb continuity or malformed footprint mapping. `STAGED_SLICE_3` permits only the exact deliberately unresolved dependencies named in Section 12.1 and must be replaced by full `PRODUCTION` validation at G10.

---

**End of Level_04 Greybox Development Reference v1.3**
