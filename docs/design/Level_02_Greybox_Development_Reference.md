# Level_02 Greybox Development Reference

FIFTEEN SHARDS OF LIGHT - Level_02 «Живой свет»

Максимально подробный технический reference для безопасной поэтапной реализации playable greybox в Godot 4.x + GDScript.

| Поле | Зафиксированное значение |
|---|---|
| Репозиторий | `MindDevastation/fifteen-shards-of-light` |
| Версия reference | `1.1` |
| Целевой repo-файл | `docs/design/Level_02_Greybox_Development_Reference.md` |
| Целевой Producer DOCX | `Level_02_Greybox_Development_Reference_v1.1.docx` |
| Статус | Documentation-only reference; runtime implementation запрещена в текущей задаче |
| Дата префлайта | 21 June 2026 |
| Целевой runtime | Godot 4.x / GDScript / Forward Plus / Jolt Physics |
| Целевой результат | Полностью проходимый greybox Level_02 из primitives и placeholder visuals |
| Рекомендуемая runtime-ветка | `feature/level-02-living-light-greybox` |
| Рекомендуемый runtime PR | `Build Level 02 Living Light greybox` |


## Version 1.1 Change Log

Version 1.1 preserves the approved architecture, gameplay, slice structure and acceptance matrix while correcting the documentation package and execution contract:

- established `docs/design/Level_02_Greybox_Development_Reference.md` as the required repository Markdown source and locked Markdown/DOCX content equivalence;
- allowed only matching Godot script UID sidecars under `scripts/levels/level_02/*.gd.uid` for approved Level_02 GDScript files;
- restored the mandatory final implementation summary pair: repository Markdown plus user-facing DOCX;
- clarified that only Slice 0 waits for explicit user `APPLY`; after `APPLY`, Slices 1-7 continue automatically while internal gates pass;
- locked upgraded and legacy `LevelPortal` configuration/delegation behavior;
- locked the event order for both trials: solved latch → `trial_completed` → `ShardSlot.reveal()` → collectible enabled → `shard_available` → reward completion → `shard_collected`;
- clarified Slice 0 handoff (`Commit SHA: N/A`), documentation scope and temporary harness cleanup.

## 1. Назначение документа

Этот документ является единым источником реализации для Producer, Codex task generator, Godot implementation agent и implementation reviewer. Он объединяет утвержденные visual, gameplay, architecture и art-production документы с фактическими контрактами текущего репозитория.

- использовать reference напрямую как вход для Codex;
- декомпозировать Level_02 на восемь безопасных slice: Slice 0-7;
- Slice 0 выполняется без изменений и единственный требует явного пользовательского `APPLY`;
- после `APPLY` реализовывать Slices 1-7 последовательно: один slice за раз, с validation и commit после каждого;
- G1-G6 являются внутренними acceptance gates и при PASS не требуют пользовательского подтверждения;
- не расширять scope и не трогать shared systems без доказанного blocker;
- проверять A→B и B→A как равноправные маршруты;
- обеспечить отсутствие softlock даже при missing optional VFX callbacks;
- завершить разработку factual implementation summary.

## 2. Утвержденные source documents

| Документ | Роль |
|---|---|
| `Level_02_Gameplay_Map_and_Level_Design_Spec.docx` | Высший authority для точных координат, размеров, маршрутов, таймингов, puzzle rules, softlock и acceptance. |
| `Level_02_Technical_Architecture_and_State_Model_v1.1.docx` | Authority для ownership, NodePaths, IDs, APIs, signals, state machines, portal/environment contracts и file boundaries. |
| `Level_02_Visual_Master_Concept_Package.docx` | Authority для эмоционального чтения, визуального языка, силуэтов, палитры и запрещенных направлений. |
| `Level_02_Art_Production_Bible_v1.1.docx` | Authority для boundary map, layer split, pivot ownership, collision policy, route openings и post-greybox art boundaries. |
| Текущий репозиторий на момент implementation preflight | Authority только для фактических shared API и текущих файлов. Не может молча отменять утвержденный Level_02 design. |

При конфликте использовать следующий порядок: exact gameplay specification → technical architecture → visual master → art production bible. Фактический репозиторий определяет способ интеграции с shared systems; несовпадение API является blocker, который нужно задокументировать, а не скрыть локальным хакингом.

## 3. Source-of-truth summary

- Level_02 - тихо работающий древний природный механизм света, а не мертвый мир, храм, алтарь или boss arena.
- Одна центральная круглая арена и три внешние платформы: Arrival, Trial A, Trial B.
- Trial A и Trial B доступны в любом порядке.
- Trial completion, shard availability и shard collection - разные события.
- Глобальное environment progression начинается только после фактического `SoulShard.collected`, то есть после завершения short reward sequence.
- После первого уникального shard возвращается насыщенность и немного уменьшается туман.
- После второго уникального shard туман расходится сильнее; игрок свободно возвращается в центр.
- Final event стартует только при одновременно выполненных условиях: оба shards собраны, fog transition готов, игрок находится в центральной зоне, final еще не стартовал.
- Main level text появляется после завершения central final visual.
- Portal formation/activation начинается только после закрытия main text.
- Portal ведет строго в `res://scenes/levels/Level_03.tscn`.
- Greybox использует primitives и placeholder VFX. Final art, audio, typography, save/GameState и Level_03 implementation не входят.

## 4. Критический repo preflight snapshot

| Наблюдение | Решение для Level_02 |
|---|---|
| `AGENTS.md` требует inspection → plan → test impact, малые slices, отсутствие unrelated changes и post-change handoff. | Каждый slice обязан соблюдать этот workflow. |
| Текущий `scenes/levels/Level_02.tscn` - устаревший one-shard placeholder с `LevelManager`, одной площадкой, одним `SoulShard`, `PoemRewardUI` и немедленным portal flow. | Scene composition заменяется целиком в отдельной Level_02 ветке; старую gameplay-схему сохранять не нужно. |
| `LevelManager` поддерживает только один shard → UI → portal. | Не расширять и не рефакторить. Level_02 получает локальный `Level02ProgressController`. |
| PR #47 по факту уже merged, несмотря на устаревшую формулировку задания. | Все файлы Level_01/PR #47 остаются immutable и не входят в Level_02 diff. |
| Открыт PR #83 `feature/implement-level-01-finale-and-portal-transitions`. | Не трогать PR #83 и его Level_01/shared changes. Runtime Slice 0 обязан повторно инспектировать shared contracts после решения PR #83. |
| PR #83 изменяет `LevelPortal`, `camera_controller`, `SoulShard`, `ShardRewardOverlay`, `project.godot` и другие shared files. | Reference использует capability-based integration; запрещено предполагать legacy или upgraded portal без повторного preflight. |
| PR #104 уже merged в PR #83 branch, а не в main. | Не считать его изменения доступными в main, пока PR #83 не merged. |

> Hard gate: runtime implementation не начинается, пока Slice 0 не зафиксирует конкретный base SHA и фактический shared API после решения активного Level_01 PR stack.

## 5. Scope

### 5.1 Входит в greybox

- central arena;
- arrival platform;
- Trial A platform;
- Trial B platform;
- three connecting paths;
- boundaries и fall recovery;
- Player и existing follow camera;
- start activation;
- central start/trial progress sectors и spiral placeholders;
- Trial A - Three Beams;
- Trial B - Echo of Light;
- два Soul Shards;
- два short shard texts;
- non-blocking saturation/fog transitions;
- either-order progression;
- center-return final event;
- main level text;
- portal to Level_03;
- duplicate-signal protection;
- no-softlock behavior;
- development summary.

### 5.2 Явно исключено

- final 3D assets и Blender integration;
- final materials, shaders, particles и lighting polish;
- final sound, music, voiceover;
- cinematics и long camera takeover;
- final typography;
- save system, checkpoint persistence, GameState, new autoload;
- Level_03 development;
- Level_07-15 cleanup;
- final acrostic и confession scene;
- combat, health, damage, death, timers, inventory, enemies;
- project-wide puzzle framework;
- broad shared refactor;
- Level_01 changes и PR #83 changes.

### 5.3 Documentation outputs

Required and content-equivalent reference outputs:

- `docs/design/Level_02_Greybox_Development_Reference.md` - repository Markdown source;
- `Level_02_Greybox_Development_Reference_v1.1.docx` - self-contained Producer/manual-review copy.

Mandatory Slice 7/final-handoff implementation summary outputs:

- `docs/development/Level_02_Greybox_Implementation_Summary.md` - committed runtime-PR evidence source;
- `Level_02_Greybox_Implementation_Summary.docx` - user-facing artifact generated from the same final summary content. It does not have to be committed into the runtime PR unless explicitly requested.

## 6. Hard technical rules

- `project.godot` не менять без доказанного blocker и отдельного approval.
- Не менять PR #47/Level_01 files; не изменять active PR #83 branch.
- Не использовать broad refactor или unrelated formatting/import churn.
- Не использовать global node-name scanning для критических Level_02 dependencies.
- Не вешать gameplay scripts на raw GLB/imported child nodes.
- Не создавать GameState, save system или new autoload.
- Не использовать random/procedural Trial B sequence.
- Не использовать free-angle optics в Trial A.
- Не предполагать, что Trial A всегда первый.
- Не активировать portal до закрытия main text.
- Не блокировать Player во время 9 s/7 s environment transitions.
- Не удалять Level_07-15.
- Не делать progression зависимым только от optional VFX completion signal; всегда нужен guarded fallback.
- Не мутировать shared Environment/material resources in place.
- Не выводить count через `count += 1`; authoritative count derived from per-ID booleans.
- Godot UID sidecars разрешены только как `scripts/levels/level_02/<approved_script>.gd.uid`, когда рядом существует одобренный этим reference `.gd`; unrelated UID regeneration запрещена.
- Не регенерировать unrelated `.uid`, `.import` или import metadata.
- Temporary validation harness files должны находиться вне repository worktree или быть удалены до каждого commit; они не входят в changed-file whitelist.

## 7. Existing architecture inventory

| Система | Фактический contract | Level_02 usage |
|---|---|---|
| Player | `CharacterBody3D`; `set_controls_enabled(bool)`; E searches `player_interactable` group and calls `can_player_interact(player)` then `interact(player)`. | Reuse unchanged. Statues and manual replay implement existing interface. Main text may call `set_controls_enabled(false)`. |
| Camera | Orbit camera with collision; current main recognizes visible controls named `PoemRewardUI` and `ShardRewardOverlay`; active PR #83 may move part of this to `mouse_blocking_ui` group. | Reuse unchanged. Keep canonical UI node names and re-inspect PR #83 contract in Slice 0. |
| SoulShard | Exports `shard_id`, `reward_text`; emits `reward_sequence_requested(shard, id, text, world_position)` and later parameterless `collected`. | Reuse unchanged as child of `Level02ShardSlot`. IDs: `Shard_03` and `Shard_04`. |
| ShardRewardSequenceController | Exports overlay/player/search-root paths; supports `register_shard(shard)`; otherwise recursively scans configured root. | Set explicit overlay/player paths, point scan root to an empty dedicated scope, explicitly register both child shards. Do not modify shared script. |
| ShardRewardOverlay | Single reusable overlay; emits `confirmation_requested` and `return_completed`. | One instance serializes both short shard rewards. |
| PoemRewardUI | `show_placeholder_reward(text)` and `closed` signal. | Reuse only for main level text, with node name exactly `PoemRewardUI`. |
| LevelPortal - main snapshot | `activate()` shows/enables trigger and frame; guards duplicate scene load. | Legacy fallback contract only if implementation base still uses it. |
| LevelPortal - active PR #83 candidate | Own activation animation/state, signals such as `activation_completed`, interaction modes and scene transition. | Preferred after PR #83 merge. Adapter delegates formation to core and does not duplicate shared visual activation. |
| LevelManager | One-shard linear flow. | Do not use or extend inside Level_02. |
| Level_03 | Target scene path contract is fixed by approved source. | Reference only. No Level_03 files changed. |

### 7.1 Shared API drift resolution

`Level02PortalAdapter` must be capability-based and validated at Slice 0.

**Upgraded shared LevelPortal configuration:**

```gdscript
target_scene_path = "res://scenes/levels/Level_03.tscn"
entry_mode = LevelPortal.EntryMode.AUTO_ENTER
require_entry_confirmation = false
```

When the actual base contains the upgraded `LevelPortal`:

1. `begin_formation()` is called only after the main text closes.
2. The adapter applies the exact configuration above, then calls shared `PortalCore.activate()` once.
3. The adapter does not play a duplicate local formation because the shared portal owns activation presentation.
4. The adapter waits for shared `activation_completed` or a guarded fallback timeout, then emits local `portal_activated` once.
5. The adapter never owns scene loading, body filtering or the shared transition latch.

When the actual base contains the legacy immediate portal:

1. The local adapter plays the approved 2.8 s primitive placeholder formation.
2. After local formation completion or its guarded fallback, it calls `PortalCore.activate()` exactly once.
3. It emits local `portal_activated` only after the guarded activation path completes.

In both capability paths the adapter never calls `change_scene_to_file`. If early overlap fails against the actual portal, stop and request a separately approved backward-compatible shared prerequisite. Do not silently patch `LevelPortal` in the Level_02 PR.

### 7.2 Shared files forbidden by default

```text
project.godot
scenes/levels/Level_01.tscn
scenes/levels/level_01/**
scripts/levels/level_01_*.gd
scripts/levels/barrier_open_controller.gd
scripts/core/level_manager.gd
scripts/player/player_controller.gd
scripts/player/camera_controller.gd
scripts/soul/soul_shard.gd
scripts/soul/soul_orb_world.gd
scenes/core/SoulShard.tscn
scripts/core/shard_reward_sequence_controller.gd
scenes/core/ShardRewardSequenceController.tscn
scripts/ui/**
scenes/ui/ShardRewardOverlay.tscn
scenes/ui/PoemRewardUI.tscn
scenes/core/LevelPortal.tscn
scripts/core/level_portal.gd
scenes/levels/Level_03.tscn
scenes/levels/Level_07.tscn through Level_15.tscn
assets/**/*.glb
assets/**/*.import
```

Исключение возможно только после отдельного blocker report с минимальным backward-compatible proposal и producer approval.

## 8. Exact spatial greybox specification

| Область | World center | Physical / usable | Y / orientation |
|---|---|---|---|
| Central arena | `Vector3(0.00, 0.00, 0.00)` | R22 physical; R20 usable | root reference |
| Arrival | `Vector3(0.00, -0.50, -51.00)` | R10 physical; R8.5 usable | azimuth 180° |
| Trial A | `Vector3(-44.17, 0.40, 25.50)` | R11 physical; R9.5 usable | azimuth 300° |
| Trial B | `Vector3(44.17, 0.80, 25.50)` | R11 physical; R9.5 usable | azimuth 60° |
| Player floor spawn marker | `Vector3(0.00, -0.30, -54.50)` | floor reference only | faces +Z; Player origin/collider clearance must be validated |
| Portal socket | `Vector3(0.00, 0.05, 0.00)` | R3.5 visual footprint | floor-integrated |
| Central activation | `Vector3(0.00, 0.50, 0.00)` | cylinder R5.2, H2.5 | presence only |
| Portal visual center | `Vector3(0.00, 2.20, 0.00)` | W3.6 × H4.0 approx. | placeholder |
| Portal trigger | `Vector3(0.00, 1.70, 0.00)` | R2.2, H3.4 | disabled until formation complete |
| Soft return | complete envelope below `Y=-6.0` | large Area3D | nearest SafeAnchor; no death/reset |

| Route | Endpoints | Center / heading | Dimensions |
|---|---|---|---|
| Arrival route | `(0,0,-22)` → `(0,-0.5,-41)` | `(0,-0.25,-31.5)`, yaw 180° | L19 × W5.5; clear W≥5.0; nominal slope 1.5° |
| Trial A route | `(-19.05,0,11)` → `(-34.64,0.4,20)` | `(-26.845,0.2,15.5)`, yaw -60° | L18 × W5.5; clear W≥5.0; nominal slope 1.3° |
| Trial B route | `(19.05,0,11)` → `(34.64,0.8,20)` | `(26.845,0.4,15.5)`, yaw +60° | L18 × W5.5; clear W≥5.0; nominal slope 2.5° |

- Hard slope maximum: 8°.
- Every circular boundary has explicit route opening ≥6.0 m.
- No blocker crosses route caps, channels or interaction corridors.
- No mandatory jump or precision platforming.
- No invisible catch floor bridging gaps. `SoftReturnVolume` is recovery authority.
- Route clear walking width never below 5.0 m.
- Props >1.8 m remain ≥3.5 m from route centerline in later art passes.
- Portal clearance cylinder R5.5/H5.0 remains unobstructed.

## 9. Proposed repository file tree

```text
scenes/
└── levels/
    ├── Level_02.tscn                         # replace obsolete placeholder
    └── level_02/
        ├── blocks/
        │   ├── Block_02_00_CentralArena.tscn
        │   ├── Block_02_01_Arrival.tscn
        │   ├── Block_02_02_TrialA.tscn
        │   ├── Block_02_03_TrialB.tscn
        │   └── Block_02_04_RoutesAndBoundaries.tscn
        ├── gameplay/
        │   ├── Level02ProgressController.tscn
        │   ├── Level02ArrivalGameplay.tscn
        │   ├── Level02CentralArenaGameplay.tscn
        │   ├── TrialA_ThreeBeams.tscn
        │   ├── TrialA_BeamStatue.tscn
        │   ├── TrialB_EchoOfLight.tscn
        │   ├── TrialB_SymbolPad.tscn
        │   ├── Level02ShardSlot.tscn
        │   ├── Level02PortalAdapter.tscn
        │   └── Level02SoftReturnVolume.tscn
        ├── state/
        │   └── Level02EnvironmentState.tscn
        └── vfx/
            ├── Level02ArrivalVFX.tscn
            ├── Level02CentralLightVFX.tscn
            ├── Level02TrialAVFX.tscn
            ├── Level02TrialBVFX.tscn
            ├── Level02EnvironmentVFX.tscn
            └── Level02PortalVFX.tscn

scripts/
└── levels/
    └── level_02/
        ├── level_02_progress_controller.gd
        ├── level_02_arrival_controller.gd
        ├── level_02_central_arena_controller.gd
        ├── level_02_environment_state_controller.gd
        ├── level_02_shard_slot.gd
        ├── level_02_portal_adapter.gd
        ├── level_02_soft_return_volume.gd
        ├── trial_a_controller.gd
        ├── trial_a_beam_statue.gd
        ├── trial_b_controller.gd
        ├── trial_b_symbol_pad.gd
        ├── trial_b_replay_interactor.gd
        ├── level_02_central_vfx_adapter.gd
        ├── trial_a_vfx_adapter.gd
        ├── trial_b_vfx_adapter.gd
        ├── level_02_environment_vfx_adapter.gd
        └── level_02_portal_vfx_adapter.gd

docs/
└── development/
    └── Level_02_Greybox_Implementation_Summary.md  # Slice 7
```

VFX adapter scripts may be omitted when a primitive scene can expose the same methods directly without gameplay coupling. Omission must be recorded; API boundaries and fallback behavior remain mandatory.

## 10. Proposed root node tree

```text
Level_02 (Node3D)
├── LevelRuntimeRoot (Node)
│   ├── Level02ProgressController
│   ├── ShardRewardSequenceController          # existing
│   └── ShardRegistrationScope (Node)           # intentionally empty scan root
├── EnvironmentRoot (Node3D)
│   └── BaseGeometry (Node3D)
│       ├── Block_02_00_CentralArena
│       ├── Block_02_01_Arrival
│       ├── Block_02_02_TrialA
│       ├── Block_02_03_TrialB
│       └── Block_02_04_RoutesAndBoundaries
├── GameplayRoot (Node3D)
│   ├── ArrivalGameplay
│   ├── CentralArenaGameplay
│   ├── TrialA_ThreeBeams
│   ├── TrialB_EchoOfLight
│   ├── Level02PortalAdapter
│   └── SafetyRoot
│       ├── SafeAnchors
│       │   ├── SafeAnchor_Arrival
│       │   ├── SafeAnchor_Center
│       │   ├── SafeAnchor_TrialA
│       │   └── SafeAnchor_TrialB
│       └── SoftReturnVolume
├── EnvironmentStateRoot (Node3D)
│   └── Level02EnvironmentState
├── VFXRoot (Node3D)
│   ├── ArrivalVFX
│   ├── CentralLightVFX
│   ├── TrialAVFX
│   ├── TrialBVFX
│   ├── EnvironmentVFX
│   └── PortalVFX
├── PlayerRoot (Node3D)
│   └── Player                                # existing Player.tscn
├── CameraRoot (Node3D)
│   └── FollowCamera                          # Camera3D + existing script
└── UILayer (CanvasLayer)
    ├── ShardRewardOverlay                    # existing; exact node name
    └── PoemRewardUI                          # existing; exact node name
```

### 10.1 Block wrapper pattern

```text
Block_02_0X_<Name> (Node3D)
├── EnvironmentRoot (Node3D)
│   ├── GroundRoot
│   ├── ArchitectureRoot
│   ├── FoliageRoot
│   └── DressingRoot
├── CollisionRoot (Node3D)
│   ├── WalkableBodies
│   └── BoundaryBodies
└── Markers (Node3D)
    ├── CenterMarker / EntryMarker / ExitMarker
    ├── GameplayAlignmentMarkers
    └── CameraPreviewMarker
```

- No puzzle controllers, shards or progression Area3D inside block scenes.
- Only primitives/placeholder meshes and explicit collision in greybox.
- Future art wrappers replace children below `EnvironmentRoot`, not gameplay nodes.
- Markers are alignment aids only; they never own state.

### 10.2 Central arena gameplay tree

```text
Level02CentralArenaGameplay (Node3D)
├── CentralArenaController
├── CentralActivationZone (Area3D, R5.2/H2.5)
├── CenterChoiceBand (non-colliding helper)
├── ReturnGuide_A (Area3D)
├── ReturnGuide_B (Area3D)
├── PortalSocketMarker
└── DevDebugRoot (optional, disabled by default)
    └── StateLabel3D
```

### 10.3 Trial A tree

```text
TrialA_ThreeBeams (Node3D)
├── TrialAController
├── TrialPresenceZone (Area3D)
├── Statue_01 (TrialA_BeamStatue)
├── Statue_02 (TrialA_BeamStatue)
├── Statue_03 (TrialA_BeamStatue)
├── CentralColumnGameplay
│   ├── Receiver_01
│   ├── Receiver_02
│   └── Receiver_03
├── ShardSpawnMarker (local 0,2.0,0)
├── ShardSlot_A (Level02ShardSlot; Shard_03)
└── Preview_TrialA

TrialA_BeamStatue (Node3D)
├── RotationPivot
│   └── VisualAnchor
├── InteractionArea
│   └── CollisionShape3D
├── PromptAnchor
├── BeamOrigin
├── BeamTargets
│   ├── Target_Left
│   ├── Target_Center
│   └── Target_Right
└── WorldInteractionPrompt
```

### 10.4 Trial B tree

```text
TrialB_EchoOfLight (Node3D)
├── TrialBController
├── TrialPresenceZone (Area3D)
├── Pads
│   ├── SymbolPad_Leaf (symbol_id=&"leaf")
│   ├── SymbolPad_Sun  (symbol_id=&"sun")
│   ├── SymbolPad_Wave (symbol_id=&"wave")
│   └── SymbolPad_Star (symbol_id=&"star")
├── CentralBudGameplay
│   ├── PetalPivot_01
│   ├── PetalPivot_02
│   ├── PetalPivot_03
│   ├── PetalPivot_04
│   └── ReplayInteractor
├── ShardSpawnMarker (local 0,2.3,0)
├── ShardSlot_B (Level02ShardSlot; Shard_04)
├── SequenceTimer
├── ErrorTimer
├── StageTransitionTimer
└── HintPulseTimer

TrialB_SymbolPad (Area3D)
├── CollisionShape3D
├── VisualAnchor
├── PadCenter
└── CueAnchor
```

### 10.5 Shard, environment, portal and safety trees

```text
Level02ShardSlot (Node3D)
├── RevealRoot
├── SoulShard (existing)
└── RevealFallbackTimer

Level02EnvironmentState (Node3D)
├── EnvironmentStateController
├── WorldEnvironment_Level02
└── Lighting
    ├── SunLight
    └── AccentLights

Level02PortalAdapter (Node3D)
├── PortalFormationRoot
├── FormationFallbackTimer
├── PortalCore (existing LevelPortal)
└── PortalCenterMarker

Level02SoftReturnVolume (Area3D)
└── CollisionShape3D
```

## 11. Stable IDs, texts and identity mapping

| Type | Canonical value | Rule |
|---|---|---|
| Trial A ID | `&"trial_a"` | Accepted once; independent of completion order. |
| Trial B ID | `&"trial_b"` | Accepted once; independent of completion order. |
| Shard A ID | `&"Shard_03"` | Trial A only; exact case. |
| Shard B ID | `&"Shard_04"` | Trial B only; exact case. |
| Main text ID | `&"level_02_main_text"` | Diagnostic/milestone ID. |
| Sector arrival | `&"arrival"` | Start sector/channel. |
| Sector Trial A | `&"trial_a"` | Activated by `Shard_03` collection. |
| Sector Trial B | `&"trial_b"` | Activated by `Shard_04` collection. |
| Trial B sequence | `[&"leaf", &"sun", &"wave", &"star"]` | Fixed; never inferred from child order or position. |

### 11.1 Locked runtime text

| ID | Exact string stored/displayed without decorative outer quotes |
|---|---|
| `Shard_03` | В тебе есть свет, который не нужно делать громче |
| `Shard_04` | Рядом с мыслью о тебе во мне больше жизни |
| `level_02_main_text` | Мне дорого, что в тебе есть свой свет - иногда яркий, иногда совсем тихий. Его не нужно делать громче или превращать во что-то другое. Мне нравится, что он твой. И рядом с мыслью о тебе во мне становится больше жизни |

## 12. Exact owner-relative NodePaths

| Owner property | Relative NodePath |
|---|---|
| Progress.player_path | `../../PlayerRoot/Player` |
| Progress.arrival_controller_path | `../../GameplayRoot/ArrivalGameplay/ArrivalController` |
| Progress.central_controller_path | `../../GameplayRoot/CentralArenaGameplay/CentralArenaController` |
| Progress.trial_a_controller_path | `../../GameplayRoot/TrialA_ThreeBeams/TrialAController` |
| Progress.trial_b_controller_path | `../../GameplayRoot/TrialB_EchoOfLight/TrialBController` |
| Progress.environment_controller_path | `../../EnvironmentStateRoot/Level02EnvironmentState/EnvironmentStateController` |
| Progress.portal_adapter_path | `../../GameplayRoot/Level02PortalAdapter` |
| Progress.main_text_ui_path | `../../UILayer/PoemRewardUI` |
| Progress.reward_sequence_controller_path | `../ShardRewardSequenceController` |
| Progress.shard_slot_a_path | `../../GameplayRoot/TrialA_ThreeBeams/ShardSlot_A` |
| Progress.shard_slot_b_path | `../../GameplayRoot/TrialB_EchoOfLight/ShardSlot_B` |
| RewardSequence.overlay_path | `../../UILayer/ShardRewardOverlay` |
| RewardSequence.player_path | `../../PlayerRoot/Player` |
| RewardSequence.shard_search_root_path | `../ShardRegistrationScope` |
| PortalAdapter.portal_core_path | `PortalCore` |
| PortalAdapter.portal_vfx_adapter_path | `../../VFXRoot/PortalVFX` |
| PortalAdapter.fallback_timer_path | `FormationFallbackTimer` |
| Environment.world_environment_path | `../WorldEnvironment_Level02` |
| Environment.lighting_root_path | `../Lighting` |
| Environment.environment_vfx_adapter_path | `../../../VFXRoot/EnvironmentVFX` |

Paths must be validated from the owner node, not copied as scene-root paths. No `/root/...`, no recursive critical lookup, no child-index identity mapping.

## 13. Signal and API contract

| Signal | Emitter | Receiver / meaning |
|---|---|---|
| `arrival_activated()` | ArrivalController | Progress accepts once; opens routes/start presentation. |
| `trial_completed(trial_id)` | Trial A/B controller | Emitted immediately after the solved state is latched and before `ShardSlot.reveal()`; Progress records trial fact only. |
| `shard_available(shard_id)` | Level02ShardSlot only | Emitted after `reveal()` has enabled the wrapped shard's collectible state; no environment side effect. |
| `shard_collected(shard_id)` | Level02ShardSlot only | Emitted only after shared reward completion; Progress authority for count, sector and environment phase. |
| `center_presence_changed(is_inside)` | CentralArenaController | Progress combines with both-shard/fog-ready gate. |
| `final_visual_complete()` | CentralArenaController | Progress opens main text once. |
| `color_ready()` | EnvironmentStateController | First transition reached target or safe fallback. |
| `fog_ready()` | EnvironmentStateController | Second transition reached target or safe fallback. |
| `closed` | PoemRewardUI | Progress accepts only in MAIN_TEXT_ACTIVE. |
| `portal_activated()` | Level02PortalAdapter | Progress moves to PORTAL_ACTIVE; no scene-load duplication. |
| `orientation_changed(statue_id,index)` | BeamStatue | Local Trial A feedback. |
| `statue_locked(statue_id)` | BeamStatue | Trial A accepts each statue once. |
| `pad_activated(symbol_id)` | SymbolPad | Trial B input only while WAITING_FOR_INPUT. |
| `replay_requested()` | ReplayInteractor | Trial B manual replay; no failure increment. |

### 13.1 Level02ProgressController public API

| Method | Contract |
|---|---|
| `register_trial_completed(trial_id: StringName) -> void` | Validate ID; set explicit trial flag once; no environment transition. |
| `register_shard_available(shard_id: StringName) -> void` | Diagnostic/readiness fact only. |
| `register_shard_collected(shard_id: StringName) -> void` | Core either-order handler; set boolean, derive count, activate matching sector, request exactly one environment phase. |
| `set_player_in_center(is_inside: bool) -> void` | Update presence and retry final gate. |
| `notify_color_ready() -> void` | Idempotent first transition completion. |
| `notify_fog_ready() -> void` | Idempotent second transition completion and final-gate retry. |
| `notify_final_visual_complete() -> void` | Open main text once only after final start. |
| `handle_main_text_closed() -> void` | Re-enable controls and begin portal formation once. |
| `notify_portal_activated() -> void` | Set macro `PORTAL_ACTIVE`; do not own scene transition. |
| `get_collected_shard_count() -> int` | Return `int(shard_a_collected)+int(shard_b_collected)`. |
| `is_trial_completed(id)`, `is_shard_collected(id)` | Read-only debug/test queries. |

### 13.2 Level02ShardSlot API

Mandatory event order for both trials:

```text
controller latches solved state
→ controller emits trial_completed(trial_id)
→ controller calls ShardSlot.reveal()
→ ShardSlot enables the wrapped SoulShard
→ ShardSlot emits shard_available(shard_id)
→ shared reward flow completes
→ ShardSlot emits shard_collected(shard_id)
```


| Method / property | Contract |
|---|---|
| `prepare_hidden()` | Idempotently hide RevealRoot/SoulShard; disable monitoring, monitorable, collision, prompt and collection availability using deferred-safe changes. |
| `reveal()` | Enable visibility and collection safely once; emit `shard_available(id)` only after collectible state is applied. |
| `get_soul_shard() -> Node` | Return wrapped existing SoulShard for explicit `register_shard()` call. |
| `get_shard_id() -> StringName` | Expose canonical ID for startup validation. |
| Child `SoulShard.collected` | Re-emit `shard_collected(id)` once; disable further availability. |

### 13.3 Central controller API

| Method | Contract |
|---|---|
| `activate_sector(sector_id)` | Accept only arrival/trial_a/trial_b; resolve sector/channel/spiral via explicit identity map. |
| `set_unsolved_route_hint(sector_id, enabled)` | Presentation only; no progression mutation. |
| `set_final_return_guidance(enabled)` | Persistent center guidance after second shard. |
| `begin_final_activation()` | One-shot 5.5-6.0 s placeholder sync → spirals → thin beam; leaving center does not cancel. |
| `set_portal_socket_ready()` | Stable placeholder presentation only. |

### 13.4 Environment controller API

| Method | Contract |
|---|---|
| `apply_initial_state()` | Ensure scene-local/deep-duplicated Environment; validate adjustment/fog; set saturation 0.20 and baseline fog. |
| `request_first_shard_transition()` | Start independent color tween to 1.00 and fog ratio to 0.92 over 9 s; emit `color_ready` once. |
| `request_second_shard_transition()` | Start/replace only fog tween to 0.55 over 7 s; preserve/retarget color tween to 1.00; emit `fog_ready` once. |
| `set_portal_ready_state()` | Presentation stabilization only. |
| `cancel_owned_tweens()` | Teardown/debug only; never blanket-kill during normal phase change. |

### 13.5 Portal adapter API

| Method | Contract |
|---|---|
| `begin_formation()` | Valid only from INACTIVE and only after accepted main text close. Upgraded core: configure AUTO_ENTER/no confirmation and call shared `activate()` directly. Legacy core: run local placeholder, then call `activate()` once. |
| `_complete_formation_guarded()` | Shared `activation_completed` and fallback race through the same one-shot guard. |
| `portal_activated` | Emit once after the upgraded shared activation completes/falls back, or after the legacy local formation + shared activation guarded path. |
| Scene transition | Always owned by existing LevelPortal. Adapter never invokes `change_scene_to_file`. |

## 14. Level state model

```gdscript
enum LevelState {
    INIT,
    ARRIVAL_READY,
    ROUTES_OPEN,
    ONE_SHARD_COLLECTED,
    BOTH_SHARDS_COLLECTED,
    WAITING_FOR_CENTER_RETURN,
    FINAL_ACTIVATING,
    MAIN_TEXT_ACTIVE,
    PORTAL_FORMING,
    PORTAL_ACTIVE,
}
```

### 14.1 Authoritative facts

| Group | Fields | Invariant |
|---|---|---|
| Arrival | `arrival_activated` | One-way false→true. |
| Trials | `trial_a_completed`, `trial_b_completed` | Independent facts; do not trigger environment. |
| Availability | `shard_a_available`, `shard_b_available` | Collection impossible before corresponding fact. |
| Collection | `shard_a_collected`, `shard_b_collected` | Environment authority; derived count. |
| Environment | `color_transition_started/complete`, `fog_transition_started/complete` | Each starts/completes once. |
| Center | `player_in_center`, `final_return_pending`, `final_started` | Final requires both shards + fog ready + presence. |
| Text | `main_text_active`, `main_text_close_handled` | Open/close once. |
| Portal | `portal_formation_started`, `portal_active` | Progress ends at active; shared portal owns scene load. |

### 14.2 Valid transitions

| From | Event / guard | To | Side effect |
|---|---|---|---|
| INIT | Required refs valid; hidden shards/portal and initial environment applied | ARRIVAL_READY | Arm arrival. |
| ARRIVAL_READY | First activity or 4 s fallback | ROUTES_OPEN | Activate arrival sector/channel. |
| ROUTES_OPEN | First unique shard collected | ONE_SHARD_COLLECTED | Matching sector; start color transition once. |
| ONE_SHARD_COLLECTED | Second unique shard collected | BOTH_SHARDS_COLLECTED | Matching sector; emit all-shards milestone. |
| BOTH_SHARDS_COLLECTED | Second-shard handling accepted | WAITING_FOR_CENTER_RETURN | Start fog transition; guidance on. |
| WAITING_FOR_CENTER_RETURN | Both shards && fog ready && in center && !final_started | FINAL_ACTIVATING | Latch and start central final. |
| FINAL_ACTIVATING | `final_visual_complete` | MAIN_TEXT_ACTIVE | Lock controls; show exact main text. |
| MAIN_TEXT_ACTIVE | First valid `closed` | PORTAL_FORMING | Unlock controls; begin formation. |
| PORTAL_FORMING | `portal_activated` | PORTAL_ACTIVE | Shared portal owns transition. |

```gdscript
can_start_final =
    shard_a_collected
    and shard_b_collected
    and fog_transition_complete
    and player_in_center
    and not final_started
```

Trial completion and shard availability are deliberately orthogonal to the macro enum. Both trials may be solved before either shard is collected.

### 14.3 Invalid/no-op events

| Event | Condition | Required behavior |
|---|---|---|
| Duplicate trial_completed | Same trial already accepted | Ignore; warning once per ID. |
| Duplicate shard_collected | Same shard already accepted | Ignore; no text/VFX/count/environment repeat. |
| Unknown ID | Not canonical trial/shard/sector | Error in debug; ignore safely in runtime. |
| Center entry | Both shards not collected | Update presence only. |
| Center entry | Fog not ready | Wait; do not start early. |
| fog_ready | Player outside center | Set ready and wait for next entry. |
| final_visual_complete | Final not started or text already active | Ignore stale callback. |
| Main text closed | Wrong state or already handled | Ignore. |
| Formation complete | Not forming or already active | Ignore. |

## 15. Trial A state model - Three Beams

| Statue | Local placement | World placement | Initial index / presses to correct |
|---|---|---|---|
| A1 | `(R0.00, F+7.00)` | `Vector3(-50.23,0.40,29.00)` | 0 / 1 |
| A2 | `(R+6.06, F-3.50)` | `Vector3(-38.11,0.40,29.00)` | 2 / 2 |
| A3 | `(R-6.06, F-3.50)` | `Vector3(-44.17,0.40,18.50)` | 0 / 1 |
| Central shell | `(0,0)` | `Vector3(-44.17,0.40,25.50)` | R2.1 / H4.2 |

| Index | Relative yaw | Target | Result |
|---|---|---|---|
| 0 | -60° | Target_Left | Incorrect bypass left |
| 1 | 0° inward | Target_Center | Correct; lock permanently |
| 2 | +60° | Target_Right | Incorrect bypass right |

- Cycle: 0→1→2→0.
- Rotation duration 0.40 s; minimum accepted interaction cooldown 0.35 s.
- Input during rotation ignored, never queued.
- Interaction distance 2.2 m and existing player_interactable contract.
- Correct index = 1 for all three statues.
- Locked statue never unlocks or resets in current scene run.
- Leave/re-enter preserves indices and locks.
- 3/3 latches solved state and disables interactions.
- Immediately after the latch, TrialAController emits `trial_completed(&"trial_a")` once.
- Only then the controller calls `ShardSlot_A.reveal()`.
- ShardSlot_A enables the shard, emits `shard_available(&"Shard_03")`, and later emits `shard_collected(&"Shard_03")` after reward completion.

### 15.1 Trial A assistance

| Threshold | Assistance |
|---|---|
| 35 s without new lock | Pulse receivers in order; slightly brighten nearest unsolved lens. |
| 55 s or 6 rotations without progress | Show 1.5 s faint inward ghost line for nearest unsolved statue. |
| 80 s unresolved | When next unsolved statue reaches correct state, hold 0.7 s before another rotation can be accepted. |

No auto-solve, punishment, reset timer or free-angle beam physics.

## 16. Trial B state model - Echo of Light

| Symbol | World position | Role |
|---|---|---|
| Leaf | `Vector3(39.84,0.80,23.00)` | Stage 1; closest to entry |
| Sun | `Vector3(46.67,0.80,21.17)` | Second symbol |
| Wave | `Vector3(48.50,0.80,28.00)` | Third symbol |
| Star | `Vector3(41.67,0.80,29.83)` | Fourth symbol |
| Central bud | `Vector3(44.17,0.80,25.50)` | R2.7; four persistent petals |

```gdscript
enum TrialBState {
    IDLE,
    INTRO,
    SHOWING_SEQUENCE,
    WAITING_FOR_INPUT,
    INPUT_SUCCESS,
    INPUT_ERROR,
    STAGE_SUCCESS,
    NEXT_STAGE,
    TRIAL_COMPLETE,
    SHARD_REVEALED,
}
```

| Stage | Displayed and entered sequence | Persistent result |
|---|---|---|
| 1 | Leaf | Petal 1 opens |
| 2 | Leaf → Sun | Petal 2 opens |
| 3 | Leaf → Sun → Wave | Petal 3 opens; shard glow readable |
| 4 | Leaf → Sun → Wave → Star | Petal 4 opens; full shard reveal |

| Timing | Normal / assisted |
|---|---|
| Symbol glow | 0.75 s / 1.20 s |
| Gap | 0.40 s / 0.60 s |
| Intro | 1.00 s |
| Error settle | 0.80 s |
| Stage success | 1.20 s |
| Next-stage delay | 0.60 s |
| Final reveal | 2.40 s |
| Hint pulse interval | 2.00 s |

- Pads are disabled during SHOWING_SEQUENCE; enter events are ignored and never queued.
- Input accepted only in WAITING_FOR_INPUT and only from an armed pad.
- After activation, a pad remains unarmed until body exit or player center is >1.35 m from PadCenter.
- A pad occupied when WAITING begins starts unarmed.
- Wrong input resets only `current_input_index=0` for current stage.
- Completed petals/stages never close after an error.
- Manual replay available within 2.5 m through E; clears partial input and does not increment fail count.
- Second failure uses slower replay; third and later failures pulse the next expected pad subtly.
- Leave platform clears partial current input, preserves completed stages and replays current stage on re-entry.
- Pad identity resolved through `pads_by_id[symbol_id]`, never child order or world placement.
- Final stage latches solved state, emits `trial_completed(&"trial_b")` once, then calls `ShardSlot_B.reveal()`.
- ShardSlot_B enables the shard, emits `shard_available(&"Shard_04")`, and later emits `shard_collected(&"Shard_04")` after reward completion.

## 17. Environment transition model

| Phase | Saturation | Fog ratio | Duration / rules |
|---|---|---|---|
| INITIAL | 0.20 | 1.00 baseline | Immediate before controls; world alive/readable. |
| FIRST_SHARD_TRANSITION | 0.20→1.00 | 1.00→0.92 | 9.0 s; movement/camera/puzzles stay active. |
| COLOR_READY | 1.00 | 0.92 | Stable. |
| SECOND_SHARD_TRANSITION | Current→1.00 if needed | 0.92→0.55 | 7.0 s; independent fog tween; never cancel color restoration. |
| FOG_READY | 1.00 | 0.55 | Final still waits for center. |
| PORTAL_READY | 1.00 | 0.55 or calibrated | Stable placeholder state. |

- Use one level-local Environment resource or deep duplicate and reassign before mutation.
- `adjustment_enabled` and `fog_enabled` are startup validations.
- Separate `_color_tween`, `_fog_tween`, optional `_light_tween` ownership.
- Second shard collected before first 9 s transition ends must not strand saturation below 1.00.
- Environment transitions never call `Player.set_controls_enabled(false)`.
- Activated sector/channel remains active as spatial memory.
- Missing optional EnvironmentVFX does not block `color_ready` or `fog_ready`.

## 18. UI and portal model

### 18.1 Short shard reward sequence

1. Trial reveal calls local ShardSlot.reveal().
2. Player collects existing SoulShard through E.
3. SoulShard emits `reward_sequence_requested`.
4. One existing ShardRewardSequenceController disables controls and drives one existing ShardRewardOverlay.
5. After confirmation/return, shared controller calls `complete_collection_sequence()`.
6. SoulShard emits `collected`.
7. Level02ShardSlot re-emits canonical `shard_collected(id)` once.
8. Only then Progress starts environment phase.

### 18.2 Main text

- Use existing `PoemRewardUI.show_placeholder_reward(main_text)`.
- Node name remains exactly `PoemRewardUI`.
- Open only after `final_visual_complete` and after shard reward overlay is no longer active.
- Disable Player controls only while main text is visible.
- Accept `closed` once; duplicate close does nothing.

### 18.3 Portal

- Portal future volume remains inactive throughout level and main text.
- `begin_formation()` can be called only after accepted main-text close.
- Formation uses actual shared portal capability as described in Section 7.1.
- Fallback and completion race through one guard.
- Target path exactly `res://scenes/levels/Level_03.tscn`.
- Early-overlap runtime test is P0.
- Adapter never owns scene loading.

## 19. Traversal safety and no-softlock baseline

- SoftReturnVolume covers complete playable envelope below Y=-6.
- Filter only configured Player identity/type.
- Choose nearest explicit SafeAnchor by horizontal distance, not name inference.
- Recovery clears velocity and restores transform; puzzle/progress state remains untouched.
- Recovery latch/cooldown prevents duplicate teleports.
- No death, health, scene reload, failure counter or puzzle reset.
- Boundary blockers remain inside visible rim and preserve all ≥6 m openings.

# Slice 0 - Full Preflight

## Slice 0.1 Goal

Establish the exact current repository baseline, resolve active-PR/shared-API drift, and produce a complete implementation map without changing any file.

## Slice 0.2 Preconditions

- Producer-approved task and four source documents are available.
- GitHub access is available.
- No implementation branch is created from an unverified base.

## Slice 0.3 Exact files expected to change

No repository files. Slice 0 is inspection-only.

## Slice 0.4 Exact files forbidden to change

- `project.godot` unless a proven blocker is separately approved
- all Level_01 files and active Level_01 PR branches
- shared Player/Camera/SoulShard/Reward UI/LevelPortal scripts and scenes
- `scripts/core/level_manager.gd`
- `scenes/levels/Level_03.tscn`
- Level_07-15 and FinalScene
- raw `.glb`, `.import`, Blender files and final art resources
- new autoload, save/GameState or broad framework files
- No file may be created, modified, deleted, reformatted or reimported.
- No branch push or PR mutation during inspection unless producer explicitly asks for a docs-only administrative action.

## Slice 0.5 Nodes, scenes and scripts

- Inspect root and nested `AGENTS.md` files.
- Inspect current `scenes/levels/Level_02.tscn`.
- Inspect Player, camera controller, SoulShard, ShardRewardSequenceController, ShardRewardOverlay, PoemRewardUI, LevelPortal and LevelManager.
- Inspect `project.godot`, DevLevelMenu and existence/path of Level_03.
- Inspect PR #47 status and all active PRs touching shared contracts, especially PR #83.
- Inspect Level_01 only to understand current wrapper/controller conventions; no modifications.
- Identify current main SHA, chosen runtime base SHA and clean working-tree status.

## Slice 0.6 Methods and signals

No runtime API changes. Inspection must identify the exact contracts used by later slices.

## Slice 0.7 Implementation steps

1. Read and summarize all applicable AGENTS instructions.
2. Record repository default branch, current main SHA, active branch and dirty-file status.
3. Confirm PR #47 actual state; list active PRs and changed shared files.
4. Compare actual LevelPortal/Camera/SoulShard/Overlay contracts against this reference.
5. Confirm whether PR #83 is merged, closed or still active; choose producer-approved base.
6. Verify exact Level_03 target file exists.
7. Inventory all expected future Level_02 files and confirm no path conflicts.
8. Produce PLAN with slice order, file ownership, dependency graph, test impact and stop conditions.
9. Do not apply any change. Wait for explicit APPLY/producer gate.

## Slice 0.8 Acceptance criteria

- Zero repository diff.
- Current Level_02 placeholder and all shared contracts are documented factually.
- Chosen base SHA is explicit.
- Portal capability path is resolved: legacy immediate vs upgraded activation-owning portal.
- Exact files for Slice 1-7 are enumerated.
- All unknowns are listed; none are silently guessed.
- No conflict with active Level_01 work.

## Slice 0.9 Automated/static checks

- `git status --short --branch` or connector-equivalent.
- `git diff --name-only` must be empty.
- Fetch/inspect exact shared files and active PR changed-file lists.
- Verify target paths exist.

## Slice 0.10 Manual runtime checks

- None. Runtime is not launched in Slice 0.
- If a local engine smoke is needed only to confirm baseline, record it as read-only evidence and do not save scenes.

## Slice 0.11 Rollback plan

- No rollback needed because no changes are allowed.
- If any accidental file change occurs, restore it before handoff and rerun zero-diff proof.

## Slice 0.12 Risks

| Risk | Mitigation |
|---|---|
| Stale source snapshot | Actual shared API is re-inspected and deviations are recorded before implementation. |
| Active PR conflict | Do not stack silently; choose approved base or wait for merge. |
| Missing target scene | Hard stop; do not invent Level_03. |
| Unclean branch | Hard stop until unrelated work is isolated. |

## Slice 0.13 Out of scope

- Any code/scene implementation.
- Branching from an unapproved integration branch.
- Shared API modification.
- Runtime art or puzzle prototyping.

## Slice 0.14 Handoff format

- Branch, base SHA, slice-start SHA and final head SHA.
- Exact `git diff --name-only` list.
- Summary of implemented behavior and preserved contracts.
- Commands/checks executed and factual outputs.
- Manual checks: PASS / FAIL / NOT VERIFIED.
- Known risks, blockers and fallback paths.
- Confirmation that no forbidden/shared/Level_01 files changed.
- `Commit SHA: N/A` because Slice 0 is inspection-only; PR link may be recorded only as existing context, not created by Slice 0.
- Explicit recommendation: proceed / stop.
- Full preflight implementation plan.
- Explicit `WAITING FOR APPLY` status.

# Slice 1 - Level_02 Scene Shell and Spatial Greybox

## Slice 1.1 Goal

Replace the obsolete placeholder with a walkable primitive-only 1+3 spatial shell, exact paths, boundaries, Player/Camera, safe fall recovery and a non-functional portal socket placeholder.

## Slice 1.2 Preconditions

- Slice 0 approved.
- Runtime branch created from approved base.
- Working tree clean.
- Shared Player/Camera contracts confirmed.

## Slice 1.3 Exact files expected to change

```text
scenes/levels/Level_02.tscn
scenes/levels/level_02/blocks/Block_02_00_CentralArena.tscn
scenes/levels/level_02/blocks/Block_02_01_Arrival.tscn
scenes/levels/level_02/blocks/Block_02_02_TrialA.tscn
scenes/levels/level_02/blocks/Block_02_03_TrialB.tscn
scenes/levels/level_02/blocks/Block_02_04_RoutesAndBoundaries.tscn
scenes/levels/level_02/gameplay/Level02SoftReturnVolume.tscn
scripts/levels/level_02/level_02_soft_return_volume.gd
```
Matching Godot UID sidecars are additionally allowed only for approved GDScript files listed in this slice:

```text
scripts/levels/level_02/<approved_script>.gd.uid
```

Every allowed `.gd.uid` must have its approved sibling `.gd` in the same slice/file scope. Unrelated UID/import regeneration is forbidden.


## Slice 1.4 Exact files forbidden to change

- `project.godot` unless a proven blocker is separately approved
- all Level_01 files and active Level_01 PR branches
- shared Player/Camera/SoulShard/Reward UI/LevelPortal scripts and scenes
- `scripts/core/level_manager.gd`
- `scenes/levels/Level_03.tscn`
- Level_07-15 and FinalScene
- raw `.glb`, `.import`, Blender files and final art resources
- new autoload, save/GameState or broad framework files
- No puzzle scenes/scripts.
- No environment state controller, shard adapter or portal core yet.
- No changes to existing shared scenes.

## Slice 1.5 Nodes, scenes and scripts

- Root layer tree from Section 10, with empty placeholders for later Gameplay/VFX/State branches.
- Primitive CylinderMesh/BoxMesh or equivalent MeshInstance3D + StaticBody3D collision.
- Exact block transforms and markers.
- Player instance and existing camera controller.
- SafeAnchors and SoftReturnVolume.
- Portal socket is a passive primitive only; no LevelPortal instance.

## Slice 1.6 Methods and signals

| Contract item | Required contract |
|---|---|
| `Level02SoftReturnVolume.recover_player(body)` | Filter configured Player, choose nearest explicit anchor, zero velocity, teleport once per cooldown. |
| Optional `recovered(anchor_id)` | Debug signal only; no progression side effect. |

## Slice 1.7 Implementation steps

1. Replace current Level_02 root scene; do not incrementally preserve old LevelManager composition.
2. Create central disc R22/R20 and the three outer platform discs at exact transforms.
3. Create three routes from exact endpoints, width 5.5 m and slopes within hard max.
4. Create visible rims and modular blockers with explicit ≥6.0 m openings.
5. Add primitive portal socket footprint at center, passive and unobstructed.
6. Instance existing Player at validated collider-safe position derived from PlayerFloorSpawnMarker.
7. Instance existing Camera3D with confirmed target path.
8. Add four SafeAnchors and a large SoftReturnVolume below Y=-6.
9. Add simple neutral light only if needed inside Level_02 scene; do not change project settings.
10. Ensure no mandatory jump and no collision gap.

## Slice 1.8 Acceptance criteria

- Level_02 opens with no missing dependencies.
- Player spawns on floor, not intersecting or falling.
- All four platforms and all three routes are reachable.
- Clear route width ≥5.0 m and slope ≤8°.
- Boundary openings are ≥6.0 m and align with routes.
- Camera can traverse without persistent collision trapping.
- Fall from each platform/route recovers within ~1 s and preserves scene.
- Portal socket has no trigger or progression.
- No puzzle logic exists.

## Slice 1.9 Automated/static checks

- Godot headless parse/check-only.
- Scene resource load for all created scenes.
- Static grep: no raw GLB paths, no LevelManager, no Level_01 references.
- Static coordinate/transform audit against Section 8.
- `git diff --check` and changed-file whitelist.

## Slice 1.10 Manual runtime checks

- Walk Arrival→Center→A→Center→B→Center.
- Attempt all route edges and platform rims.
- Force fall below each area and confirm nearest anchor.
- Rotate camera at all routes and platform edges.
- Confirm no mandatory jump and no softlock.

## Slice 1.11 Rollback plan

- Revert Slice 1 commit to restore obsolete placeholder.
- If only one block is defective, revert/fix that block before any later slice; do not compensate in gameplay.

## Slice 1.12 Risks

| Risk | Mitigation |
|---|---|
| Spawn marker copied directly to Player origin | Validate actual collider center/height and floor snap. |
| Blocker closes route mouth | Use explicit gaps and route-opening checks. |
| Catch floor bridges gaps | Forbidden; use SoftReturnVolume only. |
| Camera clips against decorative blockers | Use simple collision and test all approaches. |

## Slice 1.13 Out of scope

- Puzzles, shards, UI flow, environment transitions.
- Final visual dressing or art wrappers.
- Portal activation or Level_03 transition.

## Slice 1.14 Handoff format

- Branch, base SHA, slice-start SHA and final head SHA.
- Exact `git diff --name-only` list.
- Summary of implemented behavior and preserved contracts.
- Commands/checks executed and factual outputs.
- Manual checks: PASS / FAIL / NOT VERIFIED.
- Known risks, blockers and fallback paths.
- Confirmation that no forbidden/shared/Level_01 files changed.
- Commit SHA for the slice and PR link.
- Explicit recommendation: proceed / stop.

# Slice 2 - Arrival and Central Arena Progress Structure

## Slice 2.1 Goal

Implement the non-puzzle start activation and the local order-independent progress skeleton: arrival confirmation, start sector, three explicit central identities, placeholder spiral branches and debug observability.

## Slice 2.2 Preconditions

- Slice 1 accepted and committed.
- Spatial transforms and traversal are frozen for greybox unless a blocker is proven.
- Shared UI/reward scenes resolve on the chosen base.

## Slice 2.3 Exact files expected to change

```text
scenes/levels/Level_02.tscn
scenes/levels/level_02/gameplay/Level02ProgressController.tscn
scenes/levels/level_02/gameplay/Level02ArrivalGameplay.tscn
scenes/levels/level_02/gameplay/Level02CentralArenaGameplay.tscn
scenes/levels/level_02/vfx/Level02ArrivalVFX.tscn
scenes/levels/level_02/vfx/Level02CentralLightVFX.tscn
scripts/levels/level_02/level_02_progress_controller.gd
scripts/levels/level_02/level_02_arrival_controller.gd
scripts/levels/level_02/level_02_central_arena_controller.gd
scripts/levels/level_02/level_02_central_vfx_adapter.gd
```
Matching Godot UID sidecars are additionally allowed only for approved GDScript files listed in this slice:

```text
scripts/levels/level_02/<approved_script>.gd.uid
```

Every allowed `.gd.uid` must have its approved sibling `.gd` in the same slice/file scope. Unrelated UID/import regeneration is forbidden.


## Slice 2.4 Exact files forbidden to change

- `project.godot` unless a proven blocker is separately approved
- all Level_01 files and active Level_01 PR branches
- shared Player/Camera/SoulShard/Reward UI/LevelPortal scripts and scenes
- `scripts/core/level_manager.gd`
- `scenes/levels/Level_03.tscn`
- Level_07-15 and FinalScene
- raw `.glb`, `.import`, Blender files and final art resources
- new autoload, save/GameState or broad framework files
- Do not modify block geometry except a separately documented marker/collision defect.
- No Trial A/B puzzle logic.
- No SoulShard instance, environment transition or functional portal.

## Slice 2.5 Nodes, scenes and scripts

- Progress controller with macro enum and orthogonal facts.
- Arrival ActivityZone, StartCircleZone and 4 s fallback.
- Central activation/presence zone and return-guide placeholders.
- Central VFX placeholders with explicit Sectors, ConnectionChannels and SpiralBranches roots.
- Existing ShardRewardSequenceController, ShardRewardOverlay and PoemRewardUI instances wired in Level_02 root for later slices.
- Optional DevDebugRoot disabled by default.

## Slice 2.6 Methods and signals

| Contract item | Required contract |
|---|---|
| `arrival_activated()` | Emitted exactly once by first meaningful movement/camera activity or 4 s fallback. |
| `activate_sector(&"arrival")` | Start sector/channel becomes stable active state. |
| `center_presence_changed(bool)` | Presence signal only; no final logic yet. |
| `Level02ProgressController.get_collected_shard_count()` | Derived from future explicit booleans; currently returns 0. |
| `Level02ProgressController.debug_snapshot()` | Optional dictionary/string for slice validation; no production UI dependency. |

## Slice 2.7 Implementation steps

1. Create layered local controller scenes and scripts.
2. Implement startup validation for every exported NodePath.
3. Configure shared reward controller with explicit overlay/player paths and empty `ShardRegistrationScope` scan root.
4. Implement arrival activity detection without camera takeover.
5. On accepted arrival, transition ARRIVAL_READY→ROUTES_OPEN and activate start sector.
6. Create explicit identity map for arrival/trial_a/trial_b sector, channel and spiral nodes.
7. Keep trial sectors/spirals inactive or equally idle; no branch appears mandatory.
8. Emit and consume center presence only; do not start final.
9. Add optional concise debug state display behind an exported/default-false development flag.

## Slice 2.8 Acceptance criteria

- Arrival activates once on input and once on 4 s idle fallback in separate tests.
- Controls remain enabled.
- Start sector and arrival channel activate; both trial routes remain equally available.
- Reordering sector/channel/spiral children does not break identity mapping.
- Center presence changes do not mutate shard/final states.
- No whole-tree critical lookup or child-index coupling.
- No puzzle/shard/portal behavior.

## Slice 2.9 Automated/static checks

- Godot parse/resource load.
- Temporary harness calls arrival twice and confirms one side effect.
- Temporary harness reorders/mocks identity nodes and validates explicit NodePaths.
- Static check for forbidden `get_tree().current_scene` recursive critical search in new Level_02 scripts.
- Changed-file whitelist including only matching approved `.gd.uid` sidecars; temporary harnesses absent; `git diff --check`.

## Slice 2.10 Manual runtime checks

- Move immediately and verify start pulse.
- Stand idle for 4 s in a fresh run and verify fallback.
- Enter/exit central R5.2 zone repeatedly; confirm only presence logs.
- Inspect center from arrival and verify both trial directions are equally readable.
- Confirm shared overlay/UI nodes remain hidden.

## Slice 2.11 Rollback plan

- Revert Slice 2 commit; Slice 1 remains fully walkable.
- If debug UI causes coupling, remove it rather than modifying shared camera/UI.

## Slice 2.12 Risks

| Risk | Mitigation |
|---|---|
| Arrival signal fires from multiple input paths | Internal accepted latch before emission. |
| Sector mapping depends on child order | Dictionary/explicit NodePaths by canonical IDs. |
| Shared reward controller recursively scans whole scene | Empty scan scope plus later explicit registration. |
| Debug UI leaks into final greybox | Disabled by default and removed/hidden in Slice 7. |

## Slice 2.13 Out of scope

- Trial gameplay.
- Environment transitions.
- Shard collection.
- Main text and portal.

## Slice 2.14 Handoff format

- Branch, base SHA, slice-start SHA and final head SHA.
- Exact `git diff --name-only` list.
- Summary of implemented behavior and preserved contracts.
- Commands/checks executed and factual outputs.
- Manual checks: PASS / FAIL / NOT VERIFIED.
- Known risks, blockers and fallback paths.
- Confirmation that no forbidden/shared/Level_01 files changed.
- Commit SHA for the slice and PR link.
- Explicit recommendation: proceed / stop.

# Slice 3 - Trial A: Three Beams

## Slice 3.1 Goal

Implement a complete standalone Trial A with three deterministic interactable statues, fixed orientation locking, central shell progress, reveal-safe Shard_03 and leave/re-enter persistence.

## Slice 3.2 Preconditions

- Slice 2 accepted.
- Existing Player interaction API confirmed.
- Existing SoulShard and reward sequence contracts confirmed.
- Trial A platform and collision are stable.

## Slice 3.3 Exact files expected to change

```text
scenes/levels/Level_02.tscn
scenes/levels/level_02/gameplay/TrialA_ThreeBeams.tscn
scenes/levels/level_02/gameplay/TrialA_BeamStatue.tscn
scenes/levels/level_02/gameplay/Level02ShardSlot.tscn
scenes/levels/level_02/vfx/Level02TrialAVFX.tscn
scripts/levels/level_02/trial_a_controller.gd
scripts/levels/level_02/trial_a_beam_statue.gd
scripts/levels/level_02/level_02_shard_slot.gd
scripts/levels/level_02/trial_a_vfx_adapter.gd
scenes/levels/level_02/gameplay/Level02ProgressController.tscn
scripts/levels/level_02/level_02_progress_controller.gd
```
Matching Godot UID sidecars are additionally allowed only for approved GDScript files listed in this slice:

```text
scripts/levels/level_02/<approved_script>.gd.uid
```

Every allowed `.gd.uid` must have its approved sibling `.gd` in the same slice/file scope. Unrelated UID/import regeneration is forbidden.


## Slice 3.4 Exact files forbidden to change

- `project.godot` unless a proven blocker is separately approved
- all Level_01 files and active Level_01 PR branches
- shared Player/Camera/SoulShard/Reward UI/LevelPortal scripts and scenes
- `scripts/core/level_manager.gd`
- `scenes/levels/Level_03.tscn`
- Level_07-15 and FinalScene
- raw `.glb`, `.import`, Blender files and final art resources
- new autoload, save/GameState or broad framework files
- No Trial B files.
- No environment transition.
- No portal/main-text work.
- Do not change shared SoulShard or reward controller.

## Slice 3.5 Nodes, scenes and scripts

- Three `TrialA_BeamStatue` instances with exact initial indices and positions.
- RotationPivot and three BeamTargets per statue.
- Three primitive beam placeholders and receiver indicators.
- Central column/shell placeholder and 3/3 visual segments.
- ShardSlot_A wrapping existing SoulShard with `Shard_03` and exact text.
- Trial presence and assistance timers/state.

## Slice 3.6 Methods and signals

| Contract item | Required contract |
|---|---|
| `can_player_interact(player)` | True only unlocked, not rotating, cooldown elapsed and player valid/in range. |
| `interact(player)` | Request one next fixed orientation. |
| `request_next_orientation()` | Cycle 0→1→2→0 with 0.40 s tween; ignore concurrent input. |
| `orientation_changed(statue_id,index)` | Local feedback after accepted orientation. |
| `statue_locked(statue_id)` | Emit once when correct index reached. |
| `TrialAController.trial_completed(&"trial_a")` | Emit once immediately after solved latch and before `ShardSlot_A.reveal()`. |
| `ShardSlot_A.shard_available(&"Shard_03")` | Emit only when collectible. |
| `ShardSlot_A.shard_collected(&"Shard_03")` | Emit after shared reward flow completes. |

## Slice 3.7 Implementation steps

1. Build reusable BeamStatue scene using primitives only.
2. Apply exact initial indices A1=0, A2=2, A3=0 and correct index 1.
3. Implement deterministic clockwise cycle and anti-spam guards.
4. Update beam placeholder toward exact target marker during/after rotation.
5. Lock correct statue permanently for current run and disable prompt.
6. TrialAController derives locked count from explicit per-statue booleans.
7. At 1/3 and 2/3, update shell segments only.
8. At 3/3, latch solved state and disable remaining interactions.
9. Emit `trial_completed(&"trial_a")` once immediately after the latch.
10. Run placeholder reveal using callback + fallback, then call `ShardSlot_A.reveal()` once.
11. ShardSlot enables the shard and emits `shard_available(&"Shard_03")`; after shared reward completion it emits `shard_collected(&"Shard_03")`.
12. Explicitly register wrapped SoulShard with shared reward controller.
13. Progress records trial/availability/collection facts but environment remains unchanged.
14. Implement 35/55/80 s assistance without auto-solve.

## Slice 3.8 Acceptance criteria

- Exactly three statues and exactly three orientations.
- Initial presses to solve are 1,2,1.
- Input during rotation is ignored and not queued.
- Correct statues lock and never reset.
- Leave/re-enter preserves exact indices and locks.
- Shard cannot be seen/collected before reveal.
- Missing reveal callback triggers safe fallback and no softlock.
- Mandatory order is exact and one-shot: solved latch → `trial_completed` → `ShardSlot_A.reveal()` → collectible enabled → `shard_available` → reward completion → `shard_collected`.
- Collecting Shard_03 uses exact short text.
- No color/fog/global final side effect yet.

## Slice 3.9 Automated/static checks

- Godot parse/resource load.
- Temporary harness cycles each statue and validates indices/cooldown/locks.
- Aggregate harness locks statues in varied order and confirms one reveal.
- Hidden shard contract test: visibility, monitoring, monitorable and collision all disabled before reveal.
- Duplicate signal/idempotency checks.
- Changed-file whitelist including only matching approved `.gd.uid` sidecars; temporary harnesses absent; `git diff --check`.

## Slice 3.10 Manual runtime checks

- Solve Trial A from initial state.
- Spam E during rotation and confirm one step only.
- Lock two statues, leave to center, return and complete.
- Stand at shard spawn before reveal and press E.
- Disable Trial A optional VFX callback and confirm fallback.
- Collect shard and verify exact overlay text and control restoration.

## Slice 3.11 Rollback plan

- Revert Slice 3 commit; Slice 2 start/center shell remains functional.
- If generic ShardSlot is defective, fix within Level_02 local files; do not patch shared SoulShard.

## Slice 3.12 Risks

| Risk | Mitigation |
|---|---|
| Fixed yaw sign visually reversed | Validate clockwise player-facing cycle; implementation sign may vary but visual order is locked. |
| Tween callback fires after free/reset | Generation token or validity/state guard. |
| Hidden shard still interactable | Disable all Area/collision/prompt facets before control. |
| Trial completion incorrectly drives environment | Only collection event can do so; assert no transition counters change. |

## Slice 3.13 Out of scope

- Trial B.
- Environment transitions.
- Final center and portal.
- Final beams/particles/materials/audio.

## Slice 3.14 Handoff format

- Branch, base SHA, slice-start SHA and final head SHA.
- Exact `git diff --name-only` list.
- Summary of implemented behavior and preserved contracts.
- Commands/checks executed and factual outputs.
- Manual checks: PASS / FAIL / NOT VERIFIED.
- Known risks, blockers and fallback paths.
- Confirmation that no forbidden/shared/Level_01 files changed.
- Commit SHA for the slice and PR link.
- Explicit recommendation: proceed / stop.

# Slice 4 - Trial B: Echo of Light

## Slice 4.1 Goal

Implement a complete standalone fixed cumulative sequence puzzle with four typed symbol pads, persistent petals, current-stage-only reset, replay, assistance, reveal-safe Shard_04 and leave/re-enter safety.

## Slice 4.2 Preconditions

- Slice 3 accepted.
- Generic Level02ShardSlot proven by Trial A.
- Trial B platform/collision stable.

## Slice 4.3 Exact files expected to change

```text
scenes/levels/Level_02.tscn
scenes/levels/level_02/gameplay/TrialB_EchoOfLight.tscn
scenes/levels/level_02/gameplay/TrialB_SymbolPad.tscn
scenes/levels/level_02/vfx/Level02TrialBVFX.tscn
scripts/levels/level_02/trial_b_controller.gd
scripts/levels/level_02/trial_b_symbol_pad.gd
scripts/levels/level_02/trial_b_replay_interactor.gd
scripts/levels/level_02/trial_b_vfx_adapter.gd
scenes/levels/level_02/gameplay/Level02ProgressController.tscn
scripts/levels/level_02/level_02_progress_controller.gd
```
Matching Godot UID sidecars are additionally allowed only for approved GDScript files listed in this slice:

```text
scripts/levels/level_02/<approved_script>.gd.uid
```

Every allowed `.gd.uid` must have its approved sibling `.gd` in the same slice/file scope. Unrelated UID/import regeneration is forbidden.


## Slice 4.4 Exact files forbidden to change

- `project.godot` unless a proven blocker is separately approved
- all Level_01 files and active Level_01 PR branches
- shared Player/Camera/SoulShard/Reward UI/LevelPortal scripts and scenes
- `scripts/core/level_manager.gd`
- `scenes/levels/Level_03.tscn`
- Level_07-15 and FinalScene
- raw `.glb`, `.import`, Blender files and final art resources
- new autoload, save/GameState or broad framework files
- Do not modify Trial A except a proven shared local-adapter defect.
- No environment transition.
- No final/portal work.
- No random sequence or child-order identity.

## Slice 4.5 Nodes, scenes and scripts

- Four `TrialB_SymbolPad` instances with exact IDs/positions.
- Dedicated direct-child `Pads` registry root.
- Central bud primitive, four gameplay-owned PetalPivot nodes and four placeholder petals.
- Four progress-ring sectors.
- ReplayInteractor using existing Player E contract.
- ShardSlot_B wrapping existing SoulShard with `Shard_04` and exact text.
- Timers and generation token for stale async cancellation.

## Slice 4.6 Methods and signals

| Contract item | Required contract |
|---|---|
| `pad_activated(symbol_id)` | Emit only from armed pad while accepting input. |
| `submit_symbol(symbol_id)` | Valid only in WAITING_FOR_INPUT; compare with fixed expected ID. |
| `request_manual_replay()` | Clear current partial input; replay current stage; no fail increment. |
| `show_current_sequence()` | Resolve every ID through pads_by_id; pad input disabled. |
| `complete_stage()` | Open exactly one new petal/ring sector permanently. |
| `trial_completed(&"trial_b")` | Emit once immediately after solved latch and before `ShardSlot_B.reveal()`. |
| `ShardSlot_B.shard_available(&"Shard_04")` | Emit only after collectible state. |
| `ShardSlot_B.shard_collected(&"Shard_04")` | Emit after reward sequence. |

## Slice 4.7 Implementation steps

1. Create typed pad scene with symbol_id, occupancy and armed state.
2. Build pads_by_id from typed direct children; validate exactly leaf/sun/wave/star and no duplicates.
3. Implement locked master sequence and stages 1/2/3/4.
4. Implement FSM with explicit states and generation token after each await/timer boundary.
5. Disable all pad input during sequence display; never queue body events.
6. When WAITING begins, occupied pads remain unarmed until step-off.
7. Correct input advances current index; wrong input resets current stage input only.
8. Stage success opens one permanent petal and ring sector.
9. Second failure uses assisted timings; third+ enables next-pad pulse.
10. Manual replay available only in WAITING.
11. Leave/re-enter preserves completed stages, clears partial input and replays current stage.
12. Final stage latches solved state and emits `trial_completed(&"trial_b")` once.
13. Run final reveal using callback + fallback, then call `ShardSlot_B.reveal()` once.
14. ShardSlot enables the shard and emits `shard_available(&"Shard_04")`; after shared reward completion it emits `shard_collected(&"Shard_04")`.
15. Explicitly register wrapped SoulShard with shared reward controller.
16. Progress records trial/availability/collection; no environment transition yet.

## Slice 4.8 Acceptance criteria

- Fixed sequence leaf→sun→wave→star.
- Stages are cumulative 1,2,3,4.
- Completed petals never close on error or re-entry.
- Wrong input resets only current stage index.
- Pads ignore and do not queue input during SHOWING_SEQUENCE.
- Occupied pad requires step-off before input.
- Manual replay does not increment failure count.
- Assistance thresholds work and never auto-solve.
- Reordering/moving pads with same IDs does not change sequence.
- Shard hidden/reveal/collection contract passes.
- Mandatory order is exact and one-shot: solved latch → `trial_completed` → `ShardSlot_B.reveal()` → collectible enabled → `shard_available` → reward completion → `shard_collected`.
- Exact Shard_04 text shown once.

## Slice 4.9 Automated/static checks

- Godot parse/resource load.
- FSM harness for all correct stages.
- Wrong input at stage 3 confirms stages 1-2 persist.
- Pad occupied/rearm harness.
- Pad registry reorder/duplicate/missing-ID validation.
- Manual replay and fail-count harness.
- Leave/re-enter generation cancellation harness.
- Duplicate completion/reveal/collection checks.
- Changed-file whitelist including only matching approved `.gd.uid` sidecars; temporary harnesses absent; `git diff --check`.

## Slice 4.10 Manual runtime checks

- Complete full 1/2/3/4 sequence.
- Stand on cue pad during display and remain through WAITING.
- Fail same stage 1, 2 and 3 times; observe timing/hint behavior.
- Use E replay mid-stage.
- Leave during display and during partial input; return.
- Stand in shard spawn before reveal.
- Disable optional Trial B VFX completion and confirm fallback.
- Collect shard and verify exact overlay text.

## Slice 4.11 Rollback plan

- Revert Slice 4 commit; Trial A and Slice 2 remain functional.
- If generic ShardSlot regression appears, correct local adapter with Trial A regression tests.

## Slice 4.12 Risks

| Risk | Mitigation |
|---|---|
| Pad identity coupled to hierarchy | Strict dictionary keyed by exported symbol_id. |
| Async sequence continues after exit | Generation token and state checks. |
| Body event queued during display | Pad accepting_input=false and event discarded. |
| Player softlocks by remaining on pad | Occupied pads start unarmed; explicit step-off/rearm. |
| Error erases completed progress | Completed stage count and petal states are one-way. |

## Slice 4.13 Out of scope

- Random sequences.
- Audio-finalization.
- Environment progression.
- Final center/portal.

## Slice 4.14 Handoff format

- Branch, base SHA, slice-start SHA and final head SHA.
- Exact `git diff --name-only` list.
- Summary of implemented behavior and preserved contracts.
- Commands/checks executed and factual outputs.
- Manual checks: PASS / FAIL / NOT VERIFIED.
- Known risks, blockers and fallback paths.
- Confirmation that no forbidden/shared/Level_01 files changed.
- Commit SHA for the slice and PR link.
- Explicit recommendation: proceed / stop.

# Slice 5 - Two-Shard and Environment Progression

## Slice 5.1 Goal

Integrate the two shard collection events into order-independent sector activation and two non-blocking environment phases with race-safe idempotency.

## Slice 5.2 Preconditions

- Slices 3 and 4 accepted independently.
- Both shard slots emit canonical collection IDs after shared reward flow.
- Progress skeleton and central identity mapping are stable.

## Slice 5.3 Exact files expected to change

```text
scenes/levels/Level_02.tscn
scenes/levels/level_02/gameplay/Level02ProgressController.tscn
scripts/levels/level_02/level_02_progress_controller.gd
scenes/levels/level_02/gameplay/Level02CentralArenaGameplay.tscn
scripts/levels/level_02/level_02_central_arena_controller.gd
scenes/levels/level_02/vfx/Level02CentralLightVFX.tscn
scripts/levels/level_02/level_02_central_vfx_adapter.gd
scenes/levels/level_02/state/Level02EnvironmentState.tscn
scripts/levels/level_02/level_02_environment_state_controller.gd
scenes/levels/level_02/vfx/Level02EnvironmentVFX.tscn
scripts/levels/level_02/level_02_environment_vfx_adapter.gd
```
Matching Godot UID sidecars are additionally allowed only for approved GDScript files listed in this slice:

```text
scripts/levels/level_02/<approved_script>.gd.uid
```

Every allowed `.gd.uid` must have its approved sibling `.gd` in the same slice/file scope. Unrelated UID/import regeneration is forbidden.


## Slice 5.4 Exact files forbidden to change

- `project.godot` unless a proven blocker is separately approved
- all Level_01 files and active Level_01 PR branches
- shared Player/Camera/SoulShard/Reward UI/LevelPortal scripts and scenes
- `scripts/core/level_manager.gd`
- `scenes/levels/Level_03.tscn`
- Level_07-15 and FinalScene
- raw `.glb`, `.import`, Blender files and final art resources
- new autoload, save/GameState or broad framework files
- No changes to trial puzzle internals unless a proven integration defect.
- No main text/portal behavior.
- No shared Environment or project setting changes.

## Slice 5.5 Nodes, scenes and scripts

- Scene-local WorldEnvironment and EnvironmentStateController.
- Optional primitive EnvironmentVFX adapter.
- Progress event connections to both shard slots.
- Explicit sector/channel activation for each collected shard.
- Return-guide placeholders after second shard.

## Slice 5.6 Methods and signals

| Contract item | Required contract |
|---|---|
| `register_shard_collected(id)` | Set per-ID boolean once, derive count and dispatch correct phase. |
| `first_shard_progress_reached(id)` | Optional milestone; exactly once on 0→1. |
| `all_shards_collected()` | Optional milestone; exactly once on 1→2. |
| `request_first_shard_transition()` | Independent color/fog phase 1. |
| `request_second_shard_transition()` | Independent fog phase 2, preserve color restoration. |
| `color_ready()` / `fog_ready()` | One-shot completion or fallback signals. |

## Slice 5.7 Implementation steps

1. Connect both ShardSlot collection signals explicitly.
2. Validate exact mapping Shard_03→trial_a sector and Shard_04→trial_b sector.
3. On first unique collection, set boolean, activate matching sector/channel and start phase 1 once.
4. On second unique collection, set boolean, activate second sector/channel, start phase 2 once and enable return guidance.
5. Implement derived count and duplicate/unknown-ID guards.
6. Create scene-local/deep-duplicated Environment and capture initial fog density.
7. Apply initial saturation 0.20 and readable fog before controls.
8. Implement `_color_tween`, `_fog_tween` and optional `_light_tween` as independent owners.
9. Guarantee saturation reaches 1.00 even if second shard arrives before phase 1 completes.
10. Keep movement/camera/puzzles enabled throughout.
11. Provide logical completion fallback if optional EnvironmentVFX is missing.

## Slice 5.8 Acceptance criteria

- A→B and B→A produce identical final booleans, count, environment phase and active sectors.
- Environment does not change on trial_completed or shard_available.
- First transition starts once and lasts 9 s target.
- Second transition starts once and lasts 7 s target.
- Second transition never cancels color tween; final saturation 1.00.
- Duplicate shard signal has zero repeated side effects.
- Environment resource is unique/local.
- Player controls remain enabled.
- Final central sequence still cannot start in Slice 5.

## Slice 5.9 Automated/static checks

- Either-order progress harness with side-effect counters.
- Duplicate and unknown-ID harness.
- Environment race harness: invoke second transition before first completes.
- Validate `adjustment_enabled`, `fog_enabled`, local resource and target values.
- Godot parse/resource load.
- Static check for `set_controls_enabled(false)` inside environment scripts - must be absent.
- Changed-file whitelist including only matching approved `.gd.uid` sidecars; temporary harnesses absent; `git diff --check`.

## Slice 5.10 Manual runtime checks

- Complete/collect A then B.
- Fresh reload; complete/collect B then A.
- Solve both before collecting; collect B then A.
- Run/move camera and start remaining puzzle during 9 s transition.
- Collect second shard before 9 s phase completes.
- Enter/leave center during fog transition and confirm no final starts yet.
- Disable optional EnvironmentVFX and confirm phase signals/fallback.

## Slice 5.11 Rollback plan

- Revert Slice 5 commit; both standalone trials remain collectible without global environment progression.
- If Environment resource mutation leaks, revert immediately before any further slice.

## Slice 5.12 Risks

| Risk | Mitigation |
|---|---|
| Second phase kills first color tween | Independent tween fields and target guarantee. |
| Shared Environment mutated | Deep duplicate/reassign and startup validation. |
| Order-specific branch | No `first_shard_id` gameplay branching; per-ID booleans only. |
| Duplicate callback restarts phase | Started/complete latches checked before side effects. |
| Transition blocks movement | No player/camera control calls in environment controller. |

## Slice 5.13 Out of scope

- Main text.
- Portal formation/activation.
- Final art/audio.
- Remote final event before center return.

## Slice 5.14 Handoff format

- Branch, base SHA, slice-start SHA and final head SHA.
- Exact `git diff --name-only` list.
- Summary of implemented behavior and preserved contracts.
- Commands/checks executed and factual outputs.
- Manual checks: PASS / FAIL / NOT VERIFIED.
- Known risks, blockers and fallback paths.
- Confirmation that no forbidden/shared/Level_01 files changed.
- Commit SHA for the slice and PR link.
- Explicit recommendation: proceed / stop.

# Slice 6 - Central Return, Main Text and Portal

## Slice 6.1 Goal

Complete the chapter flow after both shards: return guidance, center gate, non-canceling final placeholder event, exact main text and safely delegated portal activation to Level_03.

## Slice 6.2 Preconditions

- Slice 5 accepted with both-order parity.
- Actual shared LevelPortal capability re-confirmed on current branch.
- PoemRewardUI and camera UI contract re-confirmed.

## Slice 6.3 Exact files expected to change

```text
scenes/levels/Level_02.tscn
scenes/levels/level_02/gameplay/Level02ProgressController.tscn
scripts/levels/level_02/level_02_progress_controller.gd
scenes/levels/level_02/gameplay/Level02CentralArenaGameplay.tscn
scripts/levels/level_02/level_02_central_arena_controller.gd
scenes/levels/level_02/vfx/Level02CentralLightVFX.tscn
scripts/levels/level_02/level_02_central_vfx_adapter.gd
scenes/levels/level_02/gameplay/Level02PortalAdapter.tscn
scripts/levels/level_02/level_02_portal_adapter.gd
scenes/levels/level_02/vfx/Level02PortalVFX.tscn
scripts/levels/level_02/level_02_portal_vfx_adapter.gd
```
Matching Godot UID sidecars are additionally allowed only for approved GDScript files listed in this slice:

```text
scripts/levels/level_02/<approved_script>.gd.uid
```

Every allowed `.gd.uid` must have its approved sibling `.gd` in the same slice/file scope. Unrelated UID/import regeneration is forbidden.


## Slice 6.4 Exact files forbidden to change

- `project.godot` unless a proven blocker is separately approved
- all Level_01 files and active Level_01 PR branches
- shared Player/Camera/SoulShard/Reward UI/LevelPortal scripts and scenes
- `scripts/core/level_manager.gd`
- `scenes/levels/Level_03.tscn`
- Level_07-15 and FinalScene
- raw `.glb`, `.import`, Blender files and final art resources
- new autoload, save/GameState or broad framework files
- No Level_03 implementation.
- No shared LevelPortal modification unless a separately approved blocker task.
- No replacement of PoemRewardUI or ShardRewardOverlay.
- No long cinematic or camera takeover.

## Slice 6.5 Nodes, scenes and scripts

- ReturnGuide_A/B active presentation after second shard.
- Central final sequence: sector sync, three spirals, thin vertical beam.
- PoemRewardUI main text.
- Level02PortalAdapter with actual shared PortalCore instance.
- Portal formation placeholder or shared activation delegation.

## Slice 6.6 Methods and signals

| Contract item | Required contract |
|---|---|
| `set_final_return_guidance(true)` | Persistent and non-blocking after second shard. |
| `begin_final_activation()` | Valid once; leaving center does not cancel. |
| `final_visual_complete()` | Emit once after 5.5-6.0 s or fallback. |
| `handle_main_text_closed()` | Accept once; unlock Player and begin portal formation. |
| `Level02PortalAdapter.begin_formation()` | Valid only from INACTIVE after main text closes. Upgraded core is configured for Level_03 + AUTO_ENTER + no confirmation and receives one shared `activate()` call; legacy core receives one call after local placeholder formation. |
| `portal_activated()` | Upgraded: emit once after shared `activation_completed` or guarded fallback. Legacy: emit once after local formation + shared activation guarded path. Scene transition remains shared. |

## Slice 6.7 Implementation steps

1. After both shards, set final_return_pending and enable central guidance.
2. Combine fog_ready and center presence through invariant; do not start from elapsed time or remote collection.
3. If player is in center when fog becomes ready, start once; if player left, wait for next entry.
4. Once started, final visual continues even if player exits zone.
5. Run 0-1.2 s calm sector sync, 1.2-4.2 s staggered spiral fill, 4.2-5.5 s thin beam, then stable state.
6. Use callback + fallback; notify Progress once.
7. Before opening main text, verify ShardRewardOverlay is not active; defer/retry safely if needed.
8. Disable Player controls only while main text is visible.
9. On first valid `closed`, re-enable controls and call portal adapter once.
10. If the actual base has upgraded `LevelPortal`, set `target_scene_path = "res://scenes/levels/Level_03.tscn"`, `entry_mode = LevelPortal.EntryMode.AUTO_ENTER`, and `require_entry_confirmation = false`.
11. Upgraded path: call shared `PortalCore.activate()` once after text closes, do not play duplicate local formation, wait for `activation_completed` or guarded fallback, then emit local `portal_activated` once.
12. Legacy path: run the local 2.8 s primitive placeholder formation, then call `PortalCore.activate()` exactly once and emit local `portal_activated` through the same guarded completion path.
13. In both paths, never call scene change or own scene loading in the adapter.
14. Run mandatory early-overlap test. If shared portal misses it, stop and request approved prerequisite.

## Slice 6.8 Acceptance criteria

- Final never starts before both shards and fog_ready.
- Entering center early queues presence only.
- Leaving before fog_ready prevents remote start.
- Leaving after final start does not cancel.
- Main text exact and shown once.
- Player locked only while main text visible.
- Portal formation/activation begins only after text closes.
- Upgraded portal configuration is exact: Level_03 target, `AUTO_ENTER`, and `require_entry_confirmation = false`.
- Upgraded core receives one shared `activate()` call and no duplicate local formation.
- Adapter waits for `activation_completed` or guarded fallback, then emits one local `portal_activated`.
- Legacy core receives one `activate()` call only after local placeholder formation.
- Duplicate close/formation/completion causes one activation.
- Portal remains inactive/unusable until the guarded activation path completes.
- Early overlap transitions exactly once after activation or triggers documented blocker.

## Slice 6.9 Automated/static checks

- Godot parse/resource load.
- Final-gate harness for all timing combinations.
- Duplicate close/formation callback race harness.
- Capability test against actual PortalCore signals/methods.
- Static check: Level02PortalAdapter contains no `change_scene_to_file`.
- Static check: portal target exact.
- Changed-file whitelist including only matching approved `.gd.uid` sidecars; temporary harnesses absent; `git diff --check`.

## Slice 6.10 Manual runtime checks

- Collect both orders and return during/after fog.
- Enter center before fog ready; stay until ready.
- Enter then leave before fog ready; return later.
- Exit central zone after final starts.
- Inspect exact main text and close once/twice.
- Walk into forming visual - no transition.
- Stand inside future portal volume before activation.
- Rapid enter/exit after activation - one Level_03 request.
- Disable optional central/portal VFX and confirm fallbacks.

## Slice 6.11 Rollback plan

- Revert Slice 6 commit; Slice 5 remains a complete two-trial environment-progress prototype without chapter exit.
- Do not patch shared portal inside rollback. Keep blocker isolated.

## Slice 6.12 Risks

| Risk | Mitigation |
|---|---|
| Double formation with upgraded portal | Capability-based delegation; local VFX disabled when shared core owns activation. |
| Early-overlap missed | P0 test; stop and request minimal shared prerequisite. |
| Main text overlaps shard overlay | Collection signal only after reward completes plus visible-panel guard. |
| Portal activates from duplicate close | Progress and adapter one-shot latches. |
| Final starts remotely | Strict both-shard + fog-ready + center-presence invariant. |

## Slice 6.13 Out of scope

- Level_03 content.
- Final portal art/audio.
- Final typography/cinematics.
- Shared portal redesign.

## Slice 6.14 Handoff format

- Branch, base SHA, slice-start SHA and final head SHA.
- Exact `git diff --name-only` list.
- Summary of implemented behavior and preserved contracts.
- Commands/checks executed and factual outputs.
- Manual checks: PASS / FAIL / NOT VERIFIED.
- Known risks, blockers and fallback paths.
- Confirmation that no forbidden/shared/Level_01 files changed.
- Commit SHA for the slice and PR link.
- Explicit recommendation: proceed / stop.

# Slice 7 - Stabilization and Acceptance

## Slice 7.1 Goal

Harden the complete greybox, remove duplicate/stale paths, execute the full acceptance and softlock matrices, clean warnings/logging, verify duration and create the factual development summary.

## Slice 7.2 Preconditions

- Slices 1-6 implemented and individually accepted.
- No P0 blocker remains unresolved.
- Full branch diff is isolated to approved Level_02/documentation files.

## Slice 7.3 Exact files expected to change

```text
scenes/levels/Level_02.tscn
scenes/levels/level_02/**/*.tscn
scripts/levels/level_02/*.gd
docs/development/Level_02_Greybox_Implementation_Summary.md
Level_02_Greybox_Implementation_Summary.docx  # user-facing artifact; commit only if explicitly requested
```
Matching Godot UID sidecars are additionally allowed only for approved GDScript files listed in this slice:

```text
scripts/levels/level_02/<approved_script>.gd.uid
```

Every allowed `.gd.uid` must have its approved sibling `.gd` in the same slice/file scope. Unrelated UID/import regeneration is forbidden.


## Slice 7.4 Exact files forbidden to change

- `project.godot` unless a proven blocker is separately approved
- all Level_01 files and active Level_01 PR branches
- shared Player/Camera/SoulShard/Reward UI/LevelPortal scripts and scenes
- `scripts/core/level_manager.gd`
- `scenes/levels/Level_03.tscn`
- Level_07-15 and FinalScene
- raw `.glb`, `.import`, Blender files and final art resources
- new autoload, save/GameState or broad framework files
- No new shared-system changes.
- No art/audio scope expansion.
- No project settings or save/GameState work.
- No unrelated cleanup.

## Slice 7.5 Nodes, scenes and scripts

- All Level_02 scenes/controllers/adapters from prior slices.
- No new gameplay architecture unless required to fix a failing acceptance test.
- Development summary Markdown committed to the runtime PR.
- Content-equivalent `Level_02_Greybox_Implementation_Summary.docx` generated as a user-facing final artifact; it is not required in the runtime PR unless explicitly requested.

## Slice 7.6 Methods and signals

| Contract item | Required contract |
|---|---|
| All public event handlers | Idempotent and stale-callback safe. |
| Verbose logging | Default false; no per-frame spam. |
| Fallback timers | One-shot, canceled/ignored after successful completion. |
| Reload | Clean deterministic reset is accepted MVP policy. |

## Slice 7.7 Implementation steps

1. Review full changed-file list against master whitelist.
2. Run parser/resource-load checks for every new scene/script.
3. Exercise duplicate trial, shard, environment, UI and portal signals.
4. Run A→B and B→A full playthroughs and compare final snapshots.
5. Run solve-both-before-collecting variant.
6. Run all leave/re-enter and fall recovery cases.
7. Run missing-VFX fallback cases.
8. Review route collision, camera clearance, interaction volumes and portal volume.
9. Measure first completion target 6-8 min; maximum with mistakes ≤10 min; correct repeat 4-6 min.
10. Resolve new warnings/errors/null references.
11. Disable/remove temporary debug UI and set verbose flags false.
12. Ensure every temporary harness lives outside the repository or is removed before commit.
13. Create factual `docs/development/Level_02_Greybox_Implementation_Summary.md` with SHAs, files, tests, manual gaps and known limitations.
14. Generate content-equivalent `Level_02_Greybox_Implementation_Summary.docx` for user-facing final handoff; do not commit it unless explicitly requested.

## Slice 7.8 Acceptance criteria

- All P0 test matrix rows pass.
- A→B and B→A final state parity.
- No duplicate side effect or softlock.
- No invalid NodePath, parser error or null dereference.
- No mandatory jump and all boundaries safe.
- No control lock during environment transitions.
- Portal only after main text close and one Level_03 transition.
- Duration within approved budget or deviation documented for producer.
- No forbidden/shared/Level_01 files in diff.
- Both final implementation summaries exist, are factual and content-equivalent: repository Markdown plus user-facing DOCX.

## Slice 7.9 Automated/static checks

- Godot headless `--check-only` or equivalent.
- Load every Level_02 PackedScene.
- Temporary validation harness for state/duplicate/either-order tests, stored outside the repository or deleted before commit.
- `git diff --check`.
- `git diff --name-only` against whitelist.
- Search for deprecated/unknown shard IDs and random-sequence APIs.
- Search for forbidden `change_scene_to_file` outside shared portal.
- Search for `project.godot`, Level_01 or Level_03 changes.

## Slice 7.10 Manual runtime checks

- Full T01-T42 matrix in Section 21.
- Two complete videos or equivalent evidence: A→B and B→A.
- Fall from arrival, all three routes and both trials.
- Missing VFX tests.
- Early-overlap portal test.
- Duration timing.
- Fresh scene reload after partial A and partial B.

## Slice 7.11 Rollback plan

- Fixes should be separate corrective commits where practical.
- If a stabilization fix expands scope or requires shared changes, stop and split into a separately approved prerequisite.
- If final branch becomes unstable, revert the last corrective commit rather than rewriting prior accepted slices.

## Slice 7.12 Risks

| Risk | Mitigation |
|---|---|
| Late broad refactor | Forbidden; fix only failing behavior in its owner. |
| Manual evidence incomplete | Mark NOT VERIFIED; do not claim acceptance. |
| P0 failure hidden by polish | Hard stop until root cause corrected. |
| Duration over 10 min | Tune approved timings/assistance only; do not remove a trial or force order. |
| Warnings from unrelated baseline | Separate pre-existing from introduced; do not claim to fix unrelated systems. |

## Slice 7.13 Out of scope

- Final art/assets/materials/sound/music.
- Save/checkpoint persistence.
- Level_03/Level_07-15/final scene changes.
- New gameplay systems.

## Slice 7.14 Handoff format

- Branch, base SHA, slice-start SHA and final head SHA.
- Exact `git diff --name-only` list.
- Summary of implemented behavior and preserved contracts.
- Commands/checks executed and factual outputs.
- Manual checks: PASS / FAIL / NOT VERIFIED.
- Known risks, blockers and fallback paths.
- Confirmation that no forbidden/shared/Level_01 files changed.
- Commit SHA for the slice and PR link.
- Explicit recommendation: proceed / stop.
- Final implementation summary paths and content-equivalence checklist for both Markdown and DOCX.
- Confirmation that the DOCX is user-facing and uncommitted unless explicitly requested.
- Final Definition of Done assessment.

# 20. Master file ownership matrix

| Area | Expected change policy |
|---|---|
| `docs/design/Level_02_Greybox_Development_Reference.md` | Required repository source for Version 1.1; documentation revision only, not a runtime-slice change. |
| `Level_02_Greybox_Development_Reference_v1.1.docx` | Content-equivalent Producer artifact; outside runtime PR unless explicitly requested. |
| `scenes/levels/Level_02.tscn` | Only existing runtime file expected to be replaced/modified across runtime slices. |
| `scenes/levels/level_02/**` | New Level_02-local scene files only. |
| `scripts/levels/level_02/*.gd` | New approved Level_02-local GDScript only. |
| `scripts/levels/level_02/*.gd.uid` | Allowed only when each sidecar corresponds to an approved sibling `.gd`; unrelated UID regeneration forbidden. |
| `docs/development/Level_02_Greybox_Implementation_Summary.md` | Mandatory committed factual summary created in Slice 7. |
| `Level_02_Greybox_Implementation_Summary.docx` | Mandatory content-equivalent user-facing artifact; commit only if explicitly requested. |
| Temporary harnesses | Must be outside repository or removed before commit. |
| Shared Player/Camera/SoulShard/UI/Portal | Read/reuse only. Any required write is a hard stop and separate task. |
| `project.godot` | No change without approved blocker. |
| Level_01 / active Level_01 PR | Never touched. |
| Level_03 | Target only; never modified. |
| Raw art/imports | Not part of greybox. |

## 20.1 Changed-file whitelist

The runtime PR may contain only:

```text
scenes/levels/Level_02.tscn
scenes/levels/level_02/**/*.tscn
scripts/levels/level_02/*.gd
scripts/levels/level_02/*.gd.uid  # only matching approved sibling .gd files
docs/development/Level_02_Greybox_Implementation_Summary.md
```

`Level_02_Greybox_Implementation_Summary.docx` is mandatory for final user handoff but remains outside the runtime PR unless explicitly requested. Temporary harnesses are not whitelisted and must live outside the repository or be removed before commit. No unrelated `.uid`, `.import` or import metadata regeneration is permitted.

The Version 1.1 documentation package is separately limited to:

```text
docs/design/Level_02_Greybox_Development_Reference.md
Level_02_Greybox_Development_Reference_v1.1.docx  # user-facing artifact, normally outside repo
```

# 21. Acceptance test matrix

| ID | Area | Action | Expected result | Priority | Primary slice |
|---|---|---|---|---|---|
| T01 | Startup | Load Level_02 from dev menu/direct scene. | Initial readable shell, shards/portal inactive, no new errors. | P0 | 1/2 |
| T02 | Arrival input | Move or rotate camera immediately. | arrival_activated once; controls stay enabled. | P1 | 2 |
| T03 | Arrival idle | No input for 4 s. | Automatic activation once. | P1 | 2 |
| T04 | A→B | Complete/collect A then B. | Color after first, fog after second, final waits for center. | P0 | 5-7 |
| T05 | B→A | Complete/collect B then A. | Same final flags/environment as T04. | P0 | 5-7 |
| T06 | Solve both before collect | Solve both, collect B then A. | No environment before collection; same final state. | P0 | 5-7 |
| T07 | Duplicate shard | Submit same canonical collection twice. | Count and side effects unchanged after first. | P0 | 5/7 |
| T08 | Trial A cycle | Cycle 0→1→2→0. | Fixed 0.40 s rotation; no queued spam. | P1 | 3 |
| T09 | Trial A lock/order | Complete 3/3 and observe events. | Solved latch, then `trial_completed`, then reveal enables shard and emits `shard_available`; prompt/receivers remain stable. | P0 | 3 |
| T10 | Trial A persistence | Lock two, leave and return. | Indices/locks preserved. | P0 | 3/7 |
| T11 | Trial A assistance | Wait/rotate without progress. | 35/55/80 s hints in order; no auto-solve. | P2 | 3 |
| T12 | Trial A early shard | Stand at spawn before reveal. | Cannot collect. | P0 | 3 |
| T13 | Trial B correct/order | Complete stages 1-4 and observe events. | One persistent petal per stage; solved latch → `trial_completed` → reveal/enable → `shard_available` exactly once. | P0 | 4 |
| T14 | Trial B wrong | Wrong symbol in stage 3. | Only current input resets; earlier petals persist. | P0 | 4 |
| T15 | Trial B assistance | Fail same stage 3+ times. | Slow replay after second; next-pad hint after third. | P1 | 4 |
| T16 | Trial B manual replay | Press E near bud while waiting. | Input clears; replay; fail count unchanged. | P1 | 4 |
| T17 | Input during showing | Stand/step on cue pad during display. | No queued input. | P0 | 4 |
| T18 | Pad step-off | Remain on pad across state change. | No activation until step-off/re-enter. | P0 | 4 |
| T19 | Trial B re-entry | Stage 2 complete, partial stage 3, leave/return. | Stages persist; partial clears; stage replays. | P0 | 4/7 |
| T20 | First transition movement | Run during 9 s color return. | No control/camera/puzzle lock. | P0 | 5 |
| T21 | Second transition movement | Run during 7 s fog dispersal. | No lock; guidance active. | P0 | 5 |
| T22 | Center before fog ready | Enter center during fog. | No early final; starts at ready only if still inside. | P0 | 6 |
| T23 | Leave before fog ready | Enter then leave. | Final waits for next valid entry. | P0 | 6 |
| T24 | Final non-cancel | Exit after final starts. | Sequence continues; text once. | P1 | 6 |
| T25 | Main text | Inspect and close. | Exact text; lock only while visible. | P0 | 6 |
| T26 | Duplicate close | Emit close twice. | One formation only. | P0 | 6/7 |
| T27 | Portal forming | Enter visual before complete. | No transition. | P0 | 6 |
| T28 | Portal early overlap | Stand inside future volume until activation. | Exactly one transition or documented shared blocker. | P0 | 6/7 |
| T29 | Rapid portal re-entry | Enter/exit repeatedly. | One scene-load request. | P0 | 6/7 |
| T30 | Missing VFX | Disable each optional adapter. | Fallback; no softlock. | P0 | 3-7 |
| T31 | Fall recovery | Fall below every platform/route. | Nearest-anchor recovery; state preserved. | P0 | 1/7 |
| T32 | Reload policy | Reload during partial progress. | Clean deterministic reset. | P1 | 7 |
| T33 | Camera/UI | Open shard overlay and PoemRewardUI. | Mouse/camera behavior matches actual shared contract. | P1 | 3/6 |
| T34 | Target scene | Enter active portal. | Loads exactly Level_03 path. | P0 | 6/7 |
| T35 | Parser/runtime | Run checks and smoke. | No new parser errors or invalid NodePaths. | P0 | all |
| T36 | Canonical IDs | Inspect exports/logs. | A=Shard_03; B=Shard_04; no deprecated IDs. | P0 | 3-7 |
| T37 | Central identity | Reorder visual children. | Explicit SECTOR mapping still correct. | P0 | 2/5 |
| T38 | Pad identity | Reorder/move pads preserving IDs. | Sequence unchanged. | P0 | 4 |
| T39 | Hidden shard/event order | Overlap before reveal, then complete reward. | No hidden collection; collectible enable precedes `shard_available`; `shard_collected` occurs only after reward completion. | P0 | 3/4 |
| T40 | Environment race | Second shard before 9 s completion. | Fog starts independently; saturation reaches 1.00. | P0 | 5 |
| T41 | Environment validation | Use invalid/shared resource in test copy. | Blocker reported; production resource local/enabled. | P0 | 5 |
| T42 | NodePath overrides | Validate every exact relative path. | Every path resolves; no absolute/global search. | P0 | 2-7 |

# 22. Softlock matrix

| Risk | Prevention | Fallback | Acceptance test |
|---|---|---|---|
| Leave Trial A halfway | Local indices/locks persist | Resume exact state; no intro reset | Lock 2/3, leave, return |
| Leave Trial B halfway | Completed stages persist; partial input clears | Replay current stage on re-entry | Stage2 + partial Stage3 |
| Pad during replay | Pads disabled and event discarded | Occupied pad remains unarmed | Stand on lit pad |
| Remain on pad | Armed latch + step-off distance | No auto-repeat | Stay across WAITING transition |
| Collect shard early / out-of-order events | Solved latch and `trial_completed` precede reveal; Slot disables all collection facets until `reveal()` enables them | `shard_available` only after enable; `shard_collected` only after reward completion | Stand at spawn, log exact A/B event order |
| Duplicate shard signal | Per-ID boolean guard | Ignore and warn once | Call twice |
| Duplicate trial signal | Per-trial boolean guard | Ignore and warn once | Call twice |
| Second shard during color tween | Independent tweens | Saturation still reaches 1.00 | Collect rapidly |
| Enter center before fog ready | Presence stored; strict gate | Start only when ready and still inside | Sprint to center |
| Leave center before fog ready | Presence becomes false | Wait for next entry | Enter/leave |
| Leave after final starts | Final one-shot latch | Sequence continues | Exit zone |
| Main text closes twice | Close-handled latch | One portal formation | Emit twice |
| Portal completion/fallback race | Single guarded handler | One activation | Trigger both |
| Portal early overlap | Shared portal runtime test | Separate prerequisite if actual API misses overlap | Stand inside future volume |
| Missing Trial A/B VFX callback | Controller fallback timer | Reveal/progress completes with warning | Disable callback |
| Missing central/portal VFX | Progress/adapter fallback | Text/portal still reachable | Disable adapter |
| Fall from route/platform | SoftReturnVolume + explicit anchors | Teleport, zero velocity, preserve flags | Fall in each zone |
| Reload partial state | MVP clean reset policy | No contradictory half-state | Reload at each stage |
| Unknown canonical ID | Validation and safe ignore | No state mutation | Submit invalid ID |
| Missing required NodePath | Startup validation | Fail closed with clear error; no partial progression | Break path in test copy |
| Reward overlay unavailable | Shared controller safe completion contract | Shard collection completes or blocker documented | Disable overlay in test copy |
| Player controls remain locked | Shared sequence reset + main-text close handler | Restore controls in all guarded exits | Force missing camera/VFX |

# 23. Producer approval gates

| Gate | After slice | Required evidence | Decision |
|---|---|---|---|
| G0 - Preflight approval | 0 | Base SHA, active PR map, shared API contracts, exact file plan, zero diff. | APPLY / WAIT / REBASE / STOP |
| G1 - Spatial gate | 1 | Walkability video/screens, coordinates, routes, boundaries, recovery, no puzzles. | INTERNAL PASS → auto-continue; FAIL → correct/stop by hard-stop rules |
| G2 - Progress shell gate | 2 | Arrival one-shot, explicit sector identity, no global scan, no puzzles. | INTERNAL PASS → auto-continue; FAIL → correct/stop by hard-stop rules |
| G3A - Trial A gate | 3 | Trial A matrix, event order, hidden shard, persistence, exact text. | INTERNAL PASS → auto-continue; FAIL → correct/stop by hard-stop rules |
| G3B - Trial B gate | 4 | Trial B FSM, event order, pad identity, replay/assistance, hidden shard. | INTERNAL PASS → auto-continue; FAIL → correct/stop by hard-stop rules |
| G4 - Integration gate | 5 | A→B/B→A harness, environment race, non-blocking controls. | INTERNAL PASS → auto-continue; FAIL → correct/stop by hard-stop rules |
| G5 - Chapter completion gate | 6 | Center gate, exact main text, portal configuration/order/early overlap/Level_03. | INTERNAL PASS → auto-continue; blocker → stop |
| G6 - Final greybox acceptance | 7 | Full P0 matrix, duration, clean diff, both summaries, no forbidden changes. | INTERNAL final PASS or stop/correct by hard-stop rules |

Execution contract: only Slice 0 requires explicit user `APPLY`. After `APPLY`, execute Slice 1, validate and commit it, then automatically continue through Slices 2-7. G1-G6 are internal gates and do not require user confirmation when PASS. Stop only for: P0 failure; shared-system blocker; scope deviation; unresolved active-PR/base conflict; required Producer-only decision; or mandatory acceptance evidence that cannot be verified.

# 24. Definition of Done

- Level_02 is a complete playable primitive-only greybox.
- Exact 1+3 layout, coordinates, route widths, slopes and boundaries match the approved specification within ±0.25 m.
- Player and camera are reused without shared modifications.
- Arrival activates once through input or 4 s fallback.
- Central arena has explicit arrival/trial_a/trial_b sectors, channels and spiral placeholders.
- Trial A has exactly three statues, exactly three fixed orientations, lock persistence, assistance and safe Shard_03 reveal.
- Trial B has four typed symbol pads, fixed cumulative 1/2/3/4 sequence, display input lock, current-stage-only reset, replay, assistance, persistent petals and safe Shard_04 reveal.
- Two exact short texts are displayed through existing shard reward flow.
- Trial completion, shard availability and shard collection are separate and follow the locked order for both trials: solved latch → `trial_completed` → reveal/enable → `shard_available` → reward completion → `shard_collected`.
- A→B and B→A produce identical final authoritative state.
- First/second environment phases are idempotent, non-blocking and race-safe; final saturation reaches 1.00.
- Final event requires both shards, fog readiness and central presence.
- Main text is exact, shown once and is the only Level_02-specific blocking text phase.
- Portal begins only after main text closes. Upgraded core is configured with exact Level_03 target, `AUTO_ENTER` and no confirmation; adapter calls shared `activate()` once, waits for `activation_completed`/fallback, emits local `portal_activated`, and never scene-loads. Legacy core receives one `activate()` call after local placeholder formation.
- Fall recovery, leave/re-enter, duplicate events, missing optional VFX and clean reload have no softlock.
- All P0 tests pass; any NOT VERIFIED manual item is clearly marked and blocks final acceptance where required.
- No `project.godot`, Level_01, shared system, Level_03, Level_07-15, raw art or save/GameState changes. Only approved Level_02 `.gd.uid` sidecars with matching sibling `.gd` are allowed; no unrelated UID/import regeneration.
- Godot parse/resource load has no new errors or invalid NodePaths.
- Verbose debug logging defaults false and no per-frame spam remains.
- Required repository reference source is `docs/design/Level_02_Greybox_Development_Reference.md`, content-equivalent to `Level_02_Greybox_Development_Reference_v1.1.docx`.
- `docs/development/Level_02_Greybox_Implementation_Summary.md` and content-equivalent `Level_02_Greybox_Implementation_Summary.docx` both exist with factual evidence; the DOCX is committed only if explicitly requested.
- No temporary harness remains in the repository at commit time.

# 25. Suggested branch, commits and PR

| Item | Recommendation |
|---|---|
| Documentation branch for this reference | `docs/level-02-greybox-development-reference` |
| Documentation PR title | `Document Level 02 greybox implementation reference` |
| Runtime branch | `feature/level-02-living-light-greybox` |
| Runtime PR title | `Build Level 02 Living Light greybox` |
| Base | Current `main` after active Level_01 PR decision, unless producer explicitly approves another integration base. |
| PR mode | One focused draft runtime PR with one logical commit per accepted slice; no force-push/amend of Level_01 work. |

```text
docs: add Level 02 greybox development reference
level02: build spatial greybox shell
level02: add arrival and central progress shell
level02: implement Three Beams trial
level02: implement Echo of Light trial
level02: integrate two-shard environment progression
level02: complete center text and portal flow
level02: stabilize greybox and add implementation summary
```

If a slice requires a shared prerequisite, create a separate minimal PR. Do not mix it into the Level_02 runtime PR.

# 26. Final Codex implementation prompt requirements

- State role: senior Godot implementation agent working inside `MindDevastation/fifteen-shards-of-light`.
- Require reading all applicable AGENTS.md and this reference before any change.
- Require Slice 0 full preflight first, no changes, then wait for APPLY.
- Record exact base branch/base SHA/head SHA and active PR conflicts.
- Treat this reference as task authority; source docs may be consulted for details but not reinterpreted into new scope.
- After explicit Slice 0 `APPLY`, implement one slice at a time in order 1→7.
- Validate and commit each slice before the next.
- When the internal G1-G6 gate is PASS, automatically continue without asking for user confirmation.
- Use only the expected file set for each slice, including matching `.gd.uid` sidecars only for approved Level_02 GDScripts.
- Stop before any shared-system write, project.godot change, Level_01 change or Level_03 change.
- Use explicit NodePaths/typed references; no global node-name scanning.
- Use upward signals and downward commands.
- Preserve canonical IDs, exact texts and either-order behavior.
- Use callback + fallback for optional VFX.
- Run A→B and B→A tests, duplicate tests, environment race and early-overlap portal test.
- Create both final development summaries in Slice 7: committed Markdown and content-equivalent user-facing DOCX.
- Keep temporary harnesses outside the repository or remove them before commit.
- Open/update only the dedicated Level_02 PR; never touch PR #47/#83.

## 26.1 Required final implementation prompt skeleton

```text
1. Repository and approved base
2. Required AGENTS/reference inspection
3. Slice 0 preflight-only instructions
4. WAIT FOR APPLY gate
5. Sequential Slice 1-7 execution rules
6. Per-slice allowed/forbidden file lists
7. Exact APIs, IDs, texts and state invariants
8. Static/headless/manual check requirements
9. Hard stop conditions
10. Commit/PR/handoff requirements
11. Final implementation summary Markdown + DOCX requirement
```

## 26.2 Hard stop conditions for Codex

- Required shared API differs and cannot be adapted locally.
- Active branch contains unrelated or Level_01 changes.
- Task appears to require project.godot/autoload/save changes.
- Level_03 target is absent/renamed.
- Progression would be attached to imported environment nodes.
- A P0 softlock test fails.
- Portal early-overlap fails and no approved shared prerequisite exists.
- A required Producer-only decision is unresolved.
- Mandatory acceptance evidence cannot be verified.

# 27. Slice handoff template

For Slice 0, use `Commit SHA: N/A`. For Slices 1-7, provide the actual commit SHA and automatically proceed after an internal PASS unless a hard-stop condition is present.

```text
## Slice N Handoff

- Branch:
- Base SHA:
- Slice start SHA:
- Final head SHA:
- Commit SHA:
- PR:
- Scope implemented:
- Files changed:
- Files explicitly untouched:
- Static/headless checks:
- Manual runtime checks:
- Acceptance criteria:
- Risks / known limitations:
- NOT VERIFIED items:
- Shared-system changes: NONE / BLOCKER
- Godot project structure preserved: YES / NO
- Runtime gameplay implemented in this slice: YES / NO
- Recommendation: PROCEED / CORRECT / STOP
```

# 28. Final implementation summary requirements

Required outputs:

- `docs/development/Level_02_Greybox_Implementation_Summary.md`;
- `Level_02_Greybox_Implementation_Summary.docx`, content-equivalent and user-facing; commit the DOCX only if explicitly requested.

Both outputs must include:

- Reference version and base SHA.
- Branch, PR and ordered slice commit SHAs.
- Complete changed-file list.
- Implemented node trees and APIs.
- Final canonical IDs/texts.
- A→B and B→A evidence.
- Trial A and Trial B acceptance results.
- Environment race and non-blocking evidence.
- Portal capability used and early-overlap result.
- Fall/reload/missing-VFX/duplicate test results.
- Measured completion times.
- Warnings/errors introduced vs pre-existing.
- Manual checks not verified.
- Known limitations and post-greybox work.
- Confirmation: no final art/audio/save/GameState/Level_03/Level_01 changes.
- Confirmation: only matching approved Level_02 `.gd.uid` sidecars were created/updated; no unrelated UID/import regeneration.
- Confirmation: temporary harnesses were outside the repository or removed before commit.

# 29. Post-greybox boundary

After this reference and runtime greybox are accepted, art production may begin under a separate reference/PR. The greybox PR must not add Blender assets, raw GLBs, final materials, final particles, sound or production dressing. Future art wrappers must replace visual children without moving gameplay-owned pivots, markers, collision zones or state controllers.

# 30. Final reference verdict

> VERSION 1.1 - APPROVED IMPLEMENTATION PLAN: a Level-local, explicit-reference, either-order greybox architecture with two independent trials, two canonical shards, non-blocking environment progression, strict center-return gating and shared-system reuse. No runtime code is created by the reference task itself.
