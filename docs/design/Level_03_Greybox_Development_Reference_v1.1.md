# Level_03 Greybox Development Reference

**FIFTEEN SHARDS OF LIGHT - Level_03 «После наших разговоров»**

**Reference version 1.1**

Максимально подробный technical implementation reference для безопасной поэтапной реализации полностью проходимого primitive-only greybox в Godot 4.x + GDScript.

| Поле | Зафиксированное значение |
| --- | --- |
| Репозиторий | `MindDevastation/fifteen-shards-of-light` |
| Reference version | `1.1` |
| Целевой repository Markdown | `docs/design/Level_03_Greybox_Development_Reference_v1.1.md` |
| Целевой Producer DOCX | `Level_03_Greybox_Development_Reference_v1.1.docx` |
| Статус | Documentation-only development authority; runtime implementation в текущей задаче запрещена |
| Дата repository inspection | 25 June 2026 |
| Current main SHA | `afd2355b186514f17652aedbb3194bddae21834d` |
| Active PR stack | Открытых PR: `0` на момент inspection |
| Целевой runtime | Godot 4.6 / GDScript / Forward Plus / Jolt Physics |
| Целевой результат | Полностью проходимый Level_03 greybox из primitives и placeholder visuals |
| Рекомендуемая runtime-ветка | `feature/level-03-after-our-conversations-greybox` |
| Рекомендуемый runtime PR | `Build Level 03 After Our Conversations greybox` |


## Version 1.1 Change Log

| ID | Version 1.1 correction |
| --- | --- |
| V11-01 | Corrected the environment scene hierarchy: `Level03EnvironmentState.tscn` is instantiated as the top-level node named `EnvironmentStateRoot`; the controller script is attached to that root and there is no intermediate environment-state child. |
| V11-02 | Corrected recovery semantics to set only `Player.velocity = Vector3.ZERO`; any additional transient movement cleanup requires a proven public Player API, otherwise Slice 2 stops for a narrow shared prerequisite. |
| V11-03 | Removed the unused Player reference from `Level03PortalAdapter`; shared `LevelPortal` remains the exclusive owner of Player overlap filtering, InteractionArea, AUTO_ENTER, transition latching and scene loading. |
| V11-04 | Locked finale arming to one delivery path: Progress emits `all_rewards_completed()` exactly once, and FinaleController receives that signal and runs its own `arm_finale()` logic. Progress never calls `arm_finale()` directly. |
| V11-05 | Corrected final static acceptance to `ST-01 through ST-19`; ST-18 validates matching approved `.gd.uid` files and ST-19 validates that no temporary harness remains in the repository. |
| V11-06 | Clarified vertical placement authority: spawn and RA0-RA6 Player runtime root Y values are evidence-derived in Slice 2, then frozen and recorded in the implementation summary; approved X/Z, floor surfaces, framing and clearances remain unchanged. |
| V11-07 | Added Section 22 heading, clarified that the final user DOCX summary is generated outside the runtime worktree unless explicitly requested in the PR, and synchronized startup/property contracts. |
| V11-08 | Revalidated that Slice 0 remains zero-diff inspection-only and ends in `WAITING FOR APPLY`; runtime implementation remains unauthorized by this document revision. |


## Version 1.0 Change Log (baseline preserved)

| ID | Version 1.0 content |
| --- | --- |
| V10-01 | Создан первый единый Greybox Development Reference на основе пяти утвержденных Level_03 source documents и свежего repository inspection. |
| V10-02 | Legacy Level_03 placeholder зафиксирован как superseded implementation drift, а не gameplay canon. |
| V10-03 | Зафиксирована continuous asymmetrical S-route, linear macro order Shard_05 -> Shard_06 -> Shard_07 и any-order локальная свобода только внутри Breathing Meadow. |
| V10-04 | Зафиксированы exact coordinates, route/camera/boundary clearances, RA0-RA6, canonical IDs и точные русские тексты без нормализации `ё`. |
| V10-05 | Зафиксированы current-main shared APIs: Player, Camera, SoulShard, reward lifecycle, LevelFinaleOverlay, LevelPortal, SceneTransition и Level_04 target. |
| V10-06 | Декомпозиция адаптирована к сложности Level_03: Slice 0-11, с отдельными risky slices для recovery, shard availability, трех puzzle systems, environment, finale и portal. |
| V10-07 | Установлен execution contract: только Slice 0 ждет explicit APPLY; после APPLY Slices 1-11 идут автоматически при PASS внутренних gates. |
| V10-08 | Разрешены только matching `scripts/levels/level_03/*.gd.uid`; unrelated UID/import churn запрещен. |
| V10-09 | Temporary harnesses разрешены только вне worktree или должны быть удалены до commit. |
| V10-10 | Final handoff обязан создать content-equivalent summary pair: repository Markdown + user-facing DOCX. |


## 1. Назначение и execution contract

Этот документ является единым implementation authority для Producer, Codex task generator, implementation agent и technical reviewer. Он не является разрешением на runtime work в текущей задаче. Его задача - сделать будущую реализацию детерминированной, малорисковой и проверяемой.

- Slice 0 всегда inspection-only: AGENTS, current main, active PRs, shared APIs, current Level_03, target Level_04, exact base decision, zero diff и `WAITING FOR APPLY`.
- Только после explicit user `APPLY` создается отдельная runtime branch и начинается Slice 1.
- После APPLY выполняется ровно один slice за раз: implement -> validate -> commit -> internal gate.
- При PASS внутреннего gate следующий slice начинается автоматически, без отдельного пользовательского подтверждения.
- Runtime progression останавливается только при documented hard-stop condition.
- Каждый slice должен оставлять предыдущий accepted slice рабочим и independently revertible.
- Нельзя скрывать NOT VERIFIED evidence формулировкой PASS.
- Финальная implementation summary должна быть factual, content-equivalent в Markdown и DOCX и отделена от этого design reference.

## 2. Approved source hierarchy and conflict resolution

| Priority | Approved source | Authority in this reference |
| --- | --- | --- |
| 1 | `Level_03_Narrative_and_Level_Scenario_Package.docx` | Meaning, emotional safety, chapter purpose, exact shard/main texts, narrative order and forbidden emotional readings. |
| 2 | `Level_03_Visual_Master_Concept_Package_v1.1.docx` | Continuous S-route visual language, landmark hierarchy, initial-world reading, puzzle silhouette language and forbidden shrine/arena/mascot directions. |
| 3 | `Level_03_Gameplay_Map_and_Level_Design_Spec_v1.1.docx` | Exact coordinates, dimensions, timings, deterministic puzzle rules, recovery policy, pacing, portal target and acceptance behavior. |
| 4 | `Level_03_Technical_Architecture_and_State_Model_v1.1.docx` | Ownership, root tree, NodePaths, controllers, signals, state machines, race guards, shared API boundaries and stop conditions. |
| 5 | `Level_03_Art_Production_Bible_v1.1.docx` | Greybox-consumable boundary map, layer ownership, proxy dimensions, collision authority, pivot/marker ownership, immediate/deferred production split and art-swap gates. |
| Repository current main | Fresh inspection at Slice 0 | Determines actual integration method and shared API availability. It may expose blockers but may not silently override approved design. |


> **Supersession:** `Level_03_Art_Production_Bible.docx` без версии является более ранней ревизией и не используется как authority там, где `Level_03_Art_Production_Bible_v1.1.docx` содержит исправленный contract.

Conflict rule: Narrative controls meaning and exact copy. Visual Master controls art direction and reading. Gameplay Spec controls exact geometry and rules. Technical Architecture controls runtime ownership and contracts. Art Bible v1.1 controls greybox-consumable layer/collision/pivot boundaries. Current main controls only the factual reusable API surface.

## 3. Emotional safety and source-of-truth summary

- Героиня не сломана и не нуждается в исправлении. Ее свет уже принадлежит ей.
- Изменения среды показывают, что автор яснее замечает и переживает собственные чувства, а не то, что игрок оживляет или исцеляет героиню.
- Уровень не требует ответа, благодарности или эмоциональной обязанности.
- Level_03 рассказывает одну конкретную историю: после разговоров автор помнит интонацию, радуется внезапному смеху и сам становится менее серьезным.
- Макро-путь линейный: Wind Trace -> Shard_05 -> Playful Spark -> Shard_06 -> Breathing Meadow -> Shard_07 -> main text -> portal.
- Breathing Meadow допускает локальный any-order для трех равнозначных petals; это не меняет narrative order.
- Мир жив и окрашен уже в E0. Он не должен читаться серым, мертвым, выключенным или ожидающим спасения.
- Final Overlook Landmark виден с начала как navigation silhouette. Shared Portal остается dormant до закрытия main text.

## 4. Current repository preflight snapshot

| Item | Verified current-main fact | Implementation consequence |
| --- | --- | --- |
| Default branch / SHA | `main` / `afd2355b186514f17652aedbb3194bddae21834d` | Future Slice 0 must re-resolve this value; this document records only the current docs-stage snapshot. |
| Open PR query | No open PRs returned | There is no current stack conflict, but Slice 0 must repeat the query before APPLY. |
| `AGENTS.md` | Blob `f0a50cd...`; inspect-first, small slices, no unrelated files, no gameplay unless requested | Workflow rules remain binding. Its old 15-micro-level canon is superseded by approved Stage 2 chapter design. |
| Current `Level_03.tscn` | Blob `1d8ee509...`; one `LevelManager`, one shard, Step01-04, RevealTriggerA-C, legacy PoemRewardUI | Replace locally. Do not preserve this structure as canon. |
| Target `Level_04.tscn` | Blob `a62ee67c...`; scene exists | Portal target is valid. Level_04 remains read-only. |
| Player | `Player.tscn` blob `201e27...`; controller blob `0e39eadd...` | Reuse. Root-to-floor and transient movement must be proven by runtime evidence. |
| Camera | Blob `51d47f...`; explicit target_path, collision, `mouse_blocking_ui` support | Reuse unchanged; overlay nodes must preserve compatible UI behavior. |
| SoulShard | Blob `6c3e1b...`; public IDs/text, reward request, collected; no public availability/overlap refresh API | Use local `Level03ShardSlot`; mandatory stationary pre-overlap P0. Private fields forbidden. |
| Reward controller | Blob `ad664e...`; `register_shard()`, serial UI flow, safe fallback | One shared controller; explicitly register all three shards. |
| LevelFinaleOverlay | Blob `2859a9...`; `show_finale_text(text)->bool`, `closed`, `mouse_blocking_ui` | Mandatory main-text UI; fail closed if API/fit validation fails. |
| LevelPortal script/scene | Script `d6eeef...`, scene `f485d3...`; owns activation, InteractionArea, AUTO_ENTER, transition latch and scene loading | Adapter requests activation once and forwards actual `activation_completed`; no local success fallback or scene load. |
| Project settings | `project.godot` blob `7d5bdb...`; Godot 4.6, Forward Plus, Jolt, max 60 FPS, VSync, SceneTransition/DevLevelMenu autoloads | No project setting change is required or allowed by default. |


> **Shared blocker policy:** A future Slice 0 must not assume the current shared APIs remain unchanged. Any new PR or main commit affecting Player, Camera, SoulShard, reward controller/UI, LevelFinaleOverlay, LevelPortal or SceneTransition is a STOP/REBASE condition until reviewed.

## 5. Scope

### 5.1 Included in the playable greybox

- One continuous broad asymmetrical S-route above soft fog.
- Seven static zone/block wrappers from Quiet Inlet through Final Overlook.
- P00-P16 route markers, CP0-CP4 camera QA markers and RA0-RA6 recovery anchors.
- Player, follow camera and shared SoulOrb_Follow reuse.
- Hard boundary belt, explicit SoftReturn/OOB volumes and minimal recovery fade.
- Arrival activity confirmation and Wind Trace with three ordered broad arches.
- Playful Spark with fixed A->B->C perches and deterministic fallback.
- Breathing Meadow with three persistent any-order grounded dwell petals.
- Three Level03ShardSlot instances wrapping shared SoulShard: Shard_05/06/07.
- Exact short shard texts and exact main text.
- One local macro progress controller, one local environment controller, one finale controller, one portal adapter and one recovery controller.
- Environment states E0-E6 using primitive/placeholder visuals and local/deep-duplicated resources.
- Main-text gate at Final Overlook and shared AUTO_ENTER portal to Level_04.
- Duplicate/race protection, leave/re-enter preservation, missing optional VFX fallbacks and clean scene reload policy.

### 5.2 Explicitly excluded

- Final Blender models, GLBs, production wrappers, textures, final materials and polished VFX.
- Final sound, music, voiceover, audio-dependent clues or cinematics.
- Final typography redesign or replacement of approved shared overlays without a proven blocker.
- Save system, GameState, checkpoint persistence or new autoload.
- Level_04 development or edits.
- Level_01/Level_02 changes, Level_07-15 cleanup, final acrostic or confession scene work.
- Combat, damage, death, inventory, dialogue system, enemies, timers requiring quick reactions or precision platforming.
- Broad LevelManager refactor or project-wide puzzle framework.
- Post-greybox art-production slices from the Art Production Bible.

## 6. Hard technical rules

- `project.godot` remains unchanged unless a proven blocker is reported and separately approved.
- No Level_01, Level_02, Level_04, Level_07-15 or final-scene changes.
- Do not expand `scripts/core/level_manager.gd`; remove LevelManager from planned Level_03 composition.
- No gameplay scripts or canonical IDs inside imported GLB/art wrapper nodes.
- No global node-name scan, `node_added`, child-index identity, spatial sorting or absolute `/root/Level_03/...` NodePaths for progression.
- Critical dependencies use exported owner-relative NodePaths and validated typed references.
- No Level_03-local `change_scene_to_file`; shared LevelPortal solely owns loading.
- No portal success fallback: only actual shared `activation_completed` may produce local `portal_active`.
- No private SoulShard state access (`_player_in_range`, private enum/state, etc.) and no shard fork.
- No private Player transient-state access; if recovery fails due stale motion, stop for a narrow shared prerequisite.
- Environment/material resources mutated at runtime must be scene-local or `duplicate(true)` before mutation.
- Environment and synthesis transitions never lock Player controls.
- Main text may lock controls only after `show_finale_text()` returns true; failure remains fail-closed.
- Recovery is triggered only by explicit fall/OOB volumes, never by standing still, slow movement or generic stuck detection.
- Canonical Russian copy must retain `ё` exactly and must not receive decorative outer quotation marks in runtime exports.
- Only matching `scripts/levels/level_03/<approved_script>.gd.uid` sidecars are allowed. Every sidecar must have an approved sibling `.gd` in the same slice scope.
- Unrelated `.uid`, `.import`, import metadata, resource UID or asset regeneration is forbidden.
- Temporary harnesses must live outside the repository worktree or be removed before every commit.
- No per-frame print spam. Structured debug logs are guarded by exported `debug_enabled=false`.

## 7. Existing architecture inventory and reuse decisions

| System | Current public contract | Level_03 decision |
| --- | --- | --- |
| Player | `CharacterBody3D`; `set_controls_enabled(bool)`; E selects nearest `player_interactable` implementing `can_player_interact`/`interact`; floor snap and step climb | Reuse unchanged. Only shard interaction needs E; puzzles use movement/proximity. |
| Follow camera | Explicit `target_path`; collision; blocks mouse when a visible `mouse_blocking_ui` exists | Reuse unchanged. No forced camera takeover. |
| SoulOrb_Follow | Shared follow visual used by modern Level_01 | Reuse at parent transform identity; no Level_03-specific orb asset. |
| SoulShard | Public `shard_id`, `reward_text`, `reward_sequence_requested`, `collected`, `complete_collection_sequence()` | Wrap in local slots; serialized hidden state and public Area/Collision/prompt properties only. |
| ShardRewardSequenceController | One active reward at a time; explicit `register_shard()`; controls Player and shared overlay; safe completion fallback | Reuse one instance. Register all three child shards explicitly. |
| ShardRewardOverlay | Short reward UI | Reuse for exact Shard_05/06/07 text. |
| LevelFinaleOverlay | `show_finale_text(text)->bool`, `closed`; internal generation guard | Reuse for exact main text; mandatory fit/API gate. |
| LevelPortal | `activate()`, `activation_completed`, AUTO_ENTER, no-confirmation mode, transition latch/loading | Reuse unchanged. Adapter owns request and semantic forwarding only. |
| SceneTransition | Autoload transition service | Indirectly used only by shared LevelPortal. |
| LevelManager / PoemRewardUI / RevealStepTrigger | Legacy one-shard placeholder flow | Not used in new Level_03 composition. |


## 8. Exact spatial greybox specification

### 8.1 Coordinate convention

| Convention | Definition |
| --- | --- |
| Origin | `Vector3(0,0,0)` at route transition into Playful Glade. |
| Forward | World `+Z` from Quiet Inlet toward Final Overlook. |
| Lateral | `+X` player-right while facing +Z. |
| Playable elevation | Floor Y from `0.00` to `1.60` m. |
| Authoritative gameplay anchors | 0.00 m movement from approved coordinates unless Producer approves a design revision. |
| Block seams | Visible/collision seams `<=0.10 m`. |


### 8.2 Zone schedule

| Zone | Center / extent | Floor | Route openings and critical clearance | Recovery |
| --- | --- | --- | --- | --- |
| Block_03_00 Quiet Inlet | Center `(-6,0,-47)`, `12x10 m` oval | Y 0.00 | Broad opening to P01; spawn clear 4 m; CP0 line to Final Overlook preserved | RA0 |
| Block_03_01 Wind Trace | P01-P06, min route width 5.5 m | Y 0.08-0.80 | All three arch openings continuous; clear width >=6.5 m; overhead >=5.2 m | RA1 after late route milestone |
| Block_03_02 Shard05 Overlook | Center `(-8,0.9,-16)`, `10x8 m` oval | Y 0.90 | At least 6 m exit; shard >=2.5 m from edge; 3 m clear radius | RA2 |
| Block_03_03 Playful Glade | Center `(7,1,-3)`, `22x18 m` oval | Y 1.00 | Broad P08/P10 openings; each perch 3 m clear; all visible in one composition | RA3 |
| Block_03_04 Connector | P10-P12, width 5.5-6.0 m | Y 1.05-1.28 | No gate; both ends open; reduced visual noise | RA4 at meadow entry |
| Block_03_05 Breathing Meadow | Center `(-7,1.3,28.5)`, `28x24 m` oval | Y 1.30 | 3 m around each petal/rest point; all targets visible from P12 | RA5 |
| Block_03_06 Final Overlook | Center `(6,1.6,47)`, `16x12 m` oval | Y 1.60 | Approach from P14; open horizon; main gate R4.5; portal clear R4.5 | RA6 |


### 8.3 Route centerline P00-P16

| Point | X | Y | Z | Use |
| --- | --- | --- | --- | --- |
| P00 Spawn | -6.00 | 0.00 | -49.00 | Spawn route floor |
| P01 Inlet exit | -5.80 | 0.08 | -43.00 | Quiet Inlet exit |
| P02 Arch_01 | -5.50 | 0.15 | -40.50 | Wind arch 1 |
| P03 Curve east | 1.00 | 0.35 | -35.00 | S-curve |
| P04 Arch_02 | 2.00 | 0.45 | -32.00 | Wind arch 2 |
| P05 Curve west | -1.00 | 0.65 | -27.00 | S-curve |
| P06 Arch_03 | -3.50 | 0.80 | -23.50 | Wind arch 3 |
| P07 Shard05 overlook | -8.00 | 0.90 | -16.00 | Reward expansion |
| P08 Glade approach | -1.00 | 0.95 | -9.00 | Glade entry |
| P09 Playful Glade center | 7.00 | 1.00 | -3.00 | Glade center |
| P10 Glade exit | 4.00 | 1.05 | 7.00 | Connector start |
| P11 Exhale bend | -1.00 | 1.15 | 13.00 | Connector bend |
| P12 Meadow entry | -4.00 | 1.28 | 18.00 | Meadow entry |
| P13 Meadow center | -7.00 | 1.30 | 28.50 | Rest point |
| P14 Final approach | -1.50 | 1.45 | 38.00 | Overlook approach |
| P15 Final Overlook | 6.00 | 1.60 | 47.00 | Main text gate center |
| P16 LevelPortalRoot | 10.00 | 1.60 | 50.50 | Shared portal root/floor anchor |


### 8.4 Exact gameplay anchors

| Anchor | Vector3 | Function |
| --- | --- | --- |
| PlayerFloorSpawnMarker | `(-6.00, 0.00, -49.00)` | Floor-contact reference facing +Z; not direct Player root assignment. |
| Gameplay spawn candidate | `(-6.00, 0.65, -49.00)` | Initial root-placement candidate only; Slice 2 derives the accepted CharacterBody root Y from actual grounding/floor-snap evidence and records the frozen result in the implementation summary. |
| Arch_01 | `(-5.50, 0.15, -40.50)` | Wind Trace 1. |
| Arch_02 | `(2.00, 0.45, -32.00)` | Wind Trace 2. |
| Arch_03 | `(-3.50, 0.80, -23.50)` | Wind Trace 3. |
| Shard_05 | `(-8.00, 2.00, -15.00)` | Reward: remembered intonation. |
| Perch_A | `(1.50, 1.05, -7.00)` | Spark start/current target A. |
| Perch_B | `(10.50, 1.05, -3.00)` | Spark destination/current target B. |
| Perch_C | `(4.00, 1.05, 3.00)` | Spark destination C. |
| Shard_06 | `(4.00, 2.00, 4.20)` | Reward: sudden laughter. |
| Petal_W | `(-16.00, 1.30, 27.00)` | Any-order west petal. |
| Petal_SE | `(-4.00, 1.30, 21.50)` | Nearest teaching petal. |
| Petal_NE | `(-1.50, 1.35, 34.00)` | Any-order far petal. |
| Rest_Point | `(-7.00, 1.30, 28.50)` | Three progress segments. |
| Shard_07 | `(-7.00, 2.20, 28.50)` | Reward: author becomes lighter. |
| Main_Text_Gate | `(6.00, 1.60, 47.00)`, radius `4.5 m` | Finale presence gate. |
| LevelPortalRoot / PortalFloorAnchor | `(10.00, 1.60, 50.50)` | Shared LevelPortal root; internal offsets remain shared. |


> **Player vertical-placement authority:** `PlayerFloorSpawnMarker` remains exactly `(-6.00, 0.00, -49.00)` as the floor-contact reference. All approved route, puzzle and portal anchors remain exact. Spawn and RA0-RA6 retain their approved X/Z and associated floor-contact surfaces. The Player runtime root Y at spawn and at each recovery destination is evidence-derived during Slice 2 from the actual shared `CharacterBody3D`, collider offset, `safe_margin`, `floor_snap_length`, Jolt grounding and stable camera behavior. After Slice 2 acceptance, the proven root-Y values are frozen and recorded in `Level_03_Greybox_Implementation_Summary.md` and its content-equivalent DOCX. A Y-only technical correction that preserves floor contact, camera framing and every approved clearance is not a gameplay-layout revision.


### 8.5 Camera QA points

| Point | Position | Target | Rule |
| --- | --- | --- | --- |
| CP0 Arrival | `(-9.0,5.5,-44.0)` | `(6.0,2.5,47.0)` | Final landmark readable; no forced camera. |
| CP1 Shard05 | `(-10.0,5.0,-18.0)` | `(7.0,1.0,-3.0)` | Glade readable after reward. |
| CP2 Glade | `(1.0,6.0,-9.0)` | `(7.0,1.0,-3.0)` | All perches in one composition. |
| CP3 Meadow | `(-3.0,7.0,18.0)` | `(-7.0,1.3,28.5)` | All petals and rest point readable. |
| CP4 Final | `(0.0,6.0,41.0)` | `(6.0,1.6,47.0)` | Overlook/horizon readable; portal secondary/dormant. |


### 8.6 Traversal, boundary and clearance rules

| Parameter | Locked greybox rule |
| --- | --- |
| Mandatory route width | `>=5.5 m`; `6-7 m` at turns, entrances and reward spaces. |
| Route shoulder | `>=1.5 m` clear beyond walkable edge before dense blockers. |
| Camera-safe corridor | `8.5 m` total clear corridor around route centerline. |
| Preferred slope | `<=8°`; isolated absolute max `10°` over `<=4 m`. |
| Cross-slope | `<=3°` on mandatory route and puzzle floors. |
| Mandatory step | `<=0.15 m`; larger changes use continuous ramps. |
| Mandatory gaps | None; visual cracks `<=0.10 m`, collision continuous. |
| Arch clear envelope | Width `>=6.5 m`, overhead `>=5.2 m`. |
| Puzzle/shard clearance | `3.0 m` clear radius around shards, perches, petals and Rest Point. |
| Reward edge safety | Shard positions `>=2.5 m` from fall edge on floor `<3°`. |
| Hard boundary belt | `1.0-1.5 m` thick behind visible rim; owned by EnvironmentRoot/BoundaryRoot or block-local Environment collision. |
| SoftReturn | Broad explicit Area below world; no invisible catch floor. |
| Portal clearance | At least `4.5 m` clear around shared portal root/footprint. |


### 8.7 Recovery anchors

The vectors below preserve the approved authoring candidates and exact X/Z locations. Their listed Y values are initial Player-root candidates, not final runtime authority. Slice 2 must derive and freeze the accepted Player root Y for each RA destination while preserving the corresponding approved floor-contact surface.

| Anchor | Vector3 initial root candidate | Activation milestone |
| --- | --- | --- |
| RA0 | `(-6.00,0.65,-49.00)` | Initial validated spawn; guaranteed fallback. |
| RA1 | `(-4.50,0.95,-20.00)` | Late Wind Trace milestone. |
| RA2 | `(-8.00,1.00,-16.00)` | Shard_05 overlook. |
| RA3 | `(4.00,1.10,7.00)` | Playful Glade exit. |
| RA4 | `(-4.00,1.35,18.00)` | Meadow entry. |
| RA5 | `(-7.00,1.40,28.50)` | Meadow Rest Point. |
| RA6 | `(6.00,1.70,46.00)` | Final Overlook approach. |


## 9. Proposed repository file tree

```text
scenes/
└── levels/
    ├── Level_03.tscn
    └── level_03/
        ├── blocks/
        │   ├── Block_03_00_QuietInlet.tscn
        │   ├── Block_03_01_WindTraceRoute.tscn
        │   ├── Block_03_02_Shard05Overlook.tscn
        │   ├── Block_03_03_PlayfulGlade.tscn
        │   ├── Block_03_04_Connector.tscn
        │   ├── Block_03_05_BreathingMeadow.tscn
        │   └── Block_03_06_FinalOverlook.tscn
        ├── gameplay/
        │   ├── WindTrace.tscn
        │   ├── PlayfulSpark.tscn
        │   ├── BreathingMeadow.tscn
        │   └── Level03ShardSlot.tscn
        ├── environment/
        │   └── Level03EnvironmentState.tscn
        ├── ui/
        │   └── RecoveryFadeOverlay.tscn
        └── vfx/
            ├── Level03WindTraceVFX.tscn
            ├── Level03PlayfulSparkVFX.tscn
            ├── Level03BreathingMeadowVFX.tscn
            ├── Level03GuidanceVFX.tscn
            ├── Level03SynthesisVFX.tscn
            └── Level03PortalAccentVFX.tscn

scripts/
└── levels/
    └── level_03/
        ├── level_03_progress_controller.gd
        ├── level_03_recovery_controller.gd
        ├── level_03_shard_slot.gd
        ├── level_03_environment_state_controller.gd
        ├── level_03_finale_controller.gd
        ├── level_03_portal_adapter.gd
        ├── wind_trace_controller.gd
        ├── wind_trace_arch.gd
        ├── playful_spark_controller.gd
        ├── playful_spark_perch.gd
        ├── breathing_meadow_controller.gd
        └── breathing_meadow_petal.gd

# Matching sidecars are allowed only beside approved scripts:
scripts/levels/level_03/<approved_script>.gd.uid

docs/
├── design/
│   └── Level_03_Greybox_Development_Reference.md
└── development/
    └── Level_03_Greybox_Implementation_Summary.md

# User-facing final artifact, generated outside the runtime worktree unless explicitly requested in the PR:
Level_03_Greybox_Implementation_Summary.docx
```

> **VFX scope:** VFX scenes above are primitive/placeholder and optional to gameplay. They own no collision, canonical IDs or state. A slice may omit a placeholder scene only when the same approved presentation API is provided locally and the omission is recorded in handoff.

## 10. Proposed root node tree

```text
Level_03 (Node3D)
├── EnvironmentRoot (Node3D)
│   ├── BaseGeometry (Node3D)
│   │   ├── Block_03_00_QuietInlet
│   │   ├── Block_03_01_WindTraceRoute
│   │   ├── Block_03_02_Shard05Overlook
│   │   ├── Block_03_03_PlayfulGlade
│   │   ├── Block_03_04_Connector
│   │   ├── Block_03_05_BreathingMeadow
│   │   └── Block_03_06_FinalOverlook
│   ├── BoundaryRoot (Node3D)
│   ├── LandmarkRoot (Node3D)
│   └── DressingRoot (Node3D)
├── GameplayRoot (Node3D)
│   ├── WindTrace
│   ├── PlayfulSpark
│   ├── BreathingMeadow
│   ├── ShardSlots (Node3D)
│   │   ├── ShardSlot_05
│   │   ├── ShardSlot_06
│   │   └── ShardSlot_07
│   ├── FinalOverlook (Node3D)
│   │   ├── FinalOverlookGate (Area3D)
│   │   │   └── CollisionShape3D
│   │   ├── LevelPortalRoot (Marker3D)
│   │   │   └── PortalCore (shared LevelPortal)
│   │   └── FinalLandmarkMarker (Marker3D)
│   └── SafetyRoot (Node3D)
│       ├── SoftReturnVolume (Area3D)
│       ├── OutOfBoundsVolumes (Node3D)
│       └── RecoveryMilestones (Node3D)
│           ├── RA0 ... RA6
├── EnvironmentStateRoot (Node3D) [instance root of Level03EnvironmentState.tscn; environment controller script on this root]
│   ├── WorldEnvironment
│   ├── LightingRoot
│   ├── GlobalFogRoot
│   └── LocalHazeRoot
├── VFXRoot (Node3D)
│   ├── WindTraceVFX
│   ├── PlayfulSparkVFX
│   ├── BreathingMeadowVFX
│   ├── GuidanceVFX
│   ├── SynthesisVFX
│   └── PortalAccentVFX
├── PlayerRoot (Node3D)
│   ├── PlayerFloorSpawnMarker
│   ├── Player (shared)
│   └── SoulOrb_Follow (shared)
├── CameraRoot (Node3D)
│   └── FollowCamera (shared script)
├── LevelRuntimeRoot (Node3D)
│   ├── Level03ProgressController
│   ├── ShardRewardSequenceController (shared)
│   ├── Level03FinaleController
│   ├── Level03PortalAdapter
│   └── Level03RecoveryController
├── MarkerRoot
│   ├── RouteMarkers / P00 ... P16
│   └── CameraQAMarkers / CP0 ... CP4
└── UILayer (CanvasLayer)
    ├── ShardRewardOverlay (shared)
    ├── LevelFinaleOverlay (shared)
    └── RecoveryFadeOverlay (local minimal UI)
```

### 10.1 Block wrapper contract

```text
Block_03_0X_<Zone> (Node3D)
├── EnvironmentRoot
│   ├── GroundRoot
│   ├── StructureRoot
│   ├── DressingRoot
│   └── VisualMounts
├── CollisionRoot
│   ├── WalkableBodies
│   └── BoundaryBodies
└── Markers
    ├── EntryMarker / ExitMarker / CenterMarker
    └── ArtAlignment_* (non-authoritative only)
```

- Block scenes own static primitive floor, visible primitive rim and approved static collision only.
- Hard boundary collision remains Environment-owned, never SafetyRoot-owned.
- Puzzle triggers, IDs, pivots, shard anchors, portal root and recovery logic remain outside block scenes.
- No raw imported node name may become a critical dependency.

### 10.2 Puzzle and adapter trees

```text
WindTrace
├── Arches
│   ├── Arch_01 (Area3D + VisualRoot + RibbonOrigin + NextTarget)
│   ├── Arch_02
│   └── Arch_03
├── ArrivalActivityArea
├── HintVFXRoot
└── DebugMarkers

PlayfulSpark
├── Perches
│   ├── Perch_A (Area3D + LandingMarker + VisualRoot)
│   ├── Perch_B
│   └── Perch_C
├── SparkVisualRoot
├── HopPresentationRoot
├── HintVFXRoot
└── DebugMarkers

BreathingMeadow
├── Petals
│   ├── Petal_W (Area3D + PetalPivot + VisualRoot)
│   ├── Petal_SE
│   └── Petal_NE
├── RestPoint
│   ├── Segment_01
│   ├── Segment_02
│   ├── Segment_03
│   └── ConvergenceMarker
├── HintVFXRoot
└── DebugMarkers

Level03ShardSlot
├── ShardAnchor
│   └── SoulShard (shared; serialized hidden/disabled)
├── RevealVFXRoot
└── RevealFallbackTimer
```

## 11. Canonical IDs and exact runtime copy

| Identity | Canonical value | Rule |
| --- | --- | --- |
| Puzzle 1 | `&"wind_trace"` | Accepted only while expected. |
| Puzzle 2 | `&"playful_spark"` | Accepted only after Shard_05 reward completion. |
| Puzzle 3 | `&"breathing_meadow"` | Accepted only after Shard_06 reward completion. |
| Arch set | `&"Arch_01"`, `&"Arch_02"`, `&"Arch_03"` | Fixed sequence by ID. |
| Perch set | `&"Perch_A"`, `&"Perch_B"`, `&"Perch_C"` | Fixed sequence by ID. |
| Petal set | `&"Petal_W"`, `&"Petal_SE"`, `&"Petal_NE"` | Any order, persistent unique set. |
| Shard set | `&"Shard_05"`, `&"Shard_06"`, `&"Shard_07"` | Exact case; linear macro order. |
| Main text ID | `&"level_03_main_text"` | Finale diagnostic/identity. |
| Recovery suspension sources | `&"shard_reward"`, `&"main_text"` | Source-keyed idempotent set. |
| Portal target | `res://scenes/levels/Level_04.tscn` | Shared portal owns transition. |


### 11.1 Locked exact texts

| ID | Exact runtime string - without decorative outer quotes |
| --- | --- |
| Shard_05 | После наших разговоров я ещё долго вспоминаю твою интонацию. |
| Shard_06 | Мне особенно нравится, как ты вдруг смеёшься над какой-нибудь полной ерундой. |
| Shard_07 | Рядом с тобой я и сам чаще смеюсь и ненадолго перестаю быть таким серьёзным. |
| level_03_main_text | Сначала я просто заметил, что жду наших разговоров. Потом понял, что после них ещё долго вспоминаю твою интонацию, а когда ты внезапно смеёшься над какой-нибудь ерундой, я и сам перестаю быть таким серьёзным. Мне дорого не только то, как легко мне бывает рядом с тобой. Мне дорога ты. |


> **Copy guard:** Do not replace `ё` with `е`, shorten the main text, add pressure language, add “спасение/исцеление”, or restore the legacy phrase «Не нужно видеть весь путь сразу - достаточно следующего шага» as player-facing copy.

## 12. Exact owner-relative NodePaths

| Owner | Export | Exact NodePath |
| --- | --- | --- |
| Level03ProgressController | player_path | `../../PlayerRoot/Player` |
|  | wind_trace_path | `../../GameplayRoot/WindTrace` |
|  | playful_spark_path | `../../GameplayRoot/PlayfulSpark` |
|  | breathing_meadow_path | `../../GameplayRoot/BreathingMeadow` |
|  | shard_05_slot_path | `../../GameplayRoot/ShardSlots/ShardSlot_05` |
|  | shard_06_slot_path | `../../GameplayRoot/ShardSlots/ShardSlot_06` |
|  | shard_07_slot_path | `../../GameplayRoot/ShardSlots/ShardSlot_07` |
|  | environment_state_path | `../../EnvironmentStateRoot` |
|  | reward_sequence_controller_path | `../ShardRewardSequenceController` |
|  | recovery_controller_path | `../Level03RecoveryController` |
| ShardRewardSequenceController | overlay_path | `../../UILayer/ShardRewardOverlay` |
|  | player_path | `../../PlayerRoot/Player` |
|  | shard_search_root_path | `../../GameplayRoot/ShardSlots` |
| Level03FinaleController | progress_controller_path | `../Level03ProgressController` |
|  | player_path | `../../PlayerRoot/Player` |
|  | gate_area_path | `../../GameplayRoot/FinalOverlook/FinalOverlookGate` |
|  | gate_collision_path | `../../GameplayRoot/FinalOverlook/FinalOverlookGate/CollisionShape3D` |
|  | finale_overlay_path | `../../UILayer/LevelFinaleOverlay` |
|  | environment_state_path | `../../EnvironmentStateRoot` |
|  | portal_adapter_path | `../Level03PortalAdapter` |
|  | recovery_controller_path | `../Level03RecoveryController` |
| Level03PortalAdapter | portal_core_path | `../../GameplayRoot/FinalOverlook/LevelPortalRoot/PortalCore` |
|  | local_portal_vfx_path | `../../VFXRoot/PortalAccentVFX` |
| Level03RecoveryController | player_path | `../../PlayerRoot/Player` |
|  | fade_overlay_path | `../../UILayer/RecoveryFadeOverlay` |
|  | soft_return_volume_path | `../../GameplayRoot/SafetyRoot/SoftReturnVolume` |
|  | out_of_bounds_root_path | `../../GameplayRoot/SafetyRoot/OutOfBoundsVolumes` |
|  | recovery_milestones_root_path | `../../GameplayRoot/SafetyRoot/RecoveryMilestones` |
| FollowCamera | target_path | `../../PlayerRoot/Player` |
| SoulOrb_Follow | target_path | `../Player` |
|  | orientation_source_path | `../Player/CharacterVisualRoot` |
| EnvironmentStateRoot | wind_trace_vfx_path | `../VFXRoot/WindTraceVFX` |
|  | playful_spark_vfx_path | `../VFXRoot/PlayfulSparkVFX` |
|  | meadow_vfx_path | `../VFXRoot/BreathingMeadowVFX` |
|  | synthesis_vfx_path | `../VFXRoot/SynthesisVFX` |
|  | portal_accent_vfx_path | `../VFXRoot/PortalAccentVFX` |


> **Validation:** All paths are resolved from the node that owns the export. Missing required paths fail closed before gameplay is armed. Optional VFX references may be null only where a documented logical fallback exists.


### 12.1 Startup validation and wiring invariants

- `Level03EnvironmentState.tscn` must have a root `Node3D` named exactly `EnvironmentStateRoot`; `level_03_environment_state_controller.gd` is attached directly to that root.
- `EnvironmentStateRoot` must contain exactly the approved direct children `WorldEnvironment`, `LightingRoot`, `GlobalFogRoot` and `LocalHazeRoot`; no additional intermediate environment-state node is permitted.
- `Level03ProgressController.environment_state_path` resolves exactly to `../../EnvironmentStateRoot`.
- Environment VFX exports resolve from the root controller as `../VFXRoot/WindTraceVFX`, `../VFXRoot/PlayfulSparkVFX`, `../VFXRoot/BreathingMeadowVFX`, `../VFXRoot/SynthesisVFX` and `../VFXRoot/PortalAccentVFX`.
- `Level03PortalAdapter` validates only `portal_core_path` and the optional `local_portal_vfx_path`. It has no Player export or Player reference.
- The shared `LevelPortal` remains the exclusive owner of Player overlap filtering, InteractionArea, AUTO_ENTER, transition latch and scene loading.
- The scene signal connection from `Level03ProgressController.all_rewards_completed()` to `Level03FinaleController` is required. FinaleController handles that signal by running its own `arm_finale()` logic. Progress has no direct finale-arm call path.
- Startup fails closed before any puzzle is armed when a required root, direct child, NodePath, canonical ID, mandatory signal connection or shared API is missing.

## 13. Signal and public API contract

### 13.1 Signals

| Signal | Emitter | Receiver / semantic meaning | One-shot/race guard |
| --- | --- | --- | --- |
| `activity_confirmed()` | WindTraceController | Progress diagnostic; first meaningful movement/camera input or one 4 s auto-confirm | Activity latch |
| `arch_crossed(arch_id)` | WindTraceArch | WindTraceController; only current ID advances | Arch latch + expected-ID guard |
| `puzzle_completed(puzzle_id)` | Each puzzle controller | Progress validates macro state and calls matching ShardSlot.reveal() | Puzzle latch + Progress accepted-ID set |
| `perch_approached(perch_id)` | PlayfulSparkPerch | Spark controller; only current perch | Occupancy/enable latch |
| `spark_hop_terminal(to_id,generation,via_fallback)` | Spark presenter/controller | First real/fallback terminal wins | Generation + terminal latch |
| `petal_activated(petal_id)` | BreathingMeadowPetal | Meadow controller; unique ID accepted | Per-petal latch + completed set |
| `petal_presentation_terminal(...)` | Petal presenter/controller | Presentation-only terminal | Per-ID generation |
| `meadow_progress_changed(completed_ids)` | Meadow controller | Progress/environment requests E3/E4 | Copied unique set |
| `shard_reveal_started(shard_id)` | Level03ShardSlot | Progress diagnostic | Reveal latch |
| `shard_available(shard_id)` | Level03ShardSlot | Availability fact only; no macro advancement | Availability latch after physics verification |
| `shard_collection_started(shard_id)` | Level03ShardSlot | Progress sets recovery source `shard_reward` active | Collection-start latch |
| `shard_collected(shard_id)` | Level03ShardSlot | Progress clears recovery suspension and advances macro state | Collected latch + expected-state guard |
| `all_rewards_completed()` | Progress | FinaleController receives the signal and runs its own `arm_finale()` logic; this is the only Progress-to-Finale arming delivery path | Progress emission latch + Finale arm latch |
| `environment_phase_changed(phase)` | Environment controller | Diagnostics/tests | Monotonic phase guard |
| `final_synthesis_terminal(generation,via_fallback)` | Environment controller | Finale opens main text after one terminal | Generation + first-terminal-wins |
| `main_text_opened(text_id)` | FinaleController | Progress/tests | Open latch |
| `main_text_closed()` | FinaleController | Finale clears lock and requests portal once | Close latch |
| `portal_activation_requested()` | PortalAdapter | Diagnostics/tests | Request latch |
| `portal_active()` | PortalAdapter | Finale/Progress terminal after actual shared completion | Actual `activation_completed` + adapter latch |
| `recovery_requested(volume_id)` | Recovery volume/controller | RecoveryController; may queue while suspended | Recovery generation |
| `recovery_completed(anchor_id)` | RecoveryController | Diagnostics/tests | One per generation |
| `recovery_suspension_changed(active_sources)` | RecoveryController | Diagnostics/tests | Source-set idempotency |


### 13.2 Public APIs

| Owner | Public method | Contract |
| --- | --- | --- |
| Level03ProgressController | `initialize_level() -> bool` | Validate canonical refs/IDs; prepare hidden slots; register shards; apply E0; arm Wind Trace. |
|  | `debug_get_state()` / `debug_get_collected_shard_ids()` / `debug_get_expected_shard_id()` | Read-only QA; returned collections are copies. |
| WindTraceController | `arm() -> bool` | Arm once and begin activity window. |
|  | `reevaluate_current_overlap_once()` | Exactly one overlap recheck when a new arch becomes active. |
| PlayfulSparkController | `arm() -> bool` | Arm only after Shard_05 reward completion. |
|  | `debug_complete_current_hop()` | Harness-only through same terminal guard. |
| BreathingMeadowController | `arm() -> bool` | Enable grounded dwell only after Shard_06 reward completion. |
|  | `debug_activate_petal(id)` | Harness-only through same validation path. |
| Level03ShardSlot | `prepare_hidden()` | Validate serialized hidden/non-monitoring/non-monitorable/collision-disabled/prompt-hidden state. |
|  | `reveal()` | Run reveal terminal/fallback, deferred-safe enable, physics-frame verification and stationary-overlap refresh; emit availability once. |
|  | `register_shared_reward_controller(controller)` | Call shared `register_shard(child)`; slot does not own controller. |
| EnvironmentStateController | `apply_initial_state()` | Validate local/deep-duplicated resources and set E0. |
|  | `request_phase(phase)` | Monotonic/race-safe E1/E2/E5/E6 request. |
|  | `request_meadow_petal_effect(id)` | Independent local haze/segment E3/E4 effect. |
|  | `begin_final_synthesis(generation)` | Start 1.5-2.0 s presentation with bounded fallback. |
| FinaleController | `arm_finale()` | Internal Finale-owned arming logic invoked by its `all_rewards_completed()` signal handler; store prerequisite complete and re-evaluate current gate occupancy. Progress never calls this method directly. |
| PortalAdapter | `activate_portal()` | Latch once, start optional local accent, call shared `activate()` once, wait actual shared completion. |
| RecoveryController | `set_current_anchor(id)` | Accept only valid RA progression. |
|  | `set_suspension_source(source_id, active)` | Idempotent source-keyed set; only `shard_reward` and `main_text`. |
|  | `request_recovery(volume_id)` | Recover immediately if unsuspended; otherwise store pending explicit overlap identity. |


## 14. Locked event order and macro progression

### 14.1 Exact event order for each puzzle/shard

```text
Puzzle controller latches logical completion
→ emits puzzle_completed(puzzle_id)
→ Level03ProgressController validates expected macro state and accepts once
→ Progress calls matching Level03ShardSlot.reveal()
→ Slot latches reveal and emits shard_reveal_started(shard_id)
→ reveal presentation completes or bounded fallback wins
→ Slot enables shared SoulShard using public/deferred-safe properties
→ waits one physics frame and verifies effective collectability/overlap semantics
→ emits shard_available(shard_id)
→ player starts shared shard collection/reward flow
→ Slot observes child reward_sequence_requested
→ emits shard_collection_started(shard_id)
→ Progress sets Recovery suspension source &"shard_reward" active
→ shared ShardRewardSequenceController completes overlay/return/fallback
→ shared SoulShard emits collected
→ Slot emits shard_collected(shard_id)
→ Progress clears &"shard_reward", requests environment phase and arms next macro beat
```

### 14.2 Macro state model

```gdscript
enum LevelState {
    INIT,
    ARRIVAL_READY,
    WIND_TRACE_ACTIVE,
    SHARD_05_AVAILABLE,
    SHARD_05_REWARD_ACTIVE,
    PLAYFUL_SPARK_ACTIVE,
    SHARD_06_AVAILABLE,
    SHARD_06_REWARD_ACTIVE,
    BREATHING_MEADOW_ACTIVE,
    SHARD_07_AVAILABLE,
    SHARD_07_REWARD_ACTIVE,
    WAITING_FOR_FINAL_OVERLOOK,
    SYNTHESIS_ACTIVE,
    MAIN_TEXT_ACTIVE,
    PORTAL_ACTIVATING,
    PORTAL_ACTIVE,
}
```

| From | Required event / guard | To | Side effects |
| --- | --- | --- | --- |
| INIT | Configuration valid; slots hidden; E0 applied | ARRIVAL_READY | Set RA0; enable activity tracking. |
| ARRIVAL_READY | Wind Trace `arm()` succeeds | WIND_TRACE_ACTIVE | Start 4 s activity window. |
| WIND_TRACE_ACTIVE | `puzzle_completed(wind_trace)` | SHARD_05_AVAILABLE | Call Slot_05.reveal(). |
| SHARD_05_AVAILABLE | `shard_collection_started(Shard_05)` | SHARD_05_REWARD_ACTIVE | Recovery `shard_reward` active. |
| SHARD_05_REWARD_ACTIVE | `shard_collected(Shard_05)` | PLAYFUL_SPARK_ACTIVE | Clear lock; request E1; arm Spark; set RA2. |
| PLAYFUL_SPARK_ACTIVE | `puzzle_completed(playful_spark)` | SHARD_06_AVAILABLE | Call Slot_06.reveal(). |
| SHARD_06_AVAILABLE | `shard_collection_started(Shard_06)` | SHARD_06_REWARD_ACTIVE | Recovery lock active. |
| SHARD_06_REWARD_ACTIVE | `shard_collected(Shard_06)` | BREATHING_MEADOW_ACTIVE | Clear lock; request E2; arm Meadow; set RA4. |
| BREATHING_MEADOW_ACTIVE | `puzzle_completed(breathing_meadow)` | SHARD_07_AVAILABLE | Call Slot_07.reveal(). |
| SHARD_07_AVAILABLE | `shard_collection_started(Shard_07)` | SHARD_07_REWARD_ACTIVE | Recovery lock active. |
| SHARD_07_REWARD_ACTIVE | `shard_collected(Shard_07)` | WAITING_FOR_FINAL_OVERLOOK | Clear lock; request E5; emit `all_rewards_completed()` exactly once; set RA5/RA6 by route milestone. Progress performs no direct finale-arm call. |
| WAITING_FOR_FINAL_OVERLOOK | FinaleController has received `all_rewards_completed()`, run its own `arm_finale()` logic, and Player is in gate | SYNTHESIS_ACTIVE | Start synthesis; Player remains free. |
| SYNTHESIS_ACTIVE | Real/fallback synthesis terminal and overlay API valid | MAIN_TEXT_ACTIVE | Show exact text; then lock controls and recovery source `main_text`. |
| MAIN_TEXT_ACTIVE | First valid overlay `closed` | PORTAL_ACTIVATING | Clear lock; request E6; adapter activates shared portal once. |
| PORTAL_ACTIVATING | Actual shared `activation_completed` | PORTAL_ACTIVE | Adapter forwards one semantic event; shared portal owns AUTO_ENTER/load. |


### 14.3 Invalid events

| Invalid or duplicate event | Required behavior |
| --- | --- |
| Future puzzle completes before armed | Ignore, warn once, no shard reveal. |
| Unknown puzzle/shard/arch/perch/petal ID | Fail closed or ignore safely with configuration/error log; no state mutation. |
| Duplicate puzzle completion | Ignore; no repeated reveal. |
| Duplicate shard availability | Ignore; no macro advancement. |
| Duplicate collection start/collected | Ignore; no repeated lock/UI/environment/arm. |
| Main-text close outside MAIN_TEXT_ACTIVE | Ignore. |
| Portal completion outside PORTAL_ACTIVATING | Diagnostic only; no state fabrication. |
| Portal diagnostic timeout | Report blocker; never emit success or scene-load. |


## 15. Wind Trace state model

```gdscript
enum WindState {
    DORMANT,
    WAITING_FOR_ACTIVITY,
    ARCH_01_ACTIVE,
    ARCH_02_ACTIVE,
    ARCH_03_ACTIVE,
    COMPLETE,
}
```

| Rule | Locked contract |
| --- | --- |
| Objects | Exactly three broad arches on the always-existing route. |
| Input | Player crosses only the currently active full-width Area3D. |
| Order | Arch_01 -> Arch_02 -> Arch_03 by explicit StringName. |
| Activity confirmation | Meaningful movement/camera change or one auto-confirm at exactly 4 s. |
| Future arch crossing | No effect and no penalty. |
| Newly active arch overlap | One immediate current-overlap re-evaluation; remaining inside advances once without exit/re-enter. |
| Hints | 20 s stronger current glow; >35 s ripple every 5 s. |
| Persistence | Leaving/re-entering preserves current arch and hint cadence. |
| Completion | Arch_03 crossing latches complete and emits `puzzle_completed(wind_trace)` once. |
| VFX failure | Logical crossing/advance remains authoritative. |


## 16. Playful Spark state model

```gdscript
enum SparkState {
    LOCKED,
    INTRO,
    AT_A,
    HOP_A_B,
    AT_B,
    HOP_B_C,
    AT_C,
    COMPLETE,
}
```

| Rule | Locked contract |
| --- | --- |
| Sequence | Perch_A -> Perch_B -> Perch_C; no random destination. |
| Input | Approach current perch within 3.0 m. |
| Telegraph | Destination preglow 0.55 s. |
| Hop | 0.75-0.90 s presentation; all proximity ignored. |
| Fallback | 1.2 s first-terminal-wins; place abstract impulse at destination and advance once. |
| Settle | 0.65 s; then one occupancy re-evaluation if Player is already inside destination. |
| Wrong perch | No effect, punishment or reset. |
| Persistence | Spark waits indefinitely at current perch across leave/re-enter. |
| Hints | 15 s current perch pulse; >30 s curved hint ribbon. |
| Completion | Post-C seed-pod reaction latches complete and emits `puzzle_completed(playful_spark)` once. |
| Visual safety | Abstract warm impulse only; no face, eyes, wings, voice or mascot behavior. |


## 17. Breathing Meadow state model

```gdscript
enum MeadowState {
    LOCKED,
    READY_0_3,
    ACTIVE_1_3,
    ACTIVE_2_3,
    CONVERGENCE,
    COMPLETE,
}
```

| Rule | Locked contract |
| --- | --- |
| Targets | Petal_W, Petal_SE, Petal_NE visible from meadow entry. |
| Input | Grounded continuous dwell: radius 2.4 m, duration 0.65 s. |
| Airborne | Does not accumulate dwell. |
| Leave early | Only current incomplete dwell resets. |
| Order | All six permutations accepted; completed-ID set authoritative. |
| Persistence | Completed petals remain complete and only pulse quietly on revisit. |
| Simultaneous activation | Zones must not overlap; at most one active dwell. |
| Presentation | 1.3-1.6 s lift/drift, but logical completion is not blocked by presentation. |
| Fallback | 1.8 s proposed first-terminal-wins; one segment/effect only. |
| Hints | 25 s nearest inactive mote trail; >45 s repeat every 6 s. |
| Completion | Third unique ID latches convergence and emits `puzzle_completed(breathing_meadow)` once. |


## 18. Level03ShardSlot and reward lifecycle model

```gdscript
enum SlotState {
    HIDDEN,
    REVEALING,
    AVAILABLE,
    REWARD_ACTIVE,
    COLLECTED,
}
```

- The packed child SoulShard is serialized hidden, `monitoring=false`, `monitorable=false`, CollisionShape disabled and prompt hidden before frame 1.
- `prepare_hidden()` validates effective public state; it does not repair private shared state.
- `reveal()` keeps collection disabled until one real/fallback presentation terminal wins.
- Enablement uses public Node/Area/Collision/prompt properties with deferred-safe changes, then waits one physics frame and verifies effective state.
- Mandatory P0 stationary pre-overlap: Player may remain inside future shard radius before/through reveal; no collection before availability and one collection afterward without re-entry.
- If stationary overlap cannot be refreshed safely without private-state access, implementation stops for a separately approved minimal shared availability/overlap API.
- Slot observes child `reward_sequence_requested` only to emit canonical `shard_collection_started`; Progress never consumes the child signal directly.
- Slot observes child `collected` to emit canonical `shard_collected` once after shared reward completion.

## 19. Environment transition model

| Phase | Technical/visual target | Duration / lock |
| --- | --- | --- |
| E0_INITIAL | Natural colors visible; saturation/richness target 0.72, allowed 0.65-0.80; fog on; route visibility 18-22 m; final landmark silhouette readable | Immediate, no lock |
| E1_AFTER_SHARD_05 | Wind ribbon/grass response clearer; warm Playful Glade accent; modest global richness increase | 4-5 s, non-blocking |
| E2_AFTER_SHARD_06 | Warm motes/trail forward; midground haze softer; slight warmth increase | 4 s, non-blocking |
| E3_MEADOW_1_3 | Clear first petal local haze pocket; RestPoint segment 1 | 1.5 s local, non-blocking |
| E4_MEADOW_2_3 | Clear second local haze pocket; segment 2; third petal converges with shard reveal | 1.5 s local, non-blocking |
| E5_AFTER_SHARD_07 | Final saturation 1.00; motifs converge; overlook landmark fully readable; portal still inactive | 6 s, non-blocking |
| E6_AFTER_MAIN_TEXT | Local PortalAccentVFX begins parallel to one shared portal activation request; does not imply ACTIVE | 1.8 s local target, no lock |


- Use Environment properties for global saturation/fog/ambient targets and a small explicit set of local material/light/VFX controls.
- No fullscreen CanvasLayer shader in MVP.
- Independent tween handles per property/channel; later phase requests must not strand prior values.
- Required overlap test: request E1, then E2 before E1 completes, then E5; final saturation must be 1.00 and fog/light canonical.
- Missing optional VFX produces a warning and logical phase completion, never a softlock.

## 20. Finale, main text and portal model

### 20.1 Finale

| Finale state | Entry / behavior |
| --- | --- |
| LOCKED | Gate may track occupancy; no synthesis/text; portal hidden/inactive. |
| ARMED | FinaleController received `all_rewards_completed()` exactly once and ran its own `arm_finale()` logic; re-evaluate stored player-inside state immediately. Progress has no direct arming call. |
| SYNTHESIS | 1.5-2.0 s local convergence with generation/fallback; Player and recovery remain active. |
| MAIN_TEXT_ACTIVE | Validate overlay/method/signal; call `show_finale_text(exact)`; only after true, set recovery source `main_text` and lock controls. |
| PORTAL_FORMING | On first valid close: clear `main_text`, unlock owned controls, request E6 and call adapter once. |
| PORTAL_ACTIVE | Actual shared activation complete; Finale no longer owns input/transition. |


> **Fail-closed UI:** Missing LevelFinaleOverlay, missing `show_finale_text`, missing `closed`, false return, unreadable/clipped text or >6 readable lines at target resolutions is a hard stop. Canonical text is not shortened or timer-skipped.

### 20.2 Shared portal configuration and ownership

```gdscript
target_scene_path = "res://scenes/levels/Level_04.tscn"
entry_mode = LevelPortal.EntryMode.AUTO_ENTER
require_entry_confirmation = false
activation_duration = 1.8
```

- PortalCore is hidden/inactive before and during main text.
- Immediately after close, adapter starts optional local accent and calls shared `PortalCore.activate()` exactly once in parallel.
- Adapter emits local `portal_active` only from actual shared `activation_completed`.
- Local accent timeout may end only local VFX. Diagnostic timeout may report missing shared completion as blocker.
- No timer may call private portal methods, call activate again, fabricate ACTIVE, emit success or scene-load.
- Mandatory stationary early-overlap P0: Player inside future InteractionArea through activation must trigger exactly one Level_04 transition without exit/re-entry.
- If shared LevelPortal fails this test, stop and create a separately approved minimal shared prerequisite; do not weaken the contract locally.

## 21. Recovery and control-lock model

- RecoveryController is the sole owner of effective recovery suspension.
- Suspension is an idempotent source set containing only `shard_reward` and `main_text`.
- Progress sets/clears `shard_reward` from slot `shard_collection_started` -> `shard_collected`.
- Finale sets/clears `main_text` only around a successfully opened/closed overlay.
- Recovery never reads private reward-controller or finale-overlay state.
- Entering an explicit recovery volume while suspended stores pending overlap identity but does not teleport.
- When the last source clears, reevaluate once: still overlapping/invalid -> one recovery; already exited and valid -> clear pending state.
- Recovery uses a 0.25-0.40 s fade, one teleport to a grounded validated destination, `Player.velocity = Vector3.ZERO`, and preserves puzzle/shard/environment state.
- Additional transient movement may be cleared only through a proven public Player API. Recovery must not access private Player step-climb, floor or movement fields. If the public behavior is insufficient, Slice 2 stops for a separately approved narrow shared prerequisite.

# 22. Slice decomposition and execution contracts

Slices 0-11 below are the locked execution units. Slice 0 is always inspection-only and ends in `WAITING FOR APPLY`. After explicit APPLY, exactly one slice is implemented, validated and committed at a time; the next slice starts automatically only while its internal gate passes.

## Slice 0 - Full Preflight

### Slice 0.1 Goal

Re-inspect the repository at execution time, resolve any drift from this docs-stage snapshot, choose the exact base and produce a zero-change implementation plan. No runtime, documentation or administrative repository write is allowed.

### Slice 0.2 Preconditions

- Producer has approved this reference and explicitly requested Slice 0 execution.
- All five approved source documents and this Markdown are available.
- GitHub and local Godot inspection access are available.

### Slice 0.3 Exact files expected to change

No repository files. Slice 0 is inspection-only and must end with zero diff.

### Slice 0.4 Exact files forbidden to change

- `project.godot` unless a proven blocker is separately approved
- all Level_01 and Level_02 files
- `scenes/levels/Level_04.tscn` and all Level_04 files
- `scripts/core/level_manager.gd` and legacy reveal-step files
- shared Player, Camera, SoulShard, reward controller/UI, LevelFinaleOverlay, LevelPortal and SceneTransition files
- save/GameState/autoload files
- raw GLB, Blender, final textures/materials and post-greybox art wrappers
- Level_07-15, final acrostic and confession scene files
- unrelated `.gd.uid`, `.uid`, `.import` or import metadata
- No file creation, modification, deletion, formatting, reimport, branch push or PR mutation.

### Slice 0.5 Nodes, scenes and scripts

- Inspect root and nested AGENTS.md files.
- Inspect current main SHA and clean worktree.
- Inspect current Level_03 and Level_04.
- Inspect Player, Camera, SoulOrb_Follow, SoulShard, reward controller/UI, LevelFinaleOverlay, LevelPortal, SceneTransition and project settings.
- Query complete active PR stack and changed shared files.
- Confirm target paths and proposed Level_03 file conflicts.

### Slice 0.6 Methods, signals and contracts

| Contract item | Required contract |
| --- | --- |
| Repository inspection | No runtime API or signal changes. |
| Base decision | Explicit main/integration SHA; unresolved conflict is hard stop. |


### Slice 0.7 Implementation steps

1. Record applicable AGENTS rules and identify obsolete narrative text separately from binding workflow constraints.
2. Record default branch, main SHA, worktree state and open PRs.
3. Compare actual shared contracts against Sections 7, 12, 13, 18, 20 and 21.
4. Confirm Level_04 exists and shared Portal target/config API remains available.
5. Confirm LevelFinaleOverlay and reward lifecycle APIs.
6. Confirm SoulShard still lacks or now exposes safe availability/overlap APIs.
7. Confirm Player recovery can be validated without private transient-state access.
8. Produce exact per-slice file plan, dependency map, test impact and hard-stop list.
9. Make no change and wait for explicit APPLY.

### Slice 0.8 Automated/static checks

- `git status --short --branch` or connector equivalent.
- `git diff --name-only` must be empty.
- Fetch exact shared file SHAs and open PR changed-file lists.
- Verify all target scene/script paths.

### Slice 0.9 Manual runtime checks

- None. A read-only baseline smoke may be recorded only if no scene is saved or imported.

### Slice 0.10 Acceptance criteria

- Zero repository diff.
- Exact base SHA recorded.
- Open PR/shared-contract conflict status resolved.
- Actual API deltas documented; no silent guessing.
- All proposed files checked for collisions.
- Execution plan ends in `WAITING FOR APPLY`.

### Slice 0.11 Rollback plan

- No rollback is needed because no changes are allowed.
- Any accidental modification must be restored before handoff and zero-diff proof repeated.

### Slice 0.12 Risks

| Risk | Mitigation |
| --- | --- |
| Stale reference snapshot | Fresh inspection takes precedence for integration mechanics. |
| Active shared PR | Stop/rebase/wait; do not stack silently. |
| Target/shared API missing | Hard stop with minimal prerequisite proposal, not local emulation. |


### Slice 0.13 Out of scope

- Any implementation, branch, commit, PR, scene save or runtime file creation.

### Slice 0.14 Handoff format

- Current main SHA, zero-diff proof, active PR map and shared API snapshot.
- Exact approved runtime base decision and implementation plan for Slices 1-11.
- `Commit SHA: N/A` - Slice 0 creates no commit.
- No branch/PR creation or mutation.
- Explicit `WAITING FOR APPLY` status.

## Slice 1 - Scene Shell and Continuous Spatial Greybox

### Slice 1.1 Goal

Replace the legacy one-shard reveal-step placeholder with the exact primitive-only continuous S-route, seven blocks, Environment/Gameplay/VFX/Runtime roots, Player/Camera/SoulOrb reuse, markers and passive safety/portal placeholders. Reserve one top-level node named `EnvironmentStateRoot`; no intermediate environment-state child is allowed. No puzzle logic.

### Slice 1.2 Preconditions

- Slice 0 APPLY received.
- Approved base branch created from exact Slice 0 SHA.
- Clean worktree and no shared-contract conflict.

### Slice 1.3 Exact files expected to change

```text
scenes/levels/Level_03.tscn
scenes/levels/level_03/blocks/Block_03_00_QuietInlet.tscn
scenes/levels/level_03/blocks/Block_03_01_WindTraceRoute.tscn
scenes/levels/level_03/blocks/Block_03_02_Shard05Overlook.tscn
scenes/levels/level_03/blocks/Block_03_03_PlayfulGlade.tscn
scenes/levels/level_03/blocks/Block_03_04_Connector.tscn
scenes/levels/level_03/blocks/Block_03_05_BreathingMeadow.tscn
scenes/levels/level_03/blocks/Block_03_06_FinalOverlook.tscn
```

### Slice 1.4 Exact files forbidden to change

- `project.godot` unless a proven blocker is separately approved
- all Level_01 and Level_02 files
- `scenes/levels/Level_04.tscn` and all Level_04 files
- `scripts/core/level_manager.gd` and legacy reveal-step files
- shared Player, Camera, SoulShard, reward controller/UI, LevelFinaleOverlay, LevelPortal and SceneTransition files
- save/GameState/autoload files
- raw GLB, Blender, final textures/materials and post-greybox art wrappers
- Level_07-15, final acrostic and confession scene files
- unrelated `.gd.uid`, `.uid`, `.import` or import metadata
- No Level_03 gameplay scripts.
- No functional shard, puzzle, finale or portal activation.

### Slice 1.5 Nodes, scenes and scripts

- Seven block wrappers with primitive floors/collision.
- EnvironmentRoot/BoundaryRoot hard blockers.
- GameplayRoot empty scene anchors and passive Area/Marker placeholders.
- P00-P16, CP0-CP4, RA0-RA6 markers.
- Player, Camera and SoulOrb_Follow shared instances.
- Passive hidden shared LevelPortal instance at canonical root, with interaction disabled by its own inactive state.
- One top-level `EnvironmentStateRoot` mount placeholder only. Slice 4 replaces that placeholder with the root instance of `Level03EnvironmentState.tscn` under the same name; it never creates an intermediate environment-state child.

### Slice 1.6 Methods, signals and contracts

| Contract item | Required contract |
| --- | --- |
| Spatial shell | All coordinates, route width, slopes, seams and clearances match Section 8. |
| Portal placeholder | Shared scene may be instanced/configured but remains inactive; no adapter. |


### Slice 1.7 Implementation steps

1. Replace legacy scene composition completely; do not preserve LevelManager/Step/RevealTrigger nodes.
2. Create seven primitive block scenes at exact zone centers/elevations.
3. Build one continuous collision-safe S-route through P00-P16.
4. Add EnvironmentRoot-owned visible rims and hard boundary belt behind them.
5. Add explicit route openings, puzzle clear zones, camera corridor and portal clearance.
6. Add PlayerFloorSpawnMarker, Player, SoulOrb_Follow and FollowCamera with exact relative paths.
7. Add passive FinalOverlook gate/portal root markers and SafetyRoot volumes/anchors without scripts.
8. Keep VFX and runtime roots as empty organizational placeholders. Reserve exactly one top-level `EnvironmentStateRoot` mount; do not add a nested environment-state node.
9. Verify no mandatory jump/gap and no catch floor.

### Slice 1.8 Automated/static checks

- Godot headless parse/check.
- Load Level_03 and every block PackedScene.
- Static transform audit against P00-P16 and zone schedule.
- Static absence of LevelManager, PoemRewardUI, Step01-04, RevealTriggerA-C and raw GLB.
- Static hierarchy audit: exactly one top-level `EnvironmentStateRoot` mount and no nested environment-state child.
- `git diff --check` and exact whitelist.

### Slice 1.9 Manual runtime checks

- Walk full route both directions.
- Inspect all route edges, openings, slopes and seams.
- Verify CP0-CP4 sightlines and camera collision.
- Confirm Player/SoulOrb do not clip geometry.
- Confirm portal remains hidden/inactive.

### Slice 1.10 Acceptance criteria

- Level loads without missing dependencies.
- Full route continuous and reachable.
- Width/slope/step/gap/camera rules pass.
- All authoritative anchors at exact coordinates.
- Hard blockers do not close route or puzzle/portal clearances.
- No puzzle/reward/progression behavior exists.
- Environment hierarchy mount is compatible with the final `Level03EnvironmentState.tscn` root-instance contract.

### Slice 1.11 Rollback plan

- Revert Slice 1 commit to restore legacy placeholder.
- A faulty block may be corrected/reverted independently; gameplay must not compensate for bad geometry.

### Slice 1.12 Risks

| Risk | Mitigation |
| --- | --- |
| Spawn root height uncertain | Marker is floor reference only; final root Y is accepted in Slice 2 by evidence. |
| Boundary blocks camera/route | Use visible rim + behind-rim blocker and repeat CP/route tests. |
| Monolithic scene growth | Keep seven block wrappers independently replaceable. |


### Slice 1.13 Out of scope

- Recovery behavior, shard availability, puzzles, environment transitions, finale and portal activation.

### Slice 1.14 Handoff format

- Branch, approved base SHA, slice-start SHA and final head SHA.
- Exact `git diff --name-only` and created/modified split.
- Summary of implemented behavior and preserved contracts.
- Commands/checks executed with factual outputs.
- Manual checks marked PASS / FAIL / NOT VERIFIED with evidence links/paths.
- Known risks, fallbacks, blockers and deviations.
- Confirmation that master forbidden/shared files have zero diff.
- Commit SHA, branch push proof and PR link.
- Internal gate result and automatic continue/stop decision.

## Slice 2 - Spawn Grounding and Explicit Fall Recovery

### Slice 2.1 Goal

Implement Level03RecoveryController, source-keyed suspension shell, minimal fade UI, evidence-derived Player runtime root Y values for spawn and RA0-RA6, and explicit one-teleport recovery while preserving all future puzzle state.

### Slice 2.2 Preconditions

- Slice 1 accepted and committed.
- Player collider/root/floor semantics re-inspected on actual base.

### Slice 2.3 Exact files expected to change

```text
scenes/levels/Level_03.tscn
scenes/levels/level_03/ui/RecoveryFadeOverlay.tscn
scripts/levels/level_03/level_03_recovery_controller.gd
```

Matching Godot UID sidecars are additionally allowed only for approved GDScript files in this slice:

```text
scripts/levels/level_03/<approved_script>.gd.uid
```

Every sidecar must have its approved sibling `.gd` in the same slice scope. Unrelated UID/import regeneration is forbidden.

### Slice 2.4 Exact files forbidden to change

- `project.godot` unless a proven blocker is separately approved
- all Level_01 and Level_02 files
- `scenes/levels/Level_04.tscn` and all Level_04 files
- `scripts/core/level_manager.gd` and legacy reveal-step files
- shared Player, Camera, SoulShard, reward controller/UI, LevelFinaleOverlay, LevelPortal and SceneTransition files
- save/GameState/autoload files
- raw GLB, Blender, final textures/materials and post-greybox art wrappers
- Level_07-15, final acrostic and confession scene files
- unrelated `.gd.uid`, `.uid`, `.import` or import metadata
- No puzzle, shard, environment, finale or portal scripts.
- No shared Player modification unless a separate blocker task is approved.

### Slice 2.5 Nodes, scenes and scripts

- Level03RecoveryController under LevelRuntimeRoot.
- SoftReturnVolume and authored OOB volumes wired explicitly.
- RA0-RA6 markers.
- RecoveryFadeOverlay minimal fade only.

### Slice 2.6 Methods, signals and contracts

| Contract item | Required contract |
| --- | --- |
| `set_current_anchor(id)` | Monotonic valid RA selection; RA0 fallback. |
| `set_suspension_source(id,active)` | Idempotent set; unknown source rejected. |
| `request_recovery(volume_id)` | One generation; fade, validated destination, teleport, set `Player.velocity = Vector3.ZERO`, fade in. |
| `recovery_completed(anchor_id)` | Emit once per accepted fall. |


### Slice 2.7 Implementation steps

1. Validate the Player runtime root Y at spawn and at RA0-RA6 using the actual shared CharacterBody, collider offset, `safe_margin`, `floor_snap_length`, Jolt grounding and stable camera behavior. Preserve every approved X/Z and floor-contact surface.
2. Freeze the proven spawn/RA root-Y values after acceptance and record them in both final implementation summaries. A Y-only technical correction preserving floor contact, camera framing and approved clearances is not a gameplay-layout revision.
3. Wire explicit volume enter/exit to RecoveryController.
4. Select latest valid RA by milestone, falling back toward RA0.
5. Implement one recovery generation and re-entry cooldown.
6. After teleport set `Player.velocity = Vector3.ZERO`; do not reset puzzle/progress state.
7. Clear any additional transient movement only through a proven public Player API. Never access private Player step-climb, floor or movement fields.
8. Implement source-keyed suspension and pending explicit overlap identity.
9. On last-source unlock, re-evaluate one time and recover only if still overlapping/invalid.
10. Keep fade 0.25-0.40 s, no failure text/damage/reload.

### Slice 2.8 Automated/static checks

- Headless parse/resource load.
- Harness: source-set idempotency and pending-overlap unlock cases.
- Harness: invalid anchor fallback and duplicate volume callback.
- Static check: recovery writes only `Player.velocity = Vector3.ZERO` directly and has no private Player step-climb, floor or movement-field access; no generic stuck timer.
- Evidence table verifies accepted spawn/RA0-RA6 root-Y values and unchanged X/Z/floor-contact surfaces.
- Whitelist/UID/harness cleanup checks.

### Slice 2.9 Manual runtime checks

- Load repeatedly and confirm stable grounded spawn.
- Fall through every authored recovery volume from all route zones.
- Test enter while suspended and remain; test exit before unlock.
- Test falls during/after Player step assist for stale motion.
- Confirm legal overlook/slow movement/blocker contact never recovers.

### Slice 2.10 Acceptance criteria

- No penetration, initial fall, snap oscillation or stale movement.
- Exactly one teleport per fall.
- `Player.velocity = Vector3.ZERO` is applied after teleport and gameplay state is preserved.
- Proven spawn and RA0-RA6 Player root-Y values are frozen and queued for both final implementation summaries.
- Recovery only from explicit volumes.
- Suspension semantics pass without exit/re-entry requirement.
- Additional transient movement is cleared only through a proven public API. If safe recovery cannot be achieved through public behavior, Slice 2 stops for a separately approved narrow shared prerequisite.

### Slice 2.11 Rollback plan

- Revert Slice 2; spatial shell remains walkable but fall recovery inactive.
- Do not patch shared Player inside this slice.

### Slice 2.12 Risks

| Risk | Mitigation |
| --- | --- |
| Stale step-climb state after teleport | P0 runtime evidence; stop for approved minimal safe-teleport API if needed. |
| Volume overlaps legal space | Move/resize authored volume, not recovery logic. |
| Multiple volume callbacks | Generation and cooldown guard. |


### Slice 2.13 Out of scope

- Puzzle state, shard/reward UI, environment transitions, finale and portal.

### Slice 2.14 Handoff format

- Branch, approved base SHA, slice-start SHA and final head SHA.
- Exact `git diff --name-only` and created/modified split.
- Summary of implemented behavior and preserved contracts.
- Commands/checks executed with factual outputs.
- Manual checks marked PASS / FAIL / NOT VERIFIED with evidence links/paths.
- Known risks, fallbacks, blockers and deviations.
- Confirmation that master forbidden/shared files have zero diff.
- Commit SHA, branch push proof and PR link.
- Internal gate result and automatic continue/stop decision.

## Slice 3 - Shard Adapter and Shared Reward Lifecycle

### Slice 3.1 Goal

Create one reusable Level03ShardSlot, instantiate three canonical hidden slots, explicitly register child SoulShards with the shared reward controller and prove reveal/availability/reward event ordering without any puzzle.

### Slice 3.2 Preconditions

- Slice 2 accepted.
- Current SoulShard and reward-controller contracts confirmed.
- No shared availability API is assumed.

### Slice 3.3 Exact files expected to change

```text
scenes/levels/Level_03.tscn
scenes/levels/level_03/gameplay/Level03ShardSlot.tscn
scripts/levels/level_03/level_03_shard_slot.gd
```

Matching Godot UID sidecars are additionally allowed only for approved GDScript files in this slice:

```text
scripts/levels/level_03/<approved_script>.gd.uid
```

Every sidecar must have its approved sibling `.gd` in the same slice scope. Unrelated UID/import regeneration is forbidden.

### Slice 3.4 Exact files forbidden to change

- `project.godot` unless a proven blocker is separately approved
- all Level_01 and Level_02 files
- `scenes/levels/Level_04.tscn` and all Level_04 files
- `scripts/core/level_manager.gd` and legacy reveal-step files
- shared Player, Camera, SoulShard, reward controller/UI, LevelFinaleOverlay, LevelPortal and SceneTransition files
- save/GameState/autoload files
- raw GLB, Blender, final textures/materials and post-greybox art wrappers
- Level_07-15, final acrostic and confession scene files
- unrelated `.gd.uid`, `.uid`, `.import` or import metadata
- No puzzle controller scripts.
- No environment/finale/portal behavior.
- No private SoulShard fields or shared SoulShard edits.

### Slice 3.5 Nodes, scenes and scripts

- ShardSlot_05/06/07 with exact parent overrides.
- One shared ShardRewardSequenceController and ShardRewardOverlay.
- Serialized hidden shared SoulShard children.

### Slice 3.6 Methods, signals and contracts

| Contract item | Required contract |
| --- | --- |
| `prepare_hidden()` | Validate packed hidden effective state before gameplay. |
| `reveal()` | First-terminal-wins presentation; deferred-safe enable; physics-frame verify; emit availability once. |
| `shard_collection_started(id)` | Slot semantic event from child reward request. |
| `shard_collected(id)` | Slot semantic event after child collected. |
| `register_shared_reward_controller()` | Explicit child registration. |


### Slice 3.7 Implementation steps

1. Build reusable slot scene with serialized disabled shared child.
2. Configure exact IDs/texts/reveal durations for three instances.
3. Explicitly register all children with one shared reward controller.
4. Implement reveal generation/fallback and effective-state verification.
5. Bridge child signals to canonical slot events with one-shot guards.
6. Create external temporary harness to call reveal independently.
7. Run stationary pre-overlap test for all three IDs.

### Slice 3.8 Automated/static checks

- Headless parse/load.
- Harness hidden-state assertions before frame 1.
- Harness duplicate reveal/real-vs-fallback order.
- Harness exact signal order and explicit registration.
- Static check for private SoulShard access/fork.
- Whitelist including only matching `.gd.uid`; harness absent.

### Slice 3.9 Manual runtime checks

- Stand inside each future shard radius before and throughout reveal.
- Verify no prompt/collection before availability.
- Verify one prompt/collection afterward without exit/re-entry.
- Verify each exact short text and reward return.
- Force missing reward overlay/camera and confirm shared safe completion.

### Slice 3.10 Acceptance criteria

- All three slots hidden before frame 1.
- Canonical IDs/texts exact.
- Event order reveal_started -> available -> collection_started -> collected is one-shot.
- No overlapping reward requests in normal flow.
- Stationary pre-overlap P0 passes or implementation stops for approved shared prerequisite.

### Slice 3.11 Rollback plan

- Revert Slice 3; recovery/spatial shell remains.
- Never solve a failed pre-overlap test by touching private fields or duplicating SoulShard.

### Slice 3.12 Risks

| Risk | Mitigation |
| --- | --- |
| Shared Area overlap does not refresh | Hard stop and minimal public shared API prerequisite. |
| Reward requests overlap via debug | Shared controller safely completes second request; normal macro flow must prevent overlap. |
| Hidden prompt leaks | Serialize and validate all public facets, not visibility alone. |


### Slice 3.13 Out of scope

- Puzzle systems, macro progression, environment phases, finale and portal.

### Slice 3.14 Handoff format

- Branch, approved base SHA, slice-start SHA and final head SHA.
- Exact `git diff --name-only` and created/modified split.
- Summary of implemented behavior and preserved contracts.
- Commands/checks executed with factual outputs.
- Manual checks marked PASS / FAIL / NOT VERIFIED with evidence links/paths.
- Known risks, fallbacks, blockers and deviations.
- Confirmation that master forbidden/shared files have zero diff.
- Commit SHA, branch push proof and PR link.
- Internal gate result and automatic continue/stop decision.

## Slice 4 - Macro Progress Shell, Puzzle Interfaces and E0

### Slice 4.1 Goal

Create the authoritative Level03ProgressController, locked macro state machine, puzzle scene/interface shells, exact NodePath wiring, the `Level03EnvironmentState.tscn` root instance named `EnvironmentStateRoot`, and clean E0 initialization without implementing puzzle gameplay.

### Slice 4.2 Preconditions

- Slice 3 accepted.
- All three slots and shared reward flow proven.
- Exact NodePaths verified against root tree.

### Slice 4.3 Exact files expected to change

```text
scenes/levels/Level_03.tscn
scenes/levels/level_03/gameplay/WindTrace.tscn
scenes/levels/level_03/gameplay/PlayfulSpark.tscn
scenes/levels/level_03/gameplay/BreathingMeadow.tscn
scenes/levels/level_03/environment/Level03EnvironmentState.tscn
scripts/levels/level_03/level_03_progress_controller.gd
scripts/levels/level_03/level_03_environment_state_controller.gd
```

Matching Godot UID sidecars are additionally allowed only for approved GDScript files in this slice:

```text
scripts/levels/level_03/<approved_script>.gd.uid
```

Every sidecar must have its approved sibling `.gd` in the same slice scope. Unrelated UID/import regeneration is forbidden.

### Slice 4.4 Exact files forbidden to change

- `project.godot` unless a proven blocker is separately approved
- all Level_01 and Level_02 files
- `scenes/levels/Level_04.tscn` and all Level_04 files
- `scripts/core/level_manager.gd` and legacy reveal-step files
- shared Player, Camera, SoulShard, reward controller/UI, LevelFinaleOverlay, LevelPortal and SceneTransition files
- save/GameState/autoload files
- raw GLB, Blender, final textures/materials and post-greybox art wrappers
- Level_07-15, final acrostic and confession scene files
- unrelated `.gd.uid`, `.uid`, `.import` or import metadata
- No puzzle implementation scripts yet.
- No finale/portal adapter scripts.
- No non-E0 environment transitions beyond validated no-op/target shell.

### Slice 4.5 Nodes, scenes and scripts

- Progress controller with full macro enum and canonical validation.
- Three gameplay scene shells exposing `arm()`/signals but no playable logic.
- `Level03EnvironmentState.tscn` whose root node is named `EnvironmentStateRoot`, carries `level_03_environment_state_controller.gd`, and directly owns `WorldEnvironment`, `LightingRoot`, `GlobalFogRoot` and `LocalHazeRoot`.
- Shared finale overlay instanced but hidden; shared portal inactive.

### Slice 4.6 Methods, signals and contracts

| Contract item | Required contract |
| --- | --- |
| `initialize_level()` | Validate refs/IDs, prepare slots, register shards, apply E0, arm Wind shell. |
| `puzzle_completed(id)` handler | Expected-ID/state guard; reveal matching slot. |
| `shard_collection_started/collected` handlers | Exact macro transitions and recovery source calls; the Shard_07 terminal path emits `all_rewards_completed()` exactly once and contains no direct finale-arm call. |
| `request_phase(phase)` | E0 works; later phases accepted only as recorded targets until Slice 8. |


### Slice 4.7 Implementation steps

1. Create exact root NodePath overrides.
2. Implement canonical expected sets and fail-closed initialization.
3. Connect upward signals and downward typed calls without circular references.
4. Implement macro transition function and duplicate/invalid warnings.
5. Instantiate `Level03EnvironmentState.tscn` directly as the top-level node named `EnvironmentStateRoot`; attach the environment controller to that root and create the four approved direct children only.
6. Apply E0 with local/deep-duplicated Environment; verify adjustment/fog enabled and route visibility.
7. Create minimal puzzle shells with stable IDs/public interfaces for later slices.
8. Declare the one-shot `all_rewards_completed()` signal contract but do not create a direct Progress-to-`arm_finale()` call. Keep portal/finale inactive and future puzzles noninteractive.

### Slice 4.8 Automated/static checks

- Macro harness valid path with injected canonical events.
- Invalid-order/duplicate/unknown-ID harness.
- All required NodePaths resolve to expected base type.
- Startup hierarchy validates `EnvironmentStateRoot` as the scene root with the controller script and four direct children; no intermediate child.
- Static Progress audit confirms `all_rewards_completed()` exists and no direct `arm_finale()` call exists.
- Static no global scans/no scene change/no LevelManager.
- Environment resource uniqueness check.
- Whitelist/UID/harness cleanup.

### Slice 4.9 Manual runtime checks

- Fresh load reaches ARRIVAL_READY/WIND_TRACE_ACTIVE shell state only.
- E0 is colored/alive and route readable.
- Future puzzle spaces remain physically open but noninteractive.
- No text/portal/reward starts without injected events.

### Slice 4.10 Acceptance criteria

- Initialization fails closed on missing required reference.
- Exact macro transitions/IDs pass harness.
- E0 no-lock and local-resource contract passes.
- Environment root hierarchy and `../VFXRoot/...` binding contract pass startup validation.
- Legacy nodes/copy absent.
- No actual puzzle can complete yet.

### Slice 4.11 Rollback plan

- Revert Slice 4; slots/recovery/spatial shell remain.
- Do not relax required NodePath validation to get a partial load.

### Slice 4.12 Risks

| Risk | Mitigation |
| --- | --- |
| Slice shell too broad | Keep puzzle scenes interface-only and no gameplay state beyond locked defaults. |
| Recursive reward scan fallback used | Explicit registration remains required; bounded scan root is ShardSlots only. |
| E0 reads dead/gray | Tune within 0.65-0.80 richness while retaining natural color. |


### Slice 4.13 Out of scope

- Puzzle mechanics, E1-E6 transitions, finale and portal activation.

### Slice 4.14 Handoff format

- Branch, approved base SHA, slice-start SHA and final head SHA.
- Exact `git diff --name-only` and created/modified split.
- Summary of implemented behavior and preserved contracts.
- Commands/checks executed with factual outputs.
- Manual checks marked PASS / FAIL / NOT VERIFIED with evidence links/paths.
- Known risks, fallbacks, blockers and deviations.
- Confirmation that master forbidden/shared files have zero diff.
- Commit SHA, branch push proof and PR link.
- Internal gate result and automatic continue/stop decision.

## Slice 5 - Wind Trace and Shard_05

### Slice 5.1 Goal

Implement the complete ordered three-arch Wind Trace, activity confirmation, overlap re-evaluation, hints and Shard_05 flow through reward completion and Spark arming.

### Slice 5.2 Preconditions

- Slice 4 accepted.
- Wind scene shell and Slot_05 available.
- Full route/arch clearances accepted.

### Slice 5.3 Exact files expected to change

```text
scenes/levels/Level_03.tscn
scenes/levels/level_03/gameplay/WindTrace.tscn
scenes/levels/level_03/vfx/Level03WindTraceVFX.tscn
scripts/levels/level_03/wind_trace_controller.gd
scripts/levels/level_03/wind_trace_arch.gd
scripts/levels/level_03/level_03_progress_controller.gd
```

Matching Godot UID sidecars are additionally allowed only for approved GDScript files in this slice:

```text
scripts/levels/level_03/<approved_script>.gd.uid
```

Every sidecar must have its approved sibling `.gd` in the same slice scope. Unrelated UID/import regeneration is forbidden.

### Slice 5.4 Exact files forbidden to change

- `project.godot` unless a proven blocker is separately approved
- all Level_01 and Level_02 files
- `scenes/levels/Level_04.tscn` and all Level_04 files
- `scripts/core/level_manager.gd` and legacy reveal-step files
- shared Player, Camera, SoulShard, reward controller/UI, LevelFinaleOverlay, LevelPortal and SceneTransition files
- save/GameState/autoload files
- raw GLB, Blender, final textures/materials and post-greybox art wrappers
- Level_07-15, final acrostic and confession scene files
- unrelated `.gd.uid`, `.uid`, `.import` or import metadata
- No Spark/Meadow gameplay implementation.
- No polished arch asset, material or final ribbon.
- No environment E1 visual implementation beyond phase request.

### Slice 5.5 Nodes, scenes and scripts

- Three typed arch Area3D nodes and full-width shapes.
- Arrival activity tracker inside WindTraceController.
- Primitive arch/ribbon/grass response placeholders.
- Slot_05 integration through Progress.

### Slice 5.6 Methods, signals and contracts

| Contract item | Required contract |
| --- | --- |
| `arm()` | One-time activity window. |
| `reevaluate_current_overlap_once()` | One active-arch overlap check after activation. |
| `arch_crossed(id)` | Only current exact ID. |
| `puzzle_completed(wind_trace)` | Logical completion once after Arch_03. |


### Slice 5.7 Implementation steps

1. Implement exact arch IDs/positions and dictionary validation.
2. Detect meaningful movement/camera change; auto-confirm exactly at 4 s.
3. Implement ordered crossing and future-arch no-op.
4. On new arch activation, run one current-overlap re-evaluation.
5. Implement 20/35 s hints and 5 s repeats.
6. Latch completion before emission.
7. Let Progress call Slot_05.reveal and process exact reward lifecycle.
8. After Shard_05 collected, request E1 and arm Spark shell.

### Slice 5.8 Automated/static checks

- Arch dictionary/duplicate/missing-ID harness.
- Activity input vs 4 s fallback one-shot harness.
- Future-arch overlap remain/exit cases.
- Duplicate same-frame crossing harness.
- Progress invalid-order and duplicate event regression.
- Whitelist/UID/harness cleanup.

### Slice 5.9 Manual runtime checks

- Run through arch center and both edges.
- Cross Arch_02/03 early.
- Remain inside future arch through activation; exit before activation variant.
- Leave route halfway and return.
- Wait for hint thresholds.
- Complete/collect Shard_05 and verify exact text/lock/recovery behavior.

### Slice 5.10 Acceptance criteria

- Exactly one ordered completion.
- No exit/re-entry requirement for newly active arch.
- No reset/punishment.
- Optional VFX removal does not block.
- Shard_05 exact lifecycle and Spark shell armed only after reward complete.

### Slice 5.11 Rollback plan

- Revert Slice 5; macro/shard shell remains.
- Do not compensate for bad arch geometry in controller code.

### Slice 5.12 Risks

| Risk | Mitigation |
| --- | --- |
| Activity false-positive | Define meaningful movement/camera delta and latch once. |
| Overlap double advance | Arch-local + controller expected-ID guard. |
| VFX coupling | Logical crossing occurs independently of presentation. |


### Slice 5.13 Out of scope

- Spark/Meadow implementation, full environment transitions, finale and portal.

### Slice 5.14 Handoff format

- Branch, approved base SHA, slice-start SHA and final head SHA.
- Exact `git diff --name-only` and created/modified split.
- Summary of implemented behavior and preserved contracts.
- Commands/checks executed with factual outputs.
- Manual checks marked PASS / FAIL / NOT VERIFIED with evidence links/paths.
- Known risks, fallbacks, blockers and deviations.
- Confirmation that master forbidden/shared files have zero diff.
- Commit SHA, branch push proof and PR link.
- Internal gate result and automatic continue/stop decision.

## Slice 6 - Playful Spark and Shard_06

### Slice 6.1 Goal

Implement the fixed A->B->C abstract Spark puzzle with destination telegraph, generation/fallback, settle occupancy re-evaluation, hints and Shard_06 reward flow.

### Slice 6.2 Preconditions

- Slice 5 accepted.
- Spark shell armed only after Shard_05 reward.
- Perch clearances and camera composition accepted.

### Slice 6.3 Exact files expected to change

```text
scenes/levels/Level_03.tscn
scenes/levels/level_03/gameplay/PlayfulSpark.tscn
scenes/levels/level_03/vfx/Level03PlayfulSparkVFX.tscn
scripts/levels/level_03/playful_spark_controller.gd
scripts/levels/level_03/playful_spark_perch.gd
scripts/levels/level_03/level_03_progress_controller.gd
```

Matching Godot UID sidecars are additionally allowed only for approved GDScript files in this slice:

```text
scripts/levels/level_03/<approved_script>.gd.uid
```

Every sidecar must have its approved sibling `.gd` in the same slice scope. Unrelated UID/import regeneration is forbidden.

### Slice 6.4 Exact files forbidden to change

- `project.godot` unless a proven blocker is separately approved
- all Level_01 and Level_02 files
- `scenes/levels/Level_04.tscn` and all Level_04 files
- `scripts/core/level_manager.gd` and legacy reveal-step files
- shared Player, Camera, SoulShard, reward controller/UI, LevelFinaleOverlay, LevelPortal and SceneTransition files
- save/GameState/autoload files
- raw GLB, Blender, final textures/materials and post-greybox art wrappers
- Level_07-15, final acrostic and confession scene files
- unrelated `.gd.uid`, `.uid`, `.import` or import metadata
- No Meadow gameplay.
- No mascot model/behavior.
- No random sequence or chase/timer failure.

### Slice 6.5 Nodes, scenes and scripts

- Three typed perch Area3D nodes and LandingMarkers.
- Abstract primitive SparkVisualRoot.
- Hop presentation/fallback and hint placeholder.
- Slot_06 integration.

### Slice 6.6 Methods, signals and contracts

| Contract item | Required contract |
| --- | --- |
| `arm()` | LOCKED -> INTRO once. |
| `perch_approached(id)` | Only enabled current perch. |
| `spark_hop_terminal(...)` | Generation/terminal latch. |
| `puzzle_completed(playful_spark)` | One emission after C reaction. |


### Slice 6.7 Implementation steps

1. Validate exact IDs/positions and fixed sequence.
2. Implement 3.0 m approach only for current perch.
3. Add 0.55 s preglow, 0.75-0.90 s hop and 1.2 s fallback.
4. Ignore all proximity during hop and 0.65 s settle.
5. After settle, one current-destination occupancy re-evaluation.
6. Implement 15/30 s hints and leave/re-enter persistence.
7. Latch completion and emit once at C.
8. Process Slot_06 reward; request E2 and arm Meadow shell after collected.

### Slice 6.8 Automated/static checks

- Fixed-sequence and wrong-perch harness.
- Real/fallback both-order race harness.
- Destination pre-overlap/post-settle re-evaluation harness.
- Leave/re-enter persistence harness.
- Duplicate completion/regression tests.
- Whitelist/UID/harness cleanup.

### Slice 6.9 Manual runtime checks

- Approach wrong future perch.
- Stand inside B/C before/during hop and settle.
- Leave at A/B and return.
- Disable hop VFX.
- Observe no mascot reading.
- Collect Shard_06 and verify exact copy and next-beat arming.

### Slice 6.10 Acceptance criteria

- One A->B->C path with no skip/double-hop.
- Player movement always free.
- Fallback preserves state.
- No punishment/reset.
- Shard_06 lifecycle exact and Meadow armed only after reward complete.

### Slice 6.11 Rollback plan

- Revert Slice 6; Wind/Shards remain.
- If moving impulse is unstable, use approved short dissolve/teleport fallback with same states/timings.

### Slice 6.12 Risks

| Risk | Mitigation |
| --- | --- |
| Spark reads as character/mascot | Reduce to abstract warm impulse or sequential seed-pod reactions. |
| Destination overlap misses event | One post-settle re-evaluation. |
| Race advances twice | Generation + terminal latch + expected state. |


### Slice 6.13 Out of scope

- Meadow, full environment transitions, finale and portal.

### Slice 6.14 Handoff format

- Branch, approved base SHA, slice-start SHA and final head SHA.
- Exact `git diff --name-only` and created/modified split.
- Summary of implemented behavior and preserved contracts.
- Commands/checks executed with factual outputs.
- Manual checks marked PASS / FAIL / NOT VERIFIED with evidence links/paths.
- Known risks, fallbacks, blockers and deviations.
- Confirmation that master forbidden/shared files have zero diff.
- Commit SHA, branch push proof and PR link.
- Internal gate result and automatic continue/stop decision.

## Slice 7 - Breathing Meadow and Shard_07

### Slice 7.1 Goal

Implement three persistent any-order grounded dwell petals, all six permutations, Rest Point progress, presentation/fallback races and Shard_07 reward flow.

### Slice 7.2 Preconditions

- Slice 6 accepted.
- Meadow shell armed only after Shard_06 reward.
- All targets visible and zones non-overlapping.

### Slice 7.3 Exact files expected to change

```text
scenes/levels/Level_03.tscn
scenes/levels/level_03/gameplay/BreathingMeadow.tscn
scenes/levels/level_03/vfx/Level03BreathingMeadowVFX.tscn
scripts/levels/level_03/breathing_meadow_controller.gd
scripts/levels/level_03/breathing_meadow_petal.gd
scripts/levels/level_03/level_03_progress_controller.gd
```

Matching Godot UID sidecars are additionally allowed only for approved GDScript files in this slice:

```text
scripts/levels/level_03/<approved_script>.gd.uid
```

Every sidecar must have its approved sibling `.gd` in the same slice scope. Unrelated UID/import regeneration is forbidden.

### Slice 7.4 Exact files forbidden to change

- `project.godot` unless a proven blocker is separately approved
- all Level_01 and Level_02 files
- `scenes/levels/Level_04.tscn` and all Level_04 files
- `scripts/core/level_manager.gd` and legacy reveal-step files
- shared Player, Camera, SoulShard, reward controller/UI, LevelFinaleOverlay, LevelPortal and SceneTransition files
- save/GameState/autoload files
- raw GLB, Blender, final textures/materials and post-greybox art wrappers
- Level_07-15, final acrostic and confession scene files
- unrelated `.gd.uid`, `.uid`, `.import` or import metadata
- No E-interaction default.
- No hidden target, order failure or reset.
- No final synthesis/main text/portal.

### Slice 7.5 Nodes, scenes and scripts

- Three typed petal Area3D nodes and gameplay-owned PetalPivots.
- Three Rest Point segments and ConvergenceMarker.
- Primitive preglow/lift/haze placeholders.
- Slot_07 integration.
- Meadow/environment presentation requests resolve through the root `EnvironmentStateRoot` controller and its `../VFXRoot/...` exports; no nested environment-state child.

### Slice 7.6 Methods, signals and contracts

| Contract item | Required contract |
| --- | --- |
| `arm()` | Enable grounded dwell and teaching preglow. |
| `petal_activated(id)` | Unique logical completion after 0.65 s grounded dwell. |
| `meadow_progress_changed(copy)` | First/second unique set progress. |
| `puzzle_completed(breathing_meadow)` | One emission after third unique ID. |


### Slice 7.7 Implementation steps

1. Validate exact petal IDs/coordinates and non-overlap.
2. Implement grounded 2.4 m / 0.65 s dwell.
3. Reset only incomplete dwell on exit/airborne.
4. Accept unique IDs in any order; keep completed states persistent.
5. Update one Rest Point segment per unique completion.
6. Run 1.3-1.6 s presentation with 1.8 s first-terminal fallback.
7. Implement 25/45 s hints.
8. Latch third completion and emit once.
9. After Slot_07 emits the accepted `shard_collected(Shard_07)`, Progress transitions to `WAITING_FOR_FINAL_OVERLOOK` and emits `all_rewards_completed()` exactly once. Progress does not call `arm_finale()` directly.

### Slice 7.8 Automated/static checks

- Parameterized all six permutations.
- Duplicate logical callback and completed-zone re-entry harness.
- Real/fallback same-frame both-order race.
- Grounded/airborne/early-exit dwell tests.
- No overlapping active dwell assertion.
- Duplicate Shard_07 collected callbacks produce one `all_rewards_completed()` emission maximum and zero direct Progress calls to `arm_finale()`.
- Environment/VFX paths resolve from the root `EnvironmentStateRoot`.
- Whitelist/UID/harness cleanup.

### Slice 7.9 Manual runtime checks

- Play all six orders in fresh runs/harness.
- Enter 0.3 s and leave.
- Jump/pass through zone.
- Revisit completed petals repeatedly.
- Disable petal VFX.
- Collect Shard_07 and verify exact copy plus one `all_rewards_completed()` emission only after reward completion; Finale arming itself is deferred to Slice 9 signal wiring.

### Slice 7.10 Acceptance criteria

- All six orders identical.
- Exactly three unique completions and one Shard_07 reveal.
- No duplicate count/presentation.
- No softlock from missing presentation.
- Macro reaches WAITING_FOR_FINAL_OVERLOOK only after reward completion.
- Progress emits `all_rewards_completed()` once and has no direct finale-arm call.

### Slice 7.11 Rollback plan

- Revert Slice 7; Wind/Spark remain.
- If proximity is proven unsuitable, stop for Producer-only decision before switching all three consistently to E.

### Slice 7.12 Risks

| Risk | Mitigation |
| --- | --- |
| Accidental activation | Grounded continuous dwell and clear preglow. |
| Overlapping zones | Authored spacing/shape correction; never simultaneous completion. |
| Order residue | Completed-ID set and parameterized permutation tests. |


### Slice 7.13 Out of scope

- Environment E1-E5 polish/integration, finale and portal.

### Slice 7.14 Handoff format

- Branch, approved base SHA, slice-start SHA and final head SHA.
- Exact `git diff --name-only` and created/modified split.
- Summary of implemented behavior and preserved contracts.
- Commands/checks executed with factual outputs.
- Manual checks marked PASS / FAIL / NOT VERIFIED with evidence links/paths.
- Known risks, fallbacks, blockers and deviations.
- Confirmation that master forbidden/shared files have zero diff.
- Commit SHA, branch push proof and PR link.
- Internal gate result and automatic continue/stop decision.

## Slice 8 - Environment E1-E5, Guidance and Recovery-Lock Integration

### Slice 8.1 Goal

Implement full non-blocking environment progression, local meadow effects, route guidance, synthesis preparation and source-keyed shard reward recovery suspension across all three rewards.

### Slice 8.2 Preconditions

- Slices 5-7 accepted.
- Macro events and all puzzle/shard lifecycles stable.
- Scene-local E0 resource already validated.

### Slice 8.3 Exact files expected to change

```text
scenes/levels/Level_03.tscn
scenes/levels/level_03/environment/Level03EnvironmentState.tscn
scenes/levels/level_03/vfx/Level03WindTraceVFX.tscn
scenes/levels/level_03/vfx/Level03PlayfulSparkVFX.tscn
scenes/levels/level_03/vfx/Level03BreathingMeadowVFX.tscn
scenes/levels/level_03/vfx/Level03GuidanceVFX.tscn
scripts/levels/level_03/level_03_environment_state_controller.gd
scripts/levels/level_03/level_03_progress_controller.gd
scripts/levels/level_03/level_03_recovery_controller.gd
```

Matching Godot UID sidecars are additionally allowed only for approved GDScript files in this slice:

```text
scripts/levels/level_03/<approved_script>.gd.uid
```

Every sidecar must have its approved sibling `.gd` in the same slice scope. Unrelated UID/import regeneration is forbidden.

### Slice 8.4 Exact files forbidden to change

- `project.godot` unless a proven blocker is separately approved
- all Level_01 and Level_02 files
- `scenes/levels/Level_04.tscn` and all Level_04 files
- `scripts/core/level_manager.gd` and legacy reveal-step files
- shared Player, Camera, SoulShard, reward controller/UI, LevelFinaleOverlay, LevelPortal and SceneTransition files
- save/GameState/autoload files
- raw GLB, Blender, final textures/materials and post-greybox art wrappers
- Level_07-15, final acrostic and confession scene files
- unrelated `.gd.uid`, `.uid`, `.import` or import metadata
- No finale main text or portal activation.
- No shared materials/resources mutated.
- No movement lock during phases.

### Slice 8.5 Nodes, scenes and scripts

- Root `EnvironmentStateRoot` scene instance with controller script on the root and direct children `WorldEnvironment`, `LightingRoot`, `GlobalFogRoot`, `LocalHazeRoot`; E0-E5 phase targets.
- Independent global and local tween channels.
- First/second petal local haze effects.
- Forward/return guidance placeholder.
- Recovery suspension wired to slot macro events.

### Slice 8.6 Methods, signals and contracts

| Contract item | Required contract |
| --- | --- |
| `request_phase(phase)` | Monotonic/idempotent E1/E2/E5. |
| `request_meadow_petal_effect(id)` | One local channel per unique petal. |
| `environment_transition_completed(...)` | Diagnostic only; macro movement does not wait. |
| `set_suspension_source(shard_reward,...)` | From collection_started/collected only. |


### Slice 8.7 Implementation steps

1. Revalidate the root-instance hierarchy and all `../VFXRoot/...` bindings, then duplicate/deep-copy all controlled resources before mutation.
2. Implement independent saturation/fog/light/local haze tween ownership.
3. Connect Shard_05/06/07 collected to E1/E2/E5 exactly once.
4. Connect first/second unique petal to E3/E4 local effects.
5. Implement guidance escalation for current beat and final return.
6. Ensure E5 preserves dormant portal.
7. Wire recovery source set around each reward and pending-overlap unlock re-evaluation.
8. Keep optional VFX removable.

### Slice 8.8 Automated/static checks

- E1->E2->E5 overlap race harness.
- Duplicate/out-of-order phase requests.
- Local haze per-ID idempotency.
- Static no `set_controls_enabled(false)` in environment code.
- Resource uniqueness/deep-duplicate audit.
- Recovery lock remain-inside/exit-before-unlock harness.
- Whitelist/UID/harness cleanup.

### Slice 8.9 Manual runtime checks

- Collect shards with minimal delay to overlap phases.
- Move/camera/puzzle during every transition.
- Disable each optional VFX scene.
- Enter recovery volume during every reward lock and test both unlock cases.
- Verify E0 remains alive and E5 final richness reaches 1.00.

### Slice 8.10 Acceptance criteria

- Canonical final saturation/fog/light targets reached under overlap.
- No shared-resource leak.
- No movement/camera lock.
- Guidance escalates without UI arrows.
- Recovery suspension works solely from canonical slot events.
- Portal remains dormant.

### Slice 8.11 Rollback plan

- Revert Slice 8; gameplay remains functional with E0/basic placeholders.
- Correct only affected tween channel; do not rebuild puzzle logic.

### Slice 8.12 Risks

| Risk | Mitigation |
| --- | --- |
| Tween cancellation strands value | Independent handles, generation and canonical snap only for affected property after logged fallback. |
| Environment too expensive | Cut decorative layers first, preserve phase semantics. |
| Recovery pending state stale | Explicit volume identity and one unlock reevaluation. |


### Slice 8.13 Out of scope

- Main text, finale overlay orchestration and portal.

### Slice 8.14 Handoff format

- Branch, approved base SHA, slice-start SHA and final head SHA.
- Exact `git diff --name-only` and created/modified split.
- Summary of implemented behavior and preserved contracts.
- Commands/checks executed with factual outputs.
- Manual checks marked PASS / FAIL / NOT VERIFIED with evidence links/paths.
- Known risks, fallbacks, blockers and deviations.
- Confirmation that master forbidden/shared files have zero diff.
- Commit SHA, branch push proof and PR link.
- Internal gate result and automatic continue/stop decision.

## Slice 9 - Final Overlook, Synthesis and Main Text

### Slice 9.1 Goal

Implement the Final Overlook presence gate, early-presence re-evaluation, non-blocking synthesis, mandatory LevelFinaleOverlay validation, exact main text and control/recovery lock ownership. Portal remains inactive.

### Slice 9.2 Preconditions

- Slice 8 accepted.
- All three rewards complete correctly and Progress exposes one-shot `all_rewards_completed()`.
- Exact main text and shared overlay API confirmed.

### Slice 9.3 Exact files expected to change

```text
scenes/levels/Level_03.tscn
scenes/levels/level_03/vfx/Level03SynthesisVFX.tscn
scripts/levels/level_03/level_03_finale_controller.gd
scripts/levels/level_03/level_03_progress_controller.gd
scripts/levels/level_03/level_03_environment_state_controller.gd
scripts/levels/level_03/level_03_recovery_controller.gd
```

Matching Godot UID sidecars are additionally allowed only for approved GDScript files in this slice:

```text
scripts/levels/level_03/<approved_script>.gd.uid
```

Every sidecar must have its approved sibling `.gd` in the same slice scope. Unrelated UID/import regeneration is forbidden.

### Slice 9.4 Exact files forbidden to change

- `project.godot` unless a proven blocker is separately approved
- all Level_01 and Level_02 files
- `scenes/levels/Level_04.tscn` and all Level_04 files
- `scripts/core/level_manager.gd` and legacy reveal-step files
- shared Player, Camera, SoulShard, reward controller/UI, LevelFinaleOverlay, LevelPortal and SceneTransition files
- save/GameState/autoload files
- raw GLB, Blender, final textures/materials and post-greybox art wrappers
- Level_07-15, final acrostic and confession scene files
- unrelated `.gd.uid`, `.uid`, `.import` or import metadata
- No portal adapter or activation.
- No replacement/shortening of LevelFinaleOverlay or canonical copy.

### Slice 9.5 Nodes, scenes and scripts

- FinalOverlookGate occupancy.
- Level03FinaleController state machine.
- Primitive SynthesisVFX and fallback.
- Shared LevelFinaleOverlay.
- Recovery source `main_text`.
- Scene signal wiring: Progress `all_rewards_completed()` -> FinaleController signal handler -> Finale-owned `arm_finale()` logic.

### Slice 9.6 Methods, signals and contracts

| Contract item | Required contract |
| --- | --- |
| `arm_finale()` | Finale-owned logic invoked only by the `all_rewards_completed()` signal handler; latch prerequisites and auto re-evaluate stored gate occupancy. Progress never calls it directly. |
| `begin_synthesis()` | 1.5-2.0 s generation/fallback; Player free. |
| `show_finale_text()` integration | Only true return permits lock/MAIN_TEXT_ACTIVE. |
| `main_text_closed()` | One semantic close; clears owned locks; portal call deferred to Slice 10. |


### Slice 9.7 Implementation steps

1. Validate gate coordinate/radius and early occupancy bookkeeping.
2. Connect Progress `all_rewards_completed()` to FinaleController. The Finale signal handler invokes its own `arm_finale()` logic; do not add a direct Progress call.
3. Accept the signal once only after Shard_07 reward completion.
4. Auto-start once if already inside; otherwise wait for entry.
5. Run synthesis real/fallback with first-terminal guard.
6. Validate overlay/method/signal before arming gameplay.
7. Render/check exact main text at 1280x720, 1920x1080, 16:10 and ultrawide.
8. Call `show_finale_text()`; only after true lock controls and recovery `main_text`.
9. On first close clear lock and emit/request-ready semantic event, but keep portal inactive.

### Slice 9.8 Automated/static checks

- Final-gate state harness including early presence.
- Duplicate `all_rewards_completed()` delivery produces one Finale arm; static audit confirms Progress has no direct `arm_finale()` call.
- Synthesis real/fallback race.
- Duplicate close harness.
- Missing/mismatched/false overlay fail-closed harness.
- Static exact text/ID and no timer skip.
- Whitelist/UID/harness cleanup.

### Slice 9.9 Manual runtime checks

- Reach overlook early.
- Remain inside while final prerequisite completes.
- Leave/re-enter before completion.
- Exit after synthesis starts.
- Inspect exact text at all target aspect ratios.
- Close normally and duplicate close.
- Force overlay failure in test copy.

### Slice 9.10 Acceptance criteria

- No synthesis/text before all rewards.
- Finale arming is delivered only by one accepted `all_rewards_completed()` signal and is latched once.
- Early presence starts once when armed.
- Player free during synthesis.
- Controls/recovery lock only while successfully opened text is active.
- Failure is fail-closed with portal inactive.
- Exact text fits and is shown once.

### Slice 9.11 Rollback plan

- Revert Slice 9; complete puzzle/environment flow remains.
- Do not shorten copy or bypass overlay on fit/API failure.

### Slice 9.12 Risks

| Risk | Mitigation |
| --- | --- |
| Text clipping | Hard stop and Producer-approved narrow UI solution. |
| Owned control lock leaks | Track only Finale-owned lock and release on every fail-closed exit. |
| Early gate presence missed | Stored occupancy + arm-time reevaluation. |


### Slice 9.13 Out of scope

- Portal adapter, portal activation and Level_04 transition.

### Slice 9.14 Handoff format

- Branch, approved base SHA, slice-start SHA and final head SHA.
- Exact `git diff --name-only` and created/modified split.
- Summary of implemented behavior and preserved contracts.
- Commands/checks executed with factual outputs.
- Manual checks marked PASS / FAIL / NOT VERIFIED with evidence links/paths.
- Known risks, fallbacks, blockers and deviations.
- Confirmation that master forbidden/shared files have zero diff.
- Commit SHA, branch push proof and PR link.
- Internal gate result and automatic continue/stop decision.

## Slice 10 - Shared Portal Activation and Level_04 Exit

### Slice 10.1 Goal

Implement the Level03PortalAdapter as a single request/diagnostic/semantic-forwarding layer around the shared LevelPortal, including exact AUTO_ENTER configuration and mandatory stationary early-overlap proof.

### Slice 10.2 Preconditions

- Slice 9 accepted.
- Main text close semantic event available.
- Actual shared portal API re-confirmed on branch.

### Slice 10.3 Exact files expected to change

```text
scenes/levels/Level_03.tscn
scenes/levels/level_03/vfx/Level03PortalAccentVFX.tscn
scripts/levels/level_03/level_03_portal_adapter.gd
scripts/levels/level_03/level_03_finale_controller.gd
scripts/levels/level_03/level_03_environment_state_controller.gd
scripts/levels/level_03/level_03_progress_controller.gd
```

Matching Godot UID sidecars are additionally allowed only for approved GDScript files in this slice:

```text
scripts/levels/level_03/<approved_script>.gd.uid
```

Every sidecar must have its approved sibling `.gd` in the same slice scope. Unrelated UID/import regeneration is forbidden.

### Slice 10.4 Exact files forbidden to change

- `project.godot` unless a proven blocker is separately approved
- all Level_01 and Level_02 files
- `scenes/levels/Level_04.tscn` and all Level_04 files
- `scripts/core/level_manager.gd` and legacy reveal-step files
- shared Player, Camera, SoulShard, reward controller/UI, LevelFinaleOverlay, LevelPortal and SceneTransition files
- save/GameState/autoload files
- raw GLB, Blender, final textures/materials and post-greybox art wrappers
- Level_07-15, final acrostic and confession scene files
- unrelated `.gd.uid`, `.uid`, `.import` or import metadata
- No shared LevelPortal edit inside Level_03 PR.
- No Level_03-local scene-loading, InteractionArea or ACTIVE fabrication.
- No success fallback on timeout/local VFX.

### Slice 10.5 Nodes, scenes and scripts

- Level03PortalAdapter under LevelRuntimeRoot with only `portal_core_path` and optional `local_portal_vfx_path`; no Player export/reference.
- Shared PortalCore at exact P16 anchor/config.
- Optional primitive PortalAccentVFX.
- Diagnostic timeout only.

### Slice 10.6 Methods, signals and contracts

| Contract item | Required contract |
| --- | --- |
| `activate_portal()` | Latch first request; request E6; start local accent; call shared activate once. |
| Shared `activation_completed` | Only accepted success event. |
| `portal_active()` | Emit once after actual shared event. |
| Diagnostic timeout | Report blocker only; never success. |


### Slice 10.7 Implementation steps

1. Apply exact target/AUTO_ENTER/no-confirmation/1.8 s config.
2. Keep PortalCore inactive before/during main text.
3. On first valid text close call adapter once.
4. Start optional local accent in parallel, not as activation owner.
5. Connect actual shared activation_completed and duplicate guard.
6. Add bounded accent timeout and separate missing-shared-completion diagnostic.
7. Run stationary early-overlap, rapid overlap and duplicate completion tests.
8. If early overlap fails, stop and create separate prerequisite proposal only.

### Slice 10.8 Automated/static checks

- Static no scene change/private portal method/ACTIVE inference.
- Duplicate activate/completion harness.
- Missing shared completion remains blocker, never success.
- Exact config/path audit, including absence of any adapter Player path/export.
- Whitelist/UID/harness cleanup.

### Slice 10.9 Manual runtime checks

- Stand inside future portal area before main text close and remain.
- Enter during activation and remain.
- Rapid enter/exit/enter around completion.
- Duplicate close/activation/completion.
- Force local accent missing/stalled.
- Confirm exactly one Level_04 transition.

### Slice 10.10 Acceptance criteria

- Portal inactive before/during text.
- One shared activate request.
- Adapter owns only the activation request, optional local accent, diagnostics and semantic forwarding of actual shared `activation_completed`; shared LevelPortal exclusively owns Player overlap filtering and transition behavior.
- No duplicate local formation ownership.
- Actual activation completion forwarded once.
- AUTO_ENTER early-overlap works without re-entry.
- At most one scene transition.
- Failure of early overlap or shared completion is a hard blocker.

### Slice 10.11 Rollback plan

- Revert Slice 10; main text flow remains complete without exit.
- Never patch shared portal inside the slice; isolate prerequisite.

### Slice 10.12 Risks

| Risk | Mitigation |
| --- | --- |
| Shared early-overlap bug | Mandatory STOP and separately approved public reevaluation API. |
| Local accent mistaken for success | Strict separation; local timer never emits portal_active. |
| Duplicate transition | Shared latch + adapter request/completion latches. |


### Slice 10.13 Out of scope

- Level_04 content, shared portal redesign and final portal art.

### Slice 10.14 Handoff format

- Branch, approved base SHA, slice-start SHA and final head SHA.
- Exact `git diff --name-only` and created/modified split.
- Summary of implemented behavior and preserved contracts.
- Commands/checks executed with factual outputs.
- Manual checks marked PASS / FAIL / NOT VERIFIED with evidence links/paths.
- Known risks, fallbacks, blockers and deviations.
- Confirmation that master forbidden/shared files have zero diff.
- Commit SHA, branch push proof and PR link.
- Internal gate result and automatic continue/stop decision.

## Slice 11 - Stabilization, Full Acceptance and Final Summary

### Slice 11.1 Goal

Harden the complete Level_03 greybox, execute all static/unit/manual/P0 matrices, verify pacing/camera/performance/reload, remove temporary diagnostics and create the factual content-equivalent implementation summary pair.

### Slice 11.2 Preconditions

- Slices 1-10 accepted.
- No unresolved P0/shared blocker.
- Full branch diff isolated to approved Level_03 files.

### Slice 11.3 Exact files expected to change

```text
scenes/levels/Level_03.tscn
scenes/levels/level_03/**/*.tscn
scripts/levels/level_03/*.gd
scripts/levels/level_03/*.gd.uid
docs/development/Level_03_Greybox_Implementation_Summary.md
Level_03_Greybox_Implementation_Summary.docx  # generate outside runtime worktree; include in PR only if explicitly requested
```

Matching Godot UID sidecars are additionally allowed only for approved GDScript files in this slice:

```text
scripts/levels/level_03/<approved_script>.gd.uid
```

Every sidecar must have its approved sibling `.gd` in the same slice scope. Unrelated UID/import regeneration is forbidden.

### Slice 11.4 Exact files forbidden to change

- `project.godot` unless a proven blocker is separately approved
- all Level_01 and Level_02 files
- `scenes/levels/Level_04.tscn` and all Level_04 files
- `scripts/core/level_manager.gd` and legacy reveal-step files
- shared Player, Camera, SoulShard, reward controller/UI, LevelFinaleOverlay, LevelPortal and SceneTransition files
- save/GameState/autoload files
- raw GLB, Blender, final textures/materials and post-greybox art wrappers
- Level_07-15, final acrostic and confession scene files
- unrelated `.gd.uid`, `.uid`, `.import` or import metadata
- No new architecture or shared-system change unless a failing acceptance test proves a blocker and a separate task is approved.
- No post-greybox art scope.
- No temporary harness in worktree.

### Slice 11.5 Nodes, scenes and scripts

- All Level_03 scenes/controllers/adapters.
- Final factual implementation summary Markdown.
- Content-equivalent user-facing DOCX summary.

### Slice 11.6 Methods, signals and contracts

| Contract item | Required contract |
| --- | --- |
| All public handlers | Idempotent, stale-callback safe and debug-quiet. |
| Reload | Clean INIT/E0 deterministic reset. |
| Summary pair | Same facts, tests, deviations and limitations in Markdown/DOCX. |


### Slice 11.7 Implementation steps

1. Audit changed-file whitelist and matching UID sidecars.
2. Run full headless/static/unit-like matrix.
3. Run complete manual acceptance/P0/softlock matrix.
4. Record A/B? Level is linear; instead record full blind-like and repeat routes plus all six Meadow permutations.
5. Verify CP0-CP4, route/boundary/recovery and UI resolutions.
6. Measure first/repeat pacing and 60 FPS baseline evidence.
7. Disable debug flags and remove all temporary harness files.
8. Create factual implementation summary Markdown with SHAs/files/tests/evidence/deviations.
9. Generate the content-equivalent user-facing DOCX outside the runtime worktree and visually QA it; add it to the PR only when explicitly requested.
10. Provide final merge recommendation without merging unless explicitly requested.

### Slice 11.8 Automated/static checks

- Godot `--headless --path . --quit --check-only`.
- Load every Level_03 PackedScene.
- UT-01 through UT-17 from Section 24.
- Static ST-01 through ST-19.
- `git diff --check` and exact whitelist/UID pairing.
- Search forbidden legacy copy/nodes, local scene loads, global scans and debug spam.

### Slice 11.9 Manual runtime checks

- Full PT/P0 matrix from Section 24.
- Blind-like first run and experienced repeat.
- All six Meadow permutations.
- All route recovery/OOB cases.
- All missing optional VFX cases.
- All target UI aspect ratios.
- Stationary shard/arch/perch/portal overlap tests.
- Long idle/leave/re-enter stability.

### Slice 11.10 Acceptance criteria

- All P0 tests pass.
- No softlock, duplicate side effect, invalid NodePath or parser error.
- First run 5:30-7:00 typical, <=8:00 scope alarm; repeat 3:00-4:00 typical, <=4:30 max.
- No forbidden/shared/unrelated diff.
- Both summary artifacts exist and are content-equivalent; the DOCX was generated outside the runtime worktree unless explicitly requested in the PR.
- `ST-01 through ST-19` pass. ST-18 confirms matching approved `.gd.uid` files; ST-19 confirms no temporary harness remains in the repository.
- Every NOT VERIFIED item is explicit and blocks final acceptance where mandatory.

### Slice 11.11 Rollback plan

- Corrective fixes should be separate small commits.
- If a fix expands scope or touches shared systems, stop and split to approved prerequisite.
- Revert last corrective commit rather than rewriting accepted history.

### Slice 11.12 Risks

| Risk | Mitigation |
| --- | --- |
| Late broad refactor | Forbidden; fix only the failing owner. |
| Manual evidence incomplete | Mark NOT VERIFIED and do not claim readiness. |
| Performance issue | Cut decorative placeholder layers first; preserve gameplay/state/copy. |
| Summary mismatch | Generate both from one canonical structured source and compare content. |


### Slice 11.13 Out of scope

- Final art/audio, save system, Level_04 changes, shared refactors and merge action.

### Slice 11.14 Handoff format

- Branch, approved base SHA, slice-start SHA and final head SHA.
- Exact `git diff --name-only` and created/modified split.
- Summary of implemented behavior and preserved contracts.
- Commands/checks executed with factual outputs.
- Manual checks marked PASS / FAIL / NOT VERIFIED with evidence links/paths.
- Known risks, fallbacks, blockers and deviations.
- Confirmation that master forbidden/shared files have zero diff.
- Commit SHA, branch push proof and PR link.
- Internal gate result and automatic continue/stop decision.

# 23. Master file ownership and changed-file whitelist

| Area | Policy |
| --- | --- |
| `docs/design/Level_03_Greybox_Development_Reference.md` | Required documentation source; current task only. |
| `Level_03_Greybox_Development_Reference.docx` | Content-equivalent Producer/manual-review artifact; current task only. |
| `scenes/levels/Level_03.tscn` | Only existing Level_03 runtime scene expected to be replaced. |
| `scenes/levels/level_03/**/*.tscn` | New Level_03-local primitive block/gameplay/environment/UI/VFX scenes only. |
| `scripts/levels/level_03/*.gd` | Approved Level_03-local GDScript only. |
| `scripts/levels/level_03/*.gd.uid` | Allowed only for matching approved sibling `.gd`; unrelated regeneration forbidden. |
| `docs/development/Level_03_Greybox_Implementation_Summary.md` | Mandatory committed factual summary in Slice 11. |
| `Level_03_Greybox_Implementation_Summary.docx` | Mandatory user-facing content-equivalent artifact; generate outside the runtime worktree and add to the PR only if explicitly requested. |
| Temporary harnesses | Outside worktree or removed before commit; never whitelisted. |
| Shared systems | Read/reuse only; any write is separate prerequisite after blocker evidence. |
| Level_04 | Target only; never modified. |


### 23.1 Runtime PR whitelist

```text
scenes/levels/Level_03.tscn
scenes/levels/level_03/**/*.tscn
scripts/levels/level_03/*.gd
scripts/levels/level_03/*.gd.uid  # matching approved sibling only
docs/development/Level_03_Greybox_Implementation_Summary.md
```

The user-facing `Level_03_Greybox_Implementation_Summary.docx` is mandatory for final handoff and is generated outside the runtime worktree unless explicitly requested in the PR.

# 24. Test and acceptance matrix

| ID | Area | Action | Expected result | Priority | Slice |
| --- | --- | --- | --- | --- | --- |
| T01 | Startup | Load Level_03 | No legacy nodes/errors; root `EnvironmentStateRoot` owns the controller and four direct children; E0, hidden shards, dormant portal | P0 | 1-4 |
| T02 | Spawn | Repeated fresh loads | Grounded, no penetration/fall/snap oscillation | P0 | 2 |
| T03 | Route | Traverse P00-P16 both directions | Continuous, width/slope/step/gap rules pass | P0 | 1/11 |
| T04 | Camera | Inspect CP0-CP4 | No collision trap/occlusion; next landmark readable | P0 | 1/11 |
| T05 | Recovery | Fall through each explicit volume | One teleport, velocity reset, state preserved | P0 | 2/11 |
| T06 | Recovery legality | Stand still/slow/blocker/overlook | No recovery | P0 | 2/11 |
| T07 | Recovery suspension remain | Enter volume under reward/text lock and remain | No teleport until last unlock; then one recovery | P0 | 2/8/9 |
| T08 | Recovery suspension exit | Enter under lock then exit before unlock | Pending clears; no recovery | P0 | 2/8/9 |
| T09 | Shard hidden | Pre-overlap each future shard | No prompt/collection before availability | P0 | 3 |
| T10 | Shard availability overlap | Remain inside through reveal | One available/collection without re-entry | P0 | 3 |
| T11 | Reward serialization | Trigger normal consecutive rewards | One overlay active; exact text; controls restore | P0 | 3/5-7 |
| T12 | Arrival activity | Meaningful input before 4 s | Immediate one confirmation | P1 | 5 |
| T13 | Arrival idle | No input for 4 s | Arch_01 pulses exactly at 4 s | P1 | 5 |
| T14 | Wind wrong order | Cross future arches early | No progress/reset | P0 | 5 |
| T15 | Wind edges | Cross each active arch near both edges | One crossing each | P0 | 5 |
| T16 | Wind future overlap remain | Remain in next inactive arch through activation | One advance on re-evaluation, no re-entry | P0 | 5 |
| T17 | Wind future overlap exit | Enter then exit before activation | Zero advance | P0 | 5 |
| T18 | Wind persistence | Leave halfway and return | Current arch/hints persist | P0 | 5 |
| T19 | Wind VFX missing | Disable placeholder VFX | Shard_05 still reachable | P0 | 5 |
| T20 | Shard_05 lifecycle | Complete/colllect | Exact order/text, Spark arms after reward | P0 | 5 |
| T21 | Spark locked | Reach glade before Shard_05 reward | No interaction | P0 | 6 |
| T22 | Spark wrong perch | Approach future perch | No punishment/reset | P1 | 6 |
| T23 | Spark hop race | Real/fallback both orders | One destination/stage advance | P0 | 6 |
| T24 | Spark destination overlap | Remain inside destination through hop/settle | One post-settle advance, no step-off | P0 | 6 |
| T25 | Spark persistence | Leave at A/B and return | Current perch persists | P0 | 6 |
| T26 | Spark VFX missing | Disable hop VFX | Fallback preserves sequence | P0 | 6 |
| T27 | Shard_06 lifecycle | Complete/collect | Exact order/text, Meadow arms after reward | P0 | 6 |
| T28 | Meadow locked | Enter before Shard_06 reward | Ambient only | P0 | 7 |
| T29 | Meadow permutations | Run all six orders | Identical set/state; one reveal | P0 | 7/11 |
| T30 | Meadow early exit | Dwell 0.3 s then leave | No activation; completed IDs persist | P1 | 7 |
| T31 | Meadow airborne | Pass/jump through zone | No dwell accumulation | P1 | 7 |
| T32 | Meadow duplicate | Reenter completed / duplicate callback | No count/presentation repeat | P0 | 7 |
| T33 | Petal race | Real/fallback same frame both orders | One segment/effect/ID | P0 | 7 |
| T34 | Shard_07 lifecycle | Complete/collect and inject duplicate terminal callback | Exact order/text; one `all_rewards_completed()` emission; Finale later arms only from that signal; no direct Progress arm call | P0 | 7/9 |
| T35 | Environment race | E1 then E2 then E5 overlap | Final saturation 1.00; no stranded values | P0 | 8 |
| T36 | Environment movement | Move/camera during all phases | No lock | P0 | 8 |
| T37 | Environment optional VFX | Disable every VFX adapter | Logical flow complete | P0 | 8 |
| T38 | Final early arrival | Reach gate before rewards | No text/portal | P0 | 9 |
| T39 | Final stored presence | Stay in gate then complete prerequisite | Synthesis starts once automatically | P0 | 9 |
| T40 | Synthesis noncancel | Leave after start | Continues, one text | P1 | 9 |
| T41 | Main text exact/fit | All target resolutions/aspects | Exact copy, <=6 readable lines, no clipping | P0 | 9/11 |
| T42 | Main text fail closed | Missing API/false result | Portal inactive; owned lock released | P0 | 9 |
| T43 | Duplicate text close | Emit close twice | One portal request | P0 | 9/10 |
| T44 | Portal dormant | Before/during text | No interaction/transition | P0 | 10 |
| T45 | Portal exact config | Inspect runtime properties | Level_04, AUTO_ENTER, no confirmation, 1.8 s | P0 | 10 |
| T46 | Portal local VFX missing | Disable/stall accent | Shared activation unaffected | P1 | 10 |
| T47 | Portal duplicate completion | Emit actual completion twice | One local active event | P0 | 10 |
| T48 | Portal stationary early overlap | Remain inside future area through activation | Exactly one Level_04 transition without re-entry | P0 | 10/11 |
| T49 | Portal rapid overlap | Enter/exit/enter around activation | No early/duplicate transition | P0 | 10/11 |
| T50 | Portal missing shared completion | Suppress event beyond diagnostic timeout | Blocker reported; no success/load | P0 | 10 |
| T51 | Invalid IDs/order | Inject future/unknown/duplicate events | No invalid state mutation | P0 | 4/11 |
| T52 | Reload | Reload at every partial stage | Clean INIT/E0 coherent reset | P0 | 11 |
| T53 | Pacing first | Blind-like run | 5:30-7:00 typical; <=8:00 alarm | P1 | 11 |
| T54 | Pacing repeat | Experienced correct run | 3:00-4:00 typical; <=4:30 max | P1 | 11 |
| T55 | Performance | Full greybox at project baseline | Stable 60 FPS target evidence; no runaway logs | P1 | 11 |


### 24.1 Required automated/unit-like matrix

| ID | Expected |
| --- | --- |
| UT-01 Macro valid path | Canonical injected events reach PORTAL_ACTIVE in exact order. |
| UT-02 Invalid order | Future puzzle/shard events do nothing. |
| UT-03 Duplicate IDs | Every duplicate has one side effect maximum, including one `all_rewards_completed()` emission and one Finale arm maximum. |
| UT-04 Spark race | Real/fallback both orders produce one destination/stage. |
| UT-05 Petal race | Real/fallback both orders produce one segment/ID. |
| UT-06 Meadow permutations | All six permutations produce identical final set. |
| UT-07 Main-text close race | Two closes -> one portal request. |
| UT-08 Portal completion/blocker | Duplicate actual completion -> one event; missing completion -> blocker, never success. |
| UT-09 Environment race | E1/E2/E5 overlap reaches canonical final values. |
| UT-10 Missing optional VFX | Logical flow persists. |
| UT-11 Recovery unlock re-evaluation | Remain/exit pending overlap cases pass. |
| UT-12 Reload | Fresh coherent INIT/E0. |
| UT-13 Shard stationary pre-overlap | No early collect; one post-enable collect without re-entry. |
| UT-14 Wind activation overlap | Remain advances once; early exit zero; duplicate same-frame one. |
| UT-15 Spark post-settle overlap | One re-evaluated approach; no step-off/double-hop. |
| UT-16 Main-text fail closed | No portal on missing/failed overlay. |
| UT-17 Finale arm delivery | Progress emits `all_rewards_completed()` once; Finale receives it and runs its own `arm_finale()` logic once; no direct Progress call exists. |


### 24.2 Static validation matrix

| ID | Validation |
| --- | --- |
| ST-01 | Godot headless check passes. |
| ST-02 | Every local PackedScene loads. |
| ST-03 | All required NodePaths resolve to expected types; `EnvironmentStateRoot` is the environment scene root with the controller script and exactly four approved direct children. |
| ST-04 | Exact IDs/texts; legacy copy absent. |
| ST-05 | No LevelManager/PoemRewardUI/Step/RevealTrigger legacy tree. |
| ST-06 | Portal target/config/anchor exact. |
| ST-07 | Environment resources local/deep duplicated and adjustment/fog enabled. |
| ST-08 | Exact identity sets; no child-order/spatial inference. |
| ST-09 | Three shards explicitly registered; Progress consumes only slot macro events; finale arming leaves Progress only through `all_rewards_completed()` and no direct `arm_finale()` call exists. |
| ST-10 | No gameplay scripts inside imported models. |
| ST-11 | Forbidden/shared files zero diff. |
| ST-12 | No local `change_scene_to_file`. |
| ST-13 | No broad tree search/node_added progression. |
| ST-14 | No per-frame print spam. |
| ST-15 | Packed shard children disabled before frame 1. |
| ST-16 | Portal adapter has no Player export/reference, state/loading ownership or success fallback. |
| ST-17 | Finale overlay API validates; failure path fail closed. |
| ST-18 | Every `.gd.uid` has approved sibling `.gd`; no unrelated UID/import churn. |
| ST-19 | No temporary harness remains in worktree. |

Final static acceptance requires **ST-01 through ST-19**. ST-18 verifies matching approved `.gd.uid` files and prohibits unrelated UID/import churn. ST-19 verifies that no temporary harness remains in the repository.


# 25. Softlock and failure matrix

| Risk | Prevention | Fallback / stop | Test |
| --- | --- | --- | --- |
| Future arch/perch/petal entered early | Locked/expected-ID guard | No penalty; re-evaluate only at approved activation point | T14/T16/T21/T28 |
| Leave Wind/Spark/Meadow halfway | Local persistent state | Resume current arch/perch; completed petals persist | T18/T25/T29 |
| Player remains in newly active arch | One current-overlap re-evaluation | Advance once without re-entry | T16 |
| Player remains at Spark destination | Ignore hop/settle; one post-settle re-evaluation | Advance once without step-off | T24 |
| Shard future radius pre-overlap | Serialized hidden state + physics verification | One post-enable overlap refresh or STOP shared prerequisite | T09/T10 |
| Duplicate puzzle/shard callback | Canonical accepted-ID/state latches | Ignore/warn once | T51 |
| Duplicate finale-arm delivery | Progress emission latch + Finale arm latch | One `all_rewards_completed()` delivery and one Finale arm maximum; no direct Progress call | T34/UT-17 |
| Spark real/fallback race | Generation + terminal latch | First terminal wins | T23 |
| Petal real/fallback race | Per-ID generation + terminal latch | First terminal wins | T33 |
| Environment phases overlap | Independent tween channels + canonical targets | Affected property snap only after logged fallback | T35 |
| Fall during reward/main text | Source-keyed suspension + pending overlap | Last-unlock reevaluation, no re-entry | T07/T08 |
| Recovery anchor invalid | Validate latest then walk back RA chain | RA0 guaranteed fallback | T05 |
| Player stale step state after recovery | Public-state evidence test | STOP for narrow Player API | T02/T05 |
| Reach Final Overlook early | Stored occupancy, gate locked | Arm-time reevaluation | T38/T39 |
| Synthesis VFX missing | Generation + bounded fallback | Open main text only after one terminal | T40 |
| Main overlay API/fit fails | Startup validation and true-return lock ownership | Fail closed; no portal | T42 |
| Duplicate text close | Close latch | One portal request | T43 |
| Portal local accent fails | Accent timeout local only | Shared activation continues | T46 |
| Shared portal completion missing | Diagnostic timeout only | Hard blocker, never success | T50 |
| Portal early overlap | Mandatory P0 | Separate approved shared prerequisite on failure | T48 |
| Scene reload partial state | Clean reset policy | INIT/E0 coherent rebuild | T52 |


# 26. Producer gates and automatic execution

| Gate | After slice | Required evidence | Action |
| --- | --- | --- | --- |
| G0 Preflight | 0 | Base SHA, open PR map, shared APIs, exact file plan, zero diff | Explicit user APPLY required. |
| G1 Spatial | 1 | Route/blocks/markers/camera/boundary evidence | Internal PASS -> continue. |
| G2 Recovery | 2 | Grounding, all volume falls, suspension shell | Internal PASS -> continue. |
| G3 Shard lifecycle | 3 | Hidden/stationary pre-overlap, exact event order/reward | Internal PASS -> continue; P0 fail -> stop. |
| G4 Macro/E0 | 4 | State/NodePath/ID harness, E0/local resource | Internal PASS -> continue. |
| G5 Wind | 5 | Ordered/overlap/persistence/hints/Shard_05 | Internal PASS -> continue. |
| G6 Spark | 6 | Race/occupancy/persistence/Shard_06 | Internal PASS -> continue. |
| G7 Meadow | 7 | All six permutations/races/Shard_07 plus one `all_rewards_completed()` emission and no direct Progress arm call | Internal PASS -> continue. |
| G8 Environment | 8 | Tween races, no lock, recovery lock integration | Internal PASS -> continue. |
| G9 Finale | 9 | Signal-only Finale arming, duplicate delivery guard, gate/synthesis/text fit/fail-closed | Internal PASS -> continue. |
| G10 Portal | 10 | Exact config, actual completion, stationary early overlap | Internal PASS -> continue; shared blocker -> stop. |
| G11 Final acceptance | 11 | Full P0/static/manual/pacing/performance + summary pair | READY TO MERGE / CORRECT / STOP. |


After APPLY, G1-G11 do not require user confirmation when PASS. Automatic continuation stops only for: P0 failure; shared-system blocker; scope deviation; unresolved active-PR/base conflict; required Producer-only decision; or mandatory evidence that cannot be verified.

# 27. Definition of Done

- Level_03 is a complete playable primitive-only greybox on the approved continuous S-route.
- Exact P00-P16, gameplay anchors, CP0-CP4, RA0-RA6, zone sizes, elevations and clearances pass.
- Legacy LevelManager/PoemRewardUI/Step/RevealTrigger flow is absent.
- Player, Camera, SoulOrb_Follow, SoulShard, reward UI/controller, LevelFinaleOverlay and LevelPortal are reused without unapproved shared edits.
- Spawn and every recovery destination are grounded; Slice 2 evidence-derived Player root-Y values are frozen in both implementation summaries; explicit recovery produces one teleport, sets `Player.velocity = Vector3.ZERO` and preserves state.
- Three slots are hidden before frame 1 and pass stationary pre-overlap availability for Shard_05/06/07.
- Macro progression is strictly linear; only Meadow petals are any-order.
- Wind Trace, Spark and Meadow pass their deterministic state/race/persistence contracts.
- Exact short texts and exact main text render without clipping and retain `ё`.
- Environment E0-E6 is alive from start, non-blocking, local-resource safe and race-safe; `Level03EnvironmentState.tscn` is instantiated as the root node named `EnvironmentStateRoot` with the controller script on that root and no intermediate child.
- Progress emits `all_rewards_completed()` exactly once after accepted Shard_07 completion; FinaleController receives that signal and runs its own `arm_finale()` logic exactly once. Progress has no direct finale-arm call.
- Finale requires all three reward completions and Final Overlook presence; early presence is reevaluated.
- Main text opens once, locks controls/recovery only while successfully visible and fails closed on API/fit error.
- Portal is dormant through main text, configured exactly for Level_04/AUTO_ENTER/no confirmation, activated once and owns all Player overlap filtering, InteractionArea behavior, transition latching and loading. The adapter has no Player reference.
- Stationary early-overlap portal P0 passes without exit/re-entry and produces one transition maximum.
- All P0/static/unit/manual tests pass, including `ST-01 through ST-19`, or mandatory NOT VERIFIED items block acceptance.
- First/repeat pacing budgets and agreed 60 FPS baseline evidence pass.
- Runtime diff contains only whitelist files and matching approved `.gd.uid` sidecars.
- No temporary harness, unrelated UID/import churn, raw art, save/GameState, project settings or Level_04 changes.
- Final implementation summary Markdown and user DOCX exist and are content-equivalent; the DOCX is generated outside the runtime worktree unless explicitly requested in the PR.

# 28. Suggested branch, commit and PR naming

| Purpose | Recommended value |
| --- | --- |
| Runtime branch | `feature/level-03-after-our-conversations-greybox` |
| Runtime PR title | `Build Level 03 After Our Conversations greybox` |
| Slice commits | `Level 03 Slice N: <small completed capability>` |
| Corrective commits | `Level 03: fix <single failing acceptance behavior>` |
| Documentation source | `docs/design/Level_03_Greybox_Development_Reference_v1.1.md` |


- Do not reuse or amend closed PR #105.
- Do not stack on a shared-feature branch without Producer-approved base decision.
- Do not merge automatically unless explicitly requested after G11.

# 29. Final Codex implementation prompt requirements

A future implementation prompt must instruct Codex to:

- Read `AGENTS.md` and this complete reference before any plan.
- Execute Slice 0 only, make zero changes and return `WAITING FOR APPLY` with `Commit SHA: N/A`.
- After explicit APPLY, create/use the approved separate branch and execute Slices 1-11 sequentially.
- Implement only one slice at a time; validate and commit before moving to the next.
- Automatically continue after internal gate PASS without asking for repeated approval.
- Stop only under the hard-stop rules in Section 26.
- Use exact IDs, coordinates, NodePaths, text and event ordering from this reference.
- Preserve shared ownership and never introduce local scene-loading/private shared-state coupling.
- Use matching `.gd.uid` sidecars only; remove temporary harnesses before commit.
- Never report manual visual/runtime evidence as PASS unless actually observed.
- Create the final implementation summary Markdown and content-equivalent user DOCX in Slice 11; generate the DOCX outside the runtime worktree unless explicitly requested in the PR.
- Return final branch/SHAs/PR/evidence/risks/DoD assessment without merging unless asked.

# 30. Final implementation handoff requirements

| Artifact | Requirement |
| --- | --- |
| `docs/development/Level_03_Greybox_Implementation_Summary.md` | Committed factual runtime-PR summary. |
| `Level_03_Greybox_Implementation_Summary.docx` | Content-equivalent user-facing artifact; generated outside the runtime worktree unless explicitly requested in the PR. |


Both summaries must include: source/base/head SHAs; branch and PR; full changed-file list; slice-by-slice commit map; implemented behavior; architecture deviations and approvals; commands/static tests; manual/P0 evidence; pacing/performance data; NOT VERIFIED items; blockers/limitations; rollback notes; final whitelist proof; Definition of Done result; merge recommendation.

# Appendix A. Source traceability

| Reference area | Primary source |
| --- | --- |
| Emotional safety, exact text, narrative arc | Narrative/Scenario Package |
| S-route, visual hierarchy, alive E0, forbidden shrine/arena/mascot reading | Visual Master v1.1 |
| Coordinates, dimensions, timings, puzzle rules, pacing, acceptance | Gameplay Spec v1.1 |
| Ownership, APIs, NodePaths, state/race/recovery/portal contracts | Technical Architecture v1.1 |
| Boundary ownership, proxy scope, clearances, greybox vs art split | Art Production Bible v1.1 |
| Actual reusable API and integration blockers | Fresh current-main Slice 0 inspection |


# Appendix B. Controller property and startup wiring contract

| Owner | Required exported properties / wiring | Explicitly absent |
| --- | --- | --- |
| `Level03ProgressController` | Player, puzzle, shard-slot, environment, reward-controller and recovery paths from Section 12; emits `all_rewards_completed()` exactly once | No direct `arm_finale()` call path; no finale-controller export required |
| `EnvironmentStateRoot` | Root of `Level03EnvironmentState.tscn`; controller script on root; VFX paths are `../VFXRoot/...` | No intermediate environment-state child |
| `Level03FinaleController` | Progress signal connection, Player, gate, overlay, environment, portal adapter and recovery paths | No polling of Progress and no duplicate arming path |
| `Level03PortalAdapter` | `portal_core_path`; optional `local_portal_vfx_path`; actual shared `activation_completed` connection | No Player export/reference, InteractionArea, AUTO_ENTER, transition latch or scene-loading ownership |
| `Level03RecoveryController` | Player, fade, explicit recovery volumes and milestone root paths | No private Player step-climb, floor or movement-field access |

Startup validation must prove these properties and signal connections before gameplay is armed.


# Appendix C. Documentation-stage completion statement

This Version 1.1 package creates documentation artifacts only. It does not create or modify runtime scenes, scripts, branches, commits or pull requests. Runtime preflight remains unauthorized until the Producer explicitly starts Slice 0, and runtime implementation remains unauthorized until the user subsequently supplies explicit APPLY.
