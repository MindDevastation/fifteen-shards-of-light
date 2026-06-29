# FIFTEEN SHARDS OF LIGHT
# Level_06 - «Ты восхищаешь меня»
## Greybox Development Reference

| Control | Value |
|---|---|
| Repository | `MindDevastation/fifteen-shards-of-light` |
| Target scene | `res://scenes/levels/Level_06.tscn` |
| Reference version | 1.2.1 |
| Primary implementation reference artifact | `Level_06_Greybox_Development_Reference_v1.2.1.md` |
| Content-equivalent Producer artifact | `Level_06_Greybox_Development_Reference_v1.2.1.docx` |
| Delivery model | The complete seven-artifact external READ ONLY packet is supplied to Codex with the implementation prompt; runtime slices neither create nor commit any packet artifact. |
| Implementation branch after APPLY | `feature/implement-level-06-greybox` |
| Portal target | `res://scenes/core/FinalScene.tscn` |
| Mode | Documentation only - no runtime files, branches, commits or PRs |
| Prepared | 29 June 2026 |

> **Emotional safety contract**  
> Героиня не сломана, и ее никто не чинит. Ее свет, красота, живость и способность увлекаться уже принадлежат ей. Level_06 выражает восхищение автора, но не превращает его в право на доступ, ответ, благодарность, взаимность или полное знание. Среда уже жива в E0; прогресс показывает ясность авторского чувства и навигационную читаемость, а не восстановление ценности.

# Version 1.2.1 Change Log

- V121-01 - Removed the pre-Slice-12 integration deadlock by defining one exact temporary `Level06IntegratedFlowHarness` fixture for Slices 6-8 while preserving all final production RuntimeRoot wiring and proxy registration in Slice 12.
- V121-02 - Split evidence into factual local-component/temporary-integrated-flow PASS and the distinct `DEFERRED TO G12 PRODUCTION WIRING` status; temporary harness proof is explicitly not production-scene wiring proof.
- V121-03 - G12 now requires production-scene evidence for Wake -> Shard_13 -> E1/VEILS_ACTIVE, Veils -> Shard_14 -> E2/CONSTELLATION_ACTIVE, Constellation -> Shard_15 -> ALL_REWARDS_COMPLETE, E3 -> FinalTextGate, actual main-text close -> E4/portal activation and one complete natural-flow run without a harness-only bypass.
- V121-04 - Unified the persistent and temporary `.gd.uid` policy across Slices 0-13, scope-consistency acceptance, ST-17/ST-20, Master File Ownership, Appendix D and Definition of Done.
- V121-05 - Corrected Slice 0 end-state wording: only a successful preflight ends `WAITING FOR APPLY`; a blocked preflight ends `PREFLIGHT BLOCKED - APPLY NOT ACCEPTED`.
- V121-06 - Corrected Slice 13 summary placement: repository Markdown is created inside the worktree and committed; the content-equivalent DOCX is created outside the worktree and is not committed.
- V121-07 - Slices 1-12 now report PR link as `N/A until Slice 13`; gates, UT/ST/P0/no-softlock matrices, Codex prompt, final handoff and Appendices C-D were synchronized.
- V121-08 - Markdown and DOCX were regenerated from one semantic source; comments/tracked changes were removed; table-by-table equivalence, metadata and full rendered-page QA were repeated.

# Version 1.2 Change Log

- V12-01 - Slice 0 dependency classification split into static integration dependencies (`PASS` / `BLOCKER` / `NOT VERIFIED`) and runtime-only P0 prerequisites (`DEFERRED TO OWNER P0` / factual `PASS` / factual `FAIL`), removing the pre-APPLY runtime-proof deadlock while preserving evidence honesty.
- V12-02 - successful and blocked Slice 0 handoffs now end with mutually exclusive exact lines: `WAITING FOR APPLY` or `PREFLIGHT BLOCKED - APPLY NOT ACCEPTED`.
- V12-03 - temporary harness scopes re-audited and closed with exact literal fixtures, executable runners, fake/spy scripts and removable generated sidecars for the owning slices and the full Slice 13 regression run.
- V12-04 - the complete seven-artifact external READ ONLY packet is mandatory, hash-recorded in Slice 0 and supplied to Codex with the implementation prompt.
- V12-05 - Slice 13 now defines one exact post-acceptance repository-metadata lifecycle: summary generation and commit, branch push, exactly one PR creation, and an appended final PR handoff carrying URL/head/base metadata.
- V12-06 - deterministic bootstrap readiness ordering added through a root-level `Level06BootstrapReadinessCoordinator`; arbitrary timers, sleeps, guessed frames, retry loops and partial arming are forbidden.
- V12-07 - canonical `TRANSFORM_EPSILON = 0.001` added for position, basis/forward, identity-child and Player/SpawnRoot transform comparisons; raw floating-point equality is forbidden.
- V12-08 - bootstrap wording, UID rules, ST/P0/no-softlock matrices, Appendices A/C-E, Definition of Done, Codex prompt and final handoff synchronized.
- V12-09 - Markdown and DOCX regenerated from one semantic source; comments/tracked changes removed; table-by-table equivalence and full DOCX render QA repeated.

# Version 1.1 Change Log

- V11-01 - formal source hierarchy expanded to all five approved design/architecture/art sources, factual repository/PR authority and lower-priority AGENTS/legacy context with explicit conflict rules.
- V11-02 - canonical reference delivery changed to two external READ ONLY Producer artifacts supplied to Codex with the implementation prompt; runtime slices no longer create or commit the reference itself.
- V11-03 - Slice 0 tightened to metadata-and-file inspection only with zero diff, no branch/commit/PR/UID/import/generated output, dependency classification PASS/BLOCKER/NOT VERIFIED and an exact final `WAITING FOR APPLY` line.
- V11-04 - Slice 1-13 file scopes fully audited and expanded with literal previously-created Level_06 dependencies, shared dependencies, external Producer artifacts, temporary files, matching UID sidecars and forbidden boundaries.
- V11-05 - scope-consistency acceptance added to every slice and the static matrix; inconsistency is a hard stop before any write.
- V11-06 - Appendices D and E replaced with a Greybox Reference Producer checklist and Greybox v1.1 source traceability, including primitive-only and collision/art separation contracts from Art Production Bible v1.1.
- V11-07 - corrected `own its own control lock`, updated document map, master ownership, Definition of Done, Codex prompt and final-summary requirements.
- V11-08 - Markdown and DOCX regenerated from one semantic source; comments/tracked changes removed and full render/equivalence QA repeated.

# Version 1.0 Change Log

- V10-01 - создан единый Greybox Development Reference на основе пяти утвержденных Level_06 source documents.
- V10-02 - зафиксированы exact P00-P30, Z00-Z11, puzzle targets, recovery volumes, B0-B5, Q0-Q5, RA0-RA13, canonical IDs и exact player-facing copy.
- V10-03 - перенесены approved root ownership, exact NodePaths, atomic bootstrap, generation domains, macro FSM, reward/release, environment, finale, portal and recovery contracts.
- V10-04 - сложная реализация разделена на Slice 0-13; независимые risky systems не объединены ради фиксированного количества slices.
- V10-05 - добавлены literal per-slice file scopes, matching Level-local `.gd.uid` rules, temporary-harness cleanup and defect-fix reopening policy.
- V10-06 - добавлены UT/ST/P0/P1, acceptance, softlock and Producer-gate matrices, Definition of Done and final Codex handoff schema.
- V10-07 - Markdown и DOCX сгенерированы из одного semantic source и проходят equivalence/render QA.

# 1. Document map

| Section | Purpose |
|---|---|
| 2-5 | Source authority, repository snapshot, scope and hard rules |
| 6-10 | Canonical copy, geometry, sightlines, recovery and scene/file layout |
| 11-21 | Ownership, APIs, bootstrap, generations, macro/puzzle/reward/environment/finale/portal/recovery models |
| 22-35 | Slice 0-13 exact execution contracts |
| 36-46 | File ownership, matrices, Producer gates, Definition of Done, branch/PR, Codex prompt and final handoff |
| Appendices A-E | Exact constants, P00-P30 registry, normative API/signal registry, Producer checklist and Greybox source traceability |


# 2. Source-of-truth hierarchy

| Priority | Authoritative source | Controls | Conflict rule |
|---|---|---|---|
| 1 | Level_06 Narrative and Level Scenario Package v1.1 | Exact title/copy, exactly three shards, emotional meaning, fixed narrative order and FinalScene boundary. | Narrative is immutable for player-facing language and emotional meaning. No downstream source may paraphrase exact copy, add emotional debt or move confession/acrostic content into Level_06. |
| 2 | Level_06 Visual Master Concept Package | High silver meadow identity, ascending crescent, Clear Veils primary concept, landmark hierarchy and E0-E4 visual intent. | Visual intent may not alter exact gameplay geometry, ownership or runtime state authority. |
| 3 | Level_06 Gameplay Map and Complete Level Design Specification v1.3 | Exact P00-P30/Z00-Z11 geometry, mechanics, target volumes, B0-B5/Q0-Q5 recovery geometry, RA0-RA13, traversal clearances and pacing. | Gameplay is authoritative for exact geometry, mechanics, recovery and pacing. No architecture or repository placeholder may silently move or reinterpret these values. |
| 4 | Level_06 Technical Architecture and State Model v1.2.2 | Canonical root ownership, exact NodePaths, APIs/signals, atomic bootstrap, generation domains, state models, reward/release, portal and recovery authority. | Technical Architecture is authoritative for ownership, exact NodePaths, APIs, generations and state machines. Implementation must stop rather than invent a conflicting contract. |
| 5 | Level_06 Art Production Bible v1.1 | Primitive-only GB-P0 boundary, gameplay/collision versus visual ownership, exact corridor/lip art constraints and deferred post-greybox replacement workflow. | Art Bible controls greybox/art separation. It cannot authorize Blender, GLB, final materials, wrappers or collision replacement during greybox implementation. |
| 6 | Current repository `main` and active PR stack | Existing files/APIs, current placeholder drift, current head/tree facts, active intersections and viable implementation base. | Factual integration authority only, not a design source. Repository facts may trigger a prerequisite or base decision, but may not silently change approved design. |
| 7 | `AGENTS.md` and legacy history | Narrow-slice workflow, no unrelated changes, historical context and handoff discipline. | Lower-priority workflow/context authority where superseded by the approved six-chapter route and the five sources above. |

## 2.1 Conflict-resolution rules

- Narrative controls exact copy, emotional meaning and the FinalScene boundary.
- Gameplay controls exact geometry, mechanics, recovery and pacing.
- Technical Architecture controls ownership, exact NodePaths, APIs, generation domains and state models.
- Art Production Bible controls the primitive-only boundary, collision/art ownership and independent post-greybox replacement stages.
- Visual Master controls visual identity and composition only inside those exact gameplay and architecture constraints.
- Current repository and active PR facts can force a narrow shared prerequisite, exact stacked-base decision or hard stop. They cannot silently cancel or redesign approved contracts.
- Where two approved sources appear inconsistent, implementation stops and records the exact conflict for Producer resolution before any write.

## 2.2 Canonical external artifact packet and delivery model

The implementation prompt must supply Codex the complete seven-artifact READ ONLY packet:

1. `Level_06_Greybox_Development_Reference_v1.2.1.md`
2. `Level_06_Greybox_Development_Reference_v1.2.1.docx`
3. `Level_06_Narrative_and_Level_Scenario_Package_v1.1.docx`
4. `Level_06_Visual_Master_Concept_Package.docx`
5. `Level_06_Gameplay_Map_and_Level_Design_Spec_v1.3.docx`
6. `Level_06_Technical_Architecture_and_State_Model_v1.2.2.docx`
7. `Level_06_Art_Production_Bible_v1.1.docx`

Delivery rules:

- The Markdown reference is the external approved Producer implementation reference.
- The DOCX reference is its content-equivalent external Producer artifact.
- All seven artifacts are supplied to Codex together with the implementation prompt and remain READ ONLY through Slice 0-13.
- Slice 0 records the factual filename, byte size and SHA-256 hash for every artifact and stops if any required artifact is missing, unreadable or named inconsistently with the controlling packet.
- None of the seven artifacts is created, modified, renamed or committed by runtime slices.
- Reference/source publication is separate from runtime implementation and grants no repository write authority.

# 3. Fresh repository inspection snapshot

The documentation-stage repository inspection resolved:

| Item | Fresh factual result | Consequence |
|---|---|---|
| Default branch | `main` | Slice 0 must refresh the exact head before any APPLY. |
| Current main SHA | `56410298d9a2f4783e9512a84653b03e73ee3e50` | Compatibility snapshot only; not permanent implementation authority. |
| Open PRs | `0` at this documentation inspection | Slice 0 still repeats active-PR inspection. |
| `AGENTS.md` | Stale 15-micro-level canon, but valid narrow-slice/no-unrelated-change workflow | Approved six-chapter documents override creative canon only. |
| Current `Level_06.tscn` | Flat 12 x 12 floor, legacy LevelManager, one SoulShard, PoemRewardUI and portal to Level_07 | Complete Level-local rewrite later; placeholder is not canon. |
| `project.godot` | Godot 4.6, Forward Plus, Jolt, 60 FPS; `SceneTransition` and `DevLevelMenu` autoloads | No project setting or autoload change is authorized. |
| Shared Player | `CharacterBody3D`; public `set_controls_enabled(bool)`; private step-climb transient state | Recovery may only set public transform/velocity; private fields forbidden; P0 prerequisite gate remains. |
| Shared SoulShard | exact `shard_id`, `reward_text`, request and collected signals; body-entered interaction bookkeeping | Reuse through Level06ShardSlot; stationary pre-overlap is a mandatory shared-contract P0 gate. |
| Shared LevelPortal | owns activation, InteractionArea, AUTO_ENTER, transition latch and scene loading | Local adapter never loads scenes or owns overlap filtering. |
| SceneTransition chain | `project.godot` autoload -> LevelPortal `/root/SceneTransition.transition_to()` -> `change_scene_to_file()` -> destination signals; LevelPortal has direct fallback if autoload unavailable | Slice 0 must inspect both scene/script and active-PR intersections; Level_06-local loading is unnecessary and forbidden. |
| FinalScene | Existing greybox pedestal/sphere/EndingOverlay placeholder | Valid technical target path; creative content remains separate scope. |

Repository evidence must be refreshed in Slice 0. Any active PR touching Player, Camera, SoulShard, reward UI/controller, SoulOrb, LevelPortal, SceneTransition, FinalScene or Level_06 source contracts is a base-decision trigger.

# 4. Scope

## Included

- Complete primitive-only playable Level_06 greybox.
- Exact continuous ascending crescent P00-P30 and Z00-Z11.
- Exact legal corridor, shoulders, jumpable lips, boundaries, dangerous Last Light crossing and recovery service geometry.
- Silver Wake, Clear Veils and Horizon Constellation.
- Shard_13, Shard_14 and Shard_15 using shared SoulShard/reward/orb flow.
- Atomic prepare/commit bootstrap and exact contract validation.
- Independent release-validity domain.
- E0-E4 nonblocking environment presentation.
- Exact main text and fail-closed bridge.
- Last Light Walk and shared AUTO_ENTER LevelPortal to FinalScene.
- RecoveryController-owned provenance, generations, token/latch/suspension/anchor/rearm architecture.
- Full automated/static/manual/no-softlock evidence and final summaries.

## Excluded

- Blender, GLB, textures, final materials, final art wrappers, custom collision GLB and art production.
- Final particles, polished VFX, sound, music, voiceover and cinematics.
- Dynamic sky, volumetric cloud sea, cloth simulation and complex constellation solver.
- Save system, GameState, persistent checkpoints or new autoload.
- FinalScene creative or runtime development.
- Level_07-Level_15 cleanup.
- Acrostic, direct love confession, response-space wording and EndingOverlay redesign.
- Broad shared-system refactors.
- Project settings changes.

# 5. Hard execution and integration rules

- Slice 0 is fully inspection-only and creates zero diff. Only a successful Slice 0 ends `WAITING FOR APPLY`; a blocked path ends `PREFLIGHT BLOCKED - APPLY NOT ACCEPTED`.
- Only one explicit APPLY is required.
- After APPLY, reconfirm clean status and approved base, create `feature/implement-level-06-greybox`, verify branch/HEAD, then execute Slices 1-13 sequentially.
- Each slice is validated and committed before the next slice begins.
- Internal gates do not require user confirmation when PASS.
- Stop only for P0 failure, shared-system blocker, file-scope deviation, unresolved PR/base conflict, Producer-only decision or mandatory evidence that cannot be verified.
- No implementation directly on `main`.
- No broad node-name scan, current-scene scan, group-based owner discovery, child-order identity or nearest-anchor inference.
- No gameplay scripts on raw GLB imports.
- No LevelManager or PoemRewardUI extension.
- No local scene loading.
- No synthetic shard collected, portal success, main-text close or recovery success.
- Exact IDs and generations are authority; blind count increment is not.
- Environment transitions never lock Player and never gate gameplay.
- Quiet Horizon is non-interactive.
- Temporary harnesses are removed before every commit.
- Mandatory NOT VERIFIED evidence blocks final acceptance.
- Scope inconsistency is a hard stop before any write and before every commit.


## 5.1 Dependency classification contract

### Static integration dependencies

Static integration dependencies use exactly `PASS`, `BLOCKER` or `NOT VERIFIED`.

They include exact file/API/signal existence, signatures, serialized exports, shared ownership, source-document availability, exact target paths, active PR/base conflicts and the ability to name one valid implementation base. Any mandatory static `BLOCKER` or `NOT VERIFIED` blocks APPLY.

### Runtime-only P0 prerequisites

Runtime-only prerequisites use exactly `DEFERRED TO OWNER P0`, factual `PASS` after runtime proof or factual `FAIL` after runtime failure.

`DEFERRED TO OWNER P0`:

- is not PASS and is not compatibility evidence;
- does not by itself block APPLY;
- must name the exact owning slice and P0 IDs;
- blocks continuation beyond the owning gate and blocks final Definition of Done until converted by actual runtime evidence to PASS;
- becomes FAIL only from an actual runtime failure, which triggers the documented hard stop and prerequisite process.

Mandatory runtime-only prerequisites include:

| Runtime-only prerequisite | Slice 0 status before runtime proof | Exact owner and P0 evidence |
|---|---|---|
| Stationary newly enabled SoulShard overlap for Shard_13 | `DEFERRED TO OWNER P0` | Slice 6; P0-06 |
| Stationary newly enabled SoulShard overlap for Shard_14 | `DEFERRED TO OWNER P0` | Slice 7; P0-11 |
| Stationary newly enabled SoulShard overlap for Shard_15 | `DEFERRED TO OWNER P0` | Slice 8; P0-16 |
| Stationary AUTO_ENTER LevelPortal overlap | `DEFERRED TO OWNER P0` | Slice 11; P0-27 and P0-28 |
| Player external-teleport transient/step-climb behavior | `DEFERRED TO OWNER P0` | Slice 3; P0-41 |
| Real SceneTransition destination replacement proof | `DEFERRED TO OWNER P0` | Slice 11; P0-28, P0-44 and P0-46 |

Mandatory `NOT VERIFIED` or `DEFERRED TO OWNER P0` evidence may never be reported as PASS in final acceptance.

## 5.2 Global UID and generated-file policy

The following exact rule applies without variation in Slices 0-13:

- A persistent matching `.gd.uid` is permitted only together with its exact sibling `.gd`, and that sibling path must be explicitly listed in the active slice `CREATE` or `MODIFY` scope.
- A temporary matching `.gd.uid` is permitted only together with its exact sibling `.gd`, and both exact paths must be explicitly listed in the active slice `TEMPORARY CREATE - REMOVE BEFORE COMMIT` scope.
- Every temporary script and every temporary sidecar is removed before commit.
- A UID for any script outside the active slice `CREATE`, `MODIFY` or `TEMPORARY CREATE - REMOVE BEFORE COMMIT` scope is forbidden.
- Unrelated `.gd.uid`, scene UID, `.import`, `.godot/imported`, cache and generated churn are forbidden.
- Slice 0 has no active `CREATE`, `MODIFY` or `TEMPORARY` script scope, so it permits no UID or generated file.

## 5.3 Pre-Slice-12 temporary integrated-flow evidence

Final production RuntimeRoot attachment, exact production NodePath wiring and atomic production RewardGate proxy registration remain owned exclusively by Slice 12. Slices 4-5 may keep their production controllers unattached without preventing factual integration testing in Slices 6-8.

Slices 6, 7 and 8 each temporarily create and remove the same exact fixture:

- `tests/levels/level_06/harness/Level06IntegratedFlowHarness.tscn`
- `tests/levels/level_06/harness/level_06_integrated_flow_harness.gd`
- `tests/levels/level_06/harness/level_06_integrated_flow_harness.gd.uid`

The fixture contract is exact:

- It instantiates the real Level_06-local controllers available through the owning slice and the real shared READ ONLY Player, SoulShard, SoulOrb, reward controller/overlay and related scenes/scripts.
- It uses the production Appendix C APIs, exact prepare/commit contract and explicit RewardGate proxy registration sequence. It does not add test-only methods or branches to production scripts and does not introduce a staged production mode.
- It drives actual shared SoulShard interaction and reward presentation/confirmation. It must not synthesize `SoulShard.collected`, reward success, main-text close or portal success, and it must not call a harness-only bypass to advance macro state.
- It may orchestrate test Player placement/input and observe production signals, but only actual shared flow may produce collection and reward-complete authority.
- It and every generated temporary sidecar are removed before the owning slice commit.

Evidence is split into two non-interchangeable classes:

- `TEMPORARY INTEGRATED-FLOW PASS` may be awarded in Slices 6-8 when the owning local component and the temporary real-shared-flow fixture factually pass.
- Production `scenes/levels/Level_06.tscn` natural-flow wiring remains `DEFERRED TO G12 PRODUCTION WIRING` through G6-G8. This status is not PASS and temporary harness proof must never be described as final production wiring proof.
- `DEFERRED TO G12 PRODUCTION WIRING` does not block Slice 6 -> 7 or Slice 7 -> 8 when the owning local and temporary integration gate passes. It does block G12 and final Definition of Done until Slice 12 proves the same flow in the fully assembled production scene.

# 6. Canonical identities and exact copy

## 6.1 Immutable IDs

| Domain | Canonical IDs |
|---|---|
| Shards | Shard_13, Shard_14, Shard_15 |
| Puzzles | SILVER_WAKE, CLEAR_VEILS, HORIZON_CONSTELLATION |
| Silver Wake | WAKE_BAND_1, WAKE_BAND_2, WAKE_BAND_3 |
| Clear Veils | VEIL_LAYER_1, VEIL_LAYER_2, VEIL_LAYER_3 |
| Horizon Constellation | CONSTELLATION_WEST, CONSTELLATION_CREST, CONSTELLATION_EAST |
| Environment | E0_INITIAL, E1_AFTER_SHARD_13, E2_AFTER_SHARD_14, E3_AFTER_SHARD_15, E4_AFTER_MAIN_TEXT |
| Recovery | RV_FALL_GLOBAL, RV_LAST_LIGHT_DROP_CATCHER, LL_EDGE_EXIT_RIBBON, RA0…RA13 |
| Suspension sources | shard_reward, main_text |
| Target scene | res://scenes/core/FinalScene.tscn |
| Bootstrap | validation_generation; run_generation |
| Release validity | VALID, NARRATIVE_PRESENTATION_FAILED |
| Portal attempt | DORMANT, ACTIVATING, EXIT_ACTIVE, TRANSITION_IN_FLIGHT (retryable; outside macro ordinal) |
| Raw support classes | SUPPORT_NONE, SUPPORT_LOWER_LEGAL, SUPPORT_LAST_LIGHT_OR_PORTAL |
| Generation domains | validation_generation, run_generation, reward_generation, presentation_generation, slot_generation, target_generation, zone_generation, hint_generation, source_generation, portal_attempt_generation, capture_generation |

## 6.2 Exact player-facing text

| ID | Exact locked text |
|---|---|
| `Shard_13` | Ты очень красивая - и я правда восхищаюсь твоей красотой. |
| `Shard_14` | Меня восхищает, как ты умеешь по-настоящему загораться тем, что тебе интересно. |
| `Shard_15` | Ты удивительная - и своей красотой, и тем, как сильно умеешь загораться идеей. |
| `LEVEL_06_MAIN_TEXT` | Мне трудно свести мое восхищение тобой к одной причине. Меня волнует твоя красота, и мне очень дорого видеть, как увлеченно ты можешь заниматься тем, что тебя по-настоящему захватывает. Но даже эти слова не объясняют тебя целиком - и я не хочу делать вид, будто знаю о тебе все. Я просто точно знаю, что восхищаюсь тобой. Дальше мне осталось сказать только самое главное. |

All four strings are compared character-for-character. RewardGate compares the actual shard's serialized `reward_text` before proxy emission. Empty, mismatched or generic fallback text marks the run `NARRATIVE_PRESENTATION_FAILED` before logical continuation.

# 7. Exact world, route and gameplay geometry

## 7.1 World and traversal contract

| Parameter | Exact contract |
|---|---|
| Origin / axes | Scene-local Godot coordinates. +X east, -X west, +Z north/up-route, -Z south/spawn; +Y vertical. |
| Gameplay envelope | X -30.00..+30.00; Z -58.00..+58.00 applies to mandatory playable collision, puzzle targets and compact gameplay anchors. Recovery/service volumes may extend only for fall coverage; they create no floor, standable geometry, route or gameplay acceptance outside the envelope. |
| Authored floor Y | P00-P30 Y values are floor elevations. Player recovery roots are normally floor Y + 1.00 m. |
| Legal route | 6.00 m clear traversable route plus 1.50 m legal shoulder each side = 9.00 m total safe corridor. |
| Mandatory slope | <= 8.00°; this layout maximum is <= 3.96°. Cross-slope <= 3.00°. |
| Mandatory steps/gaps | Step <= 0.15 m; no mandatory gap or jump. |
| Recovery/service bounds | A01 does not apply to RV_FALL_GLOBAL, RV_LAST_LIGHT_DROP_CATCHER or LL_EDGE_EXIT_RIBBON / LLR_SEG_* service geometry. They have separate coverage and false-positive acceptance criteria. |

Additional locked boundary contract:

- 6.00 m clear route + 1.50 m legal shoulder each side = 9.00 m legal corridor.
- Outside each legal shoulder, the exact natural jumpable lip is 0.75 m high x 0.55 m thick.
- Route openings preserve the full 9.00 m corridor.
- Dangerous boundary B0-B5 along P27-P30 remains physically crossable; no unjumpable belt, hidden wall, catch ledge or standable underside.
- No invisible catch floor, no hidden route mutation and no geometry bridging gaps.
- Gameplay envelope applies to mandatory playable collision and compact gameplay anchors; recovery/service geometry has separate non-playable coverage rules.

## 7.2 Z00-Z11 zone registry

| ID | Zone | Exact footprint | Floor Y | Gameplay function |
|---|---|---|---|---|
| Z00 | Lower Cloud Terrace | Ellipse center (-22.00,-51.00); width 16.00 m on world X; depth 14.00 m on world Z; heading 0°. | Y 0.80 | Bounds X -30..-14, Z -58..-44. |
| Z01 | Silver Wake corridor | Swept P01-P07; 6.00 route + 1.50 shoulders; target sections have 0.10 m colliding lip each side. | Y 1.05..3.25 | Three ordered crossings. |
| Z02 | Shard_13 Overlook | Ellipse center (15.00,-7.50); width 12.00 X; depth 11.00 Z; heading 0°. | Y 3.45 | Shard root and reward-safe floor. |
| Z03 | Ridge Rest | Swept P08-P11; total legal corridor 9.00 m. | Y 3.45..4.55 | No task. |
| Z04 | Clear Veils lane | Swept P11-P15; total legal corridor 9.00 m; 0.10 m colliding lips at crossing sections. | Y 4.55..6.35 | Three transparent layers. |
| Z05 | Shard_14 Shelf | Ellipse center (-14.00,29.00); width 12.00 X; depth 10.00 Z. | Y 6.35 | No shrine framing. |
| Z06 | Open Sky Approach | Swept P15-P18; total legal corridor 9.00 m. | Y 6.35..7.50 | Three upper zones visible. |
| Z07 | Horizon Amphitheater | Rounded offset-hull floor: H = convex hull of WEST (-20.00,47.50), CREST (-10.00,53.00), EAST (0.00,47.50), then H ⊕ disk R5.00 in XZ. Exact bounds X -25.00..+5.00, Z 42.50..58.00. | Y 7.50..8.60 | One continuous wide floor; all three R4.60 zones contained with 0.40 m reserve. |
| Z08 | Shard_15 Plateau | Ellipse center (-10.00,46.50); width 16.00 X; depth 12.00 Z. | Y 8.20 | Central dry reward floor. |
| Z09 | Quiet Horizon / Main Text | Ellipse center (2.50,49.50); width 18.00 X; depth 14.00 Z. | Y 8.60 | FinalTextGate R4.25 has >=2.75 m fall-boundary setback. |
| Z10 | Last Light Walk | Swept P21-P29; 6.00 route + 1.50 shoulders = 9.00 m safe corridor. | Y 8.60..10.70 | 65.17 m from P21 to P30. |
| Z11 | Portal pad | Ellipse center (24.00,8.50); width 12.00 m across portal; depth 10.00 m along portal facing; heading 5.71°. | Y 11.00 | Rotated bounds contained; portal subordinate. |

## 7.3 Puzzle target registry

| ID | Center Vector3 | Heading | Shape / size | Acceptance |
|---|---|---|---|---|
| WAKE_BAND_1 | (-9.00, 3.90, -45.50) | 58.39° | Oriented box A9.20 × H5.50 × L6.00 | Current Player-body overlap; 0.00 s; airborne valid. |
| WAKE_BAND_2 | (-2.50, 4.30, -41.00) | 51.34° | Same | Same. |
| WAKE_BAND_3 | (3.50, 4.70, -35.50) | 42.51° | Same | Same. |
| VEIL_LAYER_1 | (2.50, 7.50, 18.50) | -43.53° | Oriented box A9.20 × H5.50 × L6.00 | Current Player-body overlap; 0.00 s; airborne valid. |
| VEIL_LAYER_2 | (-2.50, 7.95, 23.00) | -52.70° | Same | Same. |
| VEIL_LAYER_3 | (-8.00, 8.40, 26.50) | -62.45° | Same | Same. |
| CONSTELLATION_WEST | (-20.00, 9.25, 47.50) | - | Cylinder R4.60 × H3.50 | 0.60 s accumulated grounded presence. |
| CONSTELLATION_CREST | (-10.00, 9.95, 53.00) | - | Cylinder R4.60 × H3.50 | Same. |
| CONSTELLATION_EAST | (0.00, 9.40, 47.50) | - | Cylinder R4.60 × H3.50 | Same. |
| FinalTextGate | (2.50, 10.35, 49.50) | - | Cylinder R4.25 × H3.50 | Eligible occupancy; no exit/re-entry. |

## 7.4 Spawn, landmarks, finale and portal

| Item | Exact placement | Required reading / proof |
|---|---|---|
| SpawnRoot | Vector3(-22.00, 1.80, -51.00) | Player root = floor +1.00 m; faces P01 at 72.90°. |
| Lower Cloud Terrace | World-aligned ellipse heading 0°; width 16.00 along X, depth 14.00 along Z. | X bounds -30..-14; Z bounds -58..-44. Exact containment passes. |
| First route read | P00 camera sees P01-P04, upper crescent silhouette and inactive distant portal as secondary. | Only one traversable forward route. |
| Shard_13 root | Vector3(15.00, 4.45, -7.50) | Broad overlook; >=2.00 m from fall boundary. |
| Shard_14 root | Vector3(-14.00, 7.35, 29.00) | Open shelf; upper three zones readable. |
| Shard_15 root | Vector3(-10.00, 9.20, 46.50) | Central plateau after 3/3 zones. |
| FinalTextGate | Vector3(2.50, 10.35, 49.50); cylinder R4.25 x H3.50 | Quiet Horizon platform width18/depth14 gives >=2.75 m minimum setback. |
| PortalFloorAnchor | Vector3(24.00, 11.00, 8.50) | Portal root on rotated 12 x 10 m pad. |
| Portal heading | 5.71° toward P29 | Faces back/up-route enough to remain readable but subordinate. |
| Portal target | res://scenes/core/FinalScene.tscn | Level_07 target is legacy drift. |

## 7.5 Camera and sightline QA registry

| Viewpoint | Must be visible | Must not dominate |
|---|---|---|
| P00 Arrival | One rising crescent, Wake bands, Quiet Horizon silhouette. | Dormant portal, shard VFX. |
| P08 Shard_13 | Persistent wakes below and transparent Veils ahead. | Constellation reward. |
| P15 Shard_14 | All three upper zones in one natural sweep. | Portal. |
| P18 Amphitheater entry | WEST / CREST / EAST zones and central plateau. | No hidden target or camera alignment. |
| P21 Quiet Horizon | All motifs coexist; main-text area calm. | Portal remains inactive. |
| P22-P29 Last Light | Active portal becomes the strongest single guide. | No alternate route or Level_07 detour. |

These viewpoints are QA obligations, not gameplay triggers. No camera alignment, forced camera or 360-degree search is permitted.

# 8. Recovery and Last Light exact registry

## 8.1 Recovery volumes and service nodes

| ID | Shape / exact data | Activation | Owner semantics |
|---|---|---|---|
| RV_FALL_GLOBAL | Area3D box center Vector3(0,-9,0), size Vector3(76,12,132), top Y=-3.00 | Authored from load; gameplay handling begins only after RecoveryController atomic commit. | RecoveryController resolves exact path, connects body_entered/body_exited once, filters body == canonical Player and creates/joins one internal global-fall observation/token. No adapter. |
| RV_LAST_LIGHT_DROP_CATCHER | Area3D box center Vector3(19,7,12), size Vector3(26,7,32); X6..32 Y3.5..10.5 Z-4..28 | MAIN_TEXT_CLOSED+ and current ARMED token. | RecoveryController owns exact body_entered/body_exited connections and canonical-Player filtering; internal catcher observation may promote matching ARMED -> PENDING. No adapter. |
| LL_EDGE_EXIT_RIBBON | Q0-Q5 centerline, swept R0.45, Y9.50..13.50 | MAIN_TEXT_CLOSED+. | Mathematical signed-crossing source; no floor/collision acceptance. |
| RecoveryAnchors | RA0-RA13 exact markers. | Each becomes latest valid only at canonical macro event. | No proximity-based forward skip. |

## 8.2 Dangerous boundary and continuous source ribbon

| Geometry set | Exact XZ values |
|---|---|
| Dangerous boundary B | B0 (21.047,27.319); B1 (21.011,26.821); B2 (20.513,19.847); B3 (20.019,13.911); B4 (18.030,9.097); B5 (17.839,8.635). |
| Ribbon centerline Q | Q0 (20.698,27.344); Q1 (20.662,26.846); Q2 (20.164,19.874); Q3 (19.670,13.943); Q4 (17.682,9.132); Q5 (17.491,8.670). |
| Coverage proof | Maximum boundary-to-centerline distance 0.351 m; R0.450 gives >=0.099 m reserve; round joins/caps produce 0.000 m gaps. |
| Lower-route separation | Minimum centerline separation 6.820 m; minus 4.500 m safe half-width and 0.450 m ribbon radius = 1.870 m positive separation. |

## 8.3 Canonical recovery anchors

| Anchor | Position | Earliest canonical state | Use |
|---|---|---|---|
| RA0 | (-22.00,1.80,-51.00) | L06_INIT+ | Spawn |
| RA1 | (-9.00,2.40,-45.50) | WAKE_BAND_1 accepted+ | After Wake 1 |
| RA2 | (-2.50,2.80,-41.00) | WAKE_BAND_2 accepted+ | After Wake 2 |
| RA3 | (8.50,3.55,-29.00) | WAKE_COMPLETE+ | Upper Wake curve |
| RA4 | (15.00,4.25,-14.50) | SHARD_13_AVAILABLE+ | Overlook entry |
| RA5 | (14.00,4.75,-0.50) | SHARD_13_REWARD_COMPLETE+ | Ridge Rest |
| RA6 | (2.50,6.00,18.50) | VEIL_LAYER_1 accepted+ | Veil 1 |
| RA7 | (-2.50,6.45,23.00) | VEIL_LAYER_2 accepted+ | Veil 2 |
| RA8 | (-14.00,7.35,29.00) | SHARD_14_AVAILABLE+ | Shard 14 shelf |
| RA9 | (-23.50,8.50,43.00) | CONSTELLATION_ACTIVE+ | Amphitheater entry |
| RA10 | (-19.00,8.80,47.00) | CONSTELLATION_PARTIAL+ | Inner approach |
| RA11 | (-10.00,9.20,46.50) | SHARD_15_AVAILABLE+ | Central plateau |
| RA12 | (7.00,9.85,53.50) | MAIN_TEXT_CLOSED / EXIT_ACTIVATING+ | Last Light start |
| RA13 | (24.50,11.70,13.50) | actual EXIT_ACTIVE+ | Portal approach outside InteractionArea |

## 8.4 Recovery geometry invariants

- `RV_FALL_GLOBAL` and `RV_LAST_LIGHT_DROP_CATCHER` create no floor, route, target or standable collision.
- `LL_EDGE_EXIT_RIBBON` is sensing/math only and covers Q0-Q5 continuously.
- B0-B5 remains deliberately crossable by ordinary jump.
- Lower-route separation and provenance prevent false positives.
- Recovery anchors advance only from canonical events, never proximity.
- Runtime root Y and floor contact are validated against actual Player grounding; exact approved anchor roots remain as listed.
- Recovery sets `Player.velocity = Vector3.ZERO`; extra movement transient cleanup requires a proven public Player API.


# 9. Proposed file tree

```text
scenes/levels/Level_06.tscn
scenes/levels/level_06/
├── geometry/
│   └── Level06GreyboxGeometry.tscn
├── environment/
│   └── Level06EnvironmentPresentation.tscn
├── puzzles/
│   ├── SilverWake.tscn
│   ├── ClearVeils.tscn
│   └── HorizonConstellation.tscn
└── systems/
    ├── Level06ShardSlot.tscn
    └── Level06RecoveryRig.tscn
scripts/levels/level_06/
├── level_06_contract.gd
├── level_06_bootstrap_readiness_coordinator.gd
├── level_06_runtime_contract_validator.gd
├── level_06_progress_controller.gd
├── level_06_release_validity_controller.gd
├── level_06_pass_through_target.gd
├── silver_wake_controller.gd
├── clear_veils_controller.gd
├── level_06_grounded_dwell_zone.gd
├── horizon_constellation_controller.gd
├── level_06_shard_slot.gd
├── level_06_reward_gate_controller.gd
├── level_06_environment_controller.gd
├── level_06_main_text_controller.gd
├── level_06_portal_adapter.gd
├── level_06_recovery_controller.gd
└── level_06_last_light_source.gd
docs/development/Level_06_Greybox_Implementation_Summary.md

USER ARTIFACT OUTSIDE REPOSITORY WORKTREE:
Level_06_Greybox_Implementation_Summary.docx
```

# 10. Canonical root node tree and subscenes

```text
Level_06 : Node3D + Level06BootstrapReadinessCoordinator
├── WorldRoot : Node3D
│   ├── WorldEnvironment : WorldEnvironment
│   ├── MoonLight : DirectionalLight3D
│   ├── CloudSeaRoot : Node3D
│   ├── LevelGeometry : instance(Level06GreyboxGeometry.tscn)
│   │   └── LegalSupport : Node3D
│   │       ├── LowerRoute : Node3D
│   │       └── LastLightAndPortal : Node3D
│   └── EnvironmentPresentation : instance(Level06EnvironmentPresentation.tscn)
│       └── script = Level06EnvironmentController
├── PlayerRoot : Node3D
│   ├── SpawnRoot : Marker3D
│   └── Player : instance(res://scenes/core/Player.tscn)
├── CameraRoot : Node3D
│   └── FollowCamera : Camera3D + res://scripts/player/camera_controller.gd
├── SoulOrbRoot : Node3D
│   └── SoulOrb_Follow : instance(res://scenes/core/SoulOrb_Follow.tscn)
│       └── HoverRoot/SoulOrb_Base : canonical soul_orb_visual
├── GameplayRoot : Node3D
│   ├── PuzzleRoot
│   │   ├── SilverWake : instance(SilverWake.tscn)
│   │   ├── ClearVeils : instance(ClearVeils.tscn)
│   │   └── HorizonConstellation : instance(HorizonConstellation.tscn)
│   ├── ShardRoot
│   │   ├── ShardSlot_13 : instance(Level06ShardSlot.tscn)
│   │   ├── ShardSlot_14 : instance(Level06ShardSlot.tscn)
│   │   └── ShardSlot_15 : instance(Level06ShardSlot.tscn)
│   ├── FinaleRoot
│   │   ├── FinalTextGate : Area3D
│   │   ├── LastLightGuidanceRoot : Node3D
│   │   └── PortalFloorAnchor/LevelPortal : shared instance
│   └── RecoveryRoot : instance(Level06RecoveryRig.tscn)
│       ├── RV_FALL_GLOBAL : Area3D
│       ├── RV_LAST_LIGHT_DROP_CATCHER : Area3D
│       ├── LL_EDGE_EXIT_RIBBON : Node3D + Level06LastLightSource
│       │   └── FloorProbe : ShapeCast3D
│       └── RecoveryAnchors/RA0 ... RA13
├── RuntimeRoot : Node
│   ├── Level06RuntimeContractValidator
│   ├── Level06ProgressController
│   ├── Level06ReleaseValidityController
│   ├── Level06RewardGateController
│   ├── ShardRewardSequenceController : shared instance
│   ├── Level06MainTextController
│   ├── Level06RecoveryController
│   └── Level06PortalAdapter
└── UILayer : CanvasLayer
    ├── ShardRewardOverlay : shared instance
    └── LevelFinaleOverlay : shared instance
```

## 10.1 Subscene ownership

| Future subscene | Root | Owns | Does not own |
|---|---|---|---|
| scenes/levels/level_06/geometry/Level06GreyboxGeometry.tscn | Node3D LevelGeometry | Static collision, P00-P30 geometry, and exact LegalSupport/LowerRoute + LastLightAndPortal ancestry roots. | Progress, recovery interpretation, trigger logic. |
| .../environment/Level06EnvironmentPresentation.tscn | Node3D EnvironmentPresentation + Level06EnvironmentController | The sole E0-E4 state owner, local presentation nodes, duplicated materials and presentation_generation. | Portal visuals, Player lock, puzzle or macro state. |
| .../puzzles/SilverWake.tscn | Node3D SilverWake | Three targets, visuals, local controller. | Shard or macro state. |
| .../puzzles/ClearVeils.tscn | Node3D ClearVeils | Three pass-through targets, veil visuals, local controller. | Shared materials or portal. |
| .../puzzles/HorizonConstellation.tscn | Node3D HorizonConstellation | Three grounded dwell zones, light groups, controller. | Main text or shard reward. |
| .../systems/Level06ShardSlot.tscn | Node3D Level06ShardSlot | One packed shared SoulShard lifecycle. | Reward overlay or macro sequencing. |
| .../systems/Level06RecoveryRig.tscn | Node3D RecoveryRoot | Exact RV_FALL_GLOBAL and RV_LAST_LIGHT_DROP_CATCHER Area3D nodes, LL_EDGE_EXIT_RIBBON/FloorProbe and RA0-RA13 markers. RecoveryController resolves/connects the Area3D signals directly. | Adapters, progress logic, environment presentation or a second recovery-state owner. |

## 10.2 Canonical transforms and shared exports

| Node | Canonical transform / key export | Reason |
|---|---|---|
| PlayerRoot | Canonical serialized PLAYER_SPAWN_TRANSFORM: origin Vector3(-22.00, 1.80, -51.00); no scale/shear; -basis.z equals normalize(Vector3(6.50, 0.00, 2.00)), the exact P00->P01 direction (heading 72.90°). | The parent owns the one spawn transform. |
| PlayerRoot/SpawnRoot | Local Transform3D.IDENTITY. Therefore global_transform equals PLAYER_SPAWN_TRANSFORM. | Canonical marker and Player spawn must compare equal without runtime relocation. |
| PlayerRoot/Player | Local Transform3D.IDENTITY. Therefore global_transform equals SpawnRoot.global_transform and PLAYER_SPAWN_TRANSFORM. | Serialized spawn only; validator must reject mismatch. Runtime teleport is forbidden as repair. |
| CameraRoot/FollowCamera | script=res://scripts/player/camera_controller.gd; target_path=NodePath("../../PlayerRoot/Player"); current=true. | Resolved target is the canonical Player and get_viewport().get_camera_3d() must be this exact FollowCamera. |
| SoulOrbRoot/SoulOrb_Follow/HoverRoot/SoulOrb_Base | Exact Node3D path; has_method(&"play_absorb_pulse"); is_in_group(&"soul_orb_visual"); is_visible_in_tree(); exact ancestor SoulOrb_Follow; unique visible eligible group member. | Canonical shared reward visual. The SoulOrb_Follow root itself is not orb_visual_path. |
| GameplayRoot/ShardRoot/ShardSlot_13 | Vector3(15.00, 4.45, -7.50) | Shard_13 root. |
| .../ShardSlot_14 | Vector3(-14.00, 7.35, 29.00) | Shard_14 root. |
| .../ShardSlot_15 | Vector3(-10.00, 9.20, 46.50) | Shard_15 root. |
| FinaleRoot/FinalTextGate | Vector3(2.50, 10.35, 49.50); Cylinder R4.25 × H3.50 | Main-text occupancy gate. |
| FinaleRoot/PortalFloorAnchor | Vector3(24.00, 11.00, 8.50); yaw 5.71° | Shared portal root and final target direction. |
| LevelPortal exports | AUTO_ENTER; require_entry_confirmation=false; target_scene_path=res://scenes/core/FinalScene.tscn | Approved exit contract. |

# 11. Exact owner-relative NodePaths

## 11.1 RuntimeRoot and shared dependencies

| Owner | Export | Exact NodePath |
|---|---|---|
| Level06BootstrapReadinessCoordinator | validator_path | RuntimeRoot/Level06RuntimeContractValidator |
|  | camera_path | CameraRoot/FollowCamera |
|  | orb_visual_path | SoulOrbRoot/SoulOrb_Follow/HoverRoot/SoulOrb_Base |
| Level06RuntimeContractValidator | progress_controller_path | ../Level06ProgressController |
|  | release_validity_controller_path | ../Level06ReleaseValidityController |
|  | reward_gate_path | ../Level06RewardGateController |
|  | shared_reward_controller_path | ../ShardRewardSequenceController |
|  | environment_controller_path | ../../WorldRoot/EnvironmentPresentation |
|  | main_text_controller_path | ../Level06MainTextController |
|  | recovery_controller_path | ../Level06RecoveryController |
|  | portal_adapter_path | ../Level06PortalAdapter |
|  | silver_wake_path | ../../GameplayRoot/PuzzleRoot/SilverWake |
|  | clear_veils_path | ../../GameplayRoot/PuzzleRoot/ClearVeils |
|  | constellation_path | ../../GameplayRoot/PuzzleRoot/HorizonConstellation |
|  | shard_slot_13_path | ../../GameplayRoot/ShardRoot/ShardSlot_13 |
|  | shard_slot_14_path | ../../GameplayRoot/ShardRoot/ShardSlot_14 |
|  | shard_slot_15_path | ../../GameplayRoot/ShardRoot/ShardSlot_15 |
|  | player_path | ../../PlayerRoot/Player |
|  | spawn_root_path | ../../PlayerRoot/SpawnRoot |
|  | player_root_path | ../../PlayerRoot |
|  | camera_path | ../../CameraRoot/FollowCamera |
|  | orb_visual_path | ../../SoulOrbRoot/SoulOrb_Follow/HoverRoot/SoulOrb_Base |
|  | orb_follow_path | ../../SoulOrbRoot/SoulOrb_Follow |
|  | reward_overlay_path | ../../UILayer/ShardRewardOverlay |
|  | finale_overlay_path | ../../UILayer/LevelFinaleOverlay |
|  | portal_path | ../../GameplayRoot/FinaleRoot/PortalFloorAnchor/LevelPortal |
| Level06ProgressController | silver_wake_path | ../../GameplayRoot/PuzzleRoot/SilverWake |
|  | clear_veils_path | ../../GameplayRoot/PuzzleRoot/ClearVeils |
|  | constellation_path | ../../GameplayRoot/PuzzleRoot/HorizonConstellation |
|  | shard_slot_13_path | ../../GameplayRoot/ShardRoot/ShardSlot_13 |
|  | shard_slot_14_path | ../../GameplayRoot/ShardRoot/ShardSlot_14 |
|  | shard_slot_15_path | ../../GameplayRoot/ShardRoot/ShardSlot_15 |
|  | environment_controller_path | ../../WorldRoot/EnvironmentPresentation |
|  | main_text_controller_path | ../Level06MainTextController |
|  | portal_adapter_path | ../Level06PortalAdapter |
| ShardRewardSequenceController | overlay_path | ../../UILayer/ShardRewardOverlay |
|  | player_path | ../../PlayerRoot/Player |
|  | shard_search_root_path | ../Level06RewardGateController |
| Level06RewardGateController | shared_controller_path | ../ShardRewardSequenceController |
|  | release_validity_controller_path | ../Level06ReleaseValidityController |
|  | recovery_controller_path | ../Level06RecoveryController |
|  | overlay_path | ../../UILayer/ShardRewardOverlay |
|  | player_path | ../../PlayerRoot/Player |
|  | camera_path | ../../CameraRoot/FollowCamera |
|  | slot_13_path | ../../GameplayRoot/ShardRoot/ShardSlot_13 |
|  | slot_14_path | ../../GameplayRoot/ShardRoot/ShardSlot_14 |
|  | slot_15_path | ../../GameplayRoot/ShardRoot/ShardSlot_15 |
| Level06MainTextController | player_path | ../../PlayerRoot/Player |
|  | gate_area_path | ../../GameplayRoot/FinaleRoot/FinalTextGate |
|  | gate_collision_path | ../../GameplayRoot/FinaleRoot/FinalTextGate/CollisionShape3D |
|  | overlay_path | ../../UILayer/LevelFinaleOverlay |
|  | recovery_controller_path | ../Level06RecoveryController |
| Level06PortalAdapter | portal_path | ../../GameplayRoot/FinaleRoot/PortalFloorAnchor/LevelPortal |

## 11.2 Recovery and subscene paths

| Owner | Export | Exact NodePath |
|---|---|---|
| Level06RecoveryController | player_path | ../../PlayerRoot/Player |
|  | global_fall_area_path | ../../GameplayRoot/RecoveryRoot/RV_FALL_GLOBAL |
|  | last_light_catcher_path | ../../GameplayRoot/RecoveryRoot/RV_LAST_LIGHT_DROP_CATCHER |
|  | last_light_source_path | ../../GameplayRoot/RecoveryRoot/LL_EDGE_EXIT_RIBBON |
|  | anchor_root_path | ../../GameplayRoot/RecoveryRoot/RecoveryAnchors |
| Level06LastLightSource | player_path | ../../../PlayerRoot/Player |
|  | floor_probe_path | FloorProbe |
|  | lower_legal_support_root_path | ../../../WorldRoot/LevelGeometry/LegalSupport/LowerRoute |
|  | last_light_support_root_path | ../../../WorldRoot/LevelGeometry/LegalSupport/LastLightAndPortal |
| SilverWake root | player_path | ../../../PlayerRoot/Player |
|  | target_root_path | TriggerRoot |
| ClearVeils root | player_path | ../../../PlayerRoot/Player |
|  | target_root_path | TriggerRoot |
| HorizonConstellation root | player_path | ../../../PlayerRoot/Player |
|  | zone_root_path | ZoneRoot |
| Level06ShardSlot root | player_path | ../../../PlayerRoot/Player |
|  | reward_gate_path | ../../../RuntimeRoot/Level06RewardGateController |
|  | shard_path | SoulShard |
|  | shard_collision_path | SoulShard/CollisionShape3D |
|  | shard_prompt_path | SoulShard/WorldInteractionPrompt |
| FollowCamera | target_path | ../../PlayerRoot/Player |
| SoulOrb_Follow | target_path | ../../PlayerRoot/Player |
|  | orientation_source_path | ../../PlayerRoot/Player/CharacterVisualRoot |

NodePath rules:

- Every mandatory path is non-empty, owner-relative and exact.
- Expected types and exact Appendix C signatures are validated before prepare.
- No group/name fallback may arm gameplay.
- PlayerRoot owns one serialized spawn transform; SpawnRoot and Player are local identity.
- EnvironmentPresentation is the sole Level06EnvironmentController owner.
- Actual SoulShard nodes connect only to RewardGate; shared controller registers exactly the RewardGate proxy before commit.
- RecoveryController owns direct Area3D connections; no recovery adapters exist.

# 12. Authority and ownership model

| Owner | Authoritative state | May do | Must not do |
|---|---|---|---|
| Level06BootstrapReadinessCoordinator | one-shot complete-scene readiness barrier and exactly-one `begin_bootstrap()` delivery | Execute a deterministic root `call_deferred()` only after root `_ready()`; prove required owners are inside tree/ready, exact active camera and canonical SoulOrb_Base are stable; call validator once. | Use timers/sleeps/guessed frames/retry loops; validate or arm gameplay; call begin_bootstrap before the complete instantiated scene is ready. |
| Level06RuntimeContractValidator | bootstrap phase, validation_generation, reserved run_generation, exactly-one outcome | Resolve exact contracts; prove serialized Player/SpawnRoot equality, canonical active FollowCamera, unique SoulOrb_Base visual, direct recovery-volume wiring; prepare/register; invoke one infallible commit; emit passed only afterward. | Runtime-teleport Player to repair spawn; select camera/group nodes by guessing; advance gameplay; emit passed before commit; convert passed to failed; arm partially. |
| Level06ProgressController | monotonic macro progression; accepted puzzle terminals; admitted logical reward set | prepare_run; commit_run; validate exact transition graph; emit environment/portal requests; observe portal attempts diagnostically. | Own retryable PortalAttempt state, release validity, recovery keys, UI proof or scene loading. |
| Level06ReleaseValidityController | VALID -> NARRATIVE_PRESENTATION_FAILED irreversible per run | prepare_run; begin_run as its sole infallible commit API; record first/aggregate shard-presentation defects. | Expose a second commit_run API; block logical gameplay; clear failure in same run; initialize before commit. |
| Puzzle controllers | local accepted/current/terminal states; owner-created target_generation/zone_generation, hint_generation and presentation_generation | Prepare inert; create/rotate only their own local epochs; emit exact canonical IDs; reset only for reload/harness. | Accept caller-assigned local epochs; reveal shards directly; mutate macro state; arm during prepare. |
| Level06ShardSlot | packed-disabled/reveal/available/requested/collected plus owner-created slot_generation for one exact shard | Create slot_generation on accepted request_reveal(run_generation); return/emit it as evidence; forward actual request/collected; perform stationary-overlap re-evaluation. | Accept caller-assigned slot_generation; write SoulShard private state; prove displayed text; connect actual shard to shared controller. |
| Level06RewardGateController | current admitted shard/node, reward_generation, active request; shard_reward writer | Precheck exact dependencies; latch release-invalid first; forward one proxy request; use writer-specific recovery API. | Treat collected as presentation proof; synthesize collected; use generic recovery suspension API. |
| EnvironmentPresentation + Level06EnvironmentController | single E0-E4 presentation state and presentation_generation | Animate only local duplicated resources; report optional completion/fallback. | Exist as a second RuntimeRoot owner; gate gameplay; lock Player; own portal state. |
| Level06MainTextController | gate eligibility and exact main-text lifecycle; main_text writer | Open exact overlay, own its own control lock, fail closed, use writer-specific suspension API. | Permit portal on failure; use generic recovery suspension API. |
| Level06PortalAdapter | retryable PortalAttemptState and portal_attempt_generation | Call activate once; forward actual activation/transition signals; rotate attempt generation only on real retry. | Own macro ordinal, InteractionArea, scene loading or synthetic success. |
| Shared LevelPortal | activation, InteractionArea, AUTO_ENTER, transition latch, retryable shared state, scene loading | Retain factual shared lifecycle and emit actual signals. | Expose writable private state to Level_06. |
| Level06LastLightSource | raw sampling for one run_generation/source_generation pair | Use exact FloorProbe and legal-support ancestry roots; emit raw typed observations supplied with Recovery-owned source_generation. | Own authoritative provenance/token/source generation/anchor/rearm/suspension or recovery-volume connections. |
| Level06RecoveryController | provenance, origin_epoch, event_token, source_generation, suspension set, latest anchor, rearm and exact recovery-volume signal wiring | Resolve/connect exact RV_FALL_GLOBAL and RV_LAST_LIGHT_DROP_CATCHER Area3D signals, filter canonical Player, create internal raw observations; use separate portal/recovery stop/restart APIs; recover once. | Use fictional adapters; expose one mixed stop/restart API for portal and recovery; permit another owner to mutate authority; accept stale source attempts. |

# 13. Deterministic readiness barrier and atomic bootstrap contract

## 13.1 Readiness ordering

`Level06BootstrapReadinessCoordinator` is attached to the complete `Level_06` scene root. Root `_ready()` schedules exactly one deterministic `call_deferred(&"_open_readiness_barrier")`. The barrier may call `Level06RuntimeContractValidator.begin_bootstrap()` exactly once only after all of the following are true:

- the complete instantiated Level_06 scene is inside the SceneTree;
- every exact mandatory subscene owner and RuntimeRoot owner is inside tree and has completed `_ready()`;
- all serialized NodePaths can be resolved after complete instantiation;
- FollowCamera is `current`, has the exact approved script/target and is exactly `get_viewport().get_camera_3d()`;
- `SoulOrb_Follow/HoverRoot/SoulOrb_Base` completed `_ready()`, is inside `soul_orb_visual`, is visible in tree and exposes `play_absorb_pulse`;
- shared overlays, shared reward controller, LevelPortal, recovery rig and every exact puzzle/shard/environment/finale owner are inside tree and ready.

The coordinator exposes the Appendix C API and emits `bootstrap_readiness_confirmed()` immediately before its one allowed validator call. It has no gameplay authority.

Forbidden readiness mechanisms:

- arbitrary Timer or elapsed-time delay;
- `await` sleep;
- guessed frame count;
- retry/poll loop;
- any validation/prepare/registration/commit before the barrier;
- any loop that partially arms gameplay while waiting for a dependency.

A missing or unstable readiness dependency produces a static/startup blocker report and zero `begin_bootstrap()` calls; it cannot be repaired by retrying after partial prepare.

## 13.2 Atomic prepare/commit bootstrap

| Phase / step | Bootstrap owner action | Required proof / failure behavior |
|---|---|---|
| 0 - deterministic readiness barrier | Root-level coordinator waits for complete instantiated-scene readiness, exact active viewport camera, canonical ready SoulOrb_Base, ready shared overlays and all exact owners/NodePaths; then calls begin_bootstrap exactly once. | Before barrier: zero begin_bootstrap, zero validation/prepare/registration/commit. No timer, sleep, guessed frame or retry loop. |
| Serialized BOOTSTRAP_INERT / visual E0 | Gameplay intake, puzzle targets, shard slots, FinalTextGate, Last Light sampling/catcher and portal are inert. E0 ambience is already visibly alive as a serialized presentation baseline and has no gameplay authority. | No gameplay activation before commit. E0 visibility does not mean the environment FSM has committed a run. |
| 1 - reserve generations | Increment validation_generation and reserve one run_generation without publishing it to gameplay owners. | Older validation/run callbacks are stale. Reservation has no gameplay side effect. |
| 2 - exact validation | Resolve exact NodePaths/types/IDs/texts/transforms/exports/methods/signals. Prove serialized PlayerRoot spawn, identity children/equal Player-SpawnRoot global transforms, exact FollowCamera script/target/current/active viewport camera, unique canonical SoulOrb_Base visual, one environment owner, direct recovery Area3D wiring and raw floor-sensing paths; call validate_contract(). | Aggregate all defects. Any defect goes directly to one validation_failed(report); no runtime spawn teleport, guessed camera/orb, prepare or commit. |
| 3 - side-effect-free domain prepare | Call prepare_run(run_generation) on every mandatory local owner. Prepare may allocate immutable data and connection plans, including RecoveryController exact Area3D callback plans, but must not connect gameplay input, start sampling, reveal, arm, lock Player or emit gameplay signals. | Any prepare defect emits one validation_failed(report). Every owner proves no-side-effects-on-false. |
| 4 - shard topology | Prove actual SoulShard request signals connect only to RewardGate and no actual shard connects to the shared controller. | Any direct shared connection fails before registration/commit. |
| 5 - explicit proxy registration | Call actual shared register_shard(RewardGate proxy), prove the exact proxy signal connection and prove no duplicate registration. Registration is configuration, not gameplay arming. | A registration race/defect emits one validation_failed(report); the first reward request cannot occur. |
| 6 - shared prerequisites | Validate canonical reward overlay/API, exact serialized Player/SpawnRoot, exact active FollowCamera, unique SoulOrb_Base visual, finale overlay/API, shared portal signals/exports and FinalScene target. | Any defect emits one validation_failed(report); scene stays BOOTSTRAP_INERT. |
| 7 - commit eligibility barrier | Confirm all prepare reports empty, registration proof true, outcome UNRESOLVED and all domains still inert. | This is the final failure point. After the barrier, commit cannot return false. |
| 8 - atomic commit | Level06RuntimeContractValidator executes the exact owner-specific commit manifest once: Level06ReleaseValidityController.begin_run(run_generation); Level06RecoveryController.begin_run(run_generation), including prevalidated direct Area3D signal connections; commit_run(run_generation) on every remaining prepared owner; Level06ProgressController.commit_run(run_generation) last. | No partial externally observable arming. Commit is infallible after the barrier; Player is not teleported and camera/orb are not replaced during commit. |
| 9 - success outcome | After every commit completes, set outcome PASSED and emit validation_passed(run_generation) exactly once. | passed is post-commit evidence, never permission to begin commit. |
| 10 - failure outcome | Before commit only, set outcome FAILED and emit validation_failed(report) exactly once. | No domain is active; no rollback path is required because prepare had no gameplay side effects. |

Bootstrap invariants:

- Readiness barrier resolves once before the only begin_bootstrap call.
- No early validation failure may be caused by sibling `_ready()` ordering.
- Active FollowCamera and SoulOrb_Base registration are stable before exact validation begins.
- One `validation_generation` produces exactly one outcome.
- Validation and prepare failure can emit only `validation_failed(report)`.
- `validation_passed(run_generation)` is emitted only after every domain has committed.
- Prepare is side-effect-free.
- The commit eligibility barrier is the final failure point.
- ReleaseValidityController and RecoveryController use `begin_run`; remaining prepared owners use infallible `commit_run`; ProgressController commits last.
- No partial externally observable arming and no rollback-after-pass conversion.

# 14. Generation lifecycle

| Domain | Creator / initial value | Initialization / rotation | Consumers | Stale behavior |
|---|---|---|---|---|
| validation_generation | Level06RuntimeContractValidator; 0 before begin_bootstrap | Increment for every bootstrap attempt; outcome resolution invalidates that attempt. | Validator callbacks, structured report and bootstrap harness. | Older values cannot resolve current outcome, prepare or commit. |
| run_generation | Level06RuntimeContractValidator; reserved after validation_generation begins | Published only by atomic commit. New scene reload creates a new node/run; portal retry and recovery never rotate it. | Every production local domain. | Mismatched value is rejected without state change. |
| reward_generation | Level06RewardGateController; 0 at commit | Increment for each admitted exact current-shard request; close after matching actual collected; new run resets. | RewardGate, ReleaseValidity, Progress and diagnostics. | Previous request/collected cannot mutate current admission or macro state. |
| presentation_generation | Owning async presenting controller; 0 at commit | Increment per accepted reveal/VFX/environment terminal attempt. Caller never supplies it; owner returns/emits evidence. | Owner callbacks/timeouts and correlating Progress notifications. | Late/foreign value loses first-terminal race and has no authority. |
| slot_generation | Each Level06ShardSlot; 0 at commit | Accepted request_reveal(run_generation) creates the next value and returns/emits it; no external caller assigns it. Closed by availability/collection or reload. | ShardSlot, ProgressController and RewardGate. | Old reveal callback/request/collected evidence is ignored. |
| target_generation | SilverWakeController or ClearVeilsController; 0 at commit | Increment on puzzle activation and every canonical current-target promotion; passed to exact Level06PassThroughTarget. | Owning puzzle controller and its pass-through targets. | Old overlap/re-evaluation cannot accept the newly current target. |
| zone_generation | HorizonConstellationController; 0 at commit | Increment when the three-zone any-order set is activated; passed to all exact GroundedDwellZone nodes; invalidated by reload. | Constellation controller and three zones. | Old dwell/accepted signal cannot alter current accepted set or RA10. |
| hint_generation | Owning SilverWake/ClearVeils/Horizon presenting controller; 0 at commit | Increment for every new hint request or hint cancellation/replacement; independent from presentation_generation. | Hint visuals and owning controller. | Late hint callback cannot revive or modify current assistance. |
| source_generation | Level06RecoveryController; 0/inactive at begin_run | Create at MAIN_TEXT_CLOSED; invalidate separately on matching portal transition or recovery commit; create fresh value on matching portal failure or recovery rearm; destroy on reload/replacement. | RecoveryController and Level06LastLightSource raw observations. | Prior values cannot change provenance, origin_epoch or event_token. |
| portal_attempt_generation | Level06PortalAdapter; 0 at commit | Increment when actual transition attempt starts; matching failure owns same value; retry creates fresh value. | PortalAdapter, RecoveryController, Progress diagnostics and recorder evidence. | Prior failure/completion cannot change current PortalAttemptState/source lifecycle. |
| capture_generation | PortalLifecycleRecorder test fixture; 0 after attach | begin_capture() creates/returns the next value; finish/dispose require the matching value; new recorder instance resets. | Recorder and PortalTransitionIntegrationHarness only. | Old capture evidence cannot finish/dispose or satisfy current destination proof. |

# 15. Macro state model

## 15.1 Monotonic gameplay FSM

| From | Event / guard | To | Atomic side effects / ownership |
|---|---|---|---|
| BOOTSTRAP_INERT | Atomic commit succeeds; ProgressController commit is last. | WAKE_ACTIVE | Gameplay intake becomes active; EnvironmentPresentation adopts serialized E0 without replay; Wake target 1 activates; RA0 registers. validation_passed is emitted afterward and causes no state transition. |
| WAKE_ACTIVE | WAKE_BAND_1 accepted for current target_generation/run_generation. | WAKE_ACTIVE | Anchor-only event: register RA1 exactly once. Macro ordinal does not change; duplicate/stale acceptance has no anchor effect. |
| WAKE_ACTIVE | WAKE_BAND_2 accepted for current target_generation/run_generation. | WAKE_ACTIVE | Anchor-only event: register RA2 exactly once. Macro ordinal does not change; duplicate/stale acceptance has no anchor effect. |
| BOOTSTRAP_INERT | Any validation/prepare/registration defect before commit. | TECHNICAL_STOP_INERT | One validation_failed; zero committed domains; targets/slots/gate/Last Light/portal remain inert. |
| WAKE_ACTIVE | WAKE_BAND_3 accepted and SILVER_WAKE terminal emitted once for current run_generation. | WAKE_COMPLETE | Register RA3; request Shard_13 reveal. WAKE_BAND_1/2 anchor evidence was already committed independently. |
| WAKE_COMPLETE | ShardSlot_13 availability completion. | SHARD_13_AVAILABLE | RewardGate sets current Shard_13; register RA4. |
| SHARD_13_AVAILABLE | RewardGate emits reward_admitted. | SHARD_13_COLLECTION_ACTIVE | RewardGate already wrote shard_reward through writer-specific API. |
| SHARD_13_COLLECTION_ACTIVE | Admitted actual Shard_13.collected with matching reward_generation/run_generation. | SHARD_13_REWARD_COMPLETE | Commit logical reward and clear RewardGate-owned shard_reward. Inside the same notify_reward_completed call, arm the one-shot internal next-stage commit guard; no external event can interleave. |
| SHARD_13_REWARD_COMPLETE | Synchronous internal NEXT_STAGE_COMMIT for Shard_13 with the same reward_generation/run_generation and transition-in-progress guard. | VEILS_ACTIVE | Request E1; activate ClearVeilsController, which creates target_generation for VEIL_LAYER_1; register RA5. This transition occurs in the same notify_reward_completed stack and cannot be externally interrupted. |
| VEILS_ACTIVE | VEIL_LAYER_1 accepted for current target_generation/run_generation. | VEILS_ACTIVE | Anchor-only event: register RA6 exactly once; no macro ordinal change. |
| VEILS_ACTIVE | VEIL_LAYER_2 accepted for current target_generation/run_generation. | VEILS_ACTIVE | Anchor-only event: register RA7 exactly once; no macro ordinal change. |
| VEILS_ACTIVE | VEIL_LAYER_3 logical accepted and CLEAR_VEILS terminal emitted once. | VEILS_LOGICAL_COMPLETE | Wait only for current presentation_generation terminal callback or 2.50 s local fallback. |
| VEILS_LOGICAL_COMPLETE | First current presentation terminal. | SHARD_14_REVEALING | Request Shard_14 reveal. |
| SHARD_14_REVEALING | Slot availability completion. | SHARD_14_AVAILABLE | RewardGate sets current Shard_14; RA8. |
| SHARD_14_AVAILABLE | reward_admitted current generation. | SHARD_14_COLLECTION_ACTIVE | RewardGate owns shard_reward. |
| SHARD_14_COLLECTION_ACTIVE | Admitted actual Shard_14.collected with matching reward_generation/run_generation. | SHARD_14_REWARD_COMPLETE | Commit logical reward and clear RewardGate-owned shard_reward. Inside the same notify_reward_completed call, arm the one-shot internal next-stage commit guard; no external event can interleave. |
| SHARD_14_REWARD_COMPLETE | Synchronous internal NEXT_STAGE_COMMIT for Shard_14 with the same reward_generation/run_generation and transition-in-progress guard. | CONSTELLATION_ACTIVE | Request E2; activate HorizonConstellationController, which creates zone_generation for all three zones; register RA9. This transition occurs in the same notify_reward_completed stack. |
| CONSTELLATION_ACTIVE | First unique canonical zone accepted for current zone_generation/run_generation. | CONSTELLATION_PARTIAL | Anchor-only progression: register RA10 exactly once, independent of which canonical zone is first. |
| CONSTELLATION_PARTIAL | Second unique canonical zone accepted for current zone_generation/run_generation. | CONSTELLATION_PARTIAL | Persist exact accepted set; no new anchor and no ordinal regression. |
| CONSTELLATION_PARTIAL | Third unique canonical zone accepted for current zone_generation/run_generation. | CONSTELLATION_LOGICAL_COMPLETE | Wait for current presentation_generation pulse callback or 1.40 s fallback; exact set equality is authority. |
| CONSTELLATION_LOGICAL_COMPLETE | First current presentation terminal. | SHARD_15_REVEALING | Request Shard_15 reveal. |
| SHARD_15_REVEALING | Slot availability completion. | SHARD_15_AVAILABLE | RewardGate sets current Shard_15; RA11. |
| SHARD_15_AVAILABLE | reward_admitted current generation. | SHARD_15_COLLECTION_ACTIVE | RewardGate owns shard_reward. |
| SHARD_15_COLLECTION_ACTIVE | Admitted actual collected. | ALL_REWARDS_COMPLETE | Clear key; request E3; arm FinalTextGate; emit all_rewards_completed. |
| ALL_REWARDS_COMPLETE | Eligible gate overlap after next-physics re-evaluation. | MAIN_TEXT_ACTIVE | MainText starts exact overlay and owns main_text/control lock. |
| MAIN_TEXT_ACTIVE | Actual accepted overlay.closed. | EXIT_PHASE | MainText clears own lock/key; request E4 and portal activation; register RA12; Recovery begins exit source sampling. Macro progression is now monotonic and never moves backward. |
| MAIN_TEXT_ACTIVE | main_text_failed. | MAIN_TEXT_FAILED_CLOSED | Portal stays inactive; only MainText-owned lock/key are cleaned. |
| EXIT_PHASE | Portal activation/attempt/failure/retry signals. | EXIT_PHASE | Retryable state is owned exclusively by PortalAdapter PortalAttempt FSM; macro ordinal does not regress or encode attempts. |
| Any runtime state | Shared portal/recovery prerequisite contract fails. | TECHNICAL_STOP | No local bypass; acceptance stops pending narrow approval. |

## 15.2 Retryable PortalAttempt FSM

| From | Actual event / guard | To | Authority effect |
|---|---|---|---|
| DORMANT | portal_activation_requested for current run; request accepted once | ACTIVATING | Connect actual shared signals before one LevelPortal.activate(); no scene load. |
| ACTIVATING | actual LevelPortal.activation_completed | EXIT_ACTIVE | RA13 becomes valid; stationary-overlap behavior remains shared P0 gate. |
| EXIT_ACTIVE | actual LevelPortal.transition_started | TRANSITION_IN_FLIGHT | Increment portal_attempt_generation; Recovery stops/invalidates source sampling; this is the last required source-scene handoff evidence for this attempt. |
| TRANSITION_IN_FLIGHT | actual LevelPortal.transition_failed for matching player/attempt while source survives | EXIT_ACTIVE | Shared portal is retryable ACTIVE; fresh source_generation starts; no second activate and no macro regression. |
| TRANSITION_IN_FLIGHT | current scene replacement / source nodes freed after successful change_scene_to_file | local FSM ends | SceneTree.root recorder/destination evidence proves FinalScene load. No local terminal macro state is required. |
| Any | actual transition_completed if observable | unchanged | Optional diagnostic only; never success authority. |

`TRANSITION_IN_FLIGHT` is not a monotonic macro state. Portal attempts may retry while macro gameplay remains `EXIT_PHASE`.

# 16. Silver Wake model

| Concern | Silver Wake contract |
|---|---|
| Controller state | LOCKED -> ACTIVE_1 -> ACTIVE_2 -> ACTIVE_3 -> COMPLETE. |
| Authority | accepted_ids: Set[StringName]; current_index; run_generation. |
| Input | Physics-confirmed Player CharacterBody3D overlap with current oriented box; grounded state ignored. |
| Future overlap | Sensor may remember occupancy but cannot accept. On promotion, one deferred physics frame then direct overlap re-evaluation. |
| Duplicates | Target accepted_once plus controller set; multiple enter/exit callbacks cannot advance twice. |
| Hint | 15.0 s since last accepted progress; only current target gets slow glint. Hint uses hint_generation. |
| Completion | Third unique ID emits puzzle_completed once immediately; wake VFX is optional and never gates Shard_13 reveal. |
| Leave/re-enter | Accepted IDs persist; current incomplete target remains valid. |

| API / signal | Signature | Semantics |
|---|---|---|
| activate | activate(run_generation: int) -> void | Valid only after atomic commit from LOCKED; controller creates target_generation and promotes WAKE_BAND_1. |
| reset_for_reload | reset_for_reload(new_run_generation: int) -> void | Harness/full-reload boundary only; clears target_generation, accepted set and hint_generation. Rejected during active production run. |
| target_accepted | signal target_accepted(target_id: StringName, run_generation: int) | Emitted once for each canonical ID after current target_generation validation; Progress registers RA1/RA2 or commits terminal progression. |
| puzzle_completed | signal puzzle_completed(puzzle_id: StringName, run_generation: int) | Emitted once after exact set with puzzle_id=&"SILVER_WAKE". |
| hint_requested | signal hint_requested(target_id: StringName, hint_generation: int, run_generation: int) | Presentation-only; controller creates hint_generation and late hint callbacks are stale. |

# 17. Clear Veils model

| State domain | Rule |
|---|---|
| Logical ordered targets | Identical current-target overlap semantics to Silver Wake; airborne valid; strict 1 -> 2 -> 3. |
| Per-layer presentation | Each accepted layer requests one local parting/current response with independent generation. Missing callback does not delay next target eligibility. |
| Third-layer terminal presentation | After VEIL_LAYER_3 logical acceptance, wait for actual terminal callback or 2.50 s controller-owned timeout before Shard_14 reveal. |
| Fallback meaning | The timeout completes only Clear Veils presentation. It does not synthesize puzzle acceptance, shard reward or any shared signal. |
| Resource safety | Each runtime veil material is duplicated or resource_local_to_scene. No imported/shared resource parameter is mutated. |
| Hint | 15.0 s; current unaccepted layer gets non-flashing edge motes. |

The third logical acceptance starts a presentation-generation race. Actual terminal callback or 2.50 s local timeout may complete presentation only; neither can synthesize target acceptance or reward.

# 18. Horizon Constellation model

## 18.1 Grounded dwell

| Per-zone state | Entry / update | Exit / transition |
|---|---|---|
| OUTSIDE | No overlap. | Player overlap -> INSIDE_AIRBORNE or GROUNDED_ACCUMULATING based on physics sample. |
| INSIDE_AIRBORNE | Overlap true; is_on_floor false; accumulator unchanged. | Landing inside -> GROUNDED_ACCUMULATING; actual exit -> OUTSIDE and reset incomplete accumulator. |
| GROUNDED_ACCUMULATING | Add physics delta while overlap and grounded. | Airborne inside -> pause; exit -> reset; accumulated >=0.60 -> ACCEPTED. |
| ACCEPTED | Immutable unique ID. | No reset; duplicate callbacks ignored. |

## 18.2 Controller semantics

| Concern | Contract |
|---|---|
| Order | WEST, CREST and EAST all eligible together; no canonical order ranking. |
| Completion | accepted_ids exact set equality with three constants; no count-only authority. |
| Presentation | Each accepted group rises independently and persists. Third acceptance starts shared horizontal pulse. |
| Terminal fallback | Actual pulse completion or 1.40 s local timeout; first terminal wins. |
| Hints | At 20 s without progress: nearest unvisited zone path motes. At 35 s: restrained crescents on all remaining zones. |
| No reset | Completed IDs persist; jumping pauses dwell; only actual volume exit resets incomplete dwell. |

# 19. Shard, reward and release-validity model

## 19.1 Shard slot lifecycle

| State | Required behavior | Guard / evidence |
|---|---|---|
| PACKED_DISABLED | Before first runtime frame: slot and SoulShard hidden; processing off; monitoring/monitorable false; collision disabled; prompt hidden. | Applied in slot _enter_tree and serialized scene defaults; no transient active frame. |
| REVEALING | request_reveal(run_generation) is accepted once; the slot creates a fresh slot_generation and returns/emits it as evidence. | External callers never assign slot_generation. Duplicate/stale run request returns -1/no effect. |
| ENABLE_PENDING | Actual reveal callback or per-shard timeout wins; set visible/process, then deferred monitoring/collision enable. | First terminal wins; wait one physics frame. |
| AVAILABLE | Verify effective monitoring, collision and exact serialized shard_id/reward_text. | If Player already overlaps, public can_player_interact(Player) must become true without exit/re-entry. |
| REQUESTED | Slot observes actual request and forwards metadata to RewardGate. | Does not connect shared controller directly. |
| COLLECTED | Actual shared completion causes SoulShard.collected; slot re-emits canonical ID. | One-shot; no private field read. |

## 19.2 Reveal timing

| Slot | Authored reveal | Local fallback | Exact shard |
|---|---|---|---|
| ShardSlot_13 | 1.20 s | 1.70 s | Shard_13 |
| ShardSlot_14 | 1.25 s | 1.75 s | Shard_14 |
| ShardSlot_15 | 1.35 s | 1.85 s | Shard_15 |

## 19.3 RewardGate proxy topology

| Request / completion case | RewardGate result |
|---|---|
| Current ID/node/run generation, canonical text, canonical overlay API, active Camera3D, no active sequence | Create reward_generation; set shard_reward suspension; emit reward_admitted; forward exactly one proxy request with canonical text. |
| Mandatory dependency absent: overlay/API or active camera | First call ReleaseValidityController.mark_narrative_presentation_failed(); then forward one proxy request so the existing shared controller can safe-complete logically. Run is not release-acceptable. |
| Serialized text empty/mismatched or generic fallback detected | Mark release invalid with exact hash/length diagnostic before emission. Proxy uses Level06Contract canonical text when normal overlay/camera exists; configuration remains release-invalid. |
| Duplicate request from same current shard/reward generation | Ignore idempotently; no second proxy emission or suspension mutation. |
| Non-current/different shard while active | Emit reward_rejected; never reach shared controller; no collected or macro advance. |
| Stale prior generation request/callback | Reject by exact ID + node instance + reward_generation + run_generation. |
| Actual current SoulShard.collected | Emit reward_completed once; remove shard_reward; clear admission; notify ProgressController logical completion. Never clear release-invalid. |

## 19.4 Release validity

| State / event | Authority rule | Gameplay effect | Release effect |
|---|---|---|---|
| VALID | Initial state after successful bootstrap. | None; logical macro proceeds normally. | Run may remain acceptable if all exact presentations succeed. |
| NARRATIVE_PRESENTATION_FAILED | First missing overlay/API, missing active camera, empty/mismatched text or detected generic fallback; irreversible for run_generation. | Does not enter main-text FAILED_CLOSED; logical collected may continue through shared safe completion. | Hard diagnostic; release acceptance fails. |
| Actual SoulShard.collected | Logical completion only for admitted current generation. | Advances shard macro flow once. | Never proves display and never clears failure latch. |
| Scene reload | New node instance and new run_generation. | Clean bootstrap. | New run starts VALID; previous failed run evidence remains in test/report logs. |

Logical `SoulShard.collected` advances gameplay only when admitted by exact ID/node/reward/run generation. It is never proof that exact text was displayed.

# 20. Environment presentation model

| State | Entry event | Presentation | Gameplay authority |
|---|---|---|---|
| E0_INITIAL | Serialized visible baseline; formally adopted during successful atomic commit. | Grass, transparent veils, faint light groups and cloud motion are already alive even while gameplay is BOOTSTRAP_INERT; no replay flash at commit. Portal dormant. | None. BOOTSTRAP_INERT is readiness/interaction state; E0 is visual presentation state. |
| E1_AFTER_SHARD_13 | Admitted actual Shard_13 reward complete. | Wakes persist; Veils shelf silhouette becomes clearer. | None. Veils activation remains ProgressController-owned. |
| E2_AFTER_SHARD_14 | Admitted actual Shard_14 reward complete. | Upper-zone crescents become more readable; prior motifs continue. | None. |
| E3_AFTER_SHARD_15 | Admitted actual Shard_15 reward complete. | All motif groups remain distinct; Quiet Horizon becomes primary. | None. FinalTextGate arm is separate. |
| E4_AFTER_MAIN_TEXT | Actual main-text close. | Last Light guidance appears; landscape remains stable. | None. Portal activation and retry remain PortalAdapter/shared LevelPortal concerns. |

The Level06EnvironmentController is attached to `WorldRoot/EnvironmentPresentation`. It creates its own presentation generation, duplicates local resources before mutation, never locks Player and never owns portal visuals.

# 21. Main text, portal and recovery runtime models

## 21.1 Main-text gate lifecycle

| State | Behavior |
|---|---|
| LOCKED_TRACKING | FinalTextGate may track occupancy but is ineligible; atomic bootstrap commit, not validation_passed, publishes the prepared inert controller. Eligibility begins only after ALL_REWARDS_COMPLETE. |
| ARMING | After ALL_REWARDS_COMPLETE, wait one physics frame and re-evaluate current overlapping bodies. |
| READY | If Player is already inside, start immediately; otherwise wait for valid body_entered. |
| SHOWING | MainTextController validates exact dependency, sets recovery suspension main_text itself, owns Player lock and calls show_finale_text(exact). |
| MAIN_TEXT_FAILED_CLOSED | If overlay/path/API/copy invalid or show_finale_text returns false: unlock only own lock, remove own main_text after recovery re-evaluation, emit main_text_failed; portal remains inactive. |
| CLOSING / CLOSED | Only actual overlay.closed commits once; controller unlocks own lock, removes own main_text and emits main_text_closed. |

## 21.2 Portal adapter API and shared configuration

| Signal / method | Exact semantics |
|---|---|
| validate_contract() -> Array[Dictionary] | Validate exact shared portal node, required methods/signals, target FinalScene, AUTO_ENTER and no confirmation. |
| prepare_run(run_generation: int) -> Array[Dictionary] | Side-effect-free run preparation; no signal connection that can accept gameplay and no activation. |
| commit_run(run_generation: int) -> void | Publish prepared run and connect passive observation. Infallible after successful prepare. |
| request_activation(run_generation: int) -> bool | Accept one current request; connect actual signals before one activate(); PortalAttempt DORMANT -> ACTIVATING. |
| portal_attempt_state_changed(previous_state: StringName, current_state: StringName, portal_attempt_generation: int, run_generation: int) | Exact attempt-state evidence; state is outside macro ordinal. |
| portal_activation_started(run_generation: int) | Forward only actual LevelPortal.activation_started. |
| portal_activation_completed(run_generation: int) | Forward only actual activation_completed; attempt -> EXIT_ACTIVE. |
| portal_transition_started(portal_attempt_generation: int, run_generation: int) | Forward only actual transition_started; attempt -> TRANSITION_IN_FLIGHT; no synthetic success. The adapter adds only its own attempt/run correlation and does not invent a Player argument. |
| portal_transition_failed(player: Node, error_code: int, portal_attempt_generation: int, run_generation: int) | Forward matching actual failure; attempt -> EXIT_ACTIVE; a retry receives fresh attempt/source generations. |
| portal_transition_completed_observed(portal_attempt_generation: int, run_generation: int) | Optional diagnostic if source portal survives; never macro or load authority. |
| diagnostic_watchdog_expired(phase: StringName, portal_attempt_generation: int, run_generation: int) | Diagnostic only; never synthesizes success, failure or scene load. |

| Export / node | Required value |
|---|---|
| portal_path | ../../GameplayRoot/FinaleRoot/PortalFloorAnchor/LevelPortal |
| target_scene_path | res://scenes/core/FinalScene.tscn |
| entry_mode | LevelPortal.EntryMode.AUTO_ENTER |
| require_entry_confirmation | false |
| PortalFloorAnchor | Vector3(24.00, 11.00, 8.50), yaw 5.71° |
| Shared ownership | LevelPortal retains InteractionArea, activation, AUTO_ENTER detection, transition latch, SceneTransition and scene load. |
| Monotonic gameplay state | EXIT_PHASE; never regresses during portal retry. |
| Retryable attempt state | actual activation_completed -> EXIT_ACTIVE; actual transition_started -> TRANSITION_IN_FLIGHT; matching transition_failed -> EXIT_ACTIVE. |
| Optional diagnostic | actual LevelPortal.transition_completed if source survives. |
| Destination proof | test-created SceneTree.root recorder + destination/current-scene observation; no project autoload. |

## 21.3 Source-scene transition observability

| Moment | Expected actual evidence | Local authority |
|---|---|---|
| Before shared load request | LevelPortal.transition_started emitted immediately before shared transition work. | PortalAttemptState becomes TRANSITION_IN_FLIGHT for a new portal_attempt_generation; macro remains EXIT_PHASE. Recovery stops source sampling. |
| SceneTransition fade-in / change_scene_to_file | SceneTransition transition_started, then scene_changed on successful replacement. Source Level_06 nodes may be freed. | No local controller is required after source replacement. |
| After destination frames/camera/fade-out | SceneTransition.transition_finished(scene_path) occurs in the existing autoload. Source LevelPortal.transition_completed may be unobservable. | Test-created root recorder confirms current scene path/marker, captures evidence, then removes itself. |
| Failure before successful replacement | Actual LevelPortal.transition_failed while source survives and shared portal is retryable ACTIVE. | Matching attempt returns TRANSITION_IN_FLIGHT -> EXIT_ACTIVE; PortalAdapter does not call activate again; Recovery creates fresh source_generation. |

## 21.4 Recovery provenance and token transitions

| Authoritative item | RecoveryController set / replace rule | LastLightSource role |
|---|---|---|
| origin_provenance NONE / LOWER_LEGAL / LAST_LIGHT_OR_PORTAL | Only RecoveryController changes provenance after checking exact emitter, finite payload, current run_generation/source_generation and raw support class. | Probe collider ancestry and emit raw support class/position/floor data only. |
| origin_epoch | Increment only on accepted grounded Last Light/portal support or accepted safe return; clear on recovery/reload/transition_started. | No epoch field. |
| event_token | Create/reuse/cancel only from accepted crossing/global-fall/catcher evidence. | No token field. |
| source_generation | Create/rotate/invalidate only for exit-sampling attempts. | Receive value through begin_sampling; echo it on every observation; never generate it. |
| latest valid anchor / rearm | Advance from canonical macro evidence and complete recovery/rearm internally. | No anchor or rearm state. |

| Transition / observation | Exact RecoveryController guard |
|---|---|
| Raw observation accepted | Exact configured LastLightSource emitter; finite payload; run_generation and source_generation both current. Otherwise reject with no provenance/token effect. |
| DISARMED -> SOURCE_CANDIDATE | EXIT_PHASE; authoritative origin LAST_LIGHT_OR_PORTAL; accepted signed inside->outside crossing within Q ribbon. |
| SOURCE_CANDIDATE -> ARMED | Still outside legal Last Light/portal floor and velocity.y <= -0.25 or root >=0.20 m below local floor plane. |
| ARMED -> PENDING | Accepted catcher overlap, outside legal floor and descending. |
| Any source state -> CANCELLED/DISARMED | Accepted grounded safe return on Last Light/portal support; increment fresh origin_epoch. |
| PENDING -> RECOVERING | Suspension set empty and same token still illegal after next-physics re-evaluation. |
| RECOVERING -> REARM_WAIT | Call stop_for_recovery(event_token, run_generation) before teleport; only matching current token may invalidate sampling. Teleport once to current RA, zero velocity and clear provenance/pending token state. |
| REARM_WAIT -> DISARMED | After canonical Player exits the destination safety footprint, call restart_after_recovery_rearm(event_token, run_generation). Only the matching completed token may create a fresh source_generation while EXIT_PHASE remains eligible. |
| Local token + RV_FALL_GLOBAL | Exact Area3D body_entered callback filters canonical Player and reuses the same event_token/pending event; never creates a second teleport. body_exited only updates internal overlap evidence. |
| Portal transition_started | Call stop_for_portal_transition(portal_attempt_generation, run_generation). Only the matching in-flight attempt invalidates sampling before source replacement; clear provenance/token. |
| Portal transition_failed retry | Call restart_after_portal_failure(failed_attempt_generation, run_generation). Only the matching failed in-flight attempt creates a fresh source_generation; old observations remain stale. |
| Reload / successful source replacement | Destroy local domains; no generation or callback survives. |

## 21.5 Writer-specific suspension

| Source key | Writer-specific API | Set true / false owner | RecoveryController behavior / authorization |
|---|---|---|---|
| shard_reward | set_shard_reward_suspended(suspended: bool, reward_generation: int, run_generation: int) | RewardGate immediately before reward_admitted/proxy emission; RewardGate after matching actual collected/shared safe completion. | Idempotently mutates only shard_reward. Validator statically proves the exported RewardGate -> Recovery path and development call-site audit permits only RewardGate use. No runtime caller-identity claim. |
| main_text | set_main_text_suspended(suspended: bool, run_generation: int) | MainTextController after exact overlay startup; MainTextController on close or failed-closed cleanup. | Idempotently mutates only main_text. Validator proves the MainText -> Recovery path and development call-site audit permits only MainText use. |
| ProgressController | No suspension API | Never sets or clears either key. | May observe suspension_sources_changed only. A generic set_suspended API or Progress call site is a static validation failure. |

## 21.6 Source-generation lifecycle

| Lifecycle event | RecoveryController action | LastLightSource action | Generation result |
|---|---|---|---|
| Atomic commit | begin_run(run_generation); source inactive | Prepared/committed but not sampling | source_generation = 0/inactive |
| MAIN_TEXT_CLOSED | begin_exit_source_sampling(run_generation) | begin_sampling(run_generation, new_source_generation) | Create first nonzero source_generation |
| Portal activation / EXIT_ACTIVE | No rotation | Continue same sampling attempt | Unchanged |
| Actual transition_started | stop_for_portal_transition(portal_attempt_generation, run_generation); clear provenance/token | stop_sampling(current_source_generation) | Invalidate matching portal attempt generation before handoff. |
| Matching transition_failed | restart_after_portal_failure(failed_attempt_generation, run_generation) | begin_sampling with fresh value | Only matching failed attempt creates new source_generation; prior observations stale. |
| Recovery commit | stop_for_recovery(event_token, run_generation) before teleport | stop_sampling(current_source_generation) | Token-correlated invalidation; portal attempt API is not used. |
| Recovery rearm complete in EXIT_PHASE | restart_after_recovery_rearm(event_token, run_generation) only after safety-footprint exit | begin_sampling with fresh value | Token-correlated restart; portal failure API is not used. |
| Reload / successful replacement | Node destruction | Node destruction | All local generations invalid |


# 22. Slice 0 - Full Preflight

## Goal
Refresh repository and approved-source facts, inspect the actual shared integration chain, select the exact implementation base and classify every mandatory dependency without producing any repository or generated change.

## Preconditions
- The complete seven-artifact v1.2.1 external Producer packet is supplied and remains READ ONLY.
- No APPLY has been issued.
- Slice 0 has no authority to create a branch, commit or pull request.

## Exact file scope
| Authority | Literal path / rule |
|---|---|
| CREATE | None. |
| MODIFY | None. |
| READ ONLY | `scenes/levels/Level_06.tscn` |
| READ ONLY | `AGENTS.md` |
| READ ONLY | `project.godot` |
| READ ONLY | `scenes/core/Player.tscn` |
| READ ONLY | `scripts/player/player_controller.gd` |
| READ ONLY | `scripts/player/camera_controller.gd` |
| READ ONLY | `scenes/core/SoulShard.tscn` |
| READ ONLY | `scripts/soul/soul_shard.gd` |
| READ ONLY | `scenes/core/SoulOrb_Follow.tscn` |
| READ ONLY | `scripts/core/soul_orb_follow.gd` |
| READ ONLY | `scenes/core/LevelPortal.tscn` |
| READ ONLY | `scripts/core/level_portal.gd` |
| READ ONLY | `scenes/core/SceneTransition.tscn` |
| READ ONLY | `scripts/core/scene_transition.gd` |
| READ ONLY | `scripts/core/shard_reward_sequence_controller.gd` |
| READ ONLY | `scenes/ui/ShardRewardOverlay.tscn` |
| READ ONLY | `scripts/ui/shard_reward_overlay.gd` |
| READ ONLY | `scenes/ui/LevelFinaleOverlay.tscn` |
| READ ONLY | `scripts/ui/level_finale_overlay.gd` |
| READ ONLY | `scenes/core/FinalScene.tscn` |
| READ ONLY | `scripts/core/final_scene.gd` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | None. |
| CREATE - USER ARTIFACT OUTSIDE REPOSITORY WORKTREE | None. |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Greybox_Development_Reference_v1.2.1.md` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Greybox_Development_Reference_v1.2.1.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Narrative_and_Level_Scenario_Package_v1.1.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Visual_Master_Concept_Package.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Gameplay_Map_and_Level_Design_Spec_v1.3.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Technical_Architecture_and_State_Model_v1.2.2.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Art_Production_Bible_v1.1.docx` |
| READ ONLY - REPOSITORY METADATA | current branch, HEAD and worktree status |
| READ ONLY - REPOSITORY METADATA | Git commit and tree metadata for candidate base refs |
| READ ONLY - REPOSITORY METADATA | open pull-request list |
| READ ONLY - REPOSITORY METADATA | pull-request base, head and status metadata |
| READ ONLY - REPOSITORY METADATA | changed-file lists and diffs for intersecting active pull requests |
| FORBIDDEN | All paths, artifacts and mutations not explicitly authorized above; global forbidden list applies. |

### CONDITIONAL MATCHING `.gd.uid`
- None.

Rules:

- A persistent matching `.gd.uid` is permitted only together with its exact sibling `.gd`, and that sibling path must be explicitly listed in this slice's `CREATE` or `MODIFY` scope.
- A temporary matching `.gd.uid` is permitted only together with its exact sibling `.gd`, and both exact paths must be explicitly listed in this slice's `TEMPORARY CREATE - REMOVE BEFORE COMMIT` scope.
- Every temporary script and every temporary sidecar is removed before commit.
- A UID for any script outside this slice's active `CREATE`, `MODIFY` or `TEMPORARY CREATE - REMOVE BEFORE COMMIT` scope is forbidden.
- Unrelated `.gd.uid`, scene UID, `.import`, `.godot/imported`, cache and generated churn are forbidden.

## Scope-consistency acceptance

- Before any write, every repository path, external artifact and metadata source named anywhere in this slice contract must appear in this slice's exact scope.
- No required dependency may exist only under `FORBIDDEN`.
- At handoff, the persistent changed-file list must be a subset of `CREATE` + `MODIFY` plus only persistent matching `.gd.uid` sidecars whose exact sibling `.gd` is explicitly in `CREATE` or `MODIFY`.
- Temporary scripts and temporary matching `.gd.uid` sidecars may exist only during the active validation run when both exact paths are listed in `TEMPORARY CREATE - REMOVE BEFORE COMMIT`; all are absent before commit.
- Every `READ ONLY` repository file must remain byte-unchanged.
- Every temporary harness, temporary script and temporary sidecar/generated file caused by it must be removed before commit.
- Unrelated `.gd.uid`, scene UID, `.import`, `.godot/imported`, cache and generated churn must be absent.
- Any scope inconsistency is a hard stop before the first write and again before commit.

## Nodes, scenes and scripts
- Inspect the current branch, HEAD, worktree status, main head/tree metadata and open PR stack.
- Inspect the legacy Level_06 scene and exact FinalScene technical target.
- Inspect Player, Camera, SoulShard, reward, SoulOrb, finale, LevelPortal and SceneTransition contracts.
- Inspect `project.godot` autoload mapping, `scenes/core/SceneTransition.tscn`, `scripts/core/scene_transition.gd` and the actual LevelPortal fallback/loading chain.
- Inspect changed-file lists and diffs for every active PR intersecting Level_06 or any mandatory shared dependency.
- Confirm that Level_06-local scene loading is unnecessary and forbidden.

## APIs and signals
- Record exact current signatures, signal signatures, blob SHAs and candidate base/head facts.
- Classify every mandatory static integration dependency as exactly `PASS`, `BLOCKER` or `NOT VERIFIED`.
- Classify every runtime-only prerequisite as exactly `DEFERRED TO OWNER P0`, factual `PASS` or factual `FAIL`, with exact owning slice and P0 IDs.
- Decide `main` versus one exact Producer-approved stacked prerequisite head only from read-only evidence.
- Do not create branches, files, sidecars, commits or PRs.

## Implementation steps
- Resolve current branch, HEAD, clean status, current `main` SHA/tree and open PRs.
- Resolve PR base/head/status and changed-file/diff intersections for relevant active PRs.
- Verify all seven external READ ONLY artifacts are present; record exact filenames, byte sizes and SHA-256 hashes.
- Verify the five approved source documents and the two v1.2.1 reference artifacts are mutually consistent.
- Verify `project.godot` autoload mapping and actual SceneTransition public behavior used by LevelPortal.
- Trace LevelPortal activation, AUTO_ENTER, fallback loading and SceneTransition ownership without runtime implementation writes.
- Compare shared APIs with Technical Architecture Appendix C.
- Produce the exact implementation-base decision, static dependency classification, runtime-only P0 deferral table and Slice 1-13 plan.
- Verify clean status before and after all inspection activity.

## Automated and static checks
- `git status --short` is empty before and after.
- `git diff --check` is empty and no untracked file exists.
- No `.gd.uid`, scene UID, `.import`, `.godot/imported`, cache or generated file is allowed.
- No branch, commit or PR is created.
- Scope-consistency acceptance passes with an empty changed-file set.

## Manual runtime checks
- None. Slice 0 performs read-only file/API/metadata inspection only.
- Static inspection must not claim runtime compatibility for stationary shard overlap, stationary portal overlap, Player external-teleport transient behavior or real destination replacement; those remain `DEFERRED TO OWNER P0` until their exact owning tests run.

## Acceptance criteria
- Exact base SHA/ref and active PR/base decision are recorded.
- All seven external artifacts have factual filename/size/SHA-256 evidence.
- Every mandatory static integration dependency is `PASS`; any static `BLOCKER` or `NOT VERIFIED` blocks APPLY.
- Every mandatory runtime-only prerequisite is classified with exact owning slice/P0 IDs; `DEFERRED TO OWNER P0` does not block APPLY but remains unresolved evidence.
- SceneTransition and LevelPortal chain are factually documented and require no Level_06-local scene loading.
- Scope-consistency acceptance passes.
- Diff remains empty.
- Successful handoff ends with the exact separate final line `WAITING FOR APPLY`.

## Rollback plan
- No rollback is required because no write, generated file or branch is permitted.

## Risks
- Main/PR drift.
- Source-document mismatch.
- Shared portal, shard, Player, reward or SceneTransition prerequisite unresolved.
- Static inspection cannot verify a mandatory runtime behavior.

## Out of scope
- All runtime implementation, branch creation, commits, PRs, sidecars and generated output.

## Stop conditions
- Any diff, untracked file, UID, import/cache file or generated file appears.
- Any unresolved main/PR/base conflict exists.
- Any mandatory static integration dependency is `BLOCKER` or `NOT VERIFIED`.
- Any runtime-only prerequisite has factual `FAIL` from already-available runtime evidence.
- SceneTransition scene/script or another mandatory shared contract is changed incompatibly by an active PR.
- Any of the seven external artifacts is missing, unreadable or hash/filename evidence cannot be recorded.
- A valid exact base cannot be named.
- Scope-consistency acceptance fails.
When a stop condition triggers, do not request or accept APPLY and do not execute Slice 1. The blocked handoff must end with the exact separate final line `PREFLIGHT BLOCKED - APPLY NOT ACCEPTED` and must not also contain `WAITING FOR APPLY`.

## Required handoff
- Approved base SHA/ref and tree metadata.
- Active PR/base/head/status and intersecting changed-file/diff report.
- Seven-artifact packet table with exact filename, byte size and SHA-256 hash.
- Static dependency table with `PASS` / `BLOCKER` / `NOT VERIFIED`.
- Runtime-only prerequisite table with `DEFERRED TO OWNER P0` / factual `PASS` / factual `FAIL`, exact owner slice and P0 IDs.
- Exact Slice 1-13 implementation plan and file-scope audit.
- Branch creation: N/A.
- Commit: N/A.
- PR: N/A.
- Diff: empty.
- Commands and factual outputs.
- Risks, blockers and prerequisite decision.
- Successful handoff final line: `WAITING FOR APPLY`.
- Blocked handoff final line: `PREFLIGHT BLOCKED - APPLY NOT ACCEPTED`.

WAITING FOR APPLY

# 23. Slice 1 - Branch Creation and Spatial Greybox Shell

## Goal
Create the implementation branch after APPLY and replace the legacy placeholder with the exact primitive route, zones, legal support ancestry, shared Player/camera/orb and dormant portal composition.

## Preconditions
- Explicit APPLY received.
- Slice 0 PASS.
- Clean status and exact approved base reconfirmed.

## Exact file scope
| Authority | Literal path / rule |
|---|---|
| CREATE | `scenes/levels/level_06/geometry/Level06GreyboxGeometry.tscn` |
| MODIFY | `scenes/levels/Level_06.tscn` |
| READ ONLY | `AGENTS.md` |
| READ ONLY | `project.godot` |
| READ ONLY | `scenes/core/Player.tscn` |
| READ ONLY | `scripts/player/player_controller.gd` |
| READ ONLY | `scripts/player/camera_controller.gd` |
| READ ONLY | `scenes/core/SoulShard.tscn` |
| READ ONLY | `scripts/soul/soul_shard.gd` |
| READ ONLY | `scenes/core/SoulOrb_Follow.tscn` |
| READ ONLY | `scripts/core/soul_orb_follow.gd` |
| READ ONLY | `scenes/core/LevelPortal.tscn` |
| READ ONLY | `scripts/core/level_portal.gd` |
| READ ONLY | `scenes/core/SceneTransition.tscn` |
| READ ONLY | `scripts/core/scene_transition.gd` |
| READ ONLY | `scripts/core/shard_reward_sequence_controller.gd` |
| READ ONLY | `scenes/ui/ShardRewardOverlay.tscn` |
| READ ONLY | `scripts/ui/shard_reward_overlay.gd` |
| READ ONLY | `scenes/ui/LevelFinaleOverlay.tscn` |
| READ ONLY | `scripts/ui/level_finale_overlay.gd` |
| READ ONLY | `scenes/core/FinalScene.tscn` |
| READ ONLY | `scripts/core/final_scene.gd` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | None. |
| CREATE - USER ARTIFACT OUTSIDE REPOSITORY WORKTREE | None. |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Greybox_Development_Reference_v1.2.1.md` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Greybox_Development_Reference_v1.2.1.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Narrative_and_Level_Scenario_Package_v1.1.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Visual_Master_Concept_Package.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Gameplay_Map_and_Level_Design_Spec_v1.3.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Technical_Architecture_and_State_Model_v1.2.2.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Art_Production_Bible_v1.1.docx` |
| FORBIDDEN | All paths, artifacts and mutations not explicitly authorized above; global forbidden list applies. |

### CONDITIONAL MATCHING `.gd.uid`
- None.

Rules:

- A persistent matching `.gd.uid` is permitted only together with its exact sibling `.gd`, and that sibling path must be explicitly listed in this slice's `CREATE` or `MODIFY` scope.
- A temporary matching `.gd.uid` is permitted only together with its exact sibling `.gd`, and both exact paths must be explicitly listed in this slice's `TEMPORARY CREATE - REMOVE BEFORE COMMIT` scope.
- Every temporary script and every temporary sidecar is removed before commit.
- A UID for any script outside this slice's active `CREATE`, `MODIFY` or `TEMPORARY CREATE - REMOVE BEFORE COMMIT` scope is forbidden.
- Unrelated `.gd.uid`, scene UID, `.import`, `.godot/imported`, cache and generated churn are forbidden.

## Scope-consistency acceptance

- Before any write, every repository path, external artifact and metadata source named anywhere in this slice contract must appear in this slice's exact scope.
- No required dependency may exist only under `FORBIDDEN`.
- At handoff, the persistent changed-file list must be a subset of `CREATE` + `MODIFY` plus only persistent matching `.gd.uid` sidecars whose exact sibling `.gd` is explicitly in `CREATE` or `MODIFY`.
- Temporary scripts and temporary matching `.gd.uid` sidecars may exist only during the active validation run when both exact paths are listed in `TEMPORARY CREATE - REMOVE BEFORE COMMIT`; all are absent before commit.
- Every `READ ONLY` repository file must remain byte-unchanged.
- Every temporary harness, temporary script and temporary sidecar/generated file caused by it must be removed before commit.
- Unrelated `.gd.uid`, scene UID, `.import`, `.godot/imported`, cache and generated churn must be absent.
- Any scope inconsistency is a hard stop before the first write and again before commit.

## Nodes, scenes and scripts
- WorldRoot, LevelGeometry, LegalSupport/LowerRoute, LegalSupport/LastLightAndPortal.
- P00-P30 and Z00-Z11 primitive floors/collision.
- PlayerRoot/SpawnRoot/Player exact serialized transform.
- CameraRoot/FollowCamera exact target/current.
- SoulOrbRoot/SoulOrb_Follow.
- GameplayRoot containers, FinaleRoot, PortalFloorAnchor and dormant shared LevelPortal.
- RuntimeRoot empty; no local runtime script attached yet.

## APIs and signals
- Shared camera target path and current flag.
- Shared orb target/orientation paths.
- Portal exact FinalScene target, AUTO_ENTER and no confirmation; remains inactive.

## Implementation steps
- Reconfirm clean status and base.
- Create `feature/implement-level-06-greybox` from exact base; verify branch and HEAD.
- Replace placeholder root scene.
- Build exact P00-P30 route and Z00-Z11 with primitives.
- Build 6.00+1.50+1.50 corridor, jumpable lip and required route openings.
- Create LegalSupport ancestry roots.
- Place exact PlayerRoot spawn and identity children.
- Place shared camera/orb and portal anchor.
- Record branch/base in handoff.

## Automated and static checks
- Godot parse/resource load.
- P00-P30 static coordinate/slope/length checks.
- Zone footprint and corridor width checks.
- Legacy LevelManager/PoemRewardUI absence.
- No final assets or local scripts.
- Changed-file whitelist.

## Manual runtime checks
- Walk the full route continuously using grounded traversal.
- Run and ordinary-jump edge checks without requiring jump.
- Inspect all canonical viewpoints.
- Verify no early portal transition.
- Verify no shortcut to FinalScene or hidden route.

## Acceptance criteria
- Scope-consistency acceptance passes before the first write and at handoff.
- Exact route and zones load and are walkable.
- 221.63 m total, 65.17 m Last Light and <=3.96° exact layout preserved.
- No mandatory gap/jump/precision placement.
- Player spawn, camera and orb stable.
- Portal dormant and target exact.
- G1 PASS.

## Rollback plan
- Revert Slice 1 commit to restore legacy placeholder.

## Risks
- Primitive seams/snags.
- Spawn transform mismatch.
- Lip blocks legal openings or dangerous boundary.

## Out of scope
- Puzzles, shards, runtime controllers, recovery logic, environment, UI and portal activation.

## Stop conditions
- Branch or HEAD differs from approved base.
- Serialized PlayerRoot/SpawnRoot/Player equality cannot be proven.
- Exact route, zone, corridor, slope, lip, dangerous boundary or portal target fails.
- A shared scene requires modification.
When any stop condition triggers, do not execute the next slice. Record the blocker and request the exact prerequisite or Producer decision.

## Required handoff
- Approved base SHA, branch, slice-start SHA and final head SHA.
- Exact CREATE/MODIFY/READ ONLY diff audit and matching UID mapping.
- Commands and factual outputs.
- Manual evidence marked PASS / FAIL / NOT VERIFIED.
- Risks, blocker status and rollback point.
- Commit SHA for the slice; PR link: N/A until Slice 13.
- Recommendation: continue automatically only when the internal gate passes.


# 24. Slice 2 - Boundary, Recovery Geometry and Exact Safety Registry

## Goal
Create exact recovery/service geometry, B0-B5, Q0-Q5, FloorProbe and RA0-RA13 nodes without authoritative runtime interpretation.

## Preconditions
- Slice 1 PASS and committed.
- Exact geometry authority available.

## Exact file scope
| Authority | Literal path / rule |
|---|---|
| CREATE | `scenes/levels/level_06/systems/Level06RecoveryRig.tscn` |
| MODIFY | `scenes/levels/Level_06.tscn` |
| MODIFY | `scenes/levels/level_06/geometry/Level06GreyboxGeometry.tscn` |
| READ ONLY | `AGENTS.md` |
| READ ONLY | `project.godot` |
| READ ONLY | `scenes/core/Player.tscn` |
| READ ONLY | `scripts/player/player_controller.gd` |
| READ ONLY | `scripts/player/camera_controller.gd` |
| READ ONLY | `scenes/core/SoulShard.tscn` |
| READ ONLY | `scripts/soul/soul_shard.gd` |
| READ ONLY | `scenes/core/SoulOrb_Follow.tscn` |
| READ ONLY | `scripts/core/soul_orb_follow.gd` |
| READ ONLY | `scenes/core/LevelPortal.tscn` |
| READ ONLY | `scripts/core/level_portal.gd` |
| READ ONLY | `scenes/core/SceneTransition.tscn` |
| READ ONLY | `scripts/core/scene_transition.gd` |
| READ ONLY | `scripts/core/shard_reward_sequence_controller.gd` |
| READ ONLY | `scenes/ui/ShardRewardOverlay.tscn` |
| READ ONLY | `scripts/ui/shard_reward_overlay.gd` |
| READ ONLY | `scenes/ui/LevelFinaleOverlay.tscn` |
| READ ONLY | `scripts/ui/level_finale_overlay.gd` |
| READ ONLY | `scenes/core/FinalScene.tscn` |
| READ ONLY | `scripts/core/final_scene.gd` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/RecoveryGeometryDebugDraw.tscn` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/recovery_geometry_debug_draw.gd` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/recovery_geometry_debug_draw.gd.uid` |
| CREATE - USER ARTIFACT OUTSIDE REPOSITORY WORKTREE | None. |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Greybox_Development_Reference_v1.2.1.md` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Greybox_Development_Reference_v1.2.1.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Narrative_and_Level_Scenario_Package_v1.1.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Visual_Master_Concept_Package.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Gameplay_Map_and_Level_Design_Spec_v1.3.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Technical_Architecture_and_State_Model_v1.2.2.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Art_Production_Bible_v1.1.docx` |
| FORBIDDEN | All paths, artifacts and mutations not explicitly authorized above; global forbidden list applies. |

### CONDITIONAL MATCHING `.gd.uid`
- None.

Rules:

- A persistent matching `.gd.uid` is permitted only together with its exact sibling `.gd`, and that sibling path must be explicitly listed in this slice's `CREATE` or `MODIFY` scope.
- A temporary matching `.gd.uid` is permitted only together with its exact sibling `.gd`, and both exact paths must be explicitly listed in this slice's `TEMPORARY CREATE - REMOVE BEFORE COMMIT` scope.
- Every temporary script and every temporary sidecar is removed before commit.
- A UID for any script outside this slice's active `CREATE`, `MODIFY` or `TEMPORARY CREATE - REMOVE BEFORE COMMIT` scope is forbidden.
- Unrelated `.gd.uid`, scene UID, `.import`, `.godot/imported`, cache and generated churn are forbidden.

## Scope-consistency acceptance

- Before any write, every repository path, external artifact and metadata source named anywhere in this slice contract must appear in this slice's exact scope.
- No required dependency may exist only under `FORBIDDEN`.
- At handoff, the persistent changed-file list must be a subset of `CREATE` + `MODIFY` plus only persistent matching `.gd.uid` sidecars whose exact sibling `.gd` is explicitly in `CREATE` or `MODIFY`.
- Temporary scripts and temporary matching `.gd.uid` sidecars may exist only during the active validation run when both exact paths are listed in `TEMPORARY CREATE - REMOVE BEFORE COMMIT`; all are absent before commit.
- Every `READ ONLY` repository file must remain byte-unchanged.
- Every temporary harness, temporary script and temporary sidecar/generated file caused by it must be removed before commit.
- Unrelated `.gd.uid`, scene UID, `.import`, `.godot/imported`, cache and generated churn must be absent.
- Any scope inconsistency is a hard stop before the first write and again before commit.

## Nodes, scenes and scripts
- RV_FALL_GLOBAL and RV_LAST_LIGHT_DROP_CATCHER Area3D nodes.
- LL_EDGE_EXIT_RIBBON with Q0-Q5 and FloorProbe.
- RecoveryAnchors/RA0-RA13.
- Dangerous B0-B5 remains physical crossing, not a hard wall.

## APIs and signals
- No runtime methods in this slice.
- Serialized exact geometry is the authority.

## Implementation steps
- Create recovery rig with exact shapes/transforms.
- Add B/Q markers and swept source representation.
- Create all anchors at exact positions.
- Ensure service volumes create no floor/collision.
- Ensure dangerous boundary remains jumpable.
- Instance rig under GameplayRoot/RecoveryRoot.

## Automated and static checks
- Numerical ribbon coverage <=0.25 m sampling.
- Zero-gap/0.099 m reserve proof.
- Lower-route 1.870 m separation proof.
- Area shape/transform and anchor-count assertions.
- No standable service collision.

## Manual runtime checks
- Use the exact temporary `RecoveryGeometryDebugDraw.tscn` + `recovery_geometry_debug_draw.gd` fixture to render B/Q/catcher/legal roots; remove fixture and generated UID before commit.
- Walk/jump legal corridor and dangerous edge.
- Confirm no invisible catch floor.
- Inspect no legal-space overlap.

## Acceptance criteria
- Scope-consistency acceptance passes before the first write and at handoff.
- Exact geometry registry passes.
- B remains deliberately crossable.
- Q union continuous.
- Service volumes non-playable.
- RA0-RA13 exact.
- G2 PASS.

## Rollback plan
- Revert Slice 2 commit; Slice 1 shell remains.

## Risks
- Catcher overlaps legal floor.
- Ribbon gap/corner bypass.
- Boundary unintentionally blocks deliberate crossing.

## Out of scope
- Recovery authority, progression and all puzzles.

## Stop conditions
- Any recovery/service node overlaps legal playable support improperly.
- Ribbon coverage, separation or exact transform fails.
- A hard boundary prevents approved dangerous crossing.
- Geometry requires final art or shared changes.
When any stop condition triggers, do not execute the next slice. Record the blocker and request the exact prerequisite or Producer decision.

## Required handoff
- Approved base SHA, branch, slice-start SHA and final head SHA.
- Exact CREATE/MODIFY/READ ONLY diff audit and matching UID mapping.
- Commands and factual outputs.
- Manual evidence marked PASS / FAIL / NOT VERIFIED.
- Risks, blocker status and rollback point.
- Commit SHA for the slice; PR link: N/A until Slice 13.
- Recommendation: continue automatically only when the internal gate passes.

# 25. Slice 3 - Recovery Authority and Last Light Source

## Goal
Implement RecoveryController and raw LastLightSource as inert prepare/commit domains with direct Area3D wiring, generations, provenance, token, suspension and rearm contracts.

## Preconditions
- Player external-teleport transient/step-climb prerequisite is `DEFERRED TO OWNER P0` until P0-41 passes.
- Slice 2 PASS.
- Player public recovery boundary re-inspected.

## Exact file scope
| Authority | Literal path / rule |
|---|---|
| CREATE | `scripts/levels/level_06/level_06_recovery_controller.gd` |
| CREATE | `scripts/levels/level_06/level_06_last_light_source.gd` |
| MODIFY | `scenes/levels/level_06/systems/Level06RecoveryRig.tscn` |
| READ ONLY | `scenes/levels/Level_06.tscn` |
| READ ONLY | `scenes/levels/level_06/geometry/Level06GreyboxGeometry.tscn` |
| READ ONLY | `AGENTS.md` |
| READ ONLY | `project.godot` |
| READ ONLY | `scenes/core/Player.tscn` |
| READ ONLY | `scripts/player/player_controller.gd` |
| READ ONLY | `scripts/player/camera_controller.gd` |
| READ ONLY | `scenes/core/SoulShard.tscn` |
| READ ONLY | `scripts/soul/soul_shard.gd` |
| READ ONLY | `scenes/core/SoulOrb_Follow.tscn` |
| READ ONLY | `scripts/core/soul_orb_follow.gd` |
| READ ONLY | `scenes/core/LevelPortal.tscn` |
| READ ONLY | `scripts/core/level_portal.gd` |
| READ ONLY | `scenes/core/SceneTransition.tscn` |
| READ ONLY | `scripts/core/scene_transition.gd` |
| READ ONLY | `scripts/core/shard_reward_sequence_controller.gd` |
| READ ONLY | `scenes/ui/ShardRewardOverlay.tscn` |
| READ ONLY | `scripts/ui/shard_reward_overlay.gd` |
| READ ONLY | `scenes/ui/LevelFinaleOverlay.tscn` |
| READ ONLY | `scripts/ui/level_finale_overlay.gd` |
| READ ONLY | `scenes/core/FinalScene.tscn` |
| READ ONLY | `scripts/core/final_scene.gd` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/RecoveryObservationHarness.tscn` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/RecoveryGeometryDebugDraw.tscn` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/recovery_observation_harness.gd` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/recovery_observation_harness.gd.uid` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/recovery_geometry_debug_draw.gd` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/recovery_geometry_debug_draw.gd.uid` |
| CREATE - USER ARTIFACT OUTSIDE REPOSITORY WORKTREE | None. |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Greybox_Development_Reference_v1.2.1.md` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Greybox_Development_Reference_v1.2.1.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Narrative_and_Level_Scenario_Package_v1.1.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Visual_Master_Concept_Package.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Gameplay_Map_and_Level_Design_Spec_v1.3.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Technical_Architecture_and_State_Model_v1.2.2.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Art_Production_Bible_v1.1.docx` |
| FORBIDDEN | All paths, artifacts and mutations not explicitly authorized above; global forbidden list applies. |

### CONDITIONAL MATCHING `.gd.uid`
- `scripts/levels/level_06/level_06_recovery_controller.gd.uid`
- `scripts/levels/level_06/level_06_last_light_source.gd.uid`

Rules:

- A persistent matching `.gd.uid` is permitted only together with its exact sibling `.gd`, and that sibling path must be explicitly listed in this slice's `CREATE` or `MODIFY` scope.
- A temporary matching `.gd.uid` is permitted only together with its exact sibling `.gd`, and both exact paths must be explicitly listed in this slice's `TEMPORARY CREATE - REMOVE BEFORE COMMIT` scope.
- Every temporary script and every temporary sidecar is removed before commit.
- A UID for any script outside this slice's active `CREATE`, `MODIFY` or `TEMPORARY CREATE - REMOVE BEFORE COMMIT` scope is forbidden.
- Unrelated `.gd.uid`, scene UID, `.import`, `.godot/imported`, cache and generated churn are forbidden.

## Scope-consistency acceptance

- Before any write, every repository path, external artifact and metadata source named anywhere in this slice contract must appear in this slice's exact scope.
- No required dependency may exist only under `FORBIDDEN`.
- At handoff, the persistent changed-file list must be a subset of `CREATE` + `MODIFY` plus only persistent matching `.gd.uid` sidecars whose exact sibling `.gd` is explicitly in `CREATE` or `MODIFY`.
- Temporary scripts and temporary matching `.gd.uid` sidecars may exist only during the active validation run when both exact paths are listed in `TEMPORARY CREATE - REMOVE BEFORE COMMIT`; all are absent before commit.
- Every `READ ONLY` repository file must remain byte-unchanged.
- Every temporary harness, temporary script and temporary sidecar/generated file caused by it must be removed before commit.
- Unrelated `.gd.uid`, scene UID, `.import`, `.godot/imported`, cache and generated churn must be absent.
- Any scope inconsistency is a hard stop before the first write and again before commit.

## Nodes, scenes and scripts
- Level06RecoveryController remains unattached to production RuntimeRoot until Slice 12.
- Level06LastLightSource attached to LL_EDGE_EXIT_RIBBON but serialized inert.
- Direct exact Area3D connection plan; no adapter.

## APIs and signals
- `validate_contract`, `prepare_run`, `begin_run`.
- Writer-specific suspension APIs.
- Split portal/recovery stop/restart APIs.
- Raw observation acceptance APIs and exact signals from Appendix C.

## Implementation steps
- Implement owner-created source_generation.
- Implement direct Area3D callbacks and exact Player filtering.
- Implement provenance/origin_epoch/event_token FSM.
- Implement pending under suspension and next-physics illegal recheck.
- Implement teleport once, `Player.velocity = Vector3.ZERO`, safety-footprint rearm.
- Implement raw FloorProbe support classification and signed crossing emissions.
- Keep all production intake inert before begin_run.

## Automated and static checks
- Temporary RecoveryObservationHarness and RecoveryGeometryDebugDraw, removed before commit.
- Token/duplicate/stale/source-generation unit tests.
- Writer-specific call-site static scan.
- Private Player field scan.
- Direct Area3D connection ownership scan.

## Manual runtime checks
- Global fall, catcher, signed crossing, safe return, suspension and repeat-recovery simulations.
- Force recovery during step-climb.
- Verify non-Player rejection.

## Acceptance criteria
- Runtime-only prerequisite P0-41 has factual PASS before G3; DEFERRED is not sufficient at this owner gate.
- Scope-consistency acceptance passes before the first write and at handoff.
- Recovery sole authority proven.
- One token/teleport per event.
- Pending survives suspension.
- Stale generations ignored.
- No private Player access.
- Step-climb test passes or exact prerequisite STOP.
- G3 PASS.

## Rollback plan
- Revert Slice 3 commit; recovery geometry remains inert.

## Risks
- Private Player transient causes snap-back.
- Source observation gains authority.
- Incorrect portal/recovery generation rotation.

## Out of scope
- Macro progression, puzzles, shards, UI and portal.

## Stop conditions
- Runtime-only prerequisite P0-41 is FAIL or remains DEFERRED/NOT VERIFIED.
- Safe teleport requires private Player state or broad shared edit.
- Token, suspension, provenance, stale-generation or rearm tests fail.
- Direct Area3D wiring cannot be proven.
- Recovery mutates progress or environment.
When any stop condition triggers, do not execute the next slice. Record the blocker and request the exact prerequisite or Producer decision.

## Required handoff
- Approved base SHA, branch, slice-start SHA and final head SHA.
- Exact CREATE/MODIFY/READ ONLY diff audit and matching UID mapping.
- Commands and factual outputs.
- Manual evidence marked PASS / FAIL / NOT VERIFIED.
- Risks, blocker status and rollback point.
- Commit SHA for the slice; PR link: N/A until Slice 13.
- Recommendation: continue automatically only when the internal gate passes.

# 26. Slice 4 - Canonical Contract, Progress Core and Atomic Bootstrap

## Goal
Implement immutable registry, macro-state owner and atomic validator as unattached production scripts; prove prepare/commit and exactly-one bootstrap outcomes.

## Preconditions
- Slice 3 PASS.
- All future dependency signatures are controlled by approved Appendix C.

## Exact file scope
| Authority | Literal path / rule |
|---|---|
| CREATE | `scripts/levels/level_06/level_06_contract.gd` |
| CREATE | `scripts/levels/level_06/level_06_runtime_contract_validator.gd` |
| CREATE | `scripts/levels/level_06/level_06_progress_controller.gd` |
| MODIFY | None. |
| READ ONLY | `scenes/levels/Level_06.tscn` |
| READ ONLY | `scenes/levels/level_06/geometry/Level06GreyboxGeometry.tscn` |
| READ ONLY | `scenes/levels/level_06/systems/Level06RecoveryRig.tscn` |
| READ ONLY | `scripts/levels/level_06/level_06_recovery_controller.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_last_light_source.gd` |
| READ ONLY | `AGENTS.md` |
| READ ONLY | `project.godot` |
| READ ONLY | `scenes/core/Player.tscn` |
| READ ONLY | `scripts/player/player_controller.gd` |
| READ ONLY | `scripts/player/camera_controller.gd` |
| READ ONLY | `scenes/core/SoulShard.tscn` |
| READ ONLY | `scripts/soul/soul_shard.gd` |
| READ ONLY | `scenes/core/SoulOrb_Follow.tscn` |
| READ ONLY | `scripts/core/soul_orb_follow.gd` |
| READ ONLY | `scenes/core/LevelPortal.tscn` |
| READ ONLY | `scripts/core/level_portal.gd` |
| READ ONLY | `scenes/core/SceneTransition.tscn` |
| READ ONLY | `scripts/core/scene_transition.gd` |
| READ ONLY | `scripts/core/shard_reward_sequence_controller.gd` |
| READ ONLY | `scenes/ui/ShardRewardOverlay.tscn` |
| READ ONLY | `scripts/ui/shard_reward_overlay.gd` |
| READ ONLY | `scenes/ui/LevelFinaleOverlay.tscn` |
| READ ONLY | `scripts/ui/level_finale_overlay.gd` |
| READ ONLY | `scenes/core/FinalScene.tscn` |
| READ ONLY | `scripts/core/final_scene.gd` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/Level06ArchitectureHarness.tscn` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/BootstrapRaceHarness.tscn` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/level_06_architecture_harness.gd` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/level_06_architecture_harness.gd.uid` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/bootstrap_race_harness.gd` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/bootstrap_race_harness.gd.uid` |
| CREATE - USER ARTIFACT OUTSIDE REPOSITORY WORKTREE | None. |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Greybox_Development_Reference_v1.2.1.md` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Greybox_Development_Reference_v1.2.1.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Narrative_and_Level_Scenario_Package_v1.1.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Visual_Master_Concept_Package.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Gameplay_Map_and_Level_Design_Spec_v1.3.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Technical_Architecture_and_State_Model_v1.2.2.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Art_Production_Bible_v1.1.docx` |
| FORBIDDEN | All paths, artifacts and mutations not explicitly authorized above; global forbidden list applies. |

### CONDITIONAL MATCHING `.gd.uid`
- `scripts/levels/level_06/level_06_contract.gd.uid`
- `scripts/levels/level_06/level_06_runtime_contract_validator.gd.uid`
- `scripts/levels/level_06/level_06_progress_controller.gd.uid`

Rules:

- A persistent matching `.gd.uid` is permitted only together with its exact sibling `.gd`, and that sibling path must be explicitly listed in this slice's `CREATE` or `MODIFY` scope.
- A temporary matching `.gd.uid` is permitted only together with its exact sibling `.gd`, and both exact paths must be explicitly listed in this slice's `TEMPORARY CREATE - REMOVE BEFORE COMMIT` scope.
- Every temporary script and every temporary sidecar is removed before commit.
- A UID for any script outside this slice's active `CREATE`, `MODIFY` or `TEMPORARY CREATE - REMOVE BEFORE COMMIT` scope is forbidden.
- Unrelated `.gd.uid`, scene UID, `.import`, `.godot/imported`, cache and generated churn are forbidden.

## Scope-consistency acceptance

- Before any write, every repository path, external artifact and metadata source named anywhere in this slice contract must appear in this slice's exact scope.
- No required dependency may exist only under `FORBIDDEN`.
- At handoff, the persistent changed-file list must be a subset of `CREATE` + `MODIFY` plus only persistent matching `.gd.uid` sidecars whose exact sibling `.gd` is explicitly in `CREATE` or `MODIFY`.
- Temporary scripts and temporary matching `.gd.uid` sidecars may exist only during the active validation run when both exact paths are listed in `TEMPORARY CREATE - REMOVE BEFORE COMMIT`; all are absent before commit.
- Every `READ ONLY` repository file must remain byte-unchanged.
- Every temporary harness, temporary script and temporary sidecar/generated file caused by it must be removed before commit.
- Unrelated `.gd.uid`, scene UID, `.import`, `.godot/imported`, cache and generated churn must be absent.
- Any scope inconsistency is a hard stop before the first write and again before commit.

## Nodes, scenes and scripts
- Level06Contract static registry.
- Level06ProgressController complete monotonic macro FSM.
- Level06RuntimeContractValidator prepare/commit coordinator.
- Scripts are not attached to production root until Slice 12.

## APIs and signals
- Exact Appendix C signatures.
- One validation outcome.
- Progress commits last.
- PortalAttempt excluded from macro enum.

## Implementation steps
- Implement all canonical constants and registry equality.
- Implement legal macro transitions and anchor-only events.
- Implement atomic validation/prepare/registration/commit manifest.
- Implement exact generation reservation and stale handling.
- Implement diagnostic snapshots without alternate mutation paths.
- Do not attach validator to incomplete scene.

## Automated and static checks
- Temporary Level06ArchitectureHarness and BootstrapRaceHarness, removed before commit.
- All macro transition/invalid-event tests.
- Passed-vs-failed race tests.
- Prepare no-side-effects proof.
- Static API signature scan.

## Manual runtime checks
- Run pure/state harness; no production scene arming.
- Inject prepare defects, duplicate begin, delayed callbacks and stale generations.

## Acceptance criteria
- Scope-consistency acceptance passes before the first write and at handoff.
- Exactly-one outcome.
- No passed-before-commit.
- No partial arming.
- Canonical macro graph exact.
- All scripts parse.
- G4 PASS.

## Rollback plan
- Revert Slice 4 commit.

## Risks
- Validator becomes active before dependencies exist.
- API drift from Appendix C.
- Macro state includes retryable portal attempt.

## Out of scope
- Shard/reward domains, puzzles and production attachment.

## Stop conditions
- Atomic outcome or prepare side-effect proof fails.
- Canonical transition or anchor event is ambiguous.
- Validator requires guessed discovery.
- An exact Appendix C signature cannot be implemented without source redesign.
When any stop condition triggers, do not execute the next slice. Record the blocker and request the exact prerequisite or Producer decision.

## Required handoff
- Approved base SHA, branch, slice-start SHA and final head SHA.
- Exact CREATE/MODIFY/READ ONLY diff audit and matching UID mapping.
- Commands and factual outputs.
- Manual evidence marked PASS / FAIL / NOT VERIFIED.
- Risks, blocker status and rollback point.
- Commit SHA for the slice; PR link: N/A until Slice 13.
- Recommendation: continue automatically only when the internal gate passes.

# 27. Slice 5 - Shard Slot, RewardGate and Release Validity

## Goal
Implement generic packed shard lifecycle, local RewardGate proxy and independent irreversible release-validity domain.

## Preconditions
- Slice 4 PASS.
- Actual shared SoulShard/reward APIs reconfirmed.

## Exact file scope
| Authority | Literal path / rule |
|---|---|
| CREATE | `scenes/levels/level_06/systems/Level06ShardSlot.tscn` |
| CREATE | `scripts/levels/level_06/level_06_shard_slot.gd` |
| CREATE | `scripts/levels/level_06/level_06_reward_gate_controller.gd` |
| CREATE | `scripts/levels/level_06/level_06_release_validity_controller.gd` |
| MODIFY | `scenes/levels/Level_06.tscn` |
| READ ONLY | `scenes/levels/level_06/geometry/Level06GreyboxGeometry.tscn` |
| READ ONLY | `scenes/levels/level_06/systems/Level06RecoveryRig.tscn` |
| READ ONLY | `scripts/levels/level_06/level_06_recovery_controller.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_last_light_source.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_contract.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_runtime_contract_validator.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_progress_controller.gd` |
| READ ONLY | `AGENTS.md` |
| READ ONLY | `project.godot` |
| READ ONLY | `scenes/core/Player.tscn` |
| READ ONLY | `scripts/player/player_controller.gd` |
| READ ONLY | `scripts/player/camera_controller.gd` |
| READ ONLY | `scenes/core/SoulShard.tscn` |
| READ ONLY | `scripts/soul/soul_shard.gd` |
| READ ONLY | `scenes/core/SoulOrb_Follow.tscn` |
| READ ONLY | `scripts/core/soul_orb_follow.gd` |
| READ ONLY | `scenes/core/LevelPortal.tscn` |
| READ ONLY | `scripts/core/level_portal.gd` |
| READ ONLY | `scenes/core/SceneTransition.tscn` |
| READ ONLY | `scripts/core/scene_transition.gd` |
| READ ONLY | `scripts/core/shard_reward_sequence_controller.gd` |
| READ ONLY | `scenes/ui/ShardRewardOverlay.tscn` |
| READ ONLY | `scripts/ui/shard_reward_overlay.gd` |
| READ ONLY | `scenes/ui/LevelFinaleOverlay.tscn` |
| READ ONLY | `scripts/ui/level_finale_overlay.gd` |
| READ ONLY | `scenes/core/FinalScene.tscn` |
| READ ONLY | `scripts/core/final_scene.gd` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/fakes/fake_shard.gd` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/fakes/reward_proxy_spy.gd` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/fakes/release_validity_spy.gd` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/RewardGateHarness.tscn` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/reward_gate_harness.gd` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/reward_gate_harness.gd.uid` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/fakes/fake_shard.gd.uid` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/fakes/reward_proxy_spy.gd.uid` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/fakes/release_validity_spy.gd.uid` |
| CREATE - USER ARTIFACT OUTSIDE REPOSITORY WORKTREE | None. |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Greybox_Development_Reference_v1.2.1.md` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Greybox_Development_Reference_v1.2.1.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Narrative_and_Level_Scenario_Package_v1.1.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Visual_Master_Concept_Package.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Gameplay_Map_and_Level_Design_Spec_v1.3.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Technical_Architecture_and_State_Model_v1.2.2.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Art_Production_Bible_v1.1.docx` |
| FORBIDDEN | All paths, artifacts and mutations not explicitly authorized above; global forbidden list applies. |

### CONDITIONAL MATCHING `.gd.uid`
- `scripts/levels/level_06/level_06_shard_slot.gd.uid`
- `scripts/levels/level_06/level_06_reward_gate_controller.gd.uid`
- `scripts/levels/level_06/level_06_release_validity_controller.gd.uid`

Rules:

- A persistent matching `.gd.uid` is permitted only together with its exact sibling `.gd`, and that sibling path must be explicitly listed in this slice's `CREATE` or `MODIFY` scope.
- A temporary matching `.gd.uid` is permitted only together with its exact sibling `.gd`, and both exact paths must be explicitly listed in this slice's `TEMPORARY CREATE - REMOVE BEFORE COMMIT` scope.
- Every temporary script and every temporary sidecar is removed before commit.
- A UID for any script outside this slice's active `CREATE`, `MODIFY` or `TEMPORARY CREATE - REMOVE BEFORE COMMIT` scope is forbidden.
- Unrelated `.gd.uid`, scene UID, `.import`, `.godot/imported`, cache and generated churn are forbidden.

## Scope-consistency acceptance

- Before any write, every repository path, external artifact and metadata source named anywhere in this slice contract must appear in this slice's exact scope.
- No required dependency may exist only under `FORBIDDEN`.
- At handoff, the persistent changed-file list must be a subset of `CREATE` + `MODIFY` plus only persistent matching `.gd.uid` sidecars whose exact sibling `.gd` is explicitly in `CREATE` or `MODIFY`.
- Temporary scripts and temporary matching `.gd.uid` sidecars may exist only during the active validation run when both exact paths are listed in `TEMPORARY CREATE - REMOVE BEFORE COMMIT`; all are absent before commit.
- Every `READ ONLY` repository file must remain byte-unchanged.
- Every temporary harness, temporary script and temporary sidecar/generated file caused by it must be removed before commit.
- Unrelated `.gd.uid`, scene UID, `.import`, `.godot/imported`, cache and generated churn must be absent.
- Any scope inconsistency is a hard stop before the first write and again before commit.

## Nodes, scenes and scripts
- Three Level06ShardSlot instances with exact roots/copy, packed disabled.
- ReleaseValidity and RewardGate scripts remain unattached RuntimeRoot candidates until Slice 12.
- Shared ShardRewardSequenceController and ShardRewardOverlay instances may be placed inert.

## APIs and signals
- Slot owner-created slot_generation.
- RewardGate proxy exact shared signal signature.
- Release validity `begin_run` sole commit API.
- Writer-specific reward suspension.

## Implementation steps
- Build generic slot with serialized hidden/disabled state in `_enter_tree` and scene defaults.
- Configure exact three shard IDs/texts/positions/timeouts.
- Implement effective availability and deferred overlap recheck.
- Implement proxy admission and canonical text checks.
- Mark release invalid before defect-path proxy emission.
- Reject concurrent/non-current/duplicate/stale requests before shared controller.
- Keep shared registration deferred to atomic Slice 12 commit.

## Automated and static checks
- FakeShard, RewardProxySpy and ReleaseValiditySpy temporary harnesses.
- Packed-state first-frame assertions.
- Concurrent request matrix.
- Exact text/hash checks.
- No actual shard direct shared-controller connection.

## Manual runtime checks
- Pre-overlap each hidden shard then enable in harness.
- Run normal/missing overlay/missing camera/wrong text/generic fallback cases.
- Verify logical safe completion and irreversible release failure separation.

## Acceptance criteria
- Scope-consistency acceptance passes before the first write and at handoff.
- Three exact slots packed inert.
- One proxy topology.
- Concurrent unsafe requests blocked.
- Logical collected and release validity separated.
- Stationary pre-overlap passes or prerequisite STOP.
- G5 PASS.

## Rollback plan
- Revert Slice 5 commit.

## Risks
- Stationary newly enabled shard needs shared prerequisite.
- RewardGate accidentally synthesizes collected.
- Shared controller scans actual shards.

## Out of scope
- Puzzle activation, environment, finale and portal.

## Stop conditions
- SoulShard pre-overlap cannot work without private access or unapproved shared edit.
- Reward ordering, proxy registration model, release validity or slot collection contract fails.
- Actual shards connect directly to shared controller.
When any stop condition triggers, do not execute the next slice. Record the blocker and request the exact prerequisite or Producer decision.

## Required handoff
- Approved base SHA, branch, slice-start SHA and final head SHA.
- Exact CREATE/MODIFY/READ ONLY diff audit and matching UID mapping.
- Commands and factual outputs.
- Manual evidence marked PASS / FAIL / NOT VERIFIED.
- Risks, blocker status and rollback point.
- Commit SHA for the slice; PR link: N/A until Slice 13.
- Recommendation: continue automatically only when the internal gate passes.

# 28. Slice 6 - Silver Wake and Shard_13 Path

## Goal
Implement strict ordered airborne-safe pass-through bands, persistent wake placeholders and integration to Shard_13 availability/reward.

## Preconditions
- Shard_13 stationary newly enabled overlap is `DEFERRED TO OWNER P0` until P0-06 passes through the owning temporary integrated-flow fixture.
- Slice 5 PASS.
- Progress, RewardGate, release-validity and slot APIs are exact and available to the temporary fixture, while final production RuntimeRoot attachment remains reserved for Slice 12.
- Production `Level_06.tscn` Wake -> Shard_13 -> E1/VEILS_ACTIVE wiring starts this slice as `DEFERRED TO G12 PRODUCTION WIRING`.

## Exact file scope
| Authority | Literal path / rule |
|---|---|
| CREATE | `scenes/levels/level_06/puzzles/SilverWake.tscn` |
| CREATE | `scripts/levels/level_06/level_06_pass_through_target.gd` |
| CREATE | `scripts/levels/level_06/silver_wake_controller.gd` |
| MODIFY | `scenes/levels/Level_06.tscn` |
| MODIFY | `scripts/levels/level_06/level_06_progress_controller.gd` |
| READ ONLY | `scenes/levels/level_06/geometry/Level06GreyboxGeometry.tscn` |
| READ ONLY | `scenes/levels/level_06/systems/Level06RecoveryRig.tscn` |
| READ ONLY | `scenes/levels/level_06/systems/Level06ShardSlot.tscn` |
| READ ONLY | `scripts/levels/level_06/level_06_recovery_controller.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_last_light_source.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_contract.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_runtime_contract_validator.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_shard_slot.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_reward_gate_controller.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_release_validity_controller.gd` |
| READ ONLY | `AGENTS.md` |
| READ ONLY | `project.godot` |
| READ ONLY | `scenes/core/Player.tscn` |
| READ ONLY | `scripts/player/player_controller.gd` |
| READ ONLY | `scripts/player/camera_controller.gd` |
| READ ONLY | `scenes/core/SoulShard.tscn` |
| READ ONLY | `scripts/soul/soul_shard.gd` |
| READ ONLY | `scenes/core/SoulOrb_Follow.tscn` |
| READ ONLY | `scripts/core/soul_orb_follow.gd` |
| READ ONLY | `scenes/core/LevelPortal.tscn` |
| READ ONLY | `scripts/core/level_portal.gd` |
| READ ONLY | `scenes/core/SceneTransition.tscn` |
| READ ONLY | `scripts/core/scene_transition.gd` |
| READ ONLY | `scripts/core/shard_reward_sequence_controller.gd` |
| READ ONLY | `scenes/ui/ShardRewardOverlay.tscn` |
| READ ONLY | `scripts/ui/shard_reward_overlay.gd` |
| READ ONLY | `scenes/ui/LevelFinaleOverlay.tscn` |
| READ ONLY | `scripts/ui/level_finale_overlay.gd` |
| READ ONLY | `scenes/core/FinalScene.tscn` |
| READ ONLY | `scripts/core/final_scene.gd` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/Level06IntegratedFlowHarness.tscn` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/level_06_integrated_flow_harness.gd` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/level_06_integrated_flow_harness.gd.uid` |
| CREATE - USER ARTIFACT OUTSIDE REPOSITORY WORKTREE | None. |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Greybox_Development_Reference_v1.2.1.md` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Greybox_Development_Reference_v1.2.1.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Narrative_and_Level_Scenario_Package_v1.1.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Visual_Master_Concept_Package.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Gameplay_Map_and_Level_Design_Spec_v1.3.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Technical_Architecture_and_State_Model_v1.2.2.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Art_Production_Bible_v1.1.docx` |
| FORBIDDEN | All paths, artifacts and mutations not explicitly authorized above; global forbidden list applies. |

### CONDITIONAL MATCHING `.gd.uid`
- `scripts/levels/level_06/level_06_pass_through_target.gd.uid`
- `scripts/levels/level_06/silver_wake_controller.gd.uid`
- `scripts/levels/level_06/level_06_progress_controller.gd.uid`

Rules:

- A persistent matching `.gd.uid` is permitted only together with its exact sibling `.gd`, and that sibling path must be explicitly listed in this slice's `CREATE` or `MODIFY` scope.
- A temporary matching `.gd.uid` is permitted only together with its exact sibling `.gd`, and both exact paths must be explicitly listed in this slice's `TEMPORARY CREATE - REMOVE BEFORE COMMIT` scope.
- Every temporary script and every temporary sidecar is removed before commit.
- A UID for any script outside this slice's active `CREATE`, `MODIFY` or `TEMPORARY CREATE - REMOVE BEFORE COMMIT` scope is forbidden.
- Unrelated `.gd.uid`, scene UID, `.import`, `.godot/imported`, cache and generated churn are forbidden.

## Scope-consistency acceptance

- Before any write, every repository path, external artifact and metadata source named anywhere in this slice contract must appear in this slice's exact scope.
- No required dependency may exist only under `FORBIDDEN`.
- At handoff, the persistent changed-file list must be a subset of `CREATE` + `MODIFY` plus only persistent matching `.gd.uid` sidecars whose exact sibling `.gd` is explicitly in `CREATE` or `MODIFY`.
- Temporary scripts and temporary matching `.gd.uid` sidecars may exist only during the active validation run when both exact paths are listed in `TEMPORARY CREATE - REMOVE BEFORE COMMIT`; all are absent before commit.
- Every `READ ONLY` repository file must remain byte-unchanged.
- Every temporary harness, temporary script and temporary sidecar/generated file caused by it must be removed before commit.
- Unrelated `.gd.uid`, scene UID, `.import`, `.godot/imported`, cache and generated churn must be absent.
- Any scope inconsistency is a hard stop before the first write and again before commit.

## Nodes, scenes and scripts
- WAKE_BAND_1-3 exact oriented boxes and placeholder persistent wakes.
- SilverWakeController and Level06PassThroughTarget.
- ShardSlot_13 instance already generic.

## APIs and signals
- Current-target owner-created target_generation.
- Held-future-overlap re-evaluation.
- Target accepted and puzzle completed signals from Appendix C.

## Implementation steps
- Build exact target transforms/shapes.
- Implement strict 1->2->3 unique acceptance and no grounded requirement.
- Implement next-physics current-overlap promotion.
- Implement 15 s non-flashing hint generation.
- Wire progress RA1/RA2/RA3 and Shard_13 reveal request.
- Build the exact temporary `Level06IntegratedFlowHarness`, instantiate real Level_06-local controllers and real shared READ ONLY scenes/scripts, execute the exact production prepare/commit and proxy-registration contract, then drive Wake -> actual Shard_13 interaction -> actual reward confirmation -> admitted actual `collected` -> E1/VEILS_ACTIVE.
- Do not synthesize collected/reward success, add production test branches or introduce staged production mode.
- Keep presentation optional and non-gating, then remove the complete fixture and sidecar before commit.

## Automated and static checks
- Walk/run/jump target tests.
- Future-overlap and duplicate/stale generation tests.
- Exact transform and floor-support checks.
- Temporary fixture topology scan: real Level_06-local controllers, real shared scenes/scripts, exact prepare/commit and explicit proxy registration, no production test-only branch/method, no staged production mode and no synthetic authority signal.
- Fixture cleanup and temporary UID scope proof before commit.

## Manual runtime checks
- Cross all bands by walk, run, jump and jump-spam.
- Remain inside future target during promotion.
- Backtrack after partial progress.
- Pre-overlap Shard_13 and complete exact reward through the actual shared SoulShard/reward flow in `Level06IntegratedFlowHarness`.
- Record Wake -> Shard_13 -> admitted actual collected -> E1/VEILS_ACTIVE as `TEMPORARY INTEGRATED-FLOW PASS` or factual FAIL.
- Record production `Level_06.tscn` natural-flow wiring separately as `DEFERRED TO G12 PRODUCTION WIRING`; do not report it as PASS.

## Acceptance criteria
- Runtime-only prerequisite P0-06 has factual PASS before G6; DEFERRED is not sufficient at this owner gate.
- Scope-consistency acceptance passes before the first write and at handoff.
- Strict ordered once-only completion.
- No silent crossing.
- RA1/RA2/RA3 exact.
- One Shard_13 reveal/reward through actual shared flow.
- Exact text and E1/Veils next stage only after admitted actual collected.
- Owning local component and temporary integrated-flow evidence are factual PASS; fixture and temporary sidecar are absent before commit.
- Production `Level_06.tscn` Wake -> Shard_13 -> E1/VEILS_ACTIVE remains exactly `DEFERRED TO G12 PRODUCTION WIRING`; this is not PASS but does not block Slice 7 after the temporary gate passes.
- G6 PASS is limited to the local component and temporary integrated-flow gate.

## Rollback plan
- Revert Slice 6 commit.

## Risks
- Pass-through target misses legal airborne crossing.
- Held overlap requires re-entry.
- Shard/reward order or anchor mapping fails.

## Out of scope
- Veils, constellation, environment, finale, portal.

## Stop conditions
- Runtime-only prerequisite P0-06 is FAIL or remains `DEFERRED TO OWNER P0` after the owning temporary fixture.
- The temporary integrated-flow fixture cannot prove Wake -> actual Shard_13 -> admitted actual collected -> E1/VEILS_ACTIVE without a synthetic event, production test branch or staged mode.
- Silver Wake order, persistence, target-generation or stationary Shard_13 contract fails.
- Geometry lacks 100% trigger floor support.
- A shared edit is needed without approved prerequisite.
`DEFERRED TO G12 PRODUCTION WIRING` by itself is not a Slice 6 stop after the temporary integration gate passes.
When any other stop condition triggers, do not execute the next slice. Record the blocker and request the exact prerequisite or Producer decision.

## Required handoff
- Approved base SHA, branch, slice-start SHA and final head SHA.
- Exact CREATE/MODIFY/READ ONLY diff audit and matching UID mapping.
- Commands and factual outputs.
- Manual evidence split into local component, `TEMPORARY INTEGRATED-FLOW PASS`/FAIL and production `DEFERRED TO G12 PRODUCTION WIRING`.
- Exact temporary fixture create/remove audit and temporary `.gd.uid` sibling proof.
- Risks, blocker status and rollback point.
- Commit SHA for the slice; PR link: N/A until Slice 13.
- Recommendation: continue automatically only when the internal gate passes.

# 29. Slice 7 - Clear Veils and Shard_14 Path

## Goal
Implement strict ordered transparent pass-through layers, logical/presentation split and Shard_14 reward path.

## Preconditions
- Shard_14 stationary newly enabled overlap is `DEFERRED TO OWNER P0` until P0-11 passes through the owning temporary integrated-flow fixture.
- Slice 6 local component and temporary integrated-flow gate PASS; its production natural-flow status remains `DEFERRED TO G12 PRODUCTION WIRING`.
- VEILS_ACTIVE is reached in the exact temporary `Level06IntegratedFlowHarness` through Wake -> actual Shard_13 -> admitted actual collected, not through a synthetic state injection.
- Final production RuntimeRoot attachment and natural-flow wiring remain reserved for Slice 12.

## Exact file scope
| Authority | Literal path / rule |
|---|---|
| CREATE | `scenes/levels/level_06/puzzles/ClearVeils.tscn` |
| CREATE | `scripts/levels/level_06/clear_veils_controller.gd` |
| MODIFY | `scenes/levels/Level_06.tscn` |
| MODIFY | `scripts/levels/level_06/level_06_progress_controller.gd` |
| READ ONLY | `scenes/levels/level_06/geometry/Level06GreyboxGeometry.tscn` |
| READ ONLY | `scenes/levels/level_06/systems/Level06RecoveryRig.tscn` |
| READ ONLY | `scenes/levels/level_06/systems/Level06ShardSlot.tscn` |
| READ ONLY | `scenes/levels/level_06/puzzles/SilverWake.tscn` |
| READ ONLY | `scripts/levels/level_06/level_06_recovery_controller.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_last_light_source.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_contract.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_runtime_contract_validator.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_shard_slot.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_reward_gate_controller.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_release_validity_controller.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_pass_through_target.gd` |
| READ ONLY | `scripts/levels/level_06/silver_wake_controller.gd` |
| READ ONLY | `AGENTS.md` |
| READ ONLY | `project.godot` |
| READ ONLY | `scenes/core/Player.tscn` |
| READ ONLY | `scripts/player/player_controller.gd` |
| READ ONLY | `scripts/player/camera_controller.gd` |
| READ ONLY | `scenes/core/SoulShard.tscn` |
| READ ONLY | `scripts/soul/soul_shard.gd` |
| READ ONLY | `scenes/core/SoulOrb_Follow.tscn` |
| READ ONLY | `scripts/core/soul_orb_follow.gd` |
| READ ONLY | `scenes/core/LevelPortal.tscn` |
| READ ONLY | `scripts/core/level_portal.gd` |
| READ ONLY | `scenes/core/SceneTransition.tscn` |
| READ ONLY | `scripts/core/scene_transition.gd` |
| READ ONLY | `scripts/core/shard_reward_sequence_controller.gd` |
| READ ONLY | `scenes/ui/ShardRewardOverlay.tscn` |
| READ ONLY | `scripts/ui/shard_reward_overlay.gd` |
| READ ONLY | `scenes/ui/LevelFinaleOverlay.tscn` |
| READ ONLY | `scripts/ui/level_finale_overlay.gd` |
| READ ONLY | `scenes/core/FinalScene.tscn` |
| READ ONLY | `scripts/core/final_scene.gd` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/Level06IntegratedFlowHarness.tscn` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/level_06_integrated_flow_harness.gd` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/level_06_integrated_flow_harness.gd.uid` |
| CREATE - USER ARTIFACT OUTSIDE REPOSITORY WORKTREE | None. |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Greybox_Development_Reference_v1.2.1.md` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Greybox_Development_Reference_v1.2.1.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Narrative_and_Level_Scenario_Package_v1.1.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Visual_Master_Concept_Package.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Gameplay_Map_and_Level_Design_Spec_v1.3.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Technical_Architecture_and_State_Model_v1.2.2.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Art_Production_Bible_v1.1.docx` |
| FORBIDDEN | All paths, artifacts and mutations not explicitly authorized above; global forbidden list applies. |

### CONDITIONAL MATCHING `.gd.uid`
- `scripts/levels/level_06/clear_veils_controller.gd.uid`
- `scripts/levels/level_06/level_06_progress_controller.gd.uid`

Rules:

- A persistent matching `.gd.uid` is permitted only together with its exact sibling `.gd`, and that sibling path must be explicitly listed in this slice's `CREATE` or `MODIFY` scope.
- A temporary matching `.gd.uid` is permitted only together with its exact sibling `.gd`, and both exact paths must be explicitly listed in this slice's `TEMPORARY CREATE - REMOVE BEFORE COMMIT` scope.
- Every temporary script and every temporary sidecar is removed before commit.
- A UID for any script outside this slice's active `CREATE`, `MODIFY` or `TEMPORARY CREATE - REMOVE BEFORE COMMIT` scope is forbidden.
- Unrelated `.gd.uid`, scene UID, `.import`, `.godot/imported`, cache and generated churn are forbidden.

## Scope-consistency acceptance

- Before any write, every repository path, external artifact and metadata source named anywhere in this slice contract must appear in this slice's exact scope.
- No required dependency may exist only under `FORBIDDEN`.
- At handoff, the persistent changed-file list must be a subset of `CREATE` + `MODIFY` plus only persistent matching `.gd.uid` sidecars whose exact sibling `.gd` is explicitly in `CREATE` or `MODIFY`.
- Temporary scripts and temporary matching `.gd.uid` sidecars may exist only during the active validation run when both exact paths are listed in `TEMPORARY CREATE - REMOVE BEFORE COMMIT`; all are absent before commit.
- Every `READ ONLY` repository file must remain byte-unchanged.
- Every temporary harness, temporary script and temporary sidecar/generated file caused by it must be removed before commit.
- Unrelated `.gd.uid`, scene UID, `.import`, `.godot/imported`, cache and generated churn must be absent.
- Any scope inconsistency is a hard stop before the first write and again before commit.

## Nodes, scenes and scripts
- VEIL_LAYER_1-3 exact boxes and transparent primitive presentation.
- ClearVeilsController.
- ShardSlot_14 generic instance.

## APIs and signals
- Strict target_generation sequence.
- Independent per-layer presentation_generation.
- Third-layer 2.50 s first-terminal fallback.

## Implementation steps
- Build exact transforms and transparent nonblocking placeholders.
- Implement immediate logical acceptance and next-target eligibility.
- Implement local presentation callbacks without gating intermediate targets.
- Implement final presentation race.
- Wire RA6/RA7, Shard_14 reveal and reward transition.
- Recreate the exact temporary `Level06IntegratedFlowHarness`, use the real previously implemented Wake path and actual Shard_13 shared flow to reach VEILS_ACTIVE, then drive Veils -> actual Shard_14 interaction -> actual reward confirmation -> admitted actual `collected` -> E2/CONSTELLATION_ACTIVE.
- Use production APIs and exact prepare/commit/proxy-registration contract only; do not synthesize state, collection or reward success.
- Remove the complete fixture and temporary sidecar before commit.

## Automated and static checks
- Airborne/boundary spam tests.
- Held-future-overlap tests.
- Missing callback and stale generation tests.
- Shared resource mutation scan.
- Temporary integrated-flow topology/no-bypass scan and fixture cleanup/temporary UID proof.

## Manual runtime checks
- Cross all layers by walk/run/jump.
- Suppress presentation callbacks.
- Backtrack partial/completed path.
- Pre-overlap Shard_14 and complete exact reward through the actual shared SoulShard/reward flow in `Level06IntegratedFlowHarness`.
- Record Veils -> Shard_14 -> admitted actual collected -> E2/CONSTELLATION_ACTIVE as `TEMPORARY INTEGRATED-FLOW PASS` or factual FAIL.
- Record production `Level_06.tscn` natural-flow wiring separately as `DEFERRED TO G12 PRODUCTION WIRING`; do not report it as PASS.

## Acceptance criteria
- Runtime-only prerequisite P0-11 has factual PASS before G7; DEFERRED is not sufficient at this owner gate.
- Scope-consistency acceptance passes before the first write and at handoff.
- Strict ordered persistent logical flow.
- Presentation fallback only.
- One reveal/reward.
- Exact text.
- E2/Constellation after admitted actual collected.
- Owning local component and temporary integrated-flow evidence are factual PASS; fixture and temporary sidecar are absent before commit.
- Production Wake/Shard_13 and Veils/Shard_14 natural-flow wiring remains exactly `DEFERRED TO G12 PRODUCTION WIRING`; this is not PASS but does not block Slice 8 after the temporary gate passes.
- G7 PASS is limited to the local component and temporary integrated-flow gate.

## Rollback plan
- Revert Slice 7 commit.

## Risks
- Veil blocks route.
- Logical progress waits for optional presentation.
- Fallback synthesizes gameplay.

## Out of scope
- Constellation, environment, finale and portal.

## Stop conditions
- Runtime-only prerequisite P0-11 is FAIL or remains `DEFERRED TO OWNER P0` after the owning temporary fixture.
- The temporary fixture cannot reach VEILS_ACTIVE through actual Wake/Shard_13 flow or cannot prove Veils -> actual Shard_14 -> admitted actual collected -> E2/CONSTELLATION_ACTIVE without a synthetic event, production test branch or staged mode.
- Reaction order, persistence, held-overlap or terminal race fails.
- Transparent placeholder creates collision or hidden-route reading.
- Shard_14 contract fails.
`DEFERRED TO G12 PRODUCTION WIRING` by itself is not a Slice 7 stop after the temporary integration gate passes.
When any other stop condition triggers, do not execute the next slice. Record the blocker and request the exact prerequisite or Producer decision.

## Required handoff
- Approved base SHA, branch, slice-start SHA and final head SHA.
- Exact CREATE/MODIFY/READ ONLY diff audit and matching UID mapping.
- Commands and factual outputs.
- Manual evidence split into local component, `TEMPORARY INTEGRATED-FLOW PASS`/FAIL and production `DEFERRED TO G12 PRODUCTION WIRING`.
- Exact temporary fixture create/remove audit and temporary `.gd.uid` sibling proof.
- Risks, blocker status and rollback point.
- Commit SHA for the slice; PR link: N/A until Slice 13.
- Recommendation: continue automatically only when the internal gate passes.

# 30. Slice 8 - Horizon Constellation and Shard_15 Path

## Goal
Implement three any-order grounded dwell zones, persistent independent groups, pulse fallback and Shard_15 reward completion.

## Preconditions
- Shard_15 stationary newly enabled overlap is `DEFERRED TO OWNER P0` until P0-16 passes through the owning temporary integrated-flow fixture.
- Slice 7 local component and temporary integrated-flow gate PASS; production natural-flow wiring remains `DEFERRED TO G12 PRODUCTION WIRING`.
- CONSTELLATION_ACTIVE is reached in the exact temporary `Level06IntegratedFlowHarness` through actual Wake/Shard_13 and Veils/Shard_14 shared flows, not synthetic state injection.
- Final production RuntimeRoot attachment and natural-flow wiring remain reserved for Slice 12.

## Exact file scope
| Authority | Literal path / rule |
|---|---|
| CREATE | `scenes/levels/level_06/puzzles/HorizonConstellation.tscn` |
| CREATE | `scripts/levels/level_06/level_06_grounded_dwell_zone.gd` |
| CREATE | `scripts/levels/level_06/horizon_constellation_controller.gd` |
| MODIFY | `scenes/levels/Level_06.tscn` |
| MODIFY | `scripts/levels/level_06/level_06_progress_controller.gd` |
| READ ONLY | `scenes/levels/level_06/geometry/Level06GreyboxGeometry.tscn` |
| READ ONLY | `scenes/levels/level_06/systems/Level06RecoveryRig.tscn` |
| READ ONLY | `scenes/levels/level_06/systems/Level06ShardSlot.tscn` |
| READ ONLY | `scenes/levels/level_06/puzzles/SilverWake.tscn` |
| READ ONLY | `scenes/levels/level_06/puzzles/ClearVeils.tscn` |
| READ ONLY | `scripts/levels/level_06/level_06_recovery_controller.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_last_light_source.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_contract.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_runtime_contract_validator.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_shard_slot.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_reward_gate_controller.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_release_validity_controller.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_pass_through_target.gd` |
| READ ONLY | `scripts/levels/level_06/silver_wake_controller.gd` |
| READ ONLY | `scripts/levels/level_06/clear_veils_controller.gd` |
| READ ONLY | `AGENTS.md` |
| READ ONLY | `project.godot` |
| READ ONLY | `scenes/core/Player.tscn` |
| READ ONLY | `scripts/player/player_controller.gd` |
| READ ONLY | `scripts/player/camera_controller.gd` |
| READ ONLY | `scenes/core/SoulShard.tscn` |
| READ ONLY | `scripts/soul/soul_shard.gd` |
| READ ONLY | `scenes/core/SoulOrb_Follow.tscn` |
| READ ONLY | `scripts/core/soul_orb_follow.gd` |
| READ ONLY | `scenes/core/LevelPortal.tscn` |
| READ ONLY | `scripts/core/level_portal.gd` |
| READ ONLY | `scenes/core/SceneTransition.tscn` |
| READ ONLY | `scripts/core/scene_transition.gd` |
| READ ONLY | `scripts/core/shard_reward_sequence_controller.gd` |
| READ ONLY | `scenes/ui/ShardRewardOverlay.tscn` |
| READ ONLY | `scripts/ui/shard_reward_overlay.gd` |
| READ ONLY | `scenes/ui/LevelFinaleOverlay.tscn` |
| READ ONLY | `scripts/ui/level_finale_overlay.gd` |
| READ ONLY | `scenes/core/FinalScene.tscn` |
| READ ONLY | `scripts/core/final_scene.gd` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/Level06IntegratedFlowHarness.tscn` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/level_06_integrated_flow_harness.gd` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/level_06_integrated_flow_harness.gd.uid` |
| CREATE - USER ARTIFACT OUTSIDE REPOSITORY WORKTREE | None. |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Greybox_Development_Reference_v1.2.1.md` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Greybox_Development_Reference_v1.2.1.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Narrative_and_Level_Scenario_Package_v1.1.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Visual_Master_Concept_Package.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Gameplay_Map_and_Level_Design_Spec_v1.3.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Technical_Architecture_and_State_Model_v1.2.2.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Art_Production_Bible_v1.1.docx` |
| FORBIDDEN | All paths, artifacts and mutations not explicitly authorized above; global forbidden list applies. |

### CONDITIONAL MATCHING `.gd.uid`
- `scripts/levels/level_06/level_06_grounded_dwell_zone.gd.uid`
- `scripts/levels/level_06/horizon_constellation_controller.gd.uid`
- `scripts/levels/level_06/level_06_progress_controller.gd.uid`

Rules:

- A persistent matching `.gd.uid` is permitted only together with its exact sibling `.gd`, and that sibling path must be explicitly listed in this slice's `CREATE` or `MODIFY` scope.
- A temporary matching `.gd.uid` is permitted only together with its exact sibling `.gd`, and both exact paths must be explicitly listed in this slice's `TEMPORARY CREATE - REMOVE BEFORE COMMIT` scope.
- Every temporary script and every temporary sidecar is removed before commit.
- A UID for any script outside this slice's active `CREATE`, `MODIFY` or `TEMPORARY CREATE - REMOVE BEFORE COMMIT` scope is forbidden.
- Unrelated `.gd.uid`, scene UID, `.import`, `.godot/imported`, cache and generated churn are forbidden.

## Scope-consistency acceptance

- Before any write, every repository path, external artifact and metadata source named anywhere in this slice contract must appear in this slice's exact scope.
- No required dependency may exist only under `FORBIDDEN`.
- At handoff, the persistent changed-file list must be a subset of `CREATE` + `MODIFY` plus only persistent matching `.gd.uid` sidecars whose exact sibling `.gd` is explicitly in `CREATE` or `MODIFY`.
- Temporary scripts and temporary matching `.gd.uid` sidecars may exist only during the active validation run when both exact paths are listed in `TEMPORARY CREATE - REMOVE BEFORE COMMIT`; all are absent before commit.
- Every `READ ONLY` repository file must remain byte-unchanged.
- Every temporary harness, temporary script and temporary sidecar/generated file caused by it must be removed before commit.
- Unrelated `.gd.uid`, scene UID, `.import`, `.godot/imported`, cache and generated churn must be absent.
- Any scope inconsistency is a hard stop before the first write and again before commit.

## Nodes, scenes and scripts
- CONSTELLATION_WEST/CREST/EAST exact cylinders.
- Grounded dwell zone FSM.
- Three distinct persistent primitive light groups.
- ShardSlot_15.

## APIs and signals
- Owner-created zone_generation.
- 0.60 s accumulated grounded presence.
- Exact-set completion; 1.40 s pulse first-terminal fallback.

## Implementation steps
- Build exact zones and continuous supported Z07 floor.
- Implement pause while airborne, reset only on actual exit, immutable accepted state.
- Implement six permutations and RA10 on first unique zone.
- Implement 20/35 s hints without auto-complete.
- Wire Shard_15 reveal/reward and all_rewards completion.
- Recreate the exact temporary `Level06IntegratedFlowHarness`, reach CONSTELLATION_ACTIVE through the actual prior reward-driven flow, then drive Constellation -> actual Shard_15 interaction -> actual reward confirmation -> admitted actual `collected` -> ALL_REWARDS_COMPLETE.
- Use production APIs and exact prepare/commit/proxy-registration contract only; do not synthesize state, collection or reward success.
- Remove the complete fixture and temporary sidecar before commit.

## Automated and static checks
- Six-order matrix.
- Grounded/airborne/exit semantics.
- Containment R4.60 within support R5.00.
- Stale zone/hint/presentation generations.
- Temporary integrated-flow topology/no-bypass scan and fixture cleanup/temporary UID proof.

## Manual runtime checks
- Complete all six orders.
- Jump inside zones and exit incomplete dwell.
- Backtrack after partial completion.
- Pre-overlap Shard_15 and complete exact reward through the actual shared SoulShard/reward flow in `Level06IntegratedFlowHarness`.
- Record Constellation -> Shard_15 -> admitted actual collected -> ALL_REWARDS_COMPLETE as `TEMPORARY INTEGRATED-FLOW PASS` or factual FAIL.
- Record production `Level_06.tscn` natural-flow wiring separately as `DEFERRED TO G12 PRODUCTION WIRING`; do not report it as PASS.

## Acceptance criteria
- Runtime-only prerequisite P0-16 has factual PASS before G8; DEFERRED is not sufficient at this owner gate.
- Scope-consistency acceptance passes before the first write and at handoff.
- Any-order exact-set completion.
- RA10 once for any first zone.
- No camera/audio dependency.
- One Shard_15 reveal/reward.
- ALL_REWARDS_COMPLETE only after admitted actual collected.
- Owning local component and temporary integrated-flow evidence are factual PASS; fixture and temporary sidecar are absent before commit.
- Production reward-driven natural-flow wiring through all three shards remains exactly `DEFERRED TO G12 PRODUCTION WIRING`; this is not PASS and blocks G12/final DoD until resolved there, but G8 may pass on the temporary gate.
- G8 PASS is limited to the local component and temporary integrated-flow gate.

## Rollback plan
- Revert Slice 8 commit.

## Risks
- Any-order or dwell semantics fail.
- Target not fully supported.
- Camera alignment or count-only authority appears.

## Out of scope
- Environment, finale and portal.

## Stop conditions
- Runtime-only prerequisite P0-16 is FAIL or remains `DEFERRED TO OWNER P0` after the owning temporary fixture.
- The temporary fixture cannot reach CONSTELLATION_ACTIVE through actual prior flow or cannot prove Constellation -> actual Shard_15 -> admitted actual collected -> ALL_REWARDS_COMPLETE without a synthetic event, production test branch or staged mode.
- Any-order, camera-independence, persistence, floor containment or Shard_15 contract fails.
- A zone can accept while airborne or outside support.
- Exact all-rewards event becomes ambiguous.
`DEFERRED TO G12 PRODUCTION WIRING` by itself is not a Slice 8 stop after the temporary integration gate passes; it remains a mandatory G12/final blocker.
When any other stop condition triggers, do not execute the next slice. Record the blocker and request the exact prerequisite or Producer decision.

## Required handoff
- Approved base SHA, branch, slice-start SHA and final head SHA.
- Exact CREATE/MODIFY/READ ONLY diff audit and matching UID mapping.
- Commands and factual outputs.
- Manual evidence split into local component, `TEMPORARY INTEGRATED-FLOW PASS`/FAIL and production `DEFERRED TO G12 PRODUCTION WIRING`.
- Exact temporary fixture create/remove audit and temporary `.gd.uid` sibling proof.
- Risks, blocker status and rollback point.
- Commit SHA for the slice; PR link: N/A until Slice 13.
- Recommendation: continue automatically only when the internal gate passes.

# 31. Slice 9 - Environment E0-E4 Integration

## Goal
Implement the sole EnvironmentPresentation owner with local resources and nonblocking E0-E4 state adoption/transitions.

## Preconditions
- Slice 8 PASS.
- Exact macro events available.

## Exact file scope
| Authority | Literal path / rule |
|---|---|
| CREATE | `scenes/levels/level_06/environment/Level06EnvironmentPresentation.tscn` |
| CREATE | `scripts/levels/level_06/level_06_environment_controller.gd` |
| MODIFY | `scenes/levels/Level_06.tscn` |
| MODIFY | `scripts/levels/level_06/level_06_progress_controller.gd` |
| READ ONLY | `scenes/levels/level_06/geometry/Level06GreyboxGeometry.tscn` |
| READ ONLY | `scenes/levels/level_06/systems/Level06RecoveryRig.tscn` |
| READ ONLY | `scenes/levels/level_06/systems/Level06ShardSlot.tscn` |
| READ ONLY | `scenes/levels/level_06/puzzles/SilverWake.tscn` |
| READ ONLY | `scenes/levels/level_06/puzzles/ClearVeils.tscn` |
| READ ONLY | `scenes/levels/level_06/puzzles/HorizonConstellation.tscn` |
| READ ONLY | `scripts/levels/level_06/level_06_recovery_controller.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_last_light_source.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_contract.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_runtime_contract_validator.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_shard_slot.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_reward_gate_controller.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_release_validity_controller.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_pass_through_target.gd` |
| READ ONLY | `scripts/levels/level_06/silver_wake_controller.gd` |
| READ ONLY | `scripts/levels/level_06/clear_veils_controller.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_grounded_dwell_zone.gd` |
| READ ONLY | `scripts/levels/level_06/horizon_constellation_controller.gd` |
| READ ONLY | `AGENTS.md` |
| READ ONLY | `project.godot` |
| READ ONLY | `scenes/core/Player.tscn` |
| READ ONLY | `scripts/player/player_controller.gd` |
| READ ONLY | `scripts/player/camera_controller.gd` |
| READ ONLY | `scenes/core/SoulShard.tscn` |
| READ ONLY | `scripts/soul/soul_shard.gd` |
| READ ONLY | `scenes/core/SoulOrb_Follow.tscn` |
| READ ONLY | `scripts/core/soul_orb_follow.gd` |
| READ ONLY | `scenes/core/LevelPortal.tscn` |
| READ ONLY | `scripts/core/level_portal.gd` |
| READ ONLY | `scenes/core/SceneTransition.tscn` |
| READ ONLY | `scripts/core/scene_transition.gd` |
| READ ONLY | `scripts/core/shard_reward_sequence_controller.gd` |
| READ ONLY | `scenes/ui/ShardRewardOverlay.tscn` |
| READ ONLY | `scripts/ui/shard_reward_overlay.gd` |
| READ ONLY | `scenes/ui/LevelFinaleOverlay.tscn` |
| READ ONLY | `scripts/ui/level_finale_overlay.gd` |
| READ ONLY | `scenes/core/FinalScene.tscn` |
| READ ONLY | `scripts/core/final_scene.gd` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | None. |
| CREATE - USER ARTIFACT OUTSIDE REPOSITORY WORKTREE | None. |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Greybox_Development_Reference_v1.2.1.md` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Greybox_Development_Reference_v1.2.1.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Narrative_and_Level_Scenario_Package_v1.1.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Visual_Master_Concept_Package.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Gameplay_Map_and_Level_Design_Spec_v1.3.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Technical_Architecture_and_State_Model_v1.2.2.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Art_Production_Bible_v1.1.docx` |
| FORBIDDEN | All paths, artifacts and mutations not explicitly authorized above; global forbidden list applies. |

### CONDITIONAL MATCHING `.gd.uid`
- `scripts/levels/level_06/level_06_environment_controller.gd.uid`
- `scripts/levels/level_06/level_06_progress_controller.gd.uid`

Rules:

- A persistent matching `.gd.uid` is permitted only together with its exact sibling `.gd`, and that sibling path must be explicitly listed in this slice's `CREATE` or `MODIFY` scope.
- A temporary matching `.gd.uid` is permitted only together with its exact sibling `.gd`, and both exact paths must be explicitly listed in this slice's `TEMPORARY CREATE - REMOVE BEFORE COMMIT` scope.
- Every temporary script and every temporary sidecar is removed before commit.
- A UID for any script outside this slice's active `CREATE`, `MODIFY` or `TEMPORARY CREATE - REMOVE BEFORE COMMIT` scope is forbidden.
- Unrelated `.gd.uid`, scene UID, `.import`, `.godot/imported`, cache and generated churn are forbidden.

## Scope-consistency acceptance

- Before any write, every repository path, external artifact and metadata source named anywhere in this slice contract must appear in this slice's exact scope.
- No required dependency may exist only under `FORBIDDEN`.
- At handoff, the persistent changed-file list must be a subset of `CREATE` + `MODIFY` plus only persistent matching `.gd.uid` sidecars whose exact sibling `.gd` is explicitly in `CREATE` or `MODIFY`.
- Temporary scripts and temporary matching `.gd.uid` sidecars may exist only during the active validation run when both exact paths are listed in `TEMPORARY CREATE - REMOVE BEFORE COMMIT`; all are absent before commit.
- Every `READ ONLY` repository file must remain byte-unchanged.
- Every temporary harness, temporary script and temporary sidecar/generated file caused by it must be removed before commit.
- Unrelated `.gd.uid`, scene UID, `.import`, `.godot/imported`, cache and generated churn must be absent.
- Any scope inconsistency is a hard stop before the first write and again before commit.

## Nodes, scenes and scripts
- WorldRoot/EnvironmentPresentation root with controller.
- Local primitive E0 grass/veil/light/cloud motion.
- E1-E4 local guidance placeholders.

## APIs and signals
- `validate_contract`, `prepare_run`, `commit_run`, `request_state`.
- Owner-created presentation_generation.
- Optional local fallback diagnostics.

## Implementation steps
- Create serialized alive E0 baseline.
- Deep-duplicate all mutated resources.
- Implement monotonic exact state requests.
- Keep domains independently tweened.
- Adopt E0 on commit without replay flash.
- Ensure portal visual remains exclusively shared LevelPortal.

## Automated and static checks
- Single-owner scan.
- Shared-resource identity checks.
- E2 during E1 race.
- Control-lock and PortalAccent reference scans.

## Manual runtime checks
- Continue solving while transitions run.
- Suppress callbacks.
- Reload and verify E0 alive while bootstrap inert.
- Inspect prior motifs persist.

## Acceptance criteria
- Scope-consistency acceptance passes before the first write and at handoff.
- Exactly one environment owner.
- No Player lock.
- No progression callback gate.
- No shared mutation.
- No local portal accent/controller.
- G9 PASS.

## Rollback plan
- Revert Slice 9 commit; gameplay remains logically testable.

## Risks
- Tween-domain interference.
- Environment duplicated under RuntimeRoot.
- Portal ownership leak.

## Out of scope
- Main text, portal and final art.

## Stop conditions
- Environment blocks Player, mutates shared resources, gates progression callback or owns PortalAccent.
- E0 is dead before interaction or commit causes visual reset flash.
- State can regress/skip illegally.
When any stop condition triggers, do not execute the next slice. Record the blocker and request the exact prerequisite or Producer decision.

## Required handoff
- Approved base SHA, branch, slice-start SHA and final head SHA.
- Exact CREATE/MODIFY/READ ONLY diff audit and matching UID mapping.
- Commands and factual outputs.
- Manual evidence marked PASS / FAIL / NOT VERIFIED.
- Risks, blocker status and rollback point.
- Commit SHA for the slice; PR link: N/A until Slice 13.
- Recommendation: continue automatically only when the internal gate passes.


# 32. Slice 10 - Exact Main Text and Fail-Closed Finale

## Goal
Implement FinalTextGate occupancy, exact main-text presentation, owned Player lock and writer-specific recovery suspension.

## Preconditions
- Slice 9 PASS.
- ALL_REWARDS_COMPLETE exact event available.
- Recovery writer API from Slice 3 available.

## Exact file scope
| Authority | Literal path / rule |
|---|---|
| CREATE | `scripts/levels/level_06/level_06_main_text_controller.gd` |
| MODIFY | `scenes/levels/Level_06.tscn` |
| MODIFY | `scripts/levels/level_06/level_06_progress_controller.gd` |
| READ ONLY | `scenes/levels/level_06/geometry/Level06GreyboxGeometry.tscn` |
| READ ONLY | `scenes/levels/level_06/systems/Level06RecoveryRig.tscn` |
| READ ONLY | `scenes/levels/level_06/systems/Level06ShardSlot.tscn` |
| READ ONLY | `scenes/levels/level_06/puzzles/SilverWake.tscn` |
| READ ONLY | `scenes/levels/level_06/puzzles/ClearVeils.tscn` |
| READ ONLY | `scenes/levels/level_06/puzzles/HorizonConstellation.tscn` |
| READ ONLY | `scenes/levels/level_06/environment/Level06EnvironmentPresentation.tscn` |
| READ ONLY | `scripts/levels/level_06/level_06_recovery_controller.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_last_light_source.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_contract.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_runtime_contract_validator.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_shard_slot.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_reward_gate_controller.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_release_validity_controller.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_pass_through_target.gd` |
| READ ONLY | `scripts/levels/level_06/silver_wake_controller.gd` |
| READ ONLY | `scripts/levels/level_06/clear_veils_controller.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_grounded_dwell_zone.gd` |
| READ ONLY | `scripts/levels/level_06/horizon_constellation_controller.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_environment_controller.gd` |
| READ ONLY | `AGENTS.md` |
| READ ONLY | `project.godot` |
| READ ONLY | `scenes/core/Player.tscn` |
| READ ONLY | `scripts/player/player_controller.gd` |
| READ ONLY | `scripts/player/camera_controller.gd` |
| READ ONLY | `scenes/core/SoulShard.tscn` |
| READ ONLY | `scripts/soul/soul_shard.gd` |
| READ ONLY | `scenes/core/SoulOrb_Follow.tscn` |
| READ ONLY | `scripts/core/soul_orb_follow.gd` |
| READ ONLY | `scenes/core/LevelPortal.tscn` |
| READ ONLY | `scripts/core/level_portal.gd` |
| READ ONLY | `scenes/core/SceneTransition.tscn` |
| READ ONLY | `scripts/core/scene_transition.gd` |
| READ ONLY | `scripts/core/shard_reward_sequence_controller.gd` |
| READ ONLY | `scenes/ui/ShardRewardOverlay.tscn` |
| READ ONLY | `scripts/ui/shard_reward_overlay.gd` |
| READ ONLY | `scenes/ui/LevelFinaleOverlay.tscn` |
| READ ONLY | `scripts/ui/level_finale_overlay.gd` |
| READ ONLY | `scenes/core/FinalScene.tscn` |
| READ ONLY | `scripts/core/final_scene.gd` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/fakes/fake_finale_overlay.gd` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/MainTextHarness.tscn` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/main_text_harness.gd` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/main_text_harness.gd.uid` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/fakes/fake_finale_overlay.gd.uid` |
| CREATE - USER ARTIFACT OUTSIDE REPOSITORY WORKTREE | None. |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Greybox_Development_Reference_v1.2.1.md` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Greybox_Development_Reference_v1.2.1.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Narrative_and_Level_Scenario_Package_v1.1.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Visual_Master_Concept_Package.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Gameplay_Map_and_Level_Design_Spec_v1.3.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Technical_Architecture_and_State_Model_v1.2.2.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Art_Production_Bible_v1.1.docx` |
| FORBIDDEN | All paths, artifacts and mutations not explicitly authorized above; global forbidden list applies. |

### CONDITIONAL MATCHING `.gd.uid`
- `scripts/levels/level_06/level_06_main_text_controller.gd.uid`
- `scripts/levels/level_06/level_06_progress_controller.gd.uid`

Rules:

- A persistent matching `.gd.uid` is permitted only together with its exact sibling `.gd`, and that sibling path must be explicitly listed in this slice's `CREATE` or `MODIFY` scope.
- A temporary matching `.gd.uid` is permitted only together with its exact sibling `.gd`, and both exact paths must be explicitly listed in this slice's `TEMPORARY CREATE - REMOVE BEFORE COMMIT` scope.
- Every temporary script and every temporary sidecar is removed before commit.
- A UID for any script outside this slice's active `CREATE`, `MODIFY` or `TEMPORARY CREATE - REMOVE BEFORE COMMIT` scope is forbidden.
- Unrelated `.gd.uid`, scene UID, `.import`, `.godot/imported`, cache and generated churn are forbidden.

## Scope-consistency acceptance

- Before any write, every repository path, external artifact and metadata source named anywhere in this slice contract must appear in this slice's exact scope.
- No required dependency may exist only under `FORBIDDEN`.
- At handoff, the persistent changed-file list must be a subset of `CREATE` + `MODIFY` plus only persistent matching `.gd.uid` sidecars whose exact sibling `.gd` is explicitly in `CREATE` or `MODIFY`.
- Temporary scripts and temporary matching `.gd.uid` sidecars may exist only during the active validation run when both exact paths are listed in `TEMPORARY CREATE - REMOVE BEFORE COMMIT`; all are absent before commit.
- Every `READ ONLY` repository file must remain byte-unchanged.
- Every temporary harness, temporary script and temporary sidecar/generated file caused by it must be removed before commit.
- Unrelated `.gd.uid`, scene UID, `.import`, `.godot/imported`, cache and generated churn must be absent.
- Any scope inconsistency is a hard stop before the first write and again before commit.

## Nodes, scenes and scripts
- FinalTextGate exact cylinder already under FinaleRoot.
- Level06MainTextController remains unattached until Slice 12.
- Shared LevelFinaleOverlay instance.

## APIs and signals
- Exact Appendix C main-text APIs/signals.
- No fallback-success timer.
- Owned control lock and main_text suspension.

## Implementation steps
- Implement LOCKED_TRACKING -> ARMING -> READY -> SHOWING/CLOSED/FAILED_CLOSED.
- Record occupancy before eligibility.
- Reevaluate after one physics frame.
- Validate exact overlay path/API/copy and true return.
- Set suspension and controls only after accepted startup.
- Advance only on actual `closed`.
- On failure release only owned lock/key and keep portal inactive.

## Automated and static checks
- Temporary FakeFinaleOverlay true/false/duplicate/late harness.
- Exact text equality and layout 1280x720 test.
- Early-overlap and duplicate-close tests.
- No timer-success scan.

## Manual runtime checks
- Stand inside gate before Shard_15 reward.
- Close normally and emit duplicate close.
- Remove/wrong overlay or false return.
- Fall during text and verify pending recovery after cleanup.

## Acceptance criteria
- Scope-consistency acceptance passes before the first write and at handoff.
- Exact text accepted and readable.
- No re-entry.
- One close transition.
- Failure is closed and cleans owned state.
- Portal never opens on failure.
- G10 PASS.

## Rollback plan
- Revert Slice 10 commit.

## Risks
- Shared overlay cannot display exact text.
- Lock ownership leak.
- Failure path opens exit.

## Out of scope
- Portal implementation and FinalScene content.

## Stop conditions
- Exact main text is rejected by actual overlay API, does not fit, or is altered.
- Failure activates portal.
- Control lock or suspension cannot be released safely.
- Mandatory UI evidence remains NOT VERIFIED.
When any stop condition triggers, do not execute the next slice. Record the blocker and request the exact prerequisite or Producer decision.

## Required handoff
- Approved base SHA, branch, slice-start SHA and final head SHA.
- Exact CREATE/MODIFY/READ ONLY diff audit and matching UID mapping.
- Commands and factual outputs.
- Manual evidence marked PASS / FAIL / NOT VERIFIED.
- Risks, blocker status and rollback point.
- Commit SHA for the slice; PR link: N/A until Slice 13.
- Recommendation: continue automatically only when the internal gate passes.

# 33. Slice 11 - Portal Adapter, Retryable Attempts and FinalScene Handoff

## Goal
Implement the Level-local attempt FSM and real shared LevelPortal/SceneTransition integration without local loading.

## Preconditions
- Stationary AUTO_ENTER overlap and real SceneTransition destination replacement remain `DEFERRED TO OWNER P0` until P0-27/P0-28/P0-44/P0-46 pass.
- Slice 10 PASS.
- Actual LevelPortal and SceneTransition contracts reconfirmed.

## Exact file scope
| Authority | Literal path / rule |
|---|---|
| CREATE | `scripts/levels/level_06/level_06_portal_adapter.gd` |
| MODIFY | `scenes/levels/Level_06.tscn` |
| MODIFY | `scripts/levels/level_06/level_06_progress_controller.gd` |
| MODIFY | `scripts/levels/level_06/level_06_recovery_controller.gd` |
| READ ONLY | `scenes/levels/level_06/geometry/Level06GreyboxGeometry.tscn` |
| READ ONLY | `scenes/levels/level_06/systems/Level06RecoveryRig.tscn` |
| READ ONLY | `scenes/levels/level_06/systems/Level06ShardSlot.tscn` |
| READ ONLY | `scenes/levels/level_06/puzzles/SilverWake.tscn` |
| READ ONLY | `scenes/levels/level_06/puzzles/ClearVeils.tscn` |
| READ ONLY | `scenes/levels/level_06/puzzles/HorizonConstellation.tscn` |
| READ ONLY | `scenes/levels/level_06/environment/Level06EnvironmentPresentation.tscn` |
| READ ONLY | `scripts/levels/level_06/level_06_last_light_source.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_contract.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_runtime_contract_validator.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_shard_slot.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_reward_gate_controller.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_release_validity_controller.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_pass_through_target.gd` |
| READ ONLY | `scripts/levels/level_06/silver_wake_controller.gd` |
| READ ONLY | `scripts/levels/level_06/clear_veils_controller.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_grounded_dwell_zone.gd` |
| READ ONLY | `scripts/levels/level_06/horizon_constellation_controller.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_environment_controller.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_main_text_controller.gd` |
| READ ONLY | `AGENTS.md` |
| READ ONLY | `project.godot` |
| READ ONLY | `scenes/core/Player.tscn` |
| READ ONLY | `scripts/player/player_controller.gd` |
| READ ONLY | `scripts/player/camera_controller.gd` |
| READ ONLY | `scenes/core/SoulShard.tscn` |
| READ ONLY | `scripts/soul/soul_shard.gd` |
| READ ONLY | `scenes/core/SoulOrb_Follow.tscn` |
| READ ONLY | `scripts/core/soul_orb_follow.gd` |
| READ ONLY | `scenes/core/LevelPortal.tscn` |
| READ ONLY | `scripts/core/level_portal.gd` |
| READ ONLY | `scenes/core/SceneTransition.tscn` |
| READ ONLY | `scripts/core/scene_transition.gd` |
| READ ONLY | `scripts/core/shard_reward_sequence_controller.gd` |
| READ ONLY | `scenes/ui/ShardRewardOverlay.tscn` |
| READ ONLY | `scripts/ui/shard_reward_overlay.gd` |
| READ ONLY | `scenes/ui/LevelFinaleOverlay.tscn` |
| READ ONLY | `scripts/ui/level_finale_overlay.gd` |
| READ ONLY | `scenes/core/FinalScene.tscn` |
| READ ONLY | `scripts/core/final_scene.gd` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/PortalTransitionIntegrationHarness.tscn` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/portal_lifecycle_recorder.gd` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/fakes/fake_portal_spy.gd` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/portal_transition_integration_harness.gd` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/portal_transition_integration_harness.gd.uid` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/portal_lifecycle_recorder.gd.uid` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/fakes/fake_portal_spy.gd.uid` |
| CREATE - USER ARTIFACT OUTSIDE REPOSITORY WORKTREE | None. |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Greybox_Development_Reference_v1.2.1.md` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Greybox_Development_Reference_v1.2.1.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Narrative_and_Level_Scenario_Package_v1.1.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Visual_Master_Concept_Package.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Gameplay_Map_and_Level_Design_Spec_v1.3.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Technical_Architecture_and_State_Model_v1.2.2.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Art_Production_Bible_v1.1.docx` |
| FORBIDDEN | All paths, artifacts and mutations not explicitly authorized above; global forbidden list applies. |

### CONDITIONAL MATCHING `.gd.uid`
- `scripts/levels/level_06/level_06_portal_adapter.gd.uid`
- `scripts/levels/level_06/level_06_progress_controller.gd.uid`
- `scripts/levels/level_06/level_06_recovery_controller.gd.uid`

Rules:

- A persistent matching `.gd.uid` is permitted only together with its exact sibling `.gd`, and that sibling path must be explicitly listed in this slice's `CREATE` or `MODIFY` scope.
- A temporary matching `.gd.uid` is permitted only together with its exact sibling `.gd`, and both exact paths must be explicitly listed in this slice's `TEMPORARY CREATE - REMOVE BEFORE COMMIT` scope.
- Every temporary script and every temporary sidecar is removed before commit.
- A UID for any script outside this slice's active `CREATE`, `MODIFY` or `TEMPORARY CREATE - REMOVE BEFORE COMMIT` scope is forbidden.
- Unrelated `.gd.uid`, scene UID, `.import`, `.godot/imported`, cache and generated churn are forbidden.

## Scope-consistency acceptance

- Before any write, every repository path, external artifact and metadata source named anywhere in this slice contract must appear in this slice's exact scope.
- No required dependency may exist only under `FORBIDDEN`.
- At handoff, the persistent changed-file list must be a subset of `CREATE` + `MODIFY` plus only persistent matching `.gd.uid` sidecars whose exact sibling `.gd` is explicitly in `CREATE` or `MODIFY`.
- Temporary scripts and temporary matching `.gd.uid` sidecars may exist only during the active validation run when both exact paths are listed in `TEMPORARY CREATE - REMOVE BEFORE COMMIT`; all are absent before commit.
- Every `READ ONLY` repository file must remain byte-unchanged.
- Every temporary harness, temporary script and temporary sidecar/generated file caused by it must be removed before commit.
- Unrelated `.gd.uid`, scene UID, `.import`, `.godot/imported`, cache and generated churn must be absent.
- Any scope inconsistency is a hard stop before the first write and again before commit.

## Nodes, scenes and scripts
- Level06PortalAdapter unattached until Slice 12.
- Shared LevelPortal exact config under PortalFloorAnchor.
- Temporary root recorder only in test.

## APIs and signals
- Exact PortalAttempt APIs/signals from Appendix C.
- One `activate()` request.
- Actual-signal forwarding only.
- Split recovery portal stop/restart APIs.

## Implementation steps
- Validate exact target/mode/confirmation and required actual signals.
- Implement DORMANT->ACTIVATING->EXIT_ACTIVE->TRANSITION_IN_FLIGHT and retry to EXIT_ACTIVE.
- Connect actual signals before activate.
- Forward transition_started as final source-scene handoff evidence.
- Never call SceneTransition or change_scene locally.
- Implement temporary root recorder harness for destination proof and self-cleanup.

## Automated and static checks
- FakePortalSpy duplicate/stale attempt tests.
- Static no-local-load scan.
- PortalLifecycleRecorder capture_generation tests.
- Actual SceneTransition chain inspection.

## Manual runtime checks
- Stationary early-overlap real portal test.
- Force transition failure, delay stale evidence and retry.
- Rapid boundary spam.
- Prove FinalScene current scene using temporary root recorder.

## Acceptance criteria
- Stationary AUTO_ENTER and real destination-replacement prerequisites P0-27/P0-28/P0-44/P0-46 have factual PASS before G11; DEFERRED is not sufficient.
- Scope-consistency acceptance passes before the first write and at handoff.
- One activation.
- Stationary early-overlap transitions without re-entry or prerequisite STOP.
- Retry generation isolation.
- No local scene load.
- Destination proof and recorder cleanup.
- G11 PASS.

## Rollback plan
- Revert Slice 11 commit; main text remains fail-closed with no exit.

## Risks
- Shared stationary overlap unsupported.
- Source nodes freed before local completion.
- Stale attempt affects retry.

## Out of scope
- FinalScene creative content and shared portal edits.

## Stop conditions
- Any of P0-27/P0-28/P0-44/P0-46 is FAIL or remains DEFERRED/NOT VERIFIED.
- Stationary portal early-overlap fails.
- Adapter requires private portal call, local InteractionArea or local scene loading.
- Required actual activation/transition signal is absent.
- Destination proof cannot be captured without persistent project autoload.
When any stop condition triggers, do not execute the next slice. Record the blocker and request the exact prerequisite or Producer decision.

## Required handoff
- Approved base SHA, branch, slice-start SHA and final head SHA.
- Exact CREATE/MODIFY/READ ONLY diff audit and matching UID mapping.
- Commands and factual outputs.
- Manual evidence marked PASS / FAIL / NOT VERIFIED.
- Risks, blocker status and rollback point.
- Commit SHA for the slice; PR link: N/A until Slice 13.
- Recommendation: continue automatically only when the internal gate passes.

# 34. Slice 12 - Production Root Wiring and Atomic Commit Activation

## Goal
Attach all final-path runtime owners, wire exact NodePaths/signals, register RewardGate proxy and enable mandatory PRODUCTION startup validation.

## Preconditions
- Slices 1-11 PASS under their exact gate meanings.
- Slices 6-8 local components and temporary integrated-flow fixtures are factual PASS, while every production reward-flow item remains explicitly `DEFERRED TO G12 PRODUCTION WIRING`.
- All production dependencies exist.
- No shared prerequisite is unresolved; G12 owns resolution of every production-wiring deferral.

## Exact file scope
| Authority | Literal path / rule |
|---|---|
| CREATE | `scripts/levels/level_06/level_06_bootstrap_readiness_coordinator.gd` |
| MODIFY | `scenes/levels/Level_06.tscn` |
| MODIFY | `scripts/levels/level_06/level_06_runtime_contract_validator.gd` |
| MODIFY | `scripts/levels/level_06/level_06_progress_controller.gd` |
| MODIFY | `scripts/levels/level_06/level_06_release_validity_controller.gd` |
| MODIFY | `scripts/levels/level_06/level_06_reward_gate_controller.gd` |
| MODIFY | `scripts/levels/level_06/level_06_recovery_controller.gd` |
| MODIFY | `scripts/levels/level_06/level_06_main_text_controller.gd` |
| MODIFY | `scripts/levels/level_06/level_06_portal_adapter.gd` |
| MODIFY | `scripts/levels/level_06/level_06_environment_controller.gd` |
| READ ONLY | `scenes/levels/level_06/geometry/Level06GreyboxGeometry.tscn` |
| READ ONLY | `scenes/levels/level_06/environment/Level06EnvironmentPresentation.tscn` |
| READ ONLY | `scenes/levels/level_06/puzzles/SilverWake.tscn` |
| READ ONLY | `scenes/levels/level_06/puzzles/ClearVeils.tscn` |
| READ ONLY | `scenes/levels/level_06/puzzles/HorizonConstellation.tscn` |
| READ ONLY | `scenes/levels/level_06/systems/Level06ShardSlot.tscn` |
| READ ONLY | `scenes/levels/level_06/systems/Level06RecoveryRig.tscn` |
| READ ONLY | `scripts/levels/level_06/level_06_contract.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_pass_through_target.gd` |
| READ ONLY | `scripts/levels/level_06/silver_wake_controller.gd` |
| READ ONLY | `scripts/levels/level_06/clear_veils_controller.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_grounded_dwell_zone.gd` |
| READ ONLY | `scripts/levels/level_06/horizon_constellation_controller.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_shard_slot.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_last_light_source.gd` |
| READ ONLY | `AGENTS.md` |
| READ ONLY | `project.godot` |
| READ ONLY | `scenes/core/Player.tscn` |
| READ ONLY | `scripts/player/player_controller.gd` |
| READ ONLY | `scripts/player/camera_controller.gd` |
| READ ONLY | `scenes/core/SoulShard.tscn` |
| READ ONLY | `scripts/soul/soul_shard.gd` |
| READ ONLY | `scenes/core/SoulOrb_Follow.tscn` |
| READ ONLY | `scripts/core/soul_orb_follow.gd` |
| READ ONLY | `scenes/core/LevelPortal.tscn` |
| READ ONLY | `scripts/core/level_portal.gd` |
| READ ONLY | `scenes/core/SceneTransition.tscn` |
| READ ONLY | `scripts/core/scene_transition.gd` |
| READ ONLY | `scripts/core/shard_reward_sequence_controller.gd` |
| READ ONLY | `scenes/ui/ShardRewardOverlay.tscn` |
| READ ONLY | `scripts/ui/shard_reward_overlay.gd` |
| READ ONLY | `scenes/ui/LevelFinaleOverlay.tscn` |
| READ ONLY | `scripts/ui/level_finale_overlay.gd` |
| READ ONLY | `scenes/core/FinalScene.tscn` |
| READ ONLY | `scripts/core/final_scene.gd` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/Level06ArchitectureHarness.tscn` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/level_06_architecture_harness.gd` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/level_06_architecture_harness.gd.uid` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/BootstrapRaceHarness.tscn` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/bootstrap_race_harness.gd` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/bootstrap_race_harness.gd.uid` |
| CREATE - USER ARTIFACT OUTSIDE REPOSITORY WORKTREE | None. |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Greybox_Development_Reference_v1.2.1.md` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Greybox_Development_Reference_v1.2.1.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Narrative_and_Level_Scenario_Package_v1.1.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Visual_Master_Concept_Package.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Gameplay_Map_and_Level_Design_Spec_v1.3.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Technical_Architecture_and_State_Model_v1.2.2.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Art_Production_Bible_v1.1.docx` |
| FORBIDDEN | All paths, artifacts and mutations not explicitly authorized above; global forbidden list applies. |

### CONDITIONAL MATCHING `.gd.uid`
- `scripts/levels/level_06/level_06_bootstrap_readiness_coordinator.gd.uid`
- `scripts/levels/level_06/level_06_runtime_contract_validator.gd.uid`
- `scripts/levels/level_06/level_06_progress_controller.gd.uid`
- `scripts/levels/level_06/level_06_release_validity_controller.gd.uid`
- `scripts/levels/level_06/level_06_reward_gate_controller.gd.uid`
- `scripts/levels/level_06/level_06_recovery_controller.gd.uid`
- `scripts/levels/level_06/level_06_main_text_controller.gd.uid`
- `scripts/levels/level_06/level_06_portal_adapter.gd.uid`
- `scripts/levels/level_06/level_06_environment_controller.gd.uid`

Rules:

- A persistent matching `.gd.uid` is permitted only together with its exact sibling `.gd`, and that sibling path must be explicitly listed in this slice's `CREATE` or `MODIFY` scope.
- A temporary matching `.gd.uid` is permitted only together with its exact sibling `.gd`, and both exact paths must be explicitly listed in this slice's `TEMPORARY CREATE - REMOVE BEFORE COMMIT` scope.
- Every temporary script and every temporary sidecar is removed before commit.
- A UID for any script outside this slice's active `CREATE`, `MODIFY` or `TEMPORARY CREATE - REMOVE BEFORE COMMIT` scope is forbidden.
- Unrelated `.gd.uid`, scene UID, `.import`, `.godot/imported`, cache and generated churn are forbidden.

## Scope-consistency acceptance

- Before any write, every repository path, external artifact and metadata source named anywhere in this slice contract must appear in this slice's exact scope.
- No required dependency may exist only under `FORBIDDEN`.
- At handoff, the persistent changed-file list must be a subset of `CREATE` + `MODIFY` plus only persistent matching `.gd.uid` sidecars whose exact sibling `.gd` is explicitly in `CREATE` or `MODIFY`.
- Temporary scripts and temporary matching `.gd.uid` sidecars may exist only during the active validation run when both exact paths are listed in `TEMPORARY CREATE - REMOVE BEFORE COMMIT`; all are absent before commit.
- Every `READ ONLY` repository file must remain byte-unchanged.
- Every temporary harness, temporary script and temporary sidecar/generated file caused by it must be removed before commit.
- Unrelated `.gd.uid`, scene UID, `.import`, `.godot/imported`, cache and generated churn must be absent.
- Any scope inconsistency is a hard stop before the first write and again before commit.

## Nodes, scenes and scripts
- `Level_06` root uses `Level06BootstrapReadinessCoordinator`; the coordinator is the only owner of readiness-barrier delivery.
- Complete RuntimeRoot and UILayer.
- Exact final NodePaths and parent-scene overrides.
- Atomic bootstrap auto-entry from scene startup.

## APIs and signals
- Appendix C `Level06BootstrapReadinessCoordinator` API and signals, including exactly-one `bootstrap_readiness_confirmed()` -> `begin_bootstrap()` delivery.
- Full Appendix C registry.
- Exact prepare/commit manifest.
- Explicit proxy registration before commit.
- Progress commits last.

## Implementation steps
- Attach every runtime script at final path.
- Configure all exact NodePaths and IDs.
- Connect signals once according to registry.
- Validate actual shard topology and proxy registration.
- Execute full startup validator.
- Verify E0 visible while inert, then atomic commit to WAKE_ACTIVE.
- In the fully assembled production `scenes/levels/Level_06.tscn`, prove Wake -> actual Shard_13 -> admitted actual collected -> E1/VEILS_ACTIVE.
- Continue the same natural run and prove Veils -> actual Shard_14 -> admitted actual collected -> E2/CONSTELLATION_ACTIVE.
- Continue the same natural run and prove Constellation -> actual Shard_15 -> admitted actual collected -> ALL_REWARDS_COMPLETE, then E3 -> FinalTextGate eligibility/opening.
- Close the real main text through the actual overlay close path and prove E4/portal activation.
- Complete one natural-flow production run with no harness-only bypass, synthetic collected/reward/main-text-close/portal-success signal or staged production mode.
- Remove any temporary debug UI.

## Automated and static checks
- ST-01 through ST-24.
- Connection-count and exact type/signature scans.
- Broken-contract injection tests.
- No direct actual-shard registration.
- No staged/bypass mode.
- Production-flow evidence scan distinguishes prior temporary harness proof from current production-scene proof and resolves every `DEFERRED TO G12 PRODUCTION WIRING` item only from the assembled scene.

## Manual runtime checks
- Cold-load repeatedly.
- Break each mandatory path/API/export in temporary harness and confirm one failed outcome/zero arming.
- Run valid load and verify one readiness-barrier confirmation, exactly one begin_bootstrap call and one passed outcome after commit.
- Verify no early validation failure is caused by sibling `_ready()` ordering and no partial prepare/registration/commit occurs before the barrier.
- Verify FollowCamera active-viewport identity and SoulOrb_Base group/visibility/method registration are stable before validation.
- Perform and record the exact full production natural flow through all three rewards, E3/FinalTextGate, actual main-text close and E4/portal activation without any temporary integrated-flow harness.

## Acceptance criteria
- Scope-consistency acceptance passes before the first write and at handoff.
- Deterministic readiness barrier passes before exactly one begin_bootstrap call.
- Full production validation passes.
- No partial arming.
- No guessed discovery.
- No duplicate connections.
- All domains current generation.
- Production evidence passes for Wake -> Shard_13 -> E1/VEILS_ACTIVE, Veils -> Shard_14 -> E2/CONSTELLATION_ACTIVE, Constellation -> Shard_15 -> ALL_REWARDS_COMPLETE, E3 -> FinalTextGate and actual main-text close -> E4/portal activation.
- One complete natural-flow production run passes without harness-only bypass or synthetic authority signals.
- Every `DEFERRED TO G12 PRODUCTION WIRING` item is converted to factual production PASS; none remains deferred.
- G12 PASS.

## Rollback plan
- Revert Slice 12 commit; component files remain but production root is not accepted.

## Risks
- Wiring drift.
- Validation omitted for optional-looking mandatory dependency.
- Registration race.
- Root readiness barrier or sibling `_ready()` ordering is nondeterministic.

## Out of scope
- Broad refactor and shared changes.

## Stop conditions
- Readiness barrier permits early/multiple begin_bootstrap calls or uses timer/sleep/guessed-frame/retry behavior.
- PRODUCTION validation or any required production natural-flow transition fails.
- Any partial or passed-before-commit path remains.
- NodePath, API, ID, volume, anchor, proxy or signal registration invalid.
- A temporary harness, synthetic authority event, staged production mode or debug bypass is required for normal startup or natural flow.
- Any `DEFERRED TO G12 PRODUCTION WIRING` item remains unresolved.
When any stop condition triggers, do not execute the next slice. Record the blocker and request the exact prerequisite or Producer decision.

## Required handoff
- Approved base SHA, branch, slice-start SHA and final head SHA.
- Exact CREATE/MODIFY/READ ONLY diff audit and matching UID mapping.
- Commands and factual outputs.
- Manual evidence marked PASS / FAIL / NOT VERIFIED, including the exact production natural-flow trace that resolves the G6-G8 production deferrals.
- Risks, blocker status and rollback point.
- Commit SHA for the slice; PR link: N/A until Slice 13.
- Recommendation: continue automatically only when the internal gate passes.

# 35. Slice 13 - Stabilization, Acceptance and Final Handoff

## Goal
Run the complete evidence matrix, preserve a closed write scope and create factual content-equivalent implementation summaries.

## Preconditions
- Slice 12 PASS.
- No unresolved P0/shared prerequisite.

## Exact file scope
| Authority | Literal path / rule |
|---|---|
| CREATE | `docs/development/Level_06_Greybox_Implementation_Summary.md` |
| MODIFY | None. |
| READ ONLY | `scenes/levels/Level_06.tscn` |
| READ ONLY | `scenes/levels/level_06/geometry/Level06GreyboxGeometry.tscn` |
| READ ONLY | `scenes/levels/level_06/environment/Level06EnvironmentPresentation.tscn` |
| READ ONLY | `scenes/levels/level_06/puzzles/SilverWake.tscn` |
| READ ONLY | `scenes/levels/level_06/puzzles/ClearVeils.tscn` |
| READ ONLY | `scenes/levels/level_06/puzzles/HorizonConstellation.tscn` |
| READ ONLY | `scenes/levels/level_06/systems/Level06ShardSlot.tscn` |
| READ ONLY | `scenes/levels/level_06/systems/Level06RecoveryRig.tscn` |
| READ ONLY | `scripts/levels/level_06/level_06_bootstrap_readiness_coordinator.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_contract.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_runtime_contract_validator.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_progress_controller.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_release_validity_controller.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_pass_through_target.gd` |
| READ ONLY | `scripts/levels/level_06/silver_wake_controller.gd` |
| READ ONLY | `scripts/levels/level_06/clear_veils_controller.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_grounded_dwell_zone.gd` |
| READ ONLY | `scripts/levels/level_06/horizon_constellation_controller.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_shard_slot.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_reward_gate_controller.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_environment_controller.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_main_text_controller.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_portal_adapter.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_recovery_controller.gd` |
| READ ONLY | `scripts/levels/level_06/level_06_last_light_source.gd` |
| READ ONLY | `AGENTS.md` |
| READ ONLY | `project.godot` |
| READ ONLY | `scenes/core/Player.tscn` |
| READ ONLY | `scripts/player/player_controller.gd` |
| READ ONLY | `scripts/player/camera_controller.gd` |
| READ ONLY | `scenes/core/SoulShard.tscn` |
| READ ONLY | `scripts/soul/soul_shard.gd` |
| READ ONLY | `scenes/core/SoulOrb_Follow.tscn` |
| READ ONLY | `scripts/core/soul_orb_follow.gd` |
| READ ONLY | `scenes/core/LevelPortal.tscn` |
| READ ONLY | `scripts/core/level_portal.gd` |
| READ ONLY | `scenes/core/SceneTransition.tscn` |
| READ ONLY | `scripts/core/scene_transition.gd` |
| READ ONLY | `scripts/core/shard_reward_sequence_controller.gd` |
| READ ONLY | `scenes/ui/ShardRewardOverlay.tscn` |
| READ ONLY | `scripts/ui/shard_reward_overlay.gd` |
| READ ONLY | `scenes/ui/LevelFinaleOverlay.tscn` |
| READ ONLY | `scripts/ui/level_finale_overlay.gd` |
| READ ONLY | `scenes/core/FinalScene.tscn` |
| READ ONLY | `scripts/core/final_scene.gd` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/RecoveryObservationHarness.tscn` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/recovery_observation_harness.gd` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/recovery_observation_harness.gd.uid` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/RecoveryGeometryDebugDraw.tscn` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/recovery_geometry_debug_draw.gd` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/recovery_geometry_debug_draw.gd.uid` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/Level06ArchitectureHarness.tscn` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/level_06_architecture_harness.gd` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/level_06_architecture_harness.gd.uid` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/BootstrapRaceHarness.tscn` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/bootstrap_race_harness.gd` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/bootstrap_race_harness.gd.uid` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/RewardGateHarness.tscn` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/reward_gate_harness.gd` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/reward_gate_harness.gd.uid` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/MainTextHarness.tscn` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/main_text_harness.gd` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/main_text_harness.gd.uid` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/PortalTransitionIntegrationHarness.tscn` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/portal_transition_integration_harness.gd` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/portal_transition_integration_harness.gd.uid` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/portal_lifecycle_recorder.gd` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/portal_lifecycle_recorder.gd.uid` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/runners/Level06FullRegressionRunner.tscn` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/runners/level_06_full_regression_runner.gd` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/runners/level_06_full_regression_runner.gd.uid` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/runners/Level06RuntimeP0Runner.tscn` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/runners/level_06_runtime_p0_runner.gd` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/runners/level_06_runtime_p0_runner.gd.uid` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/fakes/fake_shard.gd` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/fakes/fake_shard.gd.uid` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/fakes/reward_proxy_spy.gd` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/fakes/reward_proxy_spy.gd.uid` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/fakes/release_validity_spy.gd` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/fakes/release_validity_spy.gd.uid` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/fakes/fake_finale_overlay.gd` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/fakes/fake_finale_overlay.gd.uid` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/fakes/fake_portal_spy.gd` |
| TEMPORARY CREATE - REMOVE BEFORE COMMIT | `tests/levels/level_06/harness/fakes/fake_portal_spy.gd.uid` |
| CREATE - USER ARTIFACT OUTSIDE REPOSITORY WORKTREE | `Level_06_Greybox_Implementation_Summary.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Greybox_Development_Reference_v1.2.1.md` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Greybox_Development_Reference_v1.2.1.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Narrative_and_Level_Scenario_Package_v1.1.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Visual_Master_Concept_Package.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Gameplay_Map_and_Level_Design_Spec_v1.3.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Technical_Architecture_and_State_Model_v1.2.2.docx` |
| READ ONLY - EXTERNAL PRODUCER ARTIFACTS | `Level_06_Art_Production_Bible_v1.1.docx` |
| READ ONLY - REPOSITORY METADATA | current implementation branch, final branch HEAD, approved base ref/SHA and existing pull requests |
| WRITE - REPOSITORY METADATA AFTER G13 ACCEPTANCE PASS | push exact `feature/implement-level-06-greybox` branch; create exactly one PR with the approved title/head/base/body |
| FORBIDDEN | All paths, artifacts and mutations not explicitly authorized above; global forbidden list applies. |

### CONDITIONAL MATCHING `.gd.uid`
- None.

Rules:

- A persistent matching `.gd.uid` is permitted only together with its exact sibling `.gd`, and that sibling path must be explicitly listed in this slice's `CREATE` or `MODIFY` scope.
- A temporary matching `.gd.uid` is permitted only together with its exact sibling `.gd`, and both exact paths must be explicitly listed in this slice's `TEMPORARY CREATE - REMOVE BEFORE COMMIT` scope.
- Every temporary script and every temporary sidecar is removed before commit.
- A UID for any script outside this slice's active `CREATE`, `MODIFY` or `TEMPORARY CREATE - REMOVE BEFORE COMMIT` scope is forbidden.
- Unrelated `.gd.uid`, scene UID, `.import`, `.godot/imported`, cache and generated churn are forbidden.

## Scope-consistency acceptance

- Before any write, every repository path, external artifact and metadata source named anywhere in this slice contract must appear in this slice's exact scope.
- No required dependency may exist only under `FORBIDDEN`.
- Before summary commit, the persistent changed-file list must be a subset of `CREATE` + `MODIFY` plus only persistent matching `.gd.uid` sidecars whose exact sibling `.gd` is explicitly in `CREATE` or `MODIFY`; temporary scripts and temporary matching `.gd.uid` sidecars may exist only during the active test run when both exact paths are listed in `TEMPORARY CREATE - REMOVE BEFORE COMMIT`, and all must be absent before commit. Repository metadata push/PR actions are authorized only after G13 acceptance PASS and summary commit.
- Every `READ ONLY` repository file must remain byte-unchanged.
- Every temporary harness, temporary script and temporary sidecar/generated file caused by it must be removed before commit.
- Unrelated `.gd.uid`, scene UID, `.import`, `.godot/imported`, cache and generated churn must be absent.
- Any scope inconsistency is a hard stop before the first write and again before commit.

## Nodes, scenes and scripts
- Both external v1.2.1 reference artifacts and all five approved sources are controlling READ ONLY evidence.
- All production nodes/scripts are READ ONLY during acceptance.
- Mandatory external user artifact: Level_06_Greybox_Implementation_Summary.docx.

## APIs and signals
- No new production API or runtime write authority.

## Implementation steps
- Reconfirm all seven external READ ONLY artifacts remain available, hash-identical and unchanged.
- Temporarily recreate only the exact fixtures/runners/fakes/spies listed in this slice scope.
- Run all UT/ST/P0/P1 and no-softlock cases, including readiness-barrier, runtime-only prerequisite, temporary-integrated-flow provenance, G12 production natural-flow and real destination replacement evidence.
- Run full natural and repeat playthroughs and pacing.
- Run 1280x720, muted, reduced-color and performance checks.
- Remove every temporary harness, runner, fake, spy, recorder and exact generated sidecar before summary commit.
- Create the repository Markdown summary inside the worktree at `docs/development/Level_06_Greybox_Implementation_Summary.md`; create its content-equivalent DOCX outside the worktree as `Level_06_Greybox_Implementation_Summary.docx`.
- Commit only the repository Markdown summary as the one Slice 13 summary commit after G13 acceptance evidence passes; the outside-worktree DOCX is not committed.
- After that acceptance PASS and summary commit: reconfirm branch `feature/implement-level-06-greybox`, final head and approved base; verify no conflicting PR; push the exact branch; create exactly one PR titled `Implement Level 06 greybox - Ты восхищаешь меня`, with head `feature/implement-level-06-greybox`, base equal to the exact Slice 0 approved base ref, and body containing base SHA, per-slice commits, tests, blockers and summary references.
- Record PR URL, final head SHA and base SHA in an appended final handoff after PR creation; the committed summaries may state `PR metadata pending final handoff` because PR creation occurs after their commit.
- If a runtime defect is found: stop; identify owning prior slice; issue a literal defect-fix whitelist; test/rollback owning slice; commit corrective fix; rerun all subsequent gates and Slice 13.

## Automated and static checks
- `git diff --check`.
- Exact changed-file whitelist and matching UID map.
- ST-20 proves every fixture is named in active scope, the complete Slice 13 matrix is executable from literal scope, and all temporary files/sidecars are removed before commit.
- Summary content-equivalence check.
- Branch/head/base/PR metadata preflight before push and PR creation.

## Manual runtime checks
- Complete real portal/destination proof.
- Complete all puzzle, reward, recovery and reload matrices.
- Record exact displayed copy evidence.
- Record timings and camera/sightline evidence.

## Acceptance criteria
- All seven external reference/source artifacts remain READ ONLY, hash-identical and outside runtime commits.
- Scope-consistency acceptance passes before the first write and at handoff.
- Every static integration dependency is PASS.
- Every runtime-only `DEFERRED TO OWNER P0` item is converted by actual evidence to PASS; none remains deferred at final acceptance.
- Every mandatory P0/manual result PASS.
- No mandatory NOT VERIFIED.
- Readiness barrier and exactly-one begin_bootstrap evidence pass.
- No parser warning/error.
- No out-of-scope diff.
- Repository Markdown and outside-worktree DOCX summaries are complete and content-equivalent; only Markdown is committed.
- All temporary fixtures and generated sidecars are absent before summary commit.
- G13 acceptance evidence PASS occurs before any push or PR creation.
- Exact branch push and exactly one PR creation succeed after the summary commit; appended final handoff contains PR URL, final head SHA and base SHA.
- Final DoD verdict factual.

## Rollback plan
- No runtime rollback is performed directly in Slice 13. Reopen the owning slice through an explicit defect-fix whitelist and corrective commit.

## Risks
- Late broad fixes.
- Evidence gap hidden as PASS.
- Summary mismatch.

## Out of scope
- All final art/audio/FinalScene work.

## Stop conditions
- Any mandatory P0/manual result is FAIL or NOT VERIFIED, or any runtime-only prerequisite remains `DEFERRED TO OWNER P0` at its owner gate/final acceptance.
- Any parser warning/error, out-of-scope diff, unrelated UID/import churn or temporary harness remains.
- Summary Markdown/DOCX mismatch.
- Any unresolved blocker or release-invalid run.
- A runtime defect requires editing without an explicit owning-slice defect whitelist.
- Branch/base drift, wrong head, existing conflicting PR, push failure, PR creation failure or inability to record exact PR metadata.
When a stop condition triggers, do not proceed to push/PR/final completion. Record the blocker and request the exact prerequisite or Producer decision.

## Required handoff
- Name all seven controlling external artifacts, exact hashes and READ ONLY status.
- Approved base SHA/ref, branch, slice-start SHA, summary-commit SHA and final pushed head SHA.
- Exact CREATE/MODIFY/READ ONLY/TEMPORARY diff audit and matching UID mapping.
- Commands and factual outputs.
- Complete manual evidence marked PASS / FAIL / NOT VERIFIED, runtime-only prerequisite resolution, Slices 6-8 temporary integrated-flow results and separate G12 production-wiring resolution.
- Risks, blocker status and rollback point.
- PR URL, exact title, head branch/SHA and base ref/SHA in an appended final handoff created after PR creation.
- Confirmation that no PR existed before G13 acceptance PASS and that exactly one PR was created afterward.
- Final recommendation and Definition of Done verdict.

# 36. Master file ownership matrix

| Literal path / artifact | Authority |
|---|---|
| `Level_06_Greybox_Development_Reference_v1.2.1.md` | External READ ONLY Producer reference artifact supplied to Codex; never created, modified or committed by runtime slices. |
| `Level_06_Greybox_Development_Reference_v1.2.1.docx` | External READ ONLY Producer reference artifact supplied to Codex; never created, modified or committed by runtime slices. |
| `Level_06_Narrative_and_Level_Scenario_Package_v1.1.docx` | External READ ONLY approved source artifact. |
| `Level_06_Visual_Master_Concept_Package.docx` | External READ ONLY approved source artifact. |
| `Level_06_Gameplay_Map_and_Level_Design_Spec_v1.3.docx` | External READ ONLY approved source artifact. |
| `Level_06_Technical_Architecture_and_State_Model_v1.2.2.docx` | External READ ONLY approved source artifact. |
| `Level_06_Art_Production_Bible_v1.1.docx` | External READ ONLY approved source artifact. |
| `scenes/levels/Level_06.tscn` | Level_06 production file; write authority exists only in the exact owning slice table. |
| `scenes/levels/level_06/geometry/Level06GreyboxGeometry.tscn` | Level_06 production file; write authority exists only in the exact owning slice table. |
| `scenes/levels/level_06/environment/Level06EnvironmentPresentation.tscn` | Level_06 production file; write authority exists only in the exact owning slice table. |
| `scenes/levels/level_06/puzzles/SilverWake.tscn` | Level_06 production file; write authority exists only in the exact owning slice table. |
| `scenes/levels/level_06/puzzles/ClearVeils.tscn` | Level_06 production file; write authority exists only in the exact owning slice table. |
| `scenes/levels/level_06/puzzles/HorizonConstellation.tscn` | Level_06 production file; write authority exists only in the exact owning slice table. |
| `scenes/levels/level_06/systems/Level06ShardSlot.tscn` | Level_06 production file; write authority exists only in the exact owning slice table. |
| `scenes/levels/level_06/systems/Level06RecoveryRig.tscn` | Level_06 production file; write authority exists only in the exact owning slice table. |
| `scripts/levels/level_06/level_06_bootstrap_readiness_coordinator.gd` | Level_06 root readiness barrier; created/wired only in Slice 12; matching UID only. |
| Temporary fixture index | Informational only; grants no wildcard write authority. Every actual fixture path is listed literally in the active slice scope and every fixture/sidecar is removed before commit. |
| `tests/levels/level_06/harness/Level06IntegratedFlowHarness.tscn` | Temporary test-only scene owned by Slices 6-8 when literally listed in `TEMPORARY CREATE - REMOVE BEFORE COMMIT`; removed before every owning commit; never production wiring evidence. |
| `tests/levels/level_06/harness/level_06_integrated_flow_harness.gd` | Temporary test-only runner owned by Slices 6-8 only when this exact path and its scene are listed in active TEMPORARY scope; no production script may reference it. |
| `tests/levels/level_06/harness/level_06_integrated_flow_harness.gd.uid` | Temporary matching sidecar permitted only when both this exact path and sibling `.gd` are in active TEMPORARY scope; removed before commit. |
| `scripts/levels/level_06/level_06_contract.gd` | Level-local production script; write authority exists only in the exact owning slice table. |
| `scripts/levels/level_06/level_06_contract.gd.uid` | Persistent matching sidecar only when the exact sibling `.gd` is explicitly active in that slice `CREATE` or `MODIFY` scope. |
| `scripts/levels/level_06/level_06_runtime_contract_validator.gd` | Level-local production script; write authority exists only in the exact owning slice table. |
| `scripts/levels/level_06/level_06_runtime_contract_validator.gd.uid` | Persistent matching sidecar only when the exact sibling `.gd` is explicitly active in that slice `CREATE` or `MODIFY` scope. |
| `scripts/levels/level_06/level_06_progress_controller.gd` | Level-local production script; write authority exists only in the exact owning slice table. |
| `scripts/levels/level_06/level_06_progress_controller.gd.uid` | Persistent matching sidecar only when the exact sibling `.gd` is explicitly active in that slice `CREATE` or `MODIFY` scope. |
| `scripts/levels/level_06/level_06_release_validity_controller.gd` | Level-local production script; write authority exists only in the exact owning slice table. |
| `scripts/levels/level_06/level_06_release_validity_controller.gd.uid` | Persistent matching sidecar only when the exact sibling `.gd` is explicitly active in that slice `CREATE` or `MODIFY` scope. |
| `scripts/levels/level_06/level_06_pass_through_target.gd` | Level-local production script; write authority exists only in the exact owning slice table. |
| `scripts/levels/level_06/level_06_pass_through_target.gd.uid` | Persistent matching sidecar only when the exact sibling `.gd` is explicitly active in that slice `CREATE` or `MODIFY` scope. |
| `scripts/levels/level_06/silver_wake_controller.gd` | Level-local production script; write authority exists only in the exact owning slice table. |
| `scripts/levels/level_06/silver_wake_controller.gd.uid` | Persistent matching sidecar only when the exact sibling `.gd` is explicitly active in that slice `CREATE` or `MODIFY` scope. |
| `scripts/levels/level_06/clear_veils_controller.gd` | Level-local production script; write authority exists only in the exact owning slice table. |
| `scripts/levels/level_06/clear_veils_controller.gd.uid` | Persistent matching sidecar only when the exact sibling `.gd` is explicitly active in that slice `CREATE` or `MODIFY` scope. |
| `scripts/levels/level_06/level_06_grounded_dwell_zone.gd` | Level-local production script; write authority exists only in the exact owning slice table. |
| `scripts/levels/level_06/level_06_grounded_dwell_zone.gd.uid` | Persistent matching sidecar only when the exact sibling `.gd` is explicitly active in that slice `CREATE` or `MODIFY` scope. |
| `scripts/levels/level_06/horizon_constellation_controller.gd` | Level-local production script; write authority exists only in the exact owning slice table. |
| `scripts/levels/level_06/horizon_constellation_controller.gd.uid` | Persistent matching sidecar only when the exact sibling `.gd` is explicitly active in that slice `CREATE` or `MODIFY` scope. |
| `scripts/levels/level_06/level_06_shard_slot.gd` | Level-local production script; write authority exists only in the exact owning slice table. |
| `scripts/levels/level_06/level_06_shard_slot.gd.uid` | Persistent matching sidecar only when the exact sibling `.gd` is explicitly active in that slice `CREATE` or `MODIFY` scope. |
| `scripts/levels/level_06/level_06_reward_gate_controller.gd` | Level-local production script; write authority exists only in the exact owning slice table. |
| `scripts/levels/level_06/level_06_reward_gate_controller.gd.uid` | Persistent matching sidecar only when the exact sibling `.gd` is explicitly active in that slice `CREATE` or `MODIFY` scope. |
| `scripts/levels/level_06/level_06_environment_controller.gd` | Level-local production script; write authority exists only in the exact owning slice table. |
| `scripts/levels/level_06/level_06_environment_controller.gd.uid` | Persistent matching sidecar only when the exact sibling `.gd` is explicitly active in that slice `CREATE` or `MODIFY` scope. |
| `scripts/levels/level_06/level_06_main_text_controller.gd` | Level-local production script; write authority exists only in the exact owning slice table. |
| `scripts/levels/level_06/level_06_main_text_controller.gd.uid` | Persistent matching sidecar only when the exact sibling `.gd` is explicitly active in that slice `CREATE` or `MODIFY` scope. |
| `scripts/levels/level_06/level_06_portal_adapter.gd` | Level-local production script; write authority exists only in the exact owning slice table. |
| `scripts/levels/level_06/level_06_portal_adapter.gd.uid` | Persistent matching sidecar only when the exact sibling `.gd` is explicitly active in that slice `CREATE` or `MODIFY` scope. |
| `scripts/levels/level_06/level_06_recovery_controller.gd` | Level-local production script; write authority exists only in the exact owning slice table. |
| `scripts/levels/level_06/level_06_recovery_controller.gd.uid` | Persistent matching sidecar only when the exact sibling `.gd` is explicitly active in that slice `CREATE` or `MODIFY` scope. |
| `scripts/levels/level_06/level_06_last_light_source.gd` | Level-local production script; write authority exists only in the exact owning slice table. |
| `scripts/levels/level_06/level_06_last_light_source.gd.uid` | Persistent matching sidecar only when the exact sibling `.gd` is explicitly active in that slice `CREATE` or `MODIFY` scope. |
| `AGENTS.md` | READ ONLY unless a separate narrow prerequisite with exact literal scope is Producer-approved. |
| `project.godot` | READ ONLY unless a separate narrow prerequisite with exact literal scope is Producer-approved. |
| `scenes/core/Player.tscn` | READ ONLY unless a separate narrow prerequisite with exact literal scope is Producer-approved. |
| `scripts/player/player_controller.gd` | READ ONLY unless a separate narrow prerequisite with exact literal scope is Producer-approved. |
| `scripts/player/camera_controller.gd` | READ ONLY unless a separate narrow prerequisite with exact literal scope is Producer-approved. |
| `scenes/core/SoulShard.tscn` | READ ONLY unless a separate narrow prerequisite with exact literal scope is Producer-approved. |
| `scripts/soul/soul_shard.gd` | READ ONLY unless a separate narrow prerequisite with exact literal scope is Producer-approved. |
| `scenes/core/SoulOrb_Follow.tscn` | READ ONLY unless a separate narrow prerequisite with exact literal scope is Producer-approved. |
| `scripts/core/soul_orb_follow.gd` | READ ONLY unless a separate narrow prerequisite with exact literal scope is Producer-approved. |
| `scenes/core/LevelPortal.tscn` | READ ONLY unless a separate narrow prerequisite with exact literal scope is Producer-approved. |
| `scripts/core/level_portal.gd` | READ ONLY unless a separate narrow prerequisite with exact literal scope is Producer-approved. |
| `scenes/core/SceneTransition.tscn` | READ ONLY unless a separate narrow prerequisite with exact literal scope is Producer-approved. |
| `scripts/core/scene_transition.gd` | READ ONLY unless a separate narrow prerequisite with exact literal scope is Producer-approved. |
| `scripts/core/shard_reward_sequence_controller.gd` | READ ONLY unless a separate narrow prerequisite with exact literal scope is Producer-approved. |
| `scenes/ui/ShardRewardOverlay.tscn` | READ ONLY unless a separate narrow prerequisite with exact literal scope is Producer-approved. |
| `scripts/ui/shard_reward_overlay.gd` | READ ONLY unless a separate narrow prerequisite with exact literal scope is Producer-approved. |
| `scenes/ui/LevelFinaleOverlay.tscn` | READ ONLY unless a separate narrow prerequisite with exact literal scope is Producer-approved. |
| `scripts/ui/level_finale_overlay.gd` | READ ONLY unless a separate narrow prerequisite with exact literal scope is Producer-approved. |
| `scenes/core/FinalScene.tscn` | READ ONLY unless a separate narrow prerequisite with exact literal scope is Producer-approved. |
| `scripts/core/final_scene.gd` | READ ONLY unless a separate narrow prerequisite with exact literal scope is Producer-approved. |
| `tests/levels/level_06/harness/MainTextHarness.tscn` | Temporary test-only authority in exact owning slice(s); remove file and generated sidecars before commit. |
| `tests/levels/level_06/harness/RewardGateHarness.tscn` | Temporary test-only authority in exact owning slice(s); remove file and generated sidecars before commit. |
| `tests/levels/level_06/harness/bootstrap_race_harness.gd` | Temporary test-only authority in exact owning slice(s); remove file and generated sidecars before commit. |
| `tests/levels/level_06/harness/bootstrap_race_harness.gd.uid` | Temporary test-only authority in exact owning slice(s); remove file and generated sidecars before commit. |
| `tests/levels/level_06/harness/fakes/fake_finale_overlay.gd.uid` | Temporary test-only authority in exact owning slice(s); remove file and generated sidecars before commit. |
| `tests/levels/level_06/harness/fakes/fake_portal_spy.gd.uid` | Temporary test-only authority in exact owning slice(s); remove file and generated sidecars before commit. |
| `tests/levels/level_06/harness/fakes/fake_shard.gd.uid` | Temporary test-only authority in exact owning slice(s); remove file and generated sidecars before commit. |
| `tests/levels/level_06/harness/fakes/release_validity_spy.gd.uid` | Temporary test-only authority in exact owning slice(s); remove file and generated sidecars before commit. |
| `tests/levels/level_06/harness/fakes/reward_proxy_spy.gd.uid` | Temporary test-only authority in exact owning slice(s); remove file and generated sidecars before commit. |
| `tests/levels/level_06/harness/level_06_architecture_harness.gd` | Temporary test-only authority in exact owning slice(s); remove file and generated sidecars before commit. |
| `tests/levels/level_06/harness/level_06_architecture_harness.gd.uid` | Temporary test-only authority in exact owning slice(s); remove file and generated sidecars before commit. |
| `tests/levels/level_06/harness/main_text_harness.gd` | Temporary test-only authority in exact owning slice(s); remove file and generated sidecars before commit. |
| `tests/levels/level_06/harness/main_text_harness.gd.uid` | Temporary test-only authority in exact owning slice(s); remove file and generated sidecars before commit. |
| `tests/levels/level_06/harness/portal_lifecycle_recorder.gd.uid` | Temporary test-only authority in exact owning slice(s); remove file and generated sidecars before commit. |
| `tests/levels/level_06/harness/portal_transition_integration_harness.gd` | Temporary test-only authority in exact owning slice(s); remove file and generated sidecars before commit. |
| `tests/levels/level_06/harness/portal_transition_integration_harness.gd.uid` | Temporary test-only authority in exact owning slice(s); remove file and generated sidecars before commit. |
| `tests/levels/level_06/harness/recovery_geometry_debug_draw.gd` | Temporary test-only authority in exact owning slice(s); remove file and generated sidecars before commit. |
| `tests/levels/level_06/harness/recovery_geometry_debug_draw.gd.uid` | Temporary test-only authority in exact owning slice(s); remove file and generated sidecars before commit. |
| `tests/levels/level_06/harness/recovery_observation_harness.gd` | Temporary test-only authority in exact owning slice(s); remove file and generated sidecars before commit. |
| `tests/levels/level_06/harness/recovery_observation_harness.gd.uid` | Temporary test-only authority in exact owning slice(s); remove file and generated sidecars before commit. |
| `tests/levels/level_06/harness/reward_gate_harness.gd` | Temporary test-only authority in exact owning slice(s); remove file and generated sidecars before commit. |
| `tests/levels/level_06/harness/reward_gate_harness.gd.uid` | Temporary test-only authority in exact owning slice(s); remove file and generated sidecars before commit. |
| `tests/levels/level_06/harness/runners/Level06FullRegressionRunner.tscn` | Temporary test-only authority in exact owning slice(s); remove file and generated sidecars before commit. |
| `tests/levels/level_06/harness/runners/Level06RuntimeP0Runner.tscn` | Temporary test-only authority in exact owning slice(s); remove file and generated sidecars before commit. |
| `tests/levels/level_06/harness/runners/level_06_full_regression_runner.gd` | Temporary test-only authority in exact owning slice(s); remove file and generated sidecars before commit. |
| `tests/levels/level_06/harness/runners/level_06_full_regression_runner.gd.uid` | Temporary test-only authority in exact owning slice(s); remove file and generated sidecars before commit. |
| `tests/levels/level_06/harness/runners/level_06_runtime_p0_runner.gd` | Temporary test-only authority in exact owning slice(s); remove file and generated sidecars before commit. |
| `tests/levels/level_06/harness/runners/level_06_runtime_p0_runner.gd.uid` | Temporary test-only authority in exact owning slice(s); remove file and generated sidecars before commit. |
| `tests/levels/level_06/harness/RecoveryObservationHarness.tscn` | Temporary test-only authority in its exact slice; remove file and generated sidecars before commit. |
| `tests/levels/level_06/harness/RecoveryGeometryDebugDraw.tscn` | Temporary test-only authority in its exact slice; remove file and generated sidecars before commit. |
| `tests/levels/level_06/harness/Level06ArchitectureHarness.tscn` | Temporary test-only authority in its exact slice; remove file and generated sidecars before commit. |
| `tests/levels/level_06/harness/BootstrapRaceHarness.tscn` | Temporary test-only authority in its exact slice; remove file and generated sidecars before commit. |
| `tests/levels/level_06/harness/fakes/fake_shard.gd` | Temporary test-only authority in its exact slice; remove file and generated sidecars before commit. |
| `tests/levels/level_06/harness/fakes/reward_proxy_spy.gd` | Temporary test-only authority in its exact slice; remove file and generated sidecars before commit. |
| `tests/levels/level_06/harness/fakes/release_validity_spy.gd` | Temporary test-only authority in its exact slice; remove file and generated sidecars before commit. |
| `tests/levels/level_06/harness/fakes/fake_finale_overlay.gd` | Temporary test-only authority in its exact slice; remove file and generated sidecars before commit. |
| `tests/levels/level_06/harness/PortalTransitionIntegrationHarness.tscn` | Temporary test-only authority in its exact slice; remove file and generated sidecars before commit. |
| `tests/levels/level_06/harness/portal_lifecycle_recorder.gd` | Temporary test-only authority in its exact slice; remove file and generated sidecars before commit. |
| `tests/levels/level_06/harness/fakes/fake_portal_spy.gd` | Temporary test-only authority in its exact slice; remove file and generated sidecars before commit. |
| `docs/development/Level_06_Greybox_Implementation_Summary.md` | Mandatory committed Slice 13 factual summary. |
| `Level_06_Greybox_Implementation_Summary.docx` | Mandatory user artifact outside repository worktree; not committed without a separate explicit PR-scope decision. |
| All other repository paths, external files, scene UIDs, `.import`, `.godot/imported`, cache and generated output | FORBIDDEN unless an explicit defect-fix or shared-prerequisite scope is separately approved. |
# 37. Static validation matrix

| ID | Validation |
|---|---|
| ST-01 | All exact owner-relative NodePaths resolve to expected types. PlayerRoot/SpawnRoot/Player serialized transforms compare within `TRANSFORM_EPSILON` and are equal globally within that epsilon; FollowCamera target/current/script/active viewport identity and canonical SoulOrb_Base path/method/group/visibility/uniqueness pass. No guessed/group fallback. |
| ST-02 | Canonical registry equality includes SHARD_IDS, PUZZLE_IDS, Wake/Veil/Constellation IDs, environment/support/recovery IDs and every generation domain; no missing, duplicate, empty or extra runtime ID. |
| ST-03 | Exact Shard_13/14/15 and main text character equality. |
| ST-04 | LevelPortal target/mode/confirmation and actual lifecycle signals exact. |
| ST-05 | Wake/Veil target transforms/shapes and Constellation containment exact. |
| ST-06 | P00-P30, route metrics, B/Q/ribbon/catcher and RA0-RA13 exact. |
| ST-07 | Exactly one Level06EnvironmentController exists and is attached to WorldRoot/EnvironmentPresentation; no RuntimeRoot duplicate. |
| ST-08 | No LegalFloorClassifier path/node/script; LastLightSource resolves exact FloorProbe and LegalSupport roots and exposes no authoritative recovery property. |
| ST-09 | Actual shards connect only to RewardGate; shared controller registers exactly the proxy before commit. |
| ST-10 | Appendix C is complete: every mandatory local/public or required signal-callback signature is exact, and every row names its concrete generation domains without a generic generation placeholder. |
| ST-11 | Atomic bootstrap call graph contains prepare_run -> commit barrier -> exact infallible owner-specific commit manifest -> validation_passed; no passed-before-commit or failed-after-passed path. |
| ST-12 | ReleaseValidity and Recovery expose begin_run as their sole commit API and expose no commit_run; every remaining owner exposes commit_run only; ProgressController commits last. |
| ST-13 | Only RewardGate call sites use set_shard_reward_suspended; only MainText call sites use set_main_text_suspended; no generic set_suspended exists. |
| ST-14 | TRANSITION_IN_FLIGHT is forbidden in the monotonic macro-state enum and mandatory in the separate PortalAttemptState enum/FSM; transition_completed remains diagnostic only. |
| ST-15 | Every temporary harness, executable runner, fake, spy and recorder used by a test has an exact literal path in the active slice `TEMPORARY CREATE - REMOVE BEFORE COMMIT` scope; no project.godot/autoload entry or production reference exists. |
| ST-16 | No LevelManager, PoemRewardUI, local scene load, shared material mutation or broad shared refactor. |
| ST-17 | Persistent `.gd.uid` exists only with an exact sibling `.gd` explicitly in active `CREATE`/`MODIFY`; temporary `.gd.uid` exists only with its exact sibling `.gd` when both are explicitly in active `TEMPORARY CREATE - REMOVE BEFORE COMMIT`; every temporary script/sidecar is removed before commit; no UID exists outside active scope and no unrelated UID/scene UID/import/cache churn exists. |
| ST-18 | RecoveryController directly resolves exact RV_FALL_GLOBAL/RV_LAST_LIGHT_DROP_CATCHER Area3D nodes and owns body_entered/body_exited connections; no adapter node/script/API exists. |
| ST-19 | Public API/signature scan: Section 9/15/16 and all other contract tables match Appendix C exactly, including reset_for_reload, owner-created slot/capture generations and split recovery lifecycle APIs. |
| ST-20 | Slice 0-13 scope closure: every literal path/artifact/metadata source and test fixture named in each slice contract is present in that active scope; the complete Slice 13 UT/ST/P0/P1/no-softlock matrix is executable from literal fixture/runner scope; no dependency exists only under FORBIDDEN; persistent changed files are a subset of CREATE + MODIFY plus persistent matching UIDs with exact active siblings; temporary scripts/UIDs have both exact paths in TEMPORARY scope and are removed before commit; READ ONLY files are unchanged; unrelated UID/scene UID/import/cache/generated churn is absent. |
| ST-21 | Deterministic bootstrap readiness: root coordinator uses one deferred readiness barrier, all exact owners/NodePaths are ready, FollowCamera is the active viewport camera, SoulOrb_Base readiness/group/visibility/method are stable, and exactly one begin_bootstrap call occurs; no timer/sleep/guessed-frame/retry/partial-prepare path exists. |
| ST-22 | Seven-artifact external packet filenames and SHA-256 hashes are recorded in Slice 0; all remain READ ONLY and absent from runtime commits. |
| ST-23 | `Level06IntegratedFlowHarness` exists only transiently in Slices 6-8 at the three exact paths, instantiates real Level_06-local controllers and real shared READ ONLY scenes/scripts, uses production prepare/commit plus explicit proxy registration, contains no production test branch/staged mode and is absent before commit. |
| ST-24 | Evidence labels remain non-interchangeable: Slices 6-8 may record local and `TEMPORARY INTEGRATED-FLOW PASS`, while production natural-flow wiring remains `DEFERRED TO G12 PRODUCTION WIRING` until factual assembled-scene proof in Slice 12. |

# 38. Automated unit/state matrix

| ID | Test | Expected result |
|---|---|---|
| UT-01 | Macro graph reachability, illegal/pre-commit/stale event rejection and synchronous reward-complete transitions. | Every nonterminal state has legal outgoing edge; Shard_13/14 reward-complete immediately reach VEILS_ACTIVE/CONSTELLATION_ACTIVE under one-shot reentrancy guard; illegal events leave state/sets unchanged. |
| UT-02 | Wake duplicate/future/held overlap and anchor-only events. | Strict 1->2->3 once; held future accepts after promotion; RA1 on band 1 and RA2 on band 2 exactly once. |
| UT-03 | Veil third callback versus timeout race. | First matching presentation_generation wins; one reveal. |
| UT-04 | Constellation all six orders and first-partial anchor. | Same exact terminal set/Shard_15 request; whichever canonical zone is first registers RA10 once; later duplicates do not. |
| UT-05 | Constellation airborne/landing/exit. | Pause/resume in air; exit resets incomplete only. |
| UT-06 | Shard slot serialized disabled before frame 1. | No visual/prompt/collision/process sample. |
| UT-07 | Reveal callback versus timeout race. | One availability completion. |
| UT-08 | RewardGate concurrent non-current request. | No proxy emission, collected or macro advance. |
| UT-09 | RewardGate duplicate same request. | One proxy emission and one logical completion. |
| UT-10 | Stale reward_generation callback. | Ignored. |
| UT-11 | MainText missing/false show. | MAIN_TEXT_FAILED_CLOSED; portal dormant; own lock/key cleaned. |
| UT-12 | MainText duplicate close. | One EXIT_PHASE entry and one portal request. |
| UT-13 | Environment stale callback/timeout race and caller-supplied-generation rejection. | Environment creates/returns its owner-local presentation_generation; one state_presented; gameplay unaffected; external generation injection is impossible. |
| UT-14 | Portal repeated activation and actual transition_started. | One activate; one portal_transition_started(attempt_generation, run_generation) with no invented Player argument; PortalAttempt EXIT_ACTIVE -> TRANSITION_IN_FLIGHT; macro stays EXIT_PHASE. |
| UT-15 | Matching actual transition_failed; optional completion observation. | Attempt returns to EXIT_ACTIVE; retry later gets fresh portal_attempt_generation; completion remains diagnostic only. |
| UT-16 | Recovery pending while shard_reward suspended. | Pending survives; commits once after writer-specific clear/re-evaluation. |
| UT-17 | Recovery pending while main_text suspended. | Pending survives; commits once after writer-specific clear. |
| UT-18 | Local/global same departure. | One token and one teleport. |
| UT-19 | Safe Last Light return. | Candidate/armed/pending cancelled; fresh origin epoch. |
| UT-20 | Lower legal support after Last Light. | Origin becomes LOWER_LEGAL; catcher/ribbon ignored. |
| UT-21 | Anchor mapping and future proximity. | RA1/RA2/RA6/RA7/RA10 advance only from their exact canonical events; future proximity or duplicate/stale event never advances. |
| UT-22 | Reload reset. | New validation/run domains; BOOTSTRAP_INERT + visible E0; empty tokens; new VALID state. |
| UT-23 | First gameplay/reward event during prepare. | Rejected; no shared request or progress. |
| UT-24 | Deferred proxy-registration race. | Explicit registration proof completes before commit; no missed first request. |
| UT-25 | Duplicate bootstrap completion and attempted passed->failed conversion. | Exactly one outcome; passed only after one complete commit; failed only before zero commit. |
| UT-26 | Stale validation_generation. | Cannot resolve outcome or commit current run. |
| UT-27 | Missing path/type/method/signal or prepare defect. | One structured validation_failed; zero owner-specific commit API calls; all gameplay inert. |
| UT-28 | Atomic commit-manifest contract audit. | ReleaseValidity/Recovery each expose begin_run only; all remaining owners expose commit_run only; every manifest call is void/infallible after prepare; Progress commits last; no rollback/partial arming branch exists. |
| UT-29 | Release-validity matrix. | Normal VALID; defects latch failed before proxy; collected never heals. |
| UT-30 | Raw observations with stale source_generation/run_generation. | Recovery rejects; provenance/epoch/token unchanged. |
| UT-31 | Suspension writer authorization. | Only writer-specific methods exist; wrong owner/generic call fails static wiring/call-site audit. |
| UT-32 | Portal failure/retry source lifecycle APIs. | stop_for_portal_transition(attempt N) invalidates source N; only restart_after_portal_failure(N) creates fresh source; stale attempt cannot rotate. |
| UT-33 | Recovery source lifecycle APIs. | stop_for_recovery(token T) occurs before teleport; only restart_after_recovery_rearm(T) after safety exit creates fresh source; portal APIs cannot substitute and old samples are ignored. |
| UT-34 | Environment owner and E0 semantics. | Exactly one owner; E0 visible while inert; commit adopts E0 without duplicate transition. |
| UT-35 | Raw floor classification. | Exact ancestry yields only three support IDs; unknown collider -> SUPPORT_NONE; Recovery alone interprets. |
| UT-36 | Reset/reload APIs. | Development reset is rejected in active production run and cleanly reinitializes only in harness/reload boundary. |
| UT-37 | Stale target_generation after ordered target promotion. | Old overlap/re-evaluation cannot accept current Wake/Veil target or register RA1/RA2/RA6/RA7. |
| UT-38 | Stale zone_generation after Constellation activation/reload. | Old dwell/accepted signal cannot change accepted set, RA10 or terminal state. |
| UT-39 | Slot-owned generation and stale reveal evidence. | request_reveal(run_generation) creates/returns slot_generation; caller injection is impossible; old reveal/request/collected evidence is ignored. |
| UT-40 | Stale hint_generation and presentation_generation. | Late hint cannot revive assistance; late VFX/timeout cannot win the current presentation terminal. |
| UT-41 | Recorder-owned capture_generation. | begin_capture() creates value; old finish/dispose/evidence cannot satisfy or terminate current capture. |
| UT-42 | Direct recovery Area3D wiring and canonical Player filtering. | Exactly one connection per signal; non-Player bodies ignored; canonical Player events create internal observations without adapters. |
| UT-43 | Temporary integrated-flow fixture contract. | The fixture uses real local controllers/shared scenes, the exact production prepare/commit and proxy-registration APIs, actual SoulShard/reward flow and no synthetic collected/reward success, production test branch or staged production mode. |
| UT-44 | Temporary-versus-production evidence classification. | Harness success can satisfy only the owning temporary gate; production status remains `DEFERRED TO G12 PRODUCTION WIRING` and cannot become PASS until assembled `Level_06.tscn` proves the same flow. |

# 39. Runtime P0 matrix

| ID | Scenario | Procedure | Expected evidence |
|---|---|---|---|
| P0-01 | Clean load / atomic bootstrap and startup identity | Load Level_06 without moving Player; inspect serialized PlayerRoot/SpawnRoot/Player, FollowCamera and SoulOrb visual while injecting pre-commit events and one prepare defect. | Defect run: one failed/zero passed/zero commit. Clean run: Player and SpawnRoot global transforms equal PLAYER_SPAWN_TRANSFORM without teleport; canonical FollowCamera is current/active and targets Player; exactly one visible eligible SoulOrb_Base; then commit enters WAKE_ACTIVE and emits one passed. |
| P0-02 | Exact serialized spawn, camera and route | Inspect local/global transforms, camera exports/script/viewport identity and P00-P30. | PlayerRoot owns canonical origin/forward-to-P01; SpawnRoot and Player local identity/global equality; no runtime spawn relocation; 221.63 m/max slope exact; no mandatory jump. |
| P0-03 | Wake walk/run/jump and anchors | Cross all current bands by walk/run/jump and inspect anchor registry. | Each ID once in order; RA1 after WAKE_BAND_1, RA2 after WAKE_BAND_2, RA3 only on terminal. |
| P0-04 | Wake held future overlap | Remain inside future band during promotion. | Next-physics acceptance without re-entry. |
| P0-05 | Wake wrong order/duplicates | Force callbacks. | No early/duplicate progress. |
| P0-06 | Shard_13 stationary pre-overlap | Stand in hidden shard area before reveal. | Interactable after deferred enable; exact text. |
| P0-07 | Shard_13 reward complete | Complete canonical overlay. | Only admitted actual collected advances. |
| P0-08 | Veil airborne/boundary spam and anchors | Pass/jump/oscillate through all current layers and inspect anchor registry. | Strict once-only order; RA6 after VEIL_LAYER_1 and RA7 after VEIL_LAYER_2; terminal proceeds once. |
| P0-09 | Veil held future overlap | Remain inside next layer. | Acceptance without re-entry. |
| P0-10 | Veil missing callbacks | Suppress visuals. | 2.50 s local terminal only; one reveal. |
| P0-11 | Shard_14 stationary pre-overlap | As P0-06. | Exact text and availability. |
| P0-12 | Constellation six permutations and first-partial anchor | Complete all orders and record first canonical accepted zone. | Exact set and one Shard_15 reveal; RA10 registers once on the first unique zone in every permutation. |
| P0-13 | Constellation airborne only | Traverse in air. | No acceptance. |
| P0-14 | Constellation land/jump/exit | Exercise dwell. | Pause/resume/reset semantics exact. |
| P0-15 | Constellation floor containment | Debug sweep. | 100% support and 0.40 m reserve. |
| P0-16 | Shard_15 stationary pre-overlap | As P0-06. | Exact text; E3 after actual collected. |
| P0-17 | Exact-copy comparison | Capture all three displayed shard rewards through the canonical overlay. | Character-for-character equality; each exact reward remains visible until Player confirmation. |
| P0-18 | Missing reward overlay | Disable overlay. | Release-invalid before proxy; safe logical completion; no lock; release FAIL. |
| P0-19 | Missing active camera | Disable camera. | Same release-invalid safe-continuation policy. |
| P0-20 | Wrong/empty/generic text | Alter configuration. | Irreversible release failure; no production PASS. |
| P0-21 | Concurrent Shard_14 during Shard_13 | Force request. | Rejected before shared controller. |
| P0-22 | Concurrent Shard_15 during Shard_14 | Force request. | Rejected before shared controller. |
| P0-23 | Duplicate/stale reward callback | Emit duplicates/delay. | One completion; stale ignored. |
| P0-24 | Main-text stationary eligibility | Stand inside before arm. | Opens once without re-entry. |
| P0-25 | Main-text fail closed | Remove/wrong overlay or show false. | Portal inactive; own lock/key released. |
| P0-26 | Main-text duplicate close | Emit twice. | One EXIT_PHASE/E4/portal request and one first source_generation. |
| P0-27 | Portal inactive overlap | Stand inside inactive InteractionArea. | No early transition. |
| P0-28 | Stationary activation and destination proof | Use real portal plus temporary SceneTree.root recorder. | One activation; actual transition_started -> TRANSITION_IN_FLIGHT without re-entry; recorder survives replacement and proves FinalScene, then removes itself. |
| P0-29 | Portal spam/duplicate requests | Rapid boundary and duplicate adapter calls. | At most one activate and one in-flight attempt per attempt_generation. |
| P0-30 | Transition failure and retry | Force failure after transition_started, delay old evidence, then retry. | stop_for_portal_transition matches attempt N; actual failure returns EXIT_ACTIVE and only restart_after_portal_failure(N) creates fresh source/attempt; macro stays EXIT_PHASE; no local load. |
| P0-31 | Last Light numerical sweep | Sample dangerous boundary B at spacing <=0.25 m and verify the complete Q0-Q5 swept union. | Every sample is covered; union has 0.000 m gaps and >=0.099 m minimum reserve. |
| P0-32 | Walk-off boundary samples | Walk outward after main text. | One token and RA12/RA13 recovery. |
| P0-33 | Run-jump / early jump / shallow angle | Test ordinary/run jumps from 1.00 m, 2.00 m and the deepest legal start, including signed crossings with horizontal outward component <0.50 m/s. | Persistent Last Light origin; signed crossing accepted; horizontal outward velocity is diagnostic only; exactly one recovery. |
| P0-34 | Corner/former-gap exits | Cross joins. | One token, no gap/duplicate. |
| P0-35 | Safe return | Cross then regain legal floor. | Token cancelled; fresh epoch. |
| P0-36 | Lower-route false positives | Backtrack/jump/enter catcher. | LOWER_LEGAL -> ignored. |
| P0-37 | Local + global fall | Reach RV_FALL_GLOBAL. | Same token; one teleport. |
| P0-38 | Global fall during shard reward | Fall while reward lock. | Pending survives shard key; one recovery after clear. |
| P0-39 | Global fall during main text | Fall while main text. | Pending survives main_text key. |
| P0-40 | Anchor no-forward-skip and anchor-only event mapping | Fall at every canonical state/near future RA and replay duplicates/stale anchor events. | Latest canonical anchor only; RA1/RA2/RA6/RA7/RA10 advance only from exact event; no proximity/duplicate/stale forward skip. |
| P0-41 | Recovery during step-climb | Trigger private transient then recover. | No snap/freeze/duplicate or narrow prerequisite STOP. |
| P0-42 | Repeat recovery with token-correlated sampling | Recover, complete rearm/safety exit, re-establish origin and depart again. | First token calls stop_for_recovery(T1) then restart_after_recovery_rearm(T1); second departure uses distinct T2/source generation and exactly one second recovery. |
| P0-43 | Reload every state | Reload during all domains. | Clean BOOTSTRAP_INERT/visible E0; new run; no stale UI/token. |
| P0-44 | FinalScene boundary/source deletion | Complete real successful transition with temporary root recorder. | Source nodes may exit before transition_finished; local attempt ends by deletion; recorder proves exact FinalScene and self-cleans. |
| P0-45 | Pacing validation | Time first natural play, repeat play and the complete Last Light route without intentional idle. | First play 2:00-4:00; repeat 1:10-2:00; Last Light 15.33 s walk / 10.43 s sprint; no forced waits. |
| P0-46 | Real signal observability | Capture portal, SceneTransition, tree_exit, destination and recorder lifetime. | Classify pre/post-delete evidence; no project autoload; transition_completed optional. |
| P0-47 | Explicit proxy registration race | Delay shared deferred scan. | Proxy proven exactly once before commit. |
| P0-48 | Startup contract failure | Break Player/SpawnRoot equality, camera target/current/script/active identity, SoulOrb_Base path/method/group/visibility/uniqueness, recovery Area3D wiring, or another mandatory contract. | One validation_failed; zero validation_passed/commit; no teleport/camera substitution/group fallback; all gameplay inert. |
| P0-49 | Shard release-validity matrix | Run normal, missing overlay, missing camera, wrong text and generic fallback cases through the actual shared ShardRewardSequenceController and actual SoulShard completion path. | Only normal remains VALID; defect cases may safe-complete logically but remain irreversibly release-invalid. |
| P0-50 | Recovery owner/stale audit | Inject valid/stale samples and suspension order. | Recovery sole authority; writer-specific keys; last-key re-evaluation once. |
| P0-51 | Portal retry generation isolation | Delay observations/failure/completion from attempt N after retry N+1 starts. | Attempt N evidence cannot change N+1 state; stop/restart portal APIs require exact attempt; source N cannot change provenance/token. |
| P0-52 | Environment topology/E0 | Inspect live tree and clean load. | One EnvironmentPresentation owner, no RuntimeRoot duplicate; E0 alive while inert and adopted once at commit. |
| P0-53 | Suspension writer-specific integration | Exercise RewardGate/MainText set/clear and search runtime call graph. | No generic API or unauthorized writer; pending recovery preserved. |
| P0-54 | Raw support classification | Walk all legal roots and unknown service colliders. | Exact three support IDs; Recovery interpretation only; no classifier node. |
| P0-55 | Local generation stale matrix | Inject stale slot_generation, target_generation, zone_generation, hint_generation, presentation_generation and capture_generation at every corresponding boundary. | Each owner accepts only its current epoch; no stale reveal/target/dwell/hint/presentation/capture changes gameplay, anchor, UI or destination evidence. |
| P0-56 | Direct recovery-volume integration | Use real RV_FALL_GLOBAL and RV_LAST_LIGHT_DROP_CATCHER Area3D nodes with canonical Player and non-Player bodies. | RecoveryController owns exactly one body_entered/body_exited connection per area; non-Player ignored; canonical observations deduplicate to one token/teleport; no adapter exists. |
| P0-57 | Deterministic bootstrap readiness ordering | Instrument root coordinator and load the complete production Level_06 scene repeatedly. | begin_bootstrap cannot occur before the readiness barrier; exactly one call occurs; no sibling-ready-order failure; no validation/prepare/registration/commit before readiness; active camera and SoulOrb_Base registration remain stable before validation. |
| P0-58 | Slice 6 temporary integrated reward flow | In the exact temporary fixture, perform Wake 1-3, pre-overlap/reveal Shard_13, actual shared interaction and actual reward confirmation. | Admitted actual `SoulShard.collected` alone produces E1/VEILS_ACTIVE; result is `TEMPORARY INTEGRATED-FLOW PASS`, fixture is removed, and production wiring remains deferred. |
| P0-59 | Slice 7 temporary integrated reward flow | In the exact temporary fixture, reach VEILS_ACTIVE through P0-58-equivalent actual flow, complete Veils 1-3, Shard_14 and actual shared reward. | Admitted actual `SoulShard.collected` alone produces E2/CONSTELLATION_ACTIVE; no synthetic state/reward; fixture removed; production wiring remains deferred. |
| P0-60 | Slice 8 temporary integrated reward flow | In the exact temporary fixture, reach CONSTELLATION_ACTIVE through actual prior flow, complete all three zones, Shard_15 and actual shared reward. | Admitted actual `SoulShard.collected` alone produces ALL_REWARDS_COMPLETE; no synthetic state/reward; fixture removed; production wiring remains deferred. |
| P0-61 | Slice 12 production natural-flow closure | Load fully assembled production `Level_06.tscn` without `Level06IntegratedFlowHarness`; complete Wake, all three actual shards/rewards, E3/FinalTextGate and actual main-text close. | Exact production trace proves E1/VEILS_ACTIVE, E2/CONSTELLATION_ACTIVE, ALL_REWARDS_COMPLETE, E3 -> FinalTextGate and actual close -> E4/portal activation; every G6-G8 production deferral becomes factual PASS; no harness-only bypass or synthetic authority signal. |

# 40. Runtime P1 matrix

| ID | Scenario | Procedure | Expected result |
|---|---|---|---|
| P1-01 | Muted audio | Set audio to 0. | All targets, progress, hints, exact text and portal readable. |
| P1-02 | 1280×720 | Run lowest required viewport. | All exact texts fit; no clipping/overlap; target cues readable. |
| P1-03 | Reduced color discrimination | Inspect grayscale / reduced saturation. | Shape, motion and persistence communicate state; no color-only rule. |
| P1-04 | Camera comfort | Traverse entire route with max normal camera input. | No forced camera, shake, strobing, clipping or mandatory exact view. |
| P1-05 | Performance | Profile target hardware at 60 FPS. | No unbounded per-frame allocations; environment/trigger systems meet project target. |
| P1-06 | Long idle/hints | Idle at every puzzle stage. | Only approved non-flashing hints; no auto-completion. |
| P1-07 | Backtracking | Backtrack before/after each reward and after main text. | Progress persists; no door/trap; lower support clears Last Light provenance. |
| P1-08 | Emotional-safety audit | Review text, visuals and feedback. | No repair, entitlement, idealization, response demand, shrine or confession leak. |

# 41. No-softlock matrix

| Risk | Prevention contract | Mandatory evidence |
|---|---|---|
| Bootstrap partial arming | side-effect-free prepare + infallible commit barrier + exactly-one outcome | ST-11, P0-01, P0-48 |
| Readiness race starts validation before complete scene | root deterministic barrier and exactly-one begin_bootstrap | ST-21, P0-57 |
| Runtime-only prerequisite mislabeled PASS | DEFERRED-to-owner classification and owner-gate proof | P0-06, P0-11, P0-16, P0-28, P0-41, P0-44, P0-46 |
| Pre-Slice-12 reward-flow integration deadlock | exact temporary real-shared `Level06IntegratedFlowHarness` in Slices 6-8 while final production attachment remains Slice 12 | ST-23, UT-43, P0-58 to P0-60 |
| Temporary harness proof mislabeled as production wiring | explicit `DEFERRED TO G12 PRODUCTION WIRING` evidence class and mandatory assembled-scene closure | ST-24, UT-44, P0-61 |
| Proxy registration race | explicit RewardGate registration before commit | ST-09, P0-47 |
| Current target missed while Player remains inside | deferred current-overlap reevaluation | P0-04, P0-09 |
| Airborne Wake/Veil bypass | full-width/height/length trigger and airborne-valid overlap | P0-03, P0-08 |
| Duplicate puzzle acceptance | immutable canonical ID sets + owner generations | P0-05, P0-55 |
| Constellation accepts airborne | grounded dwell FSM | P0-13, P0-14 |
| Constellation order trap | exact any-order set equality | P0-12 |
| Shard hidden but interactable | packed disabled state | P0-06, P0-11, P0-16 |
| Shard becomes available while Player already overlaps | deferred effective-overlap recheck | P0-06/11/16 |
| Concurrent shard safe-completes wrong shard | RewardGate rejects non-current before shared controller | P0-21, P0-22 |
| Missing reward UI/camera silently passes release | irreversible release-invalid latch before proxy | P0-18, P0-19, P0-49 |
| Wrong text accepted | exact character equality | ST-03, P0-17, P0-20 |
| Optional VFX callback blocks gameplay | bounded owner-local fallback only | P0-10, P0-52 |
| Environment locks Player or gates progress | nonblocking single owner | ST-07, P0-52 |
| Main text requires re-entry | current-overlap reevaluation | P0-24 |
| Main text failure opens portal | fail-closed | P0-25 |
| Duplicate close activates twice | one-shot close and portal request | P0-26 |
| Portal early overlap misses transition | real shared stationary-overlap P0 gate | P0-27, P0-28 |
| Portal attempt stale evidence breaks retry | attempt generation isolation | P0-30, P0-51 |
| Source deletion hides success | temporary root recorder destination proof | P0-28, P0-44, P0-46 |
| Last Light shallow-angle/gap bypass | continuous Q ribbon + signed crossing + persistent origin | P0-31 to P0-34 |
| Lower route falsely arms Last Light recovery | exact support ancestry/provenance | P0-36, P0-54 |
| Global and local fall duplicate teleport | one event token | P0-37, P0-56 |
| Fall during reward/text lost | writer-specific suspension, retained pending | P0-38, P0-39, P0-53 |
| Recovery snap-back from private step-climb | public behavior P0 prerequisite | P0-41 |
| Recovery loops at destination | safety-footprint exit rearm | P0-42 |
| Anchor proximity skips progress | canonical event-only RA registry | P0-40 |
| Reload retains stale epochs | node/run destruction and fresh bootstrap | P0-43 |
| Mandatory jump/precision challenge | 9 m legal corridor, low slopes, no required gaps | P0-45, P1-04 |
| Backtracking resets progress | monotonic ID sets and macro state | P1-07 |

# 42. Producer gates

| Gate | After slice | Internal PASS required |
|---|---|---|
| G0 | Slice 0 | Static integration dependencies PASS; runtime-only prerequisites explicitly DEFERRED with owners/P0 IDs; exact base; seven hashes; zero diff; successful handoff ends `WAITING FOR APPLY`. |
| G1 | Slice 1 | Exact walkable spatial shell and branch/base proof. |
| G2 | Slice 2 | Exact recovery/service geometry and boundary coverage. |
| G3 | Slice 3 | Recovery authority/generation/token/public Player contract. |
| G4 | Slice 4 | Atomic bootstrap and macro core. |
| G5 | Slice 5 | Packed slots, RewardGate and release validity. |
| G6 | Slice 6 | Silver Wake local PASS + actual shared Shard_13 `TEMPORARY INTEGRATED-FLOW PASS`; fixture removed; production Wake -> Shard_13 -> E1/VEILS_ACTIVE remains `DEFERRED TO G12 PRODUCTION WIRING` and is not PASS. |
| G7 | Slice 7 | Clear Veils local PASS + actual shared Shard_14 `TEMPORARY INTEGRATED-FLOW PASS`; fixture removed; production flow through E2/CONSTELLATION_ACTIVE remains `DEFERRED TO G12 PRODUCTION WIRING` and is not PASS. |
| G8 | Slice 8 | Constellation local PASS + actual shared Shard_15 `TEMPORARY INTEGRATED-FLOW PASS`; fixture removed; production flow through ALL_REWARDS_COMPLETE remains `DEFERRED TO G12 PRODUCTION WIRING` and is not PASS. |
| G9 | Slice 9 | Single-owner nonblocking E0-E4. |
| G10 | Slice 10 | Exact fail-closed main text. |
| G11 | Slice 11 | Shared portal attempt/retry/destination proof. |
| G12 | Slice 12 | Full production atomic startup plus assembled-scene natural-flow proof for all three reward transitions, E3 -> FinalTextGate and actual main-text close -> E4/portal activation; every `DEFERRED TO G12 PRODUCTION WIRING` item resolved; no harness-only bypass. |
| G13 | Slice 13 | Acceptance evidence and summaries PASS first; summary commit exists; then exact branch push and one PR creation succeed; appended final handoff records PR URL/head/base; no unresolved or deferred evidence. |

# 43. Definition of Done

Level_06 greybox is complete only when:

- all five approved source documents remain authoritative and unchanged;
- title, Shard_13/14/15 copy and `LEVEL_06_MAIN_TEXT` are exact;
- P00-P30, Z00-Z11, all target volumes, B0-B5, Q0-Q5, recovery volumes and RA0-RA13 are exact;
- legal route, shoulders, lips, openings, support ancestry, slopes and no-gap contracts pass;
- Silver Wake and Clear Veils are strict ordered, persistent and airborne-safe;
- Horizon Constellation supports all six orders with correct grounded dwell;
- progress advances only through admitted actual `SoulShard.collected`;
- Slices 6-8 record factual local and temporary integrated-flow results separately from production wiring; temporary harness proof is never final production-scene proof;
- Slice 12 proves the same three reward-driven transitions, E3 -> FinalTextGate and actual main-text close -> E4/portal activation in the fully assembled production scene, resolving every `DEFERRED TO G12 PRODUCTION WIRING` item;
- no production path depends on `Level06IntegratedFlowHarness`, a staged production mode, test-only production branch or synthetic collected/reward/main-text-close/portal-success signal;
- release-validity defects are irreversible and cannot be reported as release PASS;
- exactly one environment owner presents E0-E4 without locking/gating Player;
- Quiet Horizon remains non-interactive;
- main text opens once, fits at 1280x720 and fails closed;
- shared LevelPortal exclusively owns activation overlap, transition latch, SceneTransition and scene loading;
- stationary portal early-overlap, failure/retry and one-transition destination evidence pass;
- RecoveryController alone owns provenance, tokens, source_generation, suspension, anchors and rearm;
- every UT, ST, mandatory P0 and required P1/manual case is PASS;
- mandatory NOT VERIFIED evidence and unresolved `DEFERRED TO OWNER P0` prerequisites block acceptance;
- no forbidden/shared/project/other-level/art file changed;
- every Slice 0-13 scope-consistency acceptance check passes and every changed-file list is a subset of its exact active write scope;
- both external v1.2.1 reference artifacts remain READ ONLY and are not created or committed by runtime slices;
- deterministic readiness barrier precedes exactly one begin_bootstrap call; no sibling-ready-order race or partial prepare/commit occurs;
- `TRANSFORM_EPSILON = 0.001` is used for all canonical position/basis/forward/identity/spawn comparisons; no raw floating equality;
- persistent `.gd.uid` exists only with an exact sibling `.gd` explicitly in active `CREATE`/`MODIFY`; temporary `.gd.uid` exists only with its exact sibling `.gd` when both exact paths are in active TEMPORARY scope; all temporary scripts/sidecars are removed before commit;
- no temporary harness, `.import`, `.godot/imported`, cache or generated churn remains;
- there is one validated commit per Slice 1-12 plus Slice 13 summary commit;
- repository Markdown summary exists inside the worktree and is committed; its content-equivalent DOCX exists outside the worktree and is not committed;
- after G13 acceptance PASS and summary commit, the exact implementation branch is pushed and exactly one approved PR is created; appended final handoff records PR URL, head SHA and base SHA;
- final summary includes exact base, PR/base decision, prerequisite heads/status, branch/PR, every slice commit, exact created/modified files, UID map, full test results, Slices 6-8 temporary integrated-flow evidence, separate G12 production-wiring closure, spawn/anchor evidence, recovery/ribbon evidence, exact-copy evidence, release-validity evidence, main-text fail-closed evidence, portal ownership/early-overlap/one-transition evidence, timings, warnings, limitations, blockers/NOT VERIFIED, deferred Art Bible families and final DoD verdict.

# 44. Exact branch, push and PR lifecycle

- Implementation branch: `feature/implement-level-06-greybox`.
- PR title: `Implement Level 06 greybox - Ты восхищаешь меня`.
- PR head: `feature/implement-level-06-greybox`.
- PR base: the exact Slice 0 approved base branch/ref and SHA.
- No push or PR creation occurs before G13 acceptance evidence PASS and the Slice 13 summary commit.
- Ordering is exact: finish all evidence -> generate content-equivalent summaries -> remove temporary fixtures -> commit the Markdown summary as the Slice 13 commit -> reconfirm branch/head/base and absence of conflicting PR -> push exact branch -> create exactly one PR -> append final PR metadata handoff.
- PR body contains approved base SHA, every per-slice commit, complete test status, blockers/NOT VERIFIED statement and summary references.
- The appended final handoff, not the already-committed summary, records PR URL, final head SHA and base SHA after creation.
- Base drift, wrong head, conflicting PR, push failure, PR creation failure or inability to record truthful metadata is a hard stop.
- An approved stacked prerequisite is allowed only when Slice 0 or an owner P0 stop names the exact dependency and Producer approves its exact head SHA.

# 45. Final Codex implementation prompt requirements

The final prompt must instruct Codex to:

- receive the complete seven-artifact external READ ONLY packet from Section 2.2 together with the implementation prompt and record each filename/hash in Slice 0;
- use this reference as controlling implementation contract;
- never create, modify or commit either external reference artifact during Slice 0-13;
- run Slice 0 only, make zero changes and end `WAITING FOR APPLY`;
- wait for one explicit APPLY;
- after APPLY reconfirm status/base, create `feature/implement-level-06-greybox` from the exact approved base and never implement on main;
- execute exactly one slice at a time;
- validate and commit every slice;
- continue automatically only while the internal gate passes;
- stop under every slice-specific and global stop condition;
- obey literal CREATE/MODIFY/READ ONLY/TEMPORARY/EXTERNAL/FORBIDDEN scopes and run scope-consistency acceptance before every write and commit;
- allow persistent matching `.gd.uid` only with an exact sibling `.gd` explicitly in active CREATE/MODIFY, and temporary matching `.gd.uid` only when both exact sibling paths are explicitly in active TEMPORARY scope;
- remove all temporary harnesses/residue before commit;
- in Slices 6-8 create only the exact temporary `Level06IntegratedFlowHarness` scene/script/UID paths, use real local controllers and real shared flow with production prepare/commit and proxy registration, remove them before commit, and never add production test-only branches or staged production mode;
- report local/temporary PASS separately from production `DEFERRED TO G12 PRODUCTION WIRING`, and never call temporary proof final production wiring proof;
- require Slice 12 to resolve all production deferrals with the exact assembled-scene natural-flow trace through all three shards, E3/FinalTextGate and actual main-text close -> E4/portal activation;
- never edit shared systems without a separately approved narrow prerequisite;
- never claim mandatory NOT VERIFIED or `DEFERRED TO OWNER P0` evidence as PASS; permit APPLY with deferred runtime-only prerequisites only when each names its exact owner slice/P0 IDs, then block beyond that owner gate until factual PASS;
- create the Markdown summary inside the worktree and commit it, create the content-equivalent DOCX outside the worktree and do not commit it; after G13 acceptance PASS and summary commit, push the exact branch, create exactly one approved PR, and append truthful PR URL/head/base metadata.

# 46. Final implementation handoff requirements

Both final summaries must explicitly contain:

- complete seven-artifact external packet, exact filenames, byte sizes and SHA-256 hashes, confirmed READ ONLY;

- exact implementation base SHA;
- active PR/base decision;
- every shared prerequisite, status and exact approved head SHA;
- branch and PR status; the committed summary records `PR pending final handoff`, and the appended post-creation handoff records the exact PR URL/head/base metadata;
- one commit entry per Slice 1-13;
- exact files created;
- exact files modified;
- exact persistent and temporary `.gd.uid` mapping with sibling/scope authority and temporary-removal proof;
- per-slice scope-consistency results, changed-file subset proof, READ ONLY integrity proof and temporary/generated cleanup proof;
- complete UT/ST/P0/P1 results with PASS / FAIL / NOT VERIFIED, plus each runtime-only prerequisite transition from `DEFERRED TO OWNER P0` to factual PASS/FAIL;
- Slices 6-8 local-component and `TEMPORARY INTEGRATED-FLOW PASS`/FAIL evidence, exact temporary fixture paths, actual shared SoulShard/reward trace and pre-commit removal proof;
- separate production `DEFERRED TO G12 PRODUCTION WIRING` status for each G6-G8 flow and its factual resolution only by the Slice 12 assembled-scene evidence;
- exact G12 production trace: Wake -> Shard_13 -> E1/VEILS_ACTIVE; Veils -> Shard_14 -> E2/CONSTELLATION_ACTIVE; Constellation -> Shard_15 -> ALL_REWARDS_COMPLETE; E3 -> FinalTextGate; actual main-text close -> E4/portal activation; no harness-only bypass;
- exact PlayerRoot/SpawnRoot/Player serialized and runtime equality evidence;
- exact P00-P30, zone, trigger and camera/sightline evidence;
- exact B0-B5/Q0-Q5/recovery volume/RA0-RA13 evidence;
- Last Light numerical sweep and persistent provenance evidence;
- full Silver Wake execution trace;
- full Clear Veils execution trace;
- all six Horizon Constellation traces;
- exact-copy evidence for Shard_13, Shard_14, Shard_15 and `LEVEL_06_MAIN_TEXT`;
- RewardGate proxy and explicit registration evidence;
- release-validity normal/defect matrix;
- deterministic readiness-barrier evidence, exactly-one begin_bootstrap evidence and atomic bootstrap exactly-one-outcome evidence;
- environment single-owner and E0 evidence;
- finale fail-closed evidence;
- portal ownership evidence;
- stationary portal early-overlap evidence;
- portal retry-generation and one-transition destination proof;
- recovery suspension, step-climb, repeat/rearm and direct Area3D evidence;
- first-play, repeat-play and Last Light timing evidence;
- known warnings;
- known limitations;
- blockers and NOT VERIFIED items;
- remaining art-stage work, including the three deferred Art Bible families and post-greybox production;
- final Definition of Done verdict;
- appended post-PR handoff with PR URL, exact title, final head branch/SHA and approved base ref/SHA.

The DOCX summary is mandatory, generated outside the runtime worktree and not committed unless a separate explicit PR-scope decision authorizes it.


# Appendix A. Canonical constants and export defaults

| Constant / export | Exact value | Owner |
|---|---|---|
| TRANSFORM_EPSILON | 0.001 | One canonical epsilon for all transform comparisons. |
| Position comparison | `a.distance_to(b) <= TRANSFORM_EPSILON` | Applies to Vector3 positions and Player/SpawnRoot origins. |
| Basis axis comparison | each corresponding normalized axis distance `<= TRANSFORM_EPSILON` | Applies to basis and identity-child basis checks. |
| Forward comparison | `1.0 - normalized_a.dot(normalized_b) <= TRANSFORM_EPSILON` | Applies to canonical forward direction; raw equality forbidden. |
| Identity child transform | origin length `<= TRANSFORM_EPSILON` and basis axes within epsilon of identity | Applies to SpawnRoot/Player local identity. |
| Player/SpawnRoot global equality | origins and all basis axes compare within `TRANSFORM_EPSILON` | Raw Transform3D/float equality forbidden. |
| LEVEL_ID | Level_06 | Level06Contract |
| SHARD_IDS | [Shard_13, Shard_14, Shard_15] | Level06Contract |
| PUZZLE_IDS | [&"SILVER_WAKE", &"CLEAR_VEILS", &"HORIZON_CONSTELLATION"] | Level06Contract |
| PLAYER_SPAWN_ORIGIN | Vector3(-22.00, 1.80, -51.00) | Level06Contract / PlayerRoot serialized transform |
| PLAYER_SPAWN_FORWARD | normalize(Vector3(6.50, 0.00, 2.00)); heading 72.90° toward P01 | Level06Contract / PlayerRoot serialized basis |
| SPAWNROOT_LOCAL_TRANSFORM | Transform3D.IDENTITY | SpawnRoot serialized transform |
| PLAYER_LOCAL_TRANSFORM | Transform3D.IDENTITY | Player serialized transform |
| FOLLOW_CAMERA_TARGET_PATH | NodePath("../../PlayerRoot/Player") | FollowCamera export |
| FOLLOW_CAMERA_CURRENT | true | FollowCamera export |
| FOLLOW_CAMERA_SCRIPT | res://scripts/player/camera_controller.gd | FollowCamera script |
| SOUL_ORB_VISUAL_PATH | ../../SoulOrbRoot/SoulOrb_Follow/HoverRoot/SoulOrb_Base | Level06RuntimeContractValidator export |
| SOUL_ORB_VISUAL_CONTRACT | Node3D; play_absorb_pulse; soul_orb_visual; visible-in-tree; unique eligible visible member; ancestor SoulOrb_Follow | Level06RuntimeContractValidator |
| WAKE_IDS | [WAKE_BAND_1, WAKE_BAND_2, WAKE_BAND_3] | Level06Contract |
| VEIL_IDS | [VEIL_LAYER_1, VEIL_LAYER_2, VEIL_LAYER_3] | Level06Contract |
| CONSTELLATION_IDS | [CONSTELLATION_WEST, CONSTELLATION_CREST, CONSTELLATION_EAST] | Level06Contract |
| ENVIRONMENT_IDS | [E0_INITIAL, E1_AFTER_SHARD_13, E2_AFTER_SHARD_14, E3_AFTER_SHARD_15, E4_AFTER_MAIN_TEXT] | Level06Contract |
| RAW_SUPPORT_IDS | [SUPPORT_NONE, SUPPORT_LOWER_LEGAL, SUPPORT_LAST_LIGHT_OR_PORTAL] | Level06Contract / LastLightSource raw output |
| WAKE_HINT_SECONDS | 15.0 | SilverWakeController |
| VEIL_HINT_SECONDS | 15.0 | ClearVeilsController |
| VEIL_TERMINAL_FALLBACK_SECONDS | 2.50 | ClearVeilsController |
| CONSTELLATION_DWELL_SECONDS | 0.60 | GroundedDwellZone |
| CONSTELLATION_HINT_SECONDS | 20.0 / 35.0 | HorizonConstellationController |
| CONSTELLATION_TERMINAL_FALLBACK_SECONDS | 1.40 | HorizonConstellationController |
| SHARD_13/14/15 REVEAL / FALLBACK | 1.20/1.70; 1.25/1.75; 1.35/1.85 | Shard slots |
| RECOVERY_SOURCE_SHARD_REWARD | &"shard_reward" | RecoveryController |
| RECOVERY_SOURCE_MAIN_TEXT | &"main_text" | RecoveryController |
| GLOBAL_FALL_TOP_Y | -3.00 | Recovery rig |
| LAST_LIGHT_DESCENT_VY | -0.25 m/s | RecoveryController |
| LAST_LIGHT_BELOW_PLANE | 0.20 m | RecoveryController |
| RIBBON_RADIUS | 0.45 m | LastLightSource geometry |
| PORTAL_TARGET | res://scenes/core/FinalScene.tscn | LevelPortal export |
| PORTAL_MODE | AUTO_ENTER / no confirmation | LevelPortal exports |
| RELEASE_VALIDITY_INITIAL | VALID | ReleaseValidityController.begin_run |
| RELEASE_VALIDITY_FAILURE | NARRATIVE_PRESENTATION_FAILED | ReleaseValidityController |
| BOOTSTRAP_INERT | Gameplay/runtime readiness state; no gameplay node active | Level06RuntimeContractValidator / all prepared owners |
| E0_INITIAL | Serialized visible environment baseline; adopted at commit without replay | EnvironmentPresentation |
| BOOTSTRAP_OUTCOME | UNRESOLVED -> PASSED or FAILED exactly once | Level06RuntimeContractValidator |
| VALIDATION_GENERATION | validator-created monotonic int per bootstrap attempt | Level06RuntimeContractValidator |
| RUN_GENERATION | validator-reserved; published only by atomic commit | Level06RuntimeContractValidator |
| REWARD_GENERATION | increment per admitted shard sequence | RewardGate |
| PRESENTATION_GENERATION | owner-local increment per async presentation | Each presenting controller |
| SLOT_GENERATION | ShardSlot-owned; created by request_reveal(run_generation) | Each Level06ShardSlot |
| TARGET_GENERATION | Ordered puzzle-controller-owned per current-target promotion | SilverWakeController / ClearVeilsController |
| ZONE_GENERATION | Constellation-controller-owned per three-zone activation | HorizonConstellationController |
| HINT_GENERATION | Presenting-controller-owned per hint request/cancellation | SilverWake / ClearVeils / Horizon controllers |
| CAPTURE_GENERATION | Recorder-owned; created by begin_capture() | PortalLifecycleRecorder test fixture |
| SOURCE_GENERATION | RecoveryController-created per exit-sampling attempt | RecoveryController |
| PORTAL_ATTEMPT_GENERATION | PortalAdapter-created per transition attempt | PortalAdapter |
| PORTAL_ATTEMPT_STATES | DORMANT, ACTIVATING, EXIT_ACTIVE, TRANSITION_IN_FLIGHT | PortalAdapter |
| PORTAL_SUCCESS_EVIDENCE | actual transition_started + destination/current-scene evidence | PortalAdapter / test recorder |
| PORTAL_COMPLETION_OBSERVATION | optional diagnostic only | PortalAdapter |

# Appendix B. Exact route point registry P00-P30

| Point | X | Y floor | Z | Role |
|---|---|---|---|---|
| P00 | -22.00 | 0.80 | -51.00 | Spawn |
| P01 | -15.50 | 1.05 | -49.00 | Terrace exit |
| P02 | -9.00 | 1.40 | -45.50 | Wake 1 |
| P03 | -2.50 | 1.80 | -41.00 | Wake 2 |
| P04 | 3.50 | 2.20 | -35.50 | Wake 3 |
| P05 | 8.50 | 2.55 | -29.00 | Upper curve |
| P06 | 12.50 | 2.90 | -22.00 | Overlook approach |
| P07 | 15.00 | 3.25 | -14.50 | Overlook entry |
| P08 | 15.00 | 3.45 | -7.50 | Shard 13 shelf |
| P09 | 14.00 | 3.75 | -0.50 | Ridge lower |
| P10 | 11.00 | 4.15 | 6.50 | Ridge upper |
| P11 | 7.00 | 4.55 | 13.00 | Veils approach |
| P12 | 2.50 | 5.00 | 18.50 | Veil 1 |
| P13 | -2.50 | 5.45 | 23.00 | Veil 2 |
| P14 | -8.00 | 5.90 | 26.50 | Veil 3 |
| P15 | -14.00 | 6.35 | 29.00 | Shard 14 shelf |
| P16 | -19.00 | 6.75 | 32.50 | Open Sky lower |
| P17 | -22.50 | 7.15 | 37.50 | Open Sky upper |
| P18 | -23.50 | 7.50 | 43.00 | Amphitheater entry |
| P19 | -19.00 | 7.80 | 47.00 | Inner approach |
| P20 | -10.00 | 8.20 | 46.50 | Shard 15 plateau |
| P21 | 2.50 | 8.60 | 49.50 | Quiet Horizon |
| P22 | 7.00 | 8.85 | 53.50 | Last Light 1 |
| P23 | 15.50 | 9.10 | 53.50 | Last Light 2 |
| P24 | 23.50 | 9.35 | 50.00 | Outer crest |
| P25 | 25.50 | 9.60 | 43.50 | East rim |
| P26 | 25.50 | 9.85 | 35.00 | South rim 1 |
| P27 | 25.50 | 10.10 | 26.50 | South rim 2 |
| P28 | 25.00 | 10.35 | 19.50 | Inner rim |
| P29 | 24.50 | 10.70 | 13.50 | Portal approach |
| P30 | 24.00 | 11.00 | 8.50 | PortalFloorAnchor |

# Appendix C. Complete normative Level_06 API and signal registry

This appendix reproduces the approved Technical Architecture v1.2.2 registry. It is normative. Slice implementations must not invent alternate signatures or generic generation parameters.


## Appendix C - Level06BootstrapReadinessCoordinator

| API / signal | Owner | Caller / consumer | Canonical IDs / paths | Generation domain | Precondition / effect | Idempotency / stale behavior |
|---|---|---|---|---|---|---|
| `_ready() -> void` | Level_06 root coordinator | SceneTree | exact root composition | none | Schedules one `call_deferred(&"_open_readiness_barrier")`; performs no validation or gameplay action itself. | Exactly once per scene instance. |
| `_open_readiness_barrier() -> void` | coordinator | deferred root call | validator/camera/orb/required owner paths | none | Proves complete scene readiness, active FollowCamera and ready canonical SoulOrb_Base; emits confirmation then calls validator once. | One-shot; duplicate/stale invocation ignored; no retry loop. |
| `is_readiness_satisfied() -> bool` | coordinator | diagnostics/tests | exact required owner set | none | Pure read-only readiness result; cannot arm or repair. | Pure. |
| `signal bootstrap_readiness_confirmed()` | coordinator | validator diagnostics/tests | none | none | Emitted immediately before the sole `begin_bootstrap()` call after all readiness proofs pass. | Exactly once; impossible before complete readiness. |
| `signal bootstrap_readiness_blocked(report: Dictionary)` | coordinator | diagnostics/tests | structured dependency IDs | none | Reports missing/unstable ready dependency with zero begin_bootstrap calls and zero partial prepare. | Exactly once per failed scene instance; no timer/retry. |

## Appendix C - Level06Contract

| Exact GDScript signature | Owner / emitter | Consumer / caller | ID parameter | Generation domain | Authority effect | Duplicate / stale behavior |
|---|---|---|---|---|---|---|
| validate_id(domain_id: StringName, value: StringName) -> bool | Level06Contract | Validator and domain owners | domain_id, value | none | Pure canonical membership check. | Pure/idempotent. |
| exact_text_for(shard_id: StringName) -> String | Level06Contract | Validator, RewardGate | shard_id | none | Returns locked canonical reward text. | Pure/idempotent; unknown -> empty + validation defect. |
| validate_registry() -> Array[Dictionary] | Level06Contract | Level06RuntimeContractValidator | all canonical IDs | none | Pure registry equality validation. | Pure/idempotent. |

## Appendix C - Level06RuntimeContractValidator

| Exact GDScript signature | Owner / emitter | Consumer / caller | ID parameter | Generation domain | Authority effect | Duplicate / stale behavior |
|---|---|---|---|---|---|---|
| begin_bootstrap() -> void | Level06RuntimeContractValidator | Scene startup | none | creates validation_generation + reserves run_generation | Starts one prepare/commit attempt while all gameplay remains inert. | Second call while UNRESOLVED/after resolution ignored. |
| validate_startup(validation_generation: int, run_generation: int) -> Array[Dictionary] | Level06RuntimeContractValidator | Self | none | validation_generation + reserved run_generation | Aggregates exact path/type/signature/text/export/topology failures. | Stale generations return no authority. |
| validate_player_camera_startup_contract() -> Array[Dictionary] | Level06RuntimeContractValidator | begin_bootstrap / validate_startup | PlayerRoot, SpawnRoot, Player, FollowCamera | none | Facts-only proof of exact serialized spawn transform/global equality, no runtime teleport, exact camera script/target/current and active viewport camera identity. | Idempotent; any mismatch is pre-commit validation failure. |
| validate_soul_orb_visual_contract() -> Array[Dictionary] | Level06RuntimeContractValidator | begin_bootstrap / validate_startup | SoulOrb_Follow, SoulOrb_Base | none | Facts-only proof of exact Node3D path, play_absorb_pulse, group, visibility, ancestor and unique visible eligible member. | Idempotent; no group-based fallback selection. |
| validate_recovery_volume_wiring_contract() -> Array[Dictionary] | Level06RuntimeContractValidator | begin_bootstrap / validate_startup | RV_FALL_GLOBAL, RV_LAST_LIGHT_DROP_CATCHER | none | Facts-only proof of exact Area3D paths/signals and RecoveryController-owned direct connection plan; no adapters. | Idempotent; missing/duplicate/foreign connection is pre-commit failure. |
| signal validation_passed(run_generation: int) | Level06RuntimeContractValidator | Diagnostics / harness | none | run_generation | Post-commit evidence only; gameplay already committed. | Exactly once; impossible after failed. |
| signal validation_failed(report: Dictionary) | Level06RuntimeContractValidator | Diagnostics / harness | report IDs | report.validation_generation + report.run_generation | Only pre-commit failure outcome; scene remains inert. | Exactly once; impossible after passed. |

## Appendix C - Level06ProgressController

| Exact GDScript signature | Owner / emitter | Consumer / caller | ID parameter | Generation domain | Authority effect | Duplicate / stale behavior |
|---|---|---|---|---|---|---|
| validate_contract() -> Array[Dictionary] | Level06ProgressController | Level06RuntimeContractValidator | contract IDs | none | Returns exact static/runtime compatibility failures; no arming. | Idempotent; facts-only. |
| prepare_run(run_generation: int) -> Array[Dictionary] | Level06ProgressController | Level06RuntimeContractValidator | none | run_generation | Side-effect-free run preparation only. | Same generation idempotent; stale rejected; defect has no gameplay side effect. |
| commit_run(run_generation: int) -> void | Level06ProgressController | Level06RuntimeContractValidator | none | run_generation | Infallibly publishes prepared state during atomic commit. | Exactly once; duplicate/stale ignored; cannot return false. |
| get_macro_state() -> StringName | Level06ProgressController | Diagnostics / tests | none | run_generation | Read-only monotonic macro state. | Pure; before commit returns BOOTSTRAP_INERT. |
| signal macro_state_changed(previous_state: StringName, current_state: StringName, run_generation: int) | Level06ProgressController | Domain listeners / diagnostics | state IDs | run_generation | Authoritative monotonic macro transition evidence. | One per legal transition; stale rejected. |
| signal all_rewards_completed(run_generation: int) | Level06ProgressController | MainTextController / diagnostics | none | run_generation | Arms exact main-text gate once after three admitted collected events. | One-shot; stale/duplicate ignored. |
| signal environment_state_requested(environment_id: StringName, run_generation: int) | Level06ProgressController | EnvironmentPresentation | environment_id | run_generation | Nonblocking presentation request only. | Current repeat idempotent; skip/stale rejected. |
| signal portal_activation_requested(run_generation: int) | Level06ProgressController | PortalAdapter | none | run_generation | One activation request after MAIN_TEXT_CLOSED / EXIT_PHASE. | One-shot; duplicate/stale rejected. |
| notify_wake_target_accepted(target_id: StringName, run_generation: int) -> void | Level06ProgressController | SilverWakeController | WAKE ID | run_generation | Accept exact current-target evidence; register RA1 for WAKE_BAND_1 or RA2 for WAKE_BAND_2; terminal remains puzzle_completed. | Illegal state/ID/generation ignored with diagnostic; one-shot where terminal. |
| notify_wake_completed(puzzle_id: StringName, run_generation: int) -> void | Level06ProgressController | SilverWakeController | puzzle_id | run_generation | Require puzzle_id=&"SILVER_WAKE"; commit WAKE_COMPLETE and RA3 once. | Illegal state/ID/generation ignored with diagnostic; one-shot where terminal. |
| notify_veils_target_accepted(target_id: StringName, run_generation: int) -> void | Level06ProgressController | ClearVeilsController | VEIL ID | run_generation | Register RA6 for VEIL_LAYER_1 or RA7 for VEIL_LAYER_2; VEIL_LAYER_3 terminal remains logical_completed. | Exact ID once; illegal state/duplicate/stale ignored. |
| notify_shard_available(shard_id: StringName, slot_generation: int, run_generation: int) -> void | Level06ProgressController | ShardSlot | shard_id | slot_generation + run_generation | Move exact reveal to AVAILABLE only for current slot-owned generation. | Illegal state/ID/generation ignored with diagnostic; one-shot where terminal. |
| notify_reward_admitted(shard_id: StringName, reward_generation: int, run_generation: int) -> void | Level06ProgressController | RewardGate | shard_id | reward_generation + run_generation | Enter exact collection-active state. | Illegal state/ID/generation ignored with diagnostic; one-shot where terminal. |
| notify_reward_completed(shard_id: StringName, reward_generation: int, run_generation: int) -> void | Level06ProgressController | RewardGate | shard_id | reward_generation + run_generation | Only logical reward authority. Shard_13/14 synchronously traverse reward-complete to VEILS_ACTIVE/CONSTELLATION_ACTIVE under one-shot transition guard; Shard_15 enters ALL_REWARDS_COMPLETE. | Illegal state/ID/generation ignored with diagnostic; one-shot where terminal. |
| notify_veils_logical_completed(puzzle_id: StringName, run_generation: int) -> void | Level06ProgressController | ClearVeilsController | puzzle_id | run_generation | Require puzzle_id=&"CLEAR_VEILS"; enter VEILS_LOGICAL_COMPLETE. | Illegal state/ID/generation ignored with diagnostic; one-shot where terminal. |
| notify_veils_presentation_completed(presentation_generation: int, run_generation: int) -> void | Level06ProgressController | ClearVeilsController | none | presentation_generation + run_generation | Permit Shard_14 reveal after matching logical completion. | Illegal state/ID/generation ignored with diagnostic; one-shot where terminal. |
| notify_constellation_zone_accepted(zone_id: StringName, run_generation: int) -> void | Level06ProgressController | HorizonConstellationController | zone_id | run_generation | Record unique any-order zone; first unique registers RA10 once. | Illegal state/ID/generation ignored with diagnostic; one-shot where terminal. |
| notify_constellation_logical_completed(puzzle_id: StringName, run_generation: int) -> void | Level06ProgressController | HorizonConstellationController | puzzle_id | run_generation | Require puzzle_id=&"HORIZON_CONSTELLATION"; enter logical terminal. | Illegal state/ID/generation ignored with diagnostic; one-shot where terminal. |
| notify_constellation_presentation_completed(presentation_generation: int, run_generation: int) -> void | Level06ProgressController | HorizonConstellationController | none | presentation_generation + run_generation | Permit Shard_15 reveal after matching terminal presentation. | Illegal state/ID/generation ignored with diagnostic; one-shot where terminal. |
| notify_main_text_started(run_generation: int) -> void | Level06ProgressController | MainTextController | none | run_generation | Diagnostic consistency; macro remains MAIN_TEXT_ACTIVE. | Illegal state/ID/generation ignored with diagnostic; one-shot where terminal. |
| notify_main_text_closed(run_generation: int) -> void | Level06ProgressController | MainTextController | none | run_generation | Only authority for EXIT_PHASE, E4, portal request and first source_generation. | Illegal state/ID/generation ignored with diagnostic; one-shot where terminal. |
| notify_main_text_failed(reason_code: StringName, run_generation: int, details: Dictionary) -> void | Level06ProgressController | MainTextController | reason_code | run_generation | Enter MAIN_TEXT_FAILED_CLOSED. | Illegal state/ID/generation ignored with diagnostic; one-shot where terminal. |
| notify_portal_activation_started(run_generation: int) -> void | Level06ProgressController | PortalAdapter | none | run_generation | Diagnostic only; macro stays EXIT_PHASE. | Illegal state/ID/generation ignored with diagnostic; one-shot where terminal. |
| notify_portal_activation_completed(run_generation: int) -> void | Level06ProgressController | PortalAdapter | none | run_generation | Authorize RA13; macro stays EXIT_PHASE. | Illegal state/ID/generation ignored with diagnostic; one-shot where terminal. |
| notify_portal_transition_started(portal_attempt_generation: int, run_generation: int) -> void | Level06ProgressController | PortalAdapter | none | portal_attempt_generation + run_generation | Diagnostic source-scene handoff; macro stays EXIT_PHASE. | Illegal state/ID/generation ignored with diagnostic; one-shot where terminal. |
| notify_portal_transition_failed(error_code: int, portal_attempt_generation: int, run_generation: int) -> void | Level06ProgressController | PortalAdapter | error_code | portal_attempt_generation + run_generation | Diagnostic retry evidence; no macro regression. | Illegal state/ID/generation ignored with diagnostic; one-shot where terminal. |
| reset_for_reload(new_run_generation: int) -> void | Level06ProgressController | Development harness / scene reload boundary | none | new run_generation | Clears run-local sets before a new bootstrap only. | Rejected during active production run; idempotent in harness boundary. |

## Appendix C - Level06PassThroughTarget

| Exact GDScript signature | Owner / emitter | Consumer / caller | ID parameter | Generation domain | Authority effect | Duplicate / stale behavior |
|---|---|---|---|---|---|---|
| validate_contract() -> Array[Dictionary] | Level06PassThroughTarget | Level06RuntimeContractValidator | contract IDs | none | Returns exact static/runtime compatibility failures; no arming. | Idempotent; facts-only. |
| prepare_run(run_generation: int) -> Array[Dictionary] | Level06PassThroughTarget | Level06RuntimeContractValidator | none | run_generation | Side-effect-free run preparation only. | Same generation idempotent; stale rejected; defect has no gameplay side effect. |
| commit_run(run_generation: int) -> void | Level06PassThroughTarget | Level06RuntimeContractValidator | none | run_generation | Infallibly publishes prepared state during atomic commit. | Exactly once; duplicate/stale ignored; cannot return false. |
| set_current(is_current: bool, target_generation: int, run_generation: int) -> void | Level06PassThroughTarget | Owning SilverWakeController or ClearVeilsController | target_id | target_generation + run_generation | Consumes controller-created target_generation; target never creates or accepts a caller from outside its owner. | Same value idempotent; stale rejected. |
| reevaluate_overlap(target_generation: int, run_generation: int) -> void | Level06PassThroughTarget | Owning puzzle controller / deferred physics | target_id | target_generation + run_generation | Confirms current Player overlap without exit/re-entry. | accepted_once; stale ignored. |
| reset_for_reload(new_run_generation: int) -> void | Level06PassThroughTarget | Harness/reload boundary | target_id | new run_generation | Returns sensor to inert unaccepted state. | Boundary-only. |
| signal player_overlap_changed(target_id: StringName, overlapping: bool, target_generation: int, run_generation: int) | Level06PassThroughTarget | Owning puzzle controller | target_id | target_generation + run_generation | Raw overlap evidence only. | Duplicate state coalesced; stale ignored. |
| signal current_overlap_confirmed(target_id: StringName, target_generation: int, run_generation: int) | Level06PassThroughTarget | Owning puzzle controller | target_id | target_generation + run_generation | One current-target acceptance candidate. | accepted_once; stale ignored. |

## Appendix C - SilverWakeController

| Exact GDScript signature | Owner / emitter | Consumer / caller | ID parameter | Generation domain | Authority effect | Duplicate / stale behavior |
|---|---|---|---|---|---|---|
| validate_contract() -> Array[Dictionary] | SilverWakeController | Level06RuntimeContractValidator | contract IDs | none | Returns exact static/runtime compatibility failures; no arming. | Idempotent; facts-only. |
| prepare_run(run_generation: int) -> Array[Dictionary] | SilverWakeController | Level06RuntimeContractValidator | none | run_generation | Side-effect-free run preparation only. | Same generation idempotent; stale rejected; defect has no gameplay side effect. |
| commit_run(run_generation: int) -> void | SilverWakeController | Level06RuntimeContractValidator | none | run_generation | Infallibly publishes prepared state during atomic commit. | Exactly once; duplicate/stale ignored; cannot return false. |
| activate(run_generation: int) -> void | SilverWakeController | ProgressController | WAKE_BAND_1 | run_generation | LOCKED -> ACTIVE_1 after commit. | Duplicate/stale ignored. |
| is_complete() -> bool | SilverWakeController | Progress/diagnostics | none | run_generation | Read-only exact-set terminal. | Pure. |
| reset_for_reload(new_run_generation: int) -> void | SilverWakeController | Harness/reload boundary | WAKE IDs | new run_generation | Clears local state before new bootstrap. | Boundary-only. |
| signal target_accepted(target_id: StringName, run_generation: int) | SilverWakeController | ProgressController | target_id | run_generation | Exact ordered target progress. | Unique ID once; future/stale ignored. |
| signal puzzle_completed(puzzle_id: StringName, run_generation: int) | SilverWakeController | ProgressController | &"SILVER_WAKE" | run_generation | Local logical terminal once after exact set. | One-shot. |
| signal hint_requested(target_id: StringName, hint_generation: int, run_generation: int) | SilverWakeController | Wake presentation | target_id | hint_generation + run_generation | Owner-created presentation-only assistance request. | Late/duplicate hint generation ignored; no gameplay authority. |

## Appendix C - ClearVeilsController

| Exact GDScript signature | Owner / emitter | Consumer / caller | ID parameter | Generation domain | Authority effect | Duplicate / stale behavior |
|---|---|---|---|---|---|---|
| validate_contract() -> Array[Dictionary] | ClearVeilsController | Level06RuntimeContractValidator | contract IDs | none | Returns exact static/runtime compatibility failures; no arming. | Idempotent; facts-only. |
| prepare_run(run_generation: int) -> Array[Dictionary] | ClearVeilsController | Level06RuntimeContractValidator | none | run_generation | Side-effect-free run preparation only. | Same generation idempotent; stale rejected; defect has no gameplay side effect. |
| commit_run(run_generation: int) -> void | ClearVeilsController | Level06RuntimeContractValidator | none | run_generation | Infallibly publishes prepared state during atomic commit. | Exactly once; duplicate/stale ignored; cannot return false. |
| activate(run_generation: int) -> void | ClearVeilsController | ProgressController | VEIL_LAYER_1 | run_generation | Locks strict ordered local FSM to first layer. | Duplicate/stale ignored. |
| notify_layer_presentation_finished(layer_id: StringName, presentation_generation: int, run_generation: int) -> void | ClearVeilsController | Veil presentation callback | layer_id | presentation_generation + run_generation | Commits matching optional presentation; third may win terminal race. | First terminal wins; stale ignored. |
| is_complete() -> bool | ClearVeilsController | Progress/diagnostics | none | run_generation | Read-only logical terminal. | Pure. |
| reset_for_reload(new_run_generation: int) -> void | ClearVeilsController | Harness/reload boundary | VEIL IDs | new run_generation | Clear local IDs/generations. | Boundary-only. |
| signal target_accepted(target_id: StringName, run_generation: int) | ClearVeilsController | ProgressController / visuals | target_id | run_generation | Exact ordered logical progress and RA6/RA7 anchor evidence. | Unique once; stale/future ignored. |
| signal logical_completed(puzzle_id: StringName, run_generation: int) | ClearVeilsController | ProgressController | &"CLEAR_VEILS" | run_generation | Logical terminal after exact third ID. | One-shot. |
| signal presentation_completed(presentation_generation: int, fallback_used: bool, run_generation: int) | ClearVeilsController | ProgressController | none | presentation_generation + run_generation | Third-layer presentation terminal only. | First callback/timeout wins. |
| signal hint_requested(target_id: StringName, hint_generation: int, run_generation: int) | ClearVeilsController | Veil presentation | target_id | hint_generation + run_generation | Owner-created presentation-only assistance request. | Late/duplicate hint generation ignored; no gameplay authority. |

## Appendix C - Level06GroundedDwellZone

| Exact GDScript signature | Owner / emitter | Consumer / caller | ID parameter | Generation domain | Authority effect | Duplicate / stale behavior |
|---|---|---|---|---|---|---|
| validate_contract() -> Array[Dictionary] | Level06GroundedDwellZone | Level06RuntimeContractValidator | contract IDs | none | Returns exact static/runtime compatibility failures; no arming. | Idempotent; facts-only. |
| prepare_run(run_generation: int) -> Array[Dictionary] | Level06GroundedDwellZone | Level06RuntimeContractValidator | none | run_generation | Side-effect-free run preparation only. | Same generation idempotent; stale rejected; defect has no gameplay side effect. |
| commit_run(run_generation: int) -> void | Level06GroundedDwellZone | Level06RuntimeContractValidator | none | run_generation | Infallibly publishes prepared state during atomic commit. | Exactly once; duplicate/stale ignored; cannot return false. |
| set_enabled(enabled: bool, zone_generation: int, run_generation: int) -> void | Level06GroundedDwellZone | HorizonConstellationController | zone_id | zone_generation + run_generation | Enables/disables physics accumulation. | Idempotent; stale rejected. |
| physics_sample_player(delta: float, zone_generation: int, run_generation: int) -> void | Level06GroundedDwellZone | Physics process | zone_id | zone_generation + run_generation | Accumulates only grounded overlap; pauses airborne. | One sample/frame; stale ignored. |
| reset_for_reload(new_run_generation: int) -> void | Level06GroundedDwellZone | Harness/reload boundary | zone_id | new run_generation | Clear accumulator/accepted latch. | Boundary-only. |
| signal dwell_changed(zone_id: StringName, accumulated_seconds: float, grounded: bool, zone_generation: int, run_generation: int) | Level06GroundedDwellZone | Constellation presentation/diagnostics | zone_id | zone_generation + run_generation | Read-only dwell evidence. | Duplicate frame state allowed; stale ignored. |
| signal accepted(zone_id: StringName, zone_generation: int, run_generation: int) | Level06GroundedDwellZone | HorizonConstellationController | zone_id | zone_generation + run_generation | One local zone acceptance. | accepted_once; stale ignored. |

## Appendix C - HorizonConstellationController

| Exact GDScript signature | Owner / emitter | Consumer / caller | ID parameter | Generation domain | Authority effect | Duplicate / stale behavior |
|---|---|---|---|---|---|---|
| validate_contract() -> Array[Dictionary] | HorizonConstellationController | Level06RuntimeContractValidator | contract IDs | none | Returns exact static/runtime compatibility failures; no arming. | Idempotent; facts-only. |
| prepare_run(run_generation: int) -> Array[Dictionary] | HorizonConstellationController | Level06RuntimeContractValidator | none | run_generation | Side-effect-free run preparation only. | Same generation idempotent; stale rejected; defect has no gameplay side effect. |
| commit_run(run_generation: int) -> void | HorizonConstellationController | Level06RuntimeContractValidator | none | run_generation | Infallibly publishes prepared state during atomic commit. | Exactly once; duplicate/stale ignored; cannot return false. |
| activate(run_generation: int) -> void | HorizonConstellationController | ProgressController | all constellation IDs | run_generation | Enables all three zones any-order. | Duplicate/stale ignored. |
| notify_zone_accepted(zone_id: StringName, zone_generation: int, run_generation: int) -> void | HorizonConstellationController | GroundedDwellZone | zone_id | zone_generation + run_generation | Adds exact unique zone; starts pulse at exact set equality. | Unique once; stale ignored. |
| notify_terminal_presentation_finished(presentation_generation: int, run_generation: int) -> void | HorizonConstellationController | Constellation presentation | none | presentation_generation + run_generation | Commits optional pulse terminal. | First callback/timeout wins. |
| is_complete() -> bool | HorizonConstellationController | Progress/diagnostics | none | run_generation | Read-only exact-set terminal. | Pure. |
| reset_for_reload(new_run_generation: int) -> void | HorizonConstellationController | Harness/reload boundary | zone IDs | new run_generation | Clear local sets/generations. | Boundary-only. |
| signal zone_accepted(zone_id: StringName, run_generation: int) | HorizonConstellationController | ProgressController / visuals | zone_id | run_generation | Canonical any-order progress. | Unique once; stale ignored. |
| signal logical_completed(puzzle_id: StringName, run_generation: int) | HorizonConstellationController | ProgressController | &"HORIZON_CONSTELLATION" | run_generation | Logical terminal after exact set. | One-shot. |
| signal presentation_completed(presentation_generation: int, fallback_used: bool, run_generation: int) | HorizonConstellationController | ProgressController | none | presentation_generation + run_generation | Terminal pulse completion only. | First terminal wins; stale ignored. |
| signal hint_requested(zone_ids: Array[StringName], hint_generation: int, run_generation: int) | HorizonConstellationController | Constellation presentation | zone_ids | hint_generation + run_generation | Owner-created presentation-only assistance request. | Late/duplicate hint generation ignored; no gameplay authority. |

## Appendix C - Level06ShardSlot

| Exact GDScript signature | Owner / emitter | Consumer / caller | ID parameter | Generation domain | Authority effect | Duplicate / stale behavior |
|---|---|---|---|---|---|---|
| validate_contract() -> Array[Dictionary] | Level06ShardSlot | Level06RuntimeContractValidator | contract IDs | none | Returns exact static/runtime compatibility failures; no arming. | Idempotent; facts-only. |
| prepare_run(run_generation: int) -> Array[Dictionary] | Level06ShardSlot | Level06RuntimeContractValidator | none | run_generation | Side-effect-free run preparation only. | Same generation idempotent; stale rejected; defect has no gameplay side effect. |
| commit_run(run_generation: int) -> void | Level06ShardSlot | Level06RuntimeContractValidator | none | run_generation | Infallibly publishes prepared state during atomic commit. | Exactly once; duplicate/stale ignored; cannot return false. |
| request_reveal(run_generation: int) -> int | Level06ShardSlot | ProgressController | serialized shard_id | run_generation -> creates slot_generation | Accepts PACKED_DISABLED -> REVEALING, creates and returns fresh slot_generation; rejected request returns -1. | Caller cannot assign generation; duplicate/stale run returns -1/no effect. |
| is_available() -> bool | Level06ShardSlot | Progress/RewardGate | shard_id | slot_generation + run_generation | Read-only availability. | Pure. |
| canonical_shard() -> Node | Level06ShardSlot | Validator/RewardGate | shard_id | run_generation | Returns exact packed SoulShard instance. | Stable node identity; null is defect. |
| reset_for_reload(new_run_generation: int) -> void | Level06ShardSlot | Harness/reload boundary | shard_id | new run_generation | Restore serialized packed-disabled state. | Boundary-only. |
| signal availability_started(shard_id: StringName, slot_generation: int, run_generation: int) | Level06ShardSlot | Progress/diagnostics | shard_id | slot_generation + run_generation | Reveal lifecycle evidence only. | One-shot per slot generation. |
| signal availability_completed(shard_id: StringName, shard: Node, slot_generation: int, run_generation: int) | Level06ShardSlot | ProgressController / RewardGate | shard_id | slot_generation + run_generation | Only availability authority after effective enable/re-evaluation. | First terminal wins; stale ignored. |
| signal reward_request_observed(shard: Node, shard_id: StringName, reward_text: String, world_position: Vector3, slot_generation: int, run_generation: int) | Level06ShardSlot | RewardGate | shard_id | slot_generation + run_generation | Forwards actual shared SoulShard request evidence only. | Duplicate handled by RewardGate; stale rejected. |
| signal shard_collected(shard_id: StringName, shard: Node, slot_generation: int, run_generation: int) | Level06ShardSlot | RewardGate | shard_id | slot_generation + run_generation | Re-emits actual SoulShard.collected identity evidence. | One-shot; stale ignored. |

## Appendix C - Level06RewardGateController

| Exact GDScript signature | Owner / emitter | Consumer / caller | ID parameter | Generation domain | Authority effect | Duplicate / stale behavior |
|---|---|---|---|---|---|---|
| validate_contract() -> Array[Dictionary] | Level06RewardGateController | Level06RuntimeContractValidator | contract IDs | none | Returns exact static/runtime compatibility failures; no arming. | Idempotent; facts-only. |
| prepare_run(run_generation: int) -> Array[Dictionary] | Level06RewardGateController | Level06RuntimeContractValidator | none | run_generation | Side-effect-free run preparation only. | Same generation idempotent; stale rejected; defect has no gameplay side effect. |
| commit_run(run_generation: int) -> void | Level06RewardGateController | Level06RuntimeContractValidator | none | run_generation | Infallibly publishes prepared state during atomic commit. | Exactly once; duplicate/stale ignored; cannot return false. |
| set_current_shard(shard_id: StringName, shard: Node, run_generation: int) -> bool | Level06RewardGateController | ProgressController | shard_id | run_generation | Sets the only admissible exact shard/node while no sequence active. | Same exact current idempotent; conflicting/stale rejected. |
| clear_current_shard(shard_id: StringName, run_generation: int) -> void | Level06RewardGateController | ProgressController / self after completion | shard_id | run_generation | Clears current admission only after matching lifecycle. | Wrong/stale ignored. |
| current_shard_id() -> StringName | Level06RewardGateController | Diagnostics / validator | none | run_generation | Read-only current ID. | Pure. |
| current_reward_generation() -> int | Level06RewardGateController | Diagnostics / tests | none | reward_generation | Read-only active generation or 0. | Pure. |
| is_sequence_active() -> bool | Level06RewardGateController | Diagnostics / Progress | none | reward_generation + run_generation | Read-only active admission latch. | Pure. |
| reset_for_reload(new_run_generation: int) -> void | Level06RewardGateController | Harness/reload boundary | shard IDs | new run_generation | Clear admission/generation before new bootstrap. | Boundary-only; cannot clear release failure in active run. |

## Appendix C - Level06RewardGateController proxy

| Exact GDScript signature | Owner / emitter | Consumer / caller | ID parameter | Generation domain | Authority effect | Duplicate / stale behavior |
|---|---|---|---|---|---|---|
| signal reward_sequence_requested(shard: Node, shard_id: StringName, reward_text: String, world_position: Vector3) | Level06RewardGateController proxy | Shared ShardRewardSequenceController | shard_id | internal reward_generation paired in gate state | Only admitted proxy request reaches shared controller. | One emission per active generation; non-current/stale blocked before emission. |

## Appendix C - Level06RewardGateController

| Exact GDScript signature | Owner / emitter | Consumer / caller | ID parameter | Generation domain | Authority effect | Duplicate / stale behavior |
|---|---|---|---|---|---|---|
| signal current_shard_changed(previous_id: StringName, current_id: StringName, run_generation: int) | Level06RewardGateController | Diagnostics / tests | previous_id,current_id | run_generation | Read-only current admission evidence. | Same value coalesced; stale none. |
| signal reward_gate_state_changed(previous_state: StringName, current_state: StringName, reward_generation: int, run_generation: int) | Level06RewardGateController | Diagnostics / tests | state IDs | reward_generation + run_generation | Authoritative local gate lifecycle evidence. | One per legal state transition. |
| signal reward_admitted(shard_id: StringName, shard: Node, reward_generation: int, run_generation: int) | Level06RewardGateController | ProgressController / diagnostics | shard_id | reward_generation + run_generation | Begins logical collection-active state after shard_reward key is set. | Duplicate same request ignored. |
| signal reward_rejected(shard_id: StringName, shard: Node, reason_code: StringName, reward_generation: int, run_generation: int) | Level06RewardGateController | Diagnostics | shard_id,reason_code | reward_generation + run_generation | No macro effect; prevents unsafe shared request. | Repeated diagnostic may coalesce; stale rejected. |
| signal reward_completed(shard_id: StringName, reward_generation: int, run_generation: int) | Level06RewardGateController | ProgressController | shard_id | reward_generation + run_generation | Only logical shard reward-complete authority after admitted actual collected. | One-shot; stale/duplicate ignored. |

## Appendix C - Level06EnvironmentController (attached to WorldRoot/EnvironmentPresentation)

| Exact GDScript signature | Owner / emitter | Consumer / caller | ID parameter | Generation domain | Authority effect | Duplicate / stale behavior |
|---|---|---|---|---|---|---|
| validate_contract() -> Array[Dictionary] | Level06EnvironmentController (attached to WorldRoot/EnvironmentPresentation) | Level06RuntimeContractValidator | contract IDs | none | Returns exact static/runtime compatibility failures; no arming. | Idempotent; facts-only. |
| prepare_run(run_generation: int) -> Array[Dictionary] | Level06EnvironmentController (attached to WorldRoot/EnvironmentPresentation) | Level06RuntimeContractValidator | none | run_generation | Side-effect-free run preparation only. | Same generation idempotent; stale rejected; defect has no gameplay side effect. |
| commit_run(run_generation: int) -> void | Level06EnvironmentController (attached to WorldRoot/EnvironmentPresentation) | Level06RuntimeContractValidator | none | run_generation | Infallibly publishes prepared state during atomic commit. | Exactly once; duplicate/stale ignored; cannot return false. |

## Appendix C - Level06EnvironmentController

| Exact GDScript signature | Owner / emitter | Consumer / caller | ID parameter | Generation domain | Authority effect | Duplicate / stale behavior |
|---|---|---|---|---|---|---|
| request_state(environment_id: StringName, run_generation: int) -> int | Level06EnvironmentController | ProgressController | environment_id | owner-created presentation_generation + run_generation | Accepts a monotonic nonblocking E-state request, creates and returns the owner-local presentation_generation; current-state repeat returns the current generation; rejected request returns -1. | Current repeat idempotent; skipped/decrement/stale request returns -1 and has no state effect. |
| current_state() -> StringName | Level06EnvironmentController | Progress/diagnostics | environment_id | run_generation | Read-only E0-E4 state. | Pure; before commit reports serialized E0 baseline without run authority. |
| reset_for_reload(new_run_generation: int) -> void | Level06EnvironmentController | Harness/reload boundary | E0_INITIAL | new run_generation | Return presentation FSM to serialized E0 and clear tweens/generations. | Boundary-only; no duplicate E0 animation. |
| signal state_started(environment_id: StringName, presentation_generation: int, run_generation: int) | Level06EnvironmentController | Diagnostics / local visuals | environment_id | presentation_generation + run_generation | Presentation lifecycle only. | One per accepted request; stale ignored. |
| signal state_presented(environment_id: StringName, presentation_generation: int, fallback_used: bool, run_generation: int) | Level06EnvironmentController | Diagnostics / Progress optional observer | environment_id | presentation_generation + run_generation | Nonblocking terminal evidence only. | First callback/timeout wins; stale ignored. |
| signal presentation_failed(environment_id: StringName, reason_code: StringName, presentation_generation: int, run_generation: int) | Level06EnvironmentController | Diagnostics | environment_id,reason_code | presentation_generation + run_generation | Optional local warning; gameplay unaffected. | One per failure cause/generation; stale ignored. |

## Appendix C - Level06ReleaseValidityController

| Exact GDScript signature | Owner / emitter | Consumer / caller | ID parameter | Generation domain | Authority effect | Duplicate / stale behavior |
|---|---|---|---|---|---|---|
| validate_contract() -> Array[Dictionary] | Level06ReleaseValidityController | Level06RuntimeContractValidator | contract IDs | none | Returns exact static/runtime compatibility failures; no arming. | Idempotent; facts-only. |
| prepare_run(run_generation: int) -> Array[Dictionary] | Level06ReleaseValidityController | Level06RuntimeContractValidator | none | run_generation | Side-effect-free run preparation only. | Same generation idempotent; stale rejected; defect has no gameplay side effect. |
| begin_run(run_generation: int) -> void | Level06ReleaseValidityController | Level06RuntimeContractValidator atomic commit manifest | none | run_generation | Sole infallible commit API for this owner; publishes the prepared run and initializes VALID inside the atomic commit. | Exactly once after the eligibility barrier; stale/duplicate ignored; no companion commit_run API. |
| state() -> StringName | Level06ReleaseValidityController | RewardGate / diagnostics | none | run_generation | Read-only VALID or NARRATIVE_PRESENTATION_FAILED. | Pure. |
| mark_narrative_presentation_failed(reason_code: StringName, shard_id: StringName, reward_generation: int, run_generation: int, details: Dictionary) -> void | Level06ReleaseValidityController | RewardGate | reason_code,shard_id | reward_generation + run_generation | Irreversibly latches release invalid before proxy emission. | First changes state; later current failures aggregate; stale rejected. |
| reset_for_reload(new_run_generation: int) -> void | Level06ReleaseValidityController | Harness/reload boundary | none | new run_generation | Clears old instance state only for a new bootstrap; does not heal active run. | Boundary-only. |
| signal release_validity_initialized(state: StringName, run_generation: int) | Level06ReleaseValidityController | Diagnostics / acceptance | state | run_generation | Post-begin_run evidence inside committed run. | Exactly once. |
| signal release_validity_failed(reason_code: StringName, shard_id: StringName, reward_generation: int, run_generation: int, details: Dictionary) | Level06ReleaseValidityController | Diagnostics / acceptance | reason_code,shard_id | reward_generation + run_generation | Hard release evidence; no macro transition. | Repeated current causes aggregate; stale ignored. |
| signal release_validity_changed(previous_state: StringName, current_state: StringName, run_generation: int) | Level06ReleaseValidityController | Diagnostics / acceptance | state IDs | run_generation | One irreversible VALID -> FAILED transition. | One-shot; no reversion. |

## Appendix C - Level06MainTextController

| Exact GDScript signature | Owner / emitter | Consumer / caller | ID parameter | Generation domain | Authority effect | Duplicate / stale behavior |
|---|---|---|---|---|---|---|
| validate_contract() -> Array[Dictionary] | Level06MainTextController | Level06RuntimeContractValidator | contract IDs | none | Returns exact static/runtime compatibility failures; no arming. | Idempotent; facts-only. |
| prepare_run(run_generation: int) -> Array[Dictionary] | Level06MainTextController | Level06RuntimeContractValidator | none | run_generation | Side-effect-free run preparation only. | Same generation idempotent; stale rejected; defect has no gameplay side effect. |
| commit_run(run_generation: int) -> void | Level06MainTextController | Level06RuntimeContractValidator | none | run_generation | Infallibly publishes prepared state during atomic commit. | Exactly once; duplicate/stale ignored; cannot return false. |
| arm(run_generation: int) -> bool | Level06MainTextController | ProgressController | FinalTextGate | run_generation | LOCKED_TRACKING -> ARMING; schedules next-physics occupancy check. | One-shot; duplicate/stale false/no effect. |
| state() -> StringName | Level06MainTextController | Progress/diagnostics | none | run_generation | Read-only local lifecycle. | Pure. |
| is_closed() -> bool | Level06MainTextController | Progress/diagnostics | none | run_generation | Read-only actual-close latch. | Pure. |
| failure_reason() -> StringName | Level06MainTextController | Diagnostics | reason_code | run_generation | Read-only current failure or empty. | Pure. |
| reset_for_reload(new_run_generation: int) -> void | Level06MainTextController | Harness/reload boundary | FinalTextGate | new run_generation | Clear occupancy/open/lock/failure state before new bootstrap. | Boundary-only; active production reset forbidden. |
| signal main_text_state_changed(previous_state: StringName, current_state: StringName, run_generation: int) | Level06MainTextController | Progress/diagnostics | state IDs | run_generation | Authoritative local lifecycle evidence. | One per legal transition. |
| signal main_text_started(run_generation: int) | Level06MainTextController | ProgressController / diagnostics | none | run_generation | Exact overlay returned true; controller owns main_text and Player lock. | One-shot; stale ignored. |
| signal main_text_closed(run_generation: int) | Level06MainTextController | ProgressController | none | run_generation | Only authority for macro EXIT_PHASE and portal request. | One-shot; duplicate close ignored. |
| signal main_text_failed(reason_code: StringName, run_generation: int, details: Dictionary) | Level06MainTextController | ProgressController / diagnostics | reason_code | run_generation | Mandatory fail-closed; portal remains inactive. | One-shot; stale ignored. |

## Appendix C - Level06PortalAdapter

| Exact GDScript signature | Owner / emitter | Consumer / caller | ID parameter | Generation domain | Authority effect | Duplicate / stale behavior |
|---|---|---|---|---|---|---|
| validate_contract() -> Array[Dictionary] | Level06PortalAdapter | Level06RuntimeContractValidator | contract IDs | none | Returns exact static/runtime compatibility failures; no arming. | Idempotent; facts-only. |
| prepare_run(run_generation: int) -> Array[Dictionary] | Level06PortalAdapter | Level06RuntimeContractValidator | none | run_generation | Side-effect-free run preparation only. | Same generation idempotent; stale rejected; defect has no gameplay side effect. |
| commit_run(run_generation: int) -> void | Level06PortalAdapter | Level06RuntimeContractValidator | none | run_generation | Infallibly publishes prepared state during atomic commit. | Exactly once; duplicate/stale ignored; cannot return false. |
| request_activation(run_generation: int) -> bool | Level06PortalAdapter | ProgressController | none | run_generation | DORMANT -> ACTIVATING; connects actual signals then calls activate once. | Duplicate/stale false/no effect. |
| current_attempt_state() -> StringName | Level06PortalAdapter | Progress/diagnostics | none | run_generation | Read-only DORMANT/ACTIVATING/EXIT_ACTIVE/TRANSITION_IN_FLIGHT. | Pure. |
| current_attempt_generation() -> int | Level06PortalAdapter | Progress/diagnostics/recorder | none | portal_attempt_generation | Read-only current attempt generation or 0. | Pure. |
| reset_for_reload(new_run_generation: int) -> void | Level06PortalAdapter | Harness/reload boundary | none | new run_generation | Clear adapter state before new bootstrap. | Boundary-only; cannot reset shared portal mid-run. |
| signal portal_attempt_state_changed(previous_state: StringName, current_state: StringName, portal_attempt_generation: int, run_generation: int) | Level06PortalAdapter | Progress / Recovery / diagnostics | state IDs | portal_attempt_generation + run_generation | Authoritative retryable attempt-state evidence outside macro ordinal. | One per actual legal transition; stale ignored. |

## Appendix C - Level06PortalAdapter from actual shared signal

| Exact GDScript signature | Owner / emitter | Consumer / caller | ID parameter | Generation domain | Authority effect | Duplicate / stale behavior |
|---|---|---|---|---|---|---|
| signal portal_activation_started(run_generation: int) | Level06PortalAdapter from actual shared signal | Progress / diagnostics | none | run_generation | Actual activation evidence only. | One current observation; stale ignored. |
| signal portal_activation_completed(run_generation: int) | Level06PortalAdapter from actual shared signal | Progress / Recovery | none | run_generation | Attempt -> EXIT_ACTIVE; RA13 authority. | One-shot; stale ignored. |

## Appendix C - Level06PortalAdapter from actual LevelPortal.transition_started

| Exact GDScript signature | Owner / emitter | Consumer / caller | ID parameter | Generation domain | Authority effect | Duplicate / stale behavior |
|---|---|---|---|---|---|---|
| signal portal_transition_started(portal_attempt_generation: int, run_generation: int) | Level06PortalAdapter from actual LevelPortal.transition_started | Progress / Recovery / diagnostics | none | portal_attempt_generation + run_generation | Attempt -> TRANSITION_IN_FLIGHT; source sampling invalidated; last required source-scene evidence. The adapter adds only attempt/run correlation. | One per attempt; duplicate/stale ignored. |

## Appendix C - Level06PortalAdapter from actual LevelPortal.transition_failed

| Exact GDScript signature | Owner / emitter | Consumer / caller | ID parameter | Generation domain | Authority effect | Duplicate / stale behavior |
|---|---|---|---|---|---|---|
| signal portal_transition_failed(player: Node, error_code: int, portal_attempt_generation: int, run_generation: int) | Level06PortalAdapter from actual LevelPortal.transition_failed | Progress / Recovery / diagnostics | player,error_code | portal_attempt_generation + run_generation | Matching attempt -> EXIT_ACTIVE; permits retry without activate. | Only matching in-flight attempt accepted; old failure ignored. |

## Appendix C - Level06PortalAdapter from actual LevelPortal.transition_completed

| Exact GDScript signature | Owner / emitter | Consumer / caller | ID parameter | Generation domain | Authority effect | Duplicate / stale behavior |
|---|---|---|---|---|---|---|
| signal portal_transition_completed_observed(portal_attempt_generation: int, run_generation: int) | Level06PortalAdapter from actual LevelPortal.transition_completed | Diagnostics only | none | portal_attempt_generation + run_generation | Optional observation; no authority. | Stale/duplicate/source-absent ignored. |

## Appendix C - Level06PortalAdapter

| Exact GDScript signature | Owner / emitter | Consumer / caller | ID parameter | Generation domain | Authority effect | Duplicate / stale behavior |
|---|---|---|---|---|---|---|
| signal diagnostic_watchdog_expired(phase: StringName, portal_attempt_generation: int, run_generation: int) | Level06PortalAdapter | Diagnostics | phase | portal_attempt_generation + run_generation | Diagnostic only. | No state or scene-load effect. |

## Appendix C - Level06RecoveryController

| Exact GDScript signature | Owner / emitter | Consumer / caller | ID parameter | Generation domain | Authority effect | Duplicate / stale behavior |
|---|---|---|---|---|---|---|
| validate_contract() -> Array[Dictionary] | Level06RecoveryController | Level06RuntimeContractValidator | contract IDs | none | Returns exact static/runtime compatibility failures; no arming. | Idempotent; facts-only. |
| prepare_run(run_generation: int) -> Array[Dictionary] | Level06RecoveryController | Level06RuntimeContractValidator | none | run_generation | Side-effect-free run preparation only. | Same generation idempotent; stale rejected; defect has no gameplay side effect. |
| begin_run(run_generation: int) -> void | Level06RecoveryController | Level06RuntimeContractValidator atomic commit manifest | none | run_generation | Sole infallible commit API; publishes recovery authority and connects prevalidated exact Area3D body_entered/body_exited callbacks once. | Exactly once after the eligibility barrier; stale/duplicate ignored; no companion commit_run API. |
| register_anchor(anchor_id: StringName, run_generation: int) -> bool | Level06RecoveryController | ProgressController | anchor_id | run_generation | Advances latest valid anchor only when exact canonical macro evidence permits. | Same/older idempotent false; future/stale rejected. |
| set_shard_reward_suspended(suspended: bool, reward_generation: int, run_generation: int) -> void | Level06RecoveryController | RewardGate only by static wiring/call-site contract | &"shard_reward" | reward_generation + run_generation | Writer-specific mutation of shard_reward; last-key removal schedules next-physics re-evaluation. | Idempotent; stale reward/run ignored. |
| set_main_text_suspended(suspended: bool, run_generation: int) -> void | Level06RecoveryController | MainTextController only by static wiring/call-site contract | &"main_text" | run_generation | Writer-specific mutation of main_text; last-key removal schedules re-evaluation. | Idempotent; stale run ignored. |
| begin_exit_source_sampling(run_generation: int) -> int | Level06RecoveryController | ProgressController after actual main_text_closed | none | run_generation -> creates source_generation | Creates first source generation and calls LastLightSource.begin_sampling. | One active generation; duplicate returns current/no rotation. |
| stop_for_portal_transition(portal_attempt_generation: int, run_generation: int) -> void | Level06RecoveryController | PortalAdapter on actual transition_started | none | portal_attempt_generation + source_generation + run_generation | Stops/invalidate source only for matching in-flight portal attempt; clears transition-owned provenance/token. | Same call idempotent; stale/mismatched attempt ignored. |
| restart_after_portal_failure(failed_attempt_generation: int, run_generation: int) -> int | Level06RecoveryController | PortalAdapter on matching actual transition_failed | none | failed portal_attempt_generation + run_generation -> creates source_generation | Creates/returns fresh source generation only for matching failed in-flight attempt while EXIT_PHASE remains eligible; rejected returns -1. | Duplicate returns current/no rotation; stale attempt returns -1. |
| stop_for_recovery(event_token: int, run_generation: int) -> void | Level06RecoveryController | RecoveryController internal commit path | event_token | event_token + source_generation + run_generation | Stops/invalidate sampling only for matching current recovery token before teleport. | Same token idempotent; wrong/completed/stale token ignored. |
| restart_after_recovery_rearm(event_token: int, run_generation: int) -> int | Level06RecoveryController | RecoveryController rearm path after safety-footprint exit | event_token | completed event_token + run_generation -> creates source_generation | Creates/returns fresh source only for matching completed token while EXIT_PHASE remains eligible; rejected returns -1. | Exactly once per token; portal failure/other token cannot rotate. |
| accept_grounded_support_observation(support_class: StringName, world_position: Vector3, local_floor_y: float, source_generation: int, run_generation: int) -> void | Level06RecoveryController | LastLightSource | support_class | source_generation + run_generation | Authoritatively updates provenance/epoch after validation. | Duplicate sample may coalesce; stale/unknown ignored. |
| accept_motion_sample_observation(previous_position: Vector3, current_position: Vector3, velocity: Vector3, grounded: bool, source_generation: int, run_generation: int) -> void | Level06RecoveryController | LastLightSource | none | source_generation + run_generation | Updates validated raw motion context only; may arm an existing candidate. | Duplicate frame/stale ignored. |
| accept_signed_boundary_crossing_observation(previous_position: Vector3, current_position: Vector3, previous_signed_distance: float, current_signed_distance: float, ribbon_segment_id: StringName, source_generation: int, run_generation: int) -> void | Level06RecoveryController | LastLightSource | ribbon_segment_id | source_generation + run_generation | Only authority that may create SOURCE_CANDIDATE/token after provenance check. | One token/departure; duplicate crossing/stale ignored. |
| accept_grounded_safe_return_observation(support_class: StringName, world_position: Vector3, source_generation: int, run_generation: int) -> void | Level06RecoveryController | LastLightSource | support_class | source_generation + run_generation | Cancels current candidate/pending and creates fresh origin epoch when legal. | Duplicate safe sample coalesced; stale ignored. |
| _on_global_fall_body_entered(body: Node3D) -> void | Level06RecoveryController | RV_FALL_GLOBAL.body_entered | RV_FALL_GLOBAL | current run_generation | Filter exact canonical Player; create/join internal global-fall observation and one event_token. | Non-Player ignored; repeated entry reuses token; pre-commit/inert ignored. |
| _on_global_fall_body_exited(body: Node3D) -> void | Level06RecoveryController | RV_FALL_GLOBAL.body_exited | RV_FALL_GLOBAL | current run_generation | Update internal overlap evidence only for exact canonical Player; never cancels valid pending recovery by itself. | Non-Player/duplicate/inert ignored. |
| _on_last_light_catcher_body_entered(body: Node3D) -> void | Level06RecoveryController | RV_LAST_LIGHT_DROP_CATCHER.body_entered | RV_LAST_LIGHT_DROP_CATCHER | current source_generation + run_generation | Filter canonical Player, sample current velocity/legality internally and promote matching ARMED token to PENDING when valid. | Non-Player, stale source, duplicate or non-ARMED ignored. |
| _on_last_light_catcher_body_exited(body: Node3D) -> void | Level06RecoveryController | RV_LAST_LIGHT_DROP_CATCHER.body_exited | RV_LAST_LIGHT_DROP_CATCHER | current source_generation + run_generation | Update internal catcher-overlap evidence only for canonical Player. | Non-Player/duplicate/stale ignored; no second token. |
| reset_for_reload(new_run_generation: int) -> void | Level06RecoveryController | Harness/reload boundary | all recovery IDs | new run_generation | Clear authority before a new bootstrap only. | Boundary-only; invalidates old source generations. |
| signal source_generation_changed(previous_generation: int, current_generation: int, reason_code: StringName, run_generation: int) | Level06RecoveryController | LastLightSource / diagnostics | reason_code | source_generation + run_generation | Authoritative sampling-attempt creation/invalidation evidence. | One per rotation; stale none. |
| signal suspension_sources_changed(active_sources: Array[StringName], run_generation: int) | Level06RecoveryController | Diagnostics / harness | source keys | run_generation | Read-only final suspension-set evidence. | Same set coalesced; stale none. |
| signal recovery_pending(event_token: int, anchor_id: StringName, source_generation: int, run_generation: int) | Level06RecoveryController | Diagnostics / harness | event_token,anchor_id | source_generation + run_generation | One pending recovery retained under suspension. | Duplicate sources reuse token. |
| signal recovery_committed(event_token: int, anchor_id: StringName, run_generation: int) | Level06RecoveryController | Diagnostics / Player integration | event_token,anchor_id | run_generation | Authoritative one-time teleport commit after source invalidation. | One-shot; stale/duplicate ignored. |
| signal recovery_completed(event_token: int, anchor_id: StringName, run_generation: int) | Level06RecoveryController | Diagnostics / rearm logic | event_token,anchor_id | run_generation | Recovery finished and enters REARM_WAIT. | One-shot; stale ignored. |

## Appendix C - Level06LastLightSource

| Exact GDScript signature | Owner / emitter | Consumer / caller | ID parameter | Generation domain | Authority effect | Duplicate / stale behavior |
|---|---|---|---|---|---|---|
| validate_contract() -> Array[Dictionary] | Level06LastLightSource | Level06RuntimeContractValidator | contract IDs | none | Returns exact static/runtime compatibility failures; no arming. | Idempotent; facts-only. |
| prepare_run(run_generation: int) -> Array[Dictionary] | Level06LastLightSource | Level06RuntimeContractValidator | none | run_generation | Side-effect-free run preparation only. | Same generation idempotent; stale rejected; defect has no gameplay side effect. |
| commit_run(run_generation: int) -> void | Level06LastLightSource | Level06RuntimeContractValidator | none | run_generation | Infallibly publishes prepared state during atomic commit. | Exactly once; duplicate/stale ignored; cannot return false. |
| begin_sampling(run_generation: int, source_generation: int) -> void | Level06LastLightSource | RecoveryController only | none | run_generation + source_generation | Starts raw physics sampling for exactly the supplied attempt. | Same pair idempotent; older pair rejected. |
| stop_sampling(source_generation: int) -> void | Level06LastLightSource | RecoveryController only | none | source_generation | Stops only matching active attempt and clears transient samples. | Mismatched/stale ignored. |
| is_sampling() -> bool | Level06LastLightSource | Recovery / diagnostics | none | source_generation | Read-only sampling flag. | Pure. |
| physics_sample_player(delta: float, run_generation: int, source_generation: int) -> void | Level06LastLightSource | Physics process | none | run_generation + source_generation | Uses exact FloorProbe/ancestry and emits raw typed samples only. | At most once/physics frame; stale pair ignored. |
| reset_for_reload(new_run_generation: int) -> void | Level06LastLightSource | Harness/reload boundary | none | new run_generation | Stops sampling and clears raw previous sample. | Boundary-only. |
| signal grounded_support_observed(support_class: StringName, world_position: Vector3, local_floor_y: float, source_generation: int, run_generation: int) | Level06LastLightSource | RecoveryController | support_class | source_generation + run_generation | Raw support evidence only. | Recovery rejects stale/unknown; source has no authority. |
| signal motion_sample_observed(previous_position: Vector3, current_position: Vector3, velocity: Vector3, grounded: bool, source_generation: int, run_generation: int) | Level06LastLightSource | RecoveryController | none | source_generation + run_generation | Raw motion evidence only. | Recovery rejects duplicate/stale frame. |
| signal signed_boundary_crossing_observed(previous_position: Vector3, current_position: Vector3, previous_signed_distance: float, current_signed_distance: float, ribbon_segment_id: StringName, source_generation: int, run_generation: int) | Level06LastLightSource | RecoveryController | ribbon_segment_id | source_generation + run_generation | Raw signed-crossing candidate only. | Recovery owns one-token deduplication; stale ignored. |
| signal grounded_safe_return_observed(support_class: StringName, world_position: Vector3, source_generation: int, run_generation: int) | Level06LastLightSource | RecoveryController | support_class | source_generation + run_generation | Raw safe-return candidate only. | Stale ignored; Recovery interprets. |

## Appendix C - PortalLifecycleRecorder (test only)

| Exact GDScript signature | Owner / emitter | Consumer / caller | ID parameter | Generation domain | Authority effect | Duplicate / stale behavior |
|---|---|---|---|---|---|---|
| attach(portal: Node, scene_transition: Node, expected_scene_path: String) -> Array[Dictionary] | PortalLifecycleRecorder (test only) | PortalTransitionIntegrationHarness | expected_scene_path | none | Validates references before capture; no production effect. | Idempotent before capture; defects abort test only. |
| begin_capture() -> int | PortalLifecycleRecorder (test only) | PortalTransitionIntegrationHarness | none | creates capture_generation | Creates/returns a fresh nonzero capture_generation and connects observation while temporary SceneTree.root child. | One active capture; duplicate begin returns -1/no replacement. |
| finish_capture(capture_generation: int) -> Dictionary | PortalLifecycleRecorder (test only) | PortalTransitionIntegrationHarness | none | capture_generation | Returns ordered evidence after destination/current-scene proof. | Exactly once for matching recorder-created capture; stale returns empty/no authority. |
| dispose(capture_generation: int) -> void | PortalLifecycleRecorder (test only) | PortalTransitionIntegrationHarness | none | capture_generation | Disconnects and queue_frees only the matching completed/aborted capture recorder. | Matching call idempotent; stale value cannot dispose current capture. |
| signal evidence_captured(report: Dictionary, capture_generation: int) | PortalLifecycleRecorder (test only) | PortalTransitionIntegrationHarness | report event IDs | capture_generation | Test evidence only; no production authority. | One-shot for matching current capture; stale ignored. |

## Appendix C - Level06IntegratedFlowHarness (test only; Slices 6-8 temporary)

| Exact GDScript signature / fixture contract | Owner / emitter | Consumer / caller | ID parameter | Generation domain | Authority effect | Duplicate / stale behavior |
|---|---|---|---|---|---|---|
| `configure_for_slice(owner_slice: int, terminal_state: StringName) -> Array[Dictionary]` | Level06IntegratedFlowHarness | Owning Slice 6/7/8 runner | owner_slice 6, 7 or 8; exact terminal state | none | Validates that only controllers available through the owning slice plus real shared READ ONLY scenes/scripts are instantiated. No production effect. | One configuration before prepare; duplicate/different configuration aborts the test fixture. |
| `prepare_integrated_run() -> Array[Dictionary]` | Level06IntegratedFlowHarness | Owning temporary runner | canonical IDs from production contract | validation_generation reservation through production validator API | Calls the exact production prepare sequence and explicit RewardGate proxy registration checks; does not arm gameplay. | Duplicate prepare is rejected; stale validation evidence cannot commit. |
| `commit_integrated_run() -> int` | Level06IntegratedFlowHarness | Owning temporary runner | none | creates/returns production run_generation through exact commit contract | Executes only the same infallible owner-specific production commit manifest used by final wiring. No staged production mode. | Exactly one matching commit after successful prepare; duplicate returns invalid/no authority. |
| `drive_actual_flow(owner_slice: int, run_generation: int) -> Dictionary` | Level06IntegratedFlowHarness | Owning temporary runner | canonical puzzle/shard IDs | run_generation plus owner-created local generations | Moves/inputs the real Player through real target overlaps and actual shared SoulShard/reward flow. It observes admitted actual `SoulShard.collected`; it never emits collected, reward success, main-text close or portal success. | One ordered evidence record per actual event; duplicate/stale events are handled only by production owners. |
| `dispose_fixture() -> void` | Level06IntegratedFlowHarness | Owning temporary runner | none | none | Frees temporary nodes only. The scene/script/UID files are deleted before commit. | Idempotent after completed/aborted test; cannot mutate production files. |
| evidence label `TEMPORARY INTEGRATED-FLOW PASS` | Owning temporary runner | Slice handoff | owner slice and exact terminal state | current run_generation | Test evidence only; never proves production `Level_06.tscn` wiring. | Cannot convert `DEFERRED TO G12 PRODUCTION WIRING`; only Slice 12 production evidence can do so. |

# Appendix D. Greybox Reference Producer checklist

| Review domain | Greybox v1.2.1 acceptance question |
|---|---|
| Five-source hierarchy | Does Section 2 list Narrative v1.1, Visual Master, Gameplay v1.3, Technical Architecture v1.2.2 and Art Production Bible v1.1 as formal authorities, followed by factual repository/PR authority and lower-priority AGENTS/legacy context? |
| Conflict rules | Are exact copy/emotional meaning/FinalScene, exact gameplay/recovery/pacing, technical ownership/NodePaths/APIs/generations/state models and primitive/collision/art separation assigned to the correct source? |
| External reference delivery | Are all seven v1.2.1 packet artifacts supplied to Codex, hash-recorded in Slice 0, READ ONLY and excluded from runtime-slice creation/commit authority? |
| Slice 0 boundary | Is Slice 0 inspection-only with zero diff, no branch/commit/PR/UID/import/generated output, exact metadata authority, static PASS/BLOCKER/NOT VERIFIED plus runtime-only DEFERRED/actual PASS/FAIL classification and mutually exclusive final handoff line? |
| Post-APPLY flow | Does Slice 1 create `feature/implement-level-06-greybox` from the exact approved base only after APPLY and verify branch/HEAD before writes? |
| Per-slice scope completeness | Does each Slice 0-13 contain literal CREATE, MODIFY, READ ONLY, TEMPORARY, outside-worktree artifact, matching UID and FORBIDDEN authority covering every path/artifact mentioned by that slice? |
| Scope consistency | Does every slice stop before writes when a named dependency is absent from scope, changed files exceed write scope, READ ONLY integrity fails or temporary/generated residue remains? |
| UID policy | Is a persistent `.gd.uid` allowed only with an exact sibling `.gd` explicitly in CREATE/MODIFY, a temporary `.gd.uid` only when both exact sibling paths are explicitly in TEMPORARY scope, all temporary scripts/sidecars removed before commit, and every unrelated/out-of-scope UID/scene UID/import/cache artifact forbidden? |
| Hard stops | Do shared prerequisite, active-PR/base conflict, scope inconsistency, P0 failure, mandatory static NOT VERIFIED and unresolved owner-gate DEFERRED conditions stop the correct phase? |
| Slices 6-8 integrated flow | Do Slices 6-8 use only the exact temporary `Level06IntegratedFlowHarness` paths, real local/shared components, production prepare/commit/proxy registration and actual SoulShard/reward flow, with no synthetic authority or production test branch, and remove every fixture/sidecar before commit? |
| Evidence split | Are local/temporary PASS and production `DEFERRED TO G12 PRODUCTION WIRING` reported separately, with the latter explicitly not PASS and not a blocker between Slices 6-8 after the owning temporary gate passes? |
| G12 production closure | Does Slice 12 prove all three reward transitions, E3 -> FinalTextGate and actual main-text close -> E4/portal activation in fully assembled production `Level_06.tscn` without a harness-only bypass? |
| Core contracts | Are exact copy, P00-P30/Z00-Z11, targets, B0-B5/Q0-Q5, RA0-RA13, root tree, NodePaths, atomic bootstrap, generations, reward/release, environment, main text, portal and recovery preserved? |
| Matrices | Are ST/UT/P0/P1/no-softlock matrices complete and internally consistent, including ST-20 scope closure? |
| Final summaries | Is the Markdown summary created inside the worktree and committed, the content-equivalent DOCX created outside the worktree and not committed, with explicit temporary-versus-production evidence fields and truthful PASS/FAIL/NOT VERIFIED status? |
| Truthful DoD | Does any mandatory FAIL, NOT VERIFIED or unresolved `DEFERRED TO OWNER P0` block final acceptance, with no inferred or synthetic PASS? |
| Documentation QA | Are MD/DOCX semantic content equivalent, comments/tracked changes absent and every rendered DOCX page free of blank pages, clipping, overlap, broken rows and missing glyphs? |

# Appendix E. Greybox v1.2.1 source traceability

| Greybox domain | Primary approved source / factual authority | Greybox v1.2.1 resolution |
|---|---|---|
| Exact title, Shard_13/14/15 copy, main text, emotional meaning and FinalScene boundary | Level_06 Narrative and Level Scenario Package v1.1 | Preserved character-for-character; exactly three shards in fixed narrative order; confession/acrostic remain outside Level_06. |
| High silver meadow, ascending crescent, Clear Veils primary and E0-E4 visual intent | Level_06 Visual Master Concept Package | Preserved as primitive composition/readability intent without granting final art or runtime ownership changes. |
| P00-P30, Z00-Z11, target volumes, B0-B5, Q0-Q5, recovery volumes, RA0-RA13 and pacing | Level_06 Gameplay Map and Complete Level Design Specification v1.3 | Exact geometry, deterministic mechanics, recovery semantics and pacing remain canonical. |
| Root ownership, exact NodePaths, APIs/signals, atomic bootstrap, owner-created generations and state models | Level_06 Technical Architecture and State Model v1.2.2 | Preserved as the normative runtime integration contract, including actual collected authority, irreversible release validity, one environment owner, fail-closed text, shared portal loading and RecoveryController authority. |
| Primitive-only GB-P0 and post-greybox separation | Level_06 Art Production Bible v1.1 | Greybox remains primitives only: no Blender, GLB, final materials or art wrappers. Authoritative collision remains in `WorldRoot/LevelGeometry`. Exact corridor is 6.00 m route + 1.50 m shoulder + 1.50 m shoulder; physical lip is 0.75 m high x 0.55 m thick; dangerous B0-B5 crossing freedom is preserved; no invisible catch floor is introduced. Visual replacement and collision replacement are deferred, independent gates with independent rollback. |
| Existing shared APIs, current Level_06 placeholder, SceneTransition chain and exact head/tree facts | Current repository `main` | Factual integration authority only. Placeholder drift cannot redesign approved Level_06; incompatible facts produce a prerequisite or base decision. |
| Active intersections and stacked-base decision | Active PR list, PR base/head/status, changed-file lists and diffs | Slice 0 inspects metadata/diffs read-only and records an exact base. Any unresolved intersection is a hard stop. |
| Narrow slices, no unrelated changes, handoff discipline | `AGENTS.md` workflow rules | Retained where compatible; stale 15-level creative canon remains lower priority than approved six-chapter sources. |

