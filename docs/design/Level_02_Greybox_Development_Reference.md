# Level_02 Greybox Development Reference

**FIFTEEN SHARDS OF LIGHT — Level_02 «Живой свет»**  
Documentation-only implementation authority for Godot 4.x + GDScript.

| Field | Locked value |
|---|---|
| Repository | `MindDevastation/fifteen-shards-of-light` |
| Target scene | `res://scenes/levels/Level_02.tscn` |
| Target result | Complete playable primitive-only greybox |
| Runtime branch | `feature/level-02-living-light-greybox` |
| Runtime PR | `Build Level 02 Living Light greybox` |
| Reference status | No runtime code is implemented by this document |

## 1. Purpose

This reference is the direct Codex implementation source for safe, sequential construction of Level_02. It consolidates the approved visual, gameplay, technical-architecture and art-production documents with the inspected repository contracts.

Required workflow:

1. Execute Slice 0 as inspection only.
2. Record exact base branch/SHA, head SHA, active PR conflicts and shared API contracts.
3. Wait for explicit producer `APPLY`.
4. Implement exactly one slice at a time, Slice 1 through Slice 7.
5. Commit and report each accepted slice before continuing.
6. Stop on a shared-system blocker, P0 failure, unapproved file, scope deviation or producer gate.
7. Finish with `docs/development/Level_02_Greybox_Implementation_Summary.md`.

## 2. Source-of-truth hierarchy

1. `Level_02_Gameplay_Map_and_Level_Design_Spec.docx` — exact coordinates, dimensions, timing, puzzle rules, softlock and acceptance.
2. `Level_02_Technical_Architecture_and_State_Model_v1.1.docx` — ownership, NodePaths, IDs, APIs, signals, state machines and file boundaries.
3. `Level_02_Visual_Master_Concept_Package.docx` — emotional reading, visual language, silhouettes and forbidden directions.
4. `Level_02_Art_Production_Bible_v1.1.docx` — boundary map, layer split, collision/pivot ownership and post-greybox art boundary.
5. Actual repository at Slice 0 — authority for current shared API only. API drift is a documented blocker or local compatibility decision, never a silent redesign.

## 3. Source-of-truth summary

- Level_02 is a quiet ancient natural mechanism of living light, not a dead world, temple, altar or boss arena.
- Layout is one central circular arena plus Arrival, Trial A and Trial B platforms connected by three broad safe paths.
- Trial A and Trial B are equally available and completable in either order.
- `trial_completed`, `shard_available` and `shard_collected` are separate facts.
- Global environment progression starts only after actual shard collection finishes the existing short reward flow.
- First unique shard restores saturation over 9 seconds and slightly reduces fog.
- Second unique shard reduces fog over 7 seconds while saturation is guaranteed to finish at `1.0`.
- Environment transitions never block Player or camera.
- Final central event requires both canonical shards, `fog_ready`, center presence and `not final_started`.
- Main text opens once after the central placeholder visual finishes.
- Portal formation/activation begins only after main text closes.
- Existing `LevelPortal` owns the actual transition to `res://scenes/levels/Level_03.tscn`.

## 4. Repository preflight findings and drift policy

### 4.1 Inspected baseline

- `AGENTS.md` requires inspect → plan → test-impact → apply, small scoped tasks, no unrelated changes and factual handoff.
- Current `Level_02.tscn` is an obsolete one-shard placeholder using `LevelManager`, one `SoulShard`, `PoemRewardUI` and immediate portal activation.
- `LevelManager` is a one-shard linear controller and must not be expanded for Level_02.
- Existing Player provides `set_controls_enabled(bool)` and the `player_interactable` contract: candidate methods `can_player_interact(player)` and `interact(player)`.
- Existing `SoulShard` exports `shard_id` and `reward_text`, emits `reward_sequence_requested(...)`, then parameterless `collected` after the shared reward sequence.
- Existing `ShardRewardSequenceController` supports explicit `register_shard(shard)` but otherwise recursively scans its configured root.
- Existing `PoemRewardUI` provides `show_placeholder_reward(text)` and `closed`.
- Existing `LevelPortal` API is changing in active Level_01 work.

### 4.2 PR boundary correction

The prompt calls PR #47 active, but repository inspection shows PR #47 is merged. It remains an immutable Level_01 baseline. The active Level_01 integration PR is PR #83 on `feature/implement-level-01-finale-and-portal-transitions`; it changes shared portal/camera/shard/UI/project contracts. Never edit either Level_01 files or PR #83 from Level_02 work.

### 4.3 Mandatory runtime-base gate

Before Slice 1, Slice 0 must determine whether PR #83 is merged, closed or still active and choose a producer-approved base. Do not assume PR #104 changes are in `main`; it was merged into the PR #83 branch.

### 4.4 Capability-based portal integration

`Level02PortalAdapter` must inspect actual shared `LevelPortal` capability:

- **Upgraded core:** if `LevelPortal.activate()` owns staged activation and exposes completion/state, adapter delegates activation and does not duplicate formation VFX.
- **Legacy core:** if `activate()` immediately exposes/enables portal, adapter runs a local primitive 2.8 s formation with a 3.0 s fallback, then calls `activate()` once.
- In both modes the adapter never calls `change_scene_to_file`, never owns body filtering and never duplicates the core load latch.
- Early-overlap behavior is a mandatory P0 runtime test. If the actual core misses an already-overlapping Player, stop and request a separately approved backward-compatible shared prerequisite.

## 5. Scope

### Included

- central arena, arrival platform, two trial platforms;
- three paths, boundaries, collision and soft return;
- existing Player and camera;
- start activation and central progress sectors/spiral placeholders;
- Trial A: Three Beams;
- Trial B: Echo of Light;
- two hidden/revealed Soul Shards and two short texts;
- order-independent progression;
- color/fog state transitions;
- center-return event, exact main text and portal to Level_03;
- duplicate/stale-callback protection, missing-VFX fallback and no-softlock behavior;
- debug observability during development and final implementation summary.

### Excluded

- final Blender/GLB assets, final materials, shaders, particles or dressing;
- final sound, music, voiceover, cinematics or typography;
- save/checkpoint/GameState/autoload work;
- Level_03 development;
- Level_07–15 cleanup;
- final acrostic/confession scene;
- combat, damage, death, enemies, inventory, timers or mandatory jumps;
- project-wide framework/refactor;
- any Level_01 or active Level_01 PR change.

## 6. Hard technical rules

- No `project.godot` changes unless a proven blocker is reported and separately approved.
- No Level_01, PR #47 or PR #83 changes.
- No shared Player/Camera/SoulShard/reward UI/LevelPortal modification in the default plan.
- No broad refactor or unrelated formatting/import churn.
- No global node-name scanning for critical Level_02 dependencies.
- No gameplay scripts on raw GLB/import children.
- No GameState, save system or new autoload.
- No random Trial B sequence.
- No free-angle optics in Trial A.
- No assumption that Trial A comes first.
- No portal activation before accepted main-text close.
- No Player-control lock during environment transitions.
- No deletion or cleanup of Level_07–15.
- Optional VFX completion always has a controller-owned fallback.
- Counts derive from per-ID booleans; never use blind `count += 1` as authority.
- Shared Environment/material resources are never mutated in place.

## 7. Existing architecture inventory

| System | Reuse contract |
|---|---|
| Player | Reuse unchanged. Statues and replay implement current `player_interactable` interface. Main text may call `set_controls_enabled(false)` only while visible. |
| Camera | Reuse unchanged. Preserve canonical UI names and re-inspect PR #83 group/name behavior in Slice 0. |
| SoulShard | Child of local `Level02ShardSlot`; unchanged shared script/scene. |
| ShardRewardSequenceController | One instance; explicit overlay/player paths; intentionally empty scan root; explicit registration of both wrapped shards. |
| ShardRewardOverlay | One existing instance serializes both short reward phrases. |
| PoemRewardUI | Existing instance named exactly `PoemRewardUI`; main text only. |
| LevelPortal | Existing core; capability-based adapter; core owns actual transition. |
| LevelManager | Not used or extended in Level_02. |

## 8. Proposed runtime file tree

```text
scenes/levels/Level_02.tscn
scenes/levels/level_02/
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
├── state/Level02EnvironmentState.tscn
└── vfx/
    ├── Level02ArrivalVFX.tscn
    ├── Level02CentralLightVFX.tscn
    ├── Level02TrialAVFX.tscn
    ├── Level02TrialBVFX.tscn
    ├── Level02EnvironmentVFX.tscn
    └── Level02PortalVFX.tscn

scripts/levels/level_02/
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

docs/development/Level_02_Greybox_Implementation_Summary.md
```

Adapter scripts may be omitted only when their primitive scene exposes the exact optional presentation API without gameplay coupling; omissions must be recorded.

## 9. Exact spatial locks

Godot ground plane is X/Z; Y is vertical. +Z runs from Arrival toward center.

| Area | Center | Physical / usable radius |
|---|---|---|
| Central arena | `Vector3(0.00, 0.00, 0.00)` | R22 / R20 |
| Arrival | `Vector3(0.00, -0.50, -51.00)` | R10 / R8.5 |
| Trial A | `Vector3(-44.17, 0.40, 25.50)` | R11 / R9.5 |
| Trial B | `Vector3(44.17, 0.80, 25.50)` | R11 / R9.5 |
| Player floor spawn reference | `Vector3(0.00, -0.30, -54.50)` | validate actual CharacterBody origin/collider/floor snap |

| Route | Endpoints | Length / width |
|---|---|---|
| Arrival | `(0,0,-22)` → `(0,-0.5,-41)` | 19 m / W5.5, clear ≥5.0 |
| Trial A | `(-19.05,0,11)` → `(-34.64,0.4,20)` | 18 m / W5.5, clear ≥5.0 |
| Trial B | `(19.05,0,11)` → `(34.64,0.8,20)` | 18 m / W5.5, clear ≥5.0 |

Hard slope ≤8°. Every circular boundary has explicit route opening ≥6.0 m. No invisible catch floor bridges gaps. `SoftReturnVolume` below Y=-6 is recovery authority.

Important markers:

- central socket `Vector3(0,0.05,0)`, visual R3.5;
- central activation zone `Vector3(0,0.5,0)`, cylinder R5.2/H2.5;
- Shard A `Vector3(-44.17,2.0,25.5)`;
- Shard B `Vector3(44.17,2.3,25.5)`;
- portal visual center `Vector3(0,2.2,0)`;
- portal trigger nominal center `Vector3(0,1.7,0)`, R2.2/H3.4;
- ReturnGuide A/B at `(-34.64,1.1,20)` and `(34.64,1.5,20)`.

## 10. Proposed root node tree

```text
Level_02 (Node3D)
├── LevelRuntimeRoot (Node)
│   ├── Level02ProgressController
│   ├── ShardRewardSequenceController        # existing
│   └── ShardRegistrationScope (Node)         # intentionally empty scan root
├── EnvironmentRoot (Node3D)
│   └── BaseGeometry
│       ├── Block_02_00_CentralArena
│       ├── Block_02_01_Arrival
│       ├── Block_02_02_TrialA
│       ├── Block_02_03_TrialB
│       └── Block_02_04_RoutesAndBoundaries
├── GameplayRoot
│   ├── ArrivalGameplay
│   ├── CentralArenaGameplay
│   ├── TrialA_ThreeBeams
│   ├── TrialB_EchoOfLight
│   ├── Level02PortalAdapter
│   └── SafetyRoot
│       ├── SafeAnchors/Aarrival, Center, TrialA, TrialB
│       └── SoftReturnVolume
├── EnvironmentStateRoot/Level02EnvironmentState
├── VFXRoot
│   ├── ArrivalVFX
│   ├── CentralLightVFX
│   ├── TrialAVFX
│   ├── TrialBVFX
│   ├── EnvironmentVFX
│   └── PortalVFX
├── PlayerRoot/Player                       # existing
├── CameraRoot/FollowCamera                 # existing controller
└── UILayer
    ├── ShardRewardOverlay                  # existing exact name
    └── PoemRewardUI                        # existing exact name
```

### Block wrapper rule

Each block contains `EnvironmentRoot`, optional primitive `CollisionRoot` and `Markers`. Blocks never contain trial/progression controllers, shard collection or progression `Area3D`. Future art replaces visual children without moving gameplay nodes.

### Trial A tree

```text
TrialA_ThreeBeams
├── TrialAController
├── TrialPresenceZone
├── Statue_01 / Statue_02 / Statue_03 (TrialA_BeamStatue)
├── CentralColumnGameplay
│   ├── Receiver_01
│   ├── Receiver_02
│   └── Receiver_03
├── ShardSpawnMarker
├── ShardSlot_A (Shard_03)
└── Preview_TrialA

TrialA_BeamStatue
├── RotationPivot/VisualAnchor
├── InteractionArea/CollisionShape3D
├── PromptAnchor
├── BeamOrigin
├── BeamTargets/Target_Left, Target_Center, Target_Right
└── WorldInteractionPrompt
```

### Trial B tree

```text
TrialB_EchoOfLight
├── TrialBController
├── TrialPresenceZone
├── Pads
│   ├── SymbolPad_Leaf (symbol_id=&"leaf")
│   ├── SymbolPad_Sun  (symbol_id=&"sun")
│   ├── SymbolPad_Wave (symbol_id=&"wave")
│   └── SymbolPad_Star (symbol_id=&"star")
├── CentralBudGameplay
│   ├── PetalPivot_01..04
│   └── ReplayInteractor
├── ShardSpawnMarker
├── ShardSlot_B (Shard_04)
├── SequenceTimer / ErrorTimer / StageTransitionTimer / HintPulseTimer
└── Preview_TrialB
```

## 11. Canonical IDs and exact text

```gdscript
const TRIAL_A_ID: StringName = &"trial_a"
const TRIAL_B_ID: StringName = &"trial_b"
const SHARD_A_ID: StringName = &"Shard_03"
const SHARD_B_ID: StringName = &"Shard_04"
const SECTOR_ARRIVAL: StringName = &"arrival"
const SECTOR_TRIAL_A: StringName = &"trial_a"
const SECTOR_TRIAL_B: StringName = &"trial_b"
const TRIAL_B_SEQUENCE: Array[StringName] = [&"leaf", &"sun", &"wave", &"star"]
```

Stored/displayed without decorative outer quotation marks:

- Shard_03: `В тебе есть свет, который не нужно делать громче`
- Shard_04: `Рядом с мыслью о тебе во мне больше жизни`
- Main: `Мне дорого, что в тебе есть свой свет - иногда яркий, иногда совсем тихий. Его не нужно делать громче или превращать во что-то другое. Мне нравится, что он твой. И рядом с мыслью о тебе во мне становится больше жизни`

## 12. Exact owner-relative NodePaths

Validate from each owner node:

| Owner property | Relative path |
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
| Environment.world_environment_path | `../WorldEnvironment_Level02` |
| Environment.lighting_root_path | `../Lighting` |
| Environment.environment_vfx_adapter_path | `../../../VFXRoot/EnvironmentVFX` |

No absolute `/root/...`, recursive critical lookup or child-index identity mapping.

## 13. Signals and APIs

### Upward event signals

| Signal | Emitter | Meaning |
|---|---|---|
| `arrival_activated()` | ArrivalController | Accepted once; opens route/start presentation. |
| `trial_completed(trial_id)` | Trial A/B controller | Trial fact only; no environment side effect. |
| `shard_available(shard_id)` | Level02ShardSlot only | Child shard is actually collectible. |
| `shard_collected(shard_id)` | Level02ShardSlot only | Shared short reward flow completed. |
| `center_presence_changed(bool)` | CentralArenaController | Presence fact only. |
| `final_visual_complete()` | CentralArenaController | Final placeholder reached stable state/fallback. |
| `color_ready()` / `fog_ready()` | Environment controller | Respective phase completed/fallback. |
| `closed` | PoemRewardUI | Main text closed; accept once. |
| `portal_activated()` | Level02PortalAdapter | Shared core active; transition still core-owned. |
| `orientation_changed(id,index)` / `statue_locked(id)` | BeamStatue | Local Trial A events. |
| `pad_activated(symbol_id)` | SymbolPad | Valid only while controller waits for input. |
| `replay_requested()` | ReplayInteractor | Manual replay, no failure increment. |

### ProgressController public API

- `register_trial_completed(trial_id: StringName) -> void`
- `register_shard_available(shard_id: StringName) -> void`
- `register_shard_collected(shard_id: StringName) -> void`
- `set_player_in_center(is_inside: bool) -> void`
- `notify_color_ready()`, `notify_fog_ready()`
- `notify_final_visual_complete()`
- `handle_main_text_closed()`
- `notify_portal_activated()`
- `get_collected_shard_count() -> int` derived from booleans
- read-only `is_trial_completed(id)`, `is_shard_collected(id)`

### Level02ShardSlot contract

- `prepare_hidden()` idempotently hides reveal root and SoulShard, disables monitoring, monitorable, collision, prompt and availability using deferred-safe operations.
- `reveal()` enables visibility/collection once and emits `shard_available(id)` only after collectible state is applied.
- `get_soul_shard() -> Node` supports explicit shared-controller registration.
- Child `collected` is re-emitted as canonical `shard_collected(id)` once.

### Central/environment/portal commands

- `activate_sector(sector_id)` uses explicit identity map for sector, connection channel and spiral.
- `set_unsolved_route_hint(id, enabled)` and `set_final_return_guidance(enabled)` are presentation-only.
- `begin_final_activation()` one-shot; leaving center never cancels.
- Environment: `apply_initial_state()`, `request_first_shard_transition()`, `request_second_shard_transition()`, `set_portal_ready_state()`.
- Portal: `begin_formation()` valid only from INACTIVE after main text close; one guarded completion path calls/delegates shared `activate()` once.

## 14. Macro level state model

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

Authoritative facts are orthogonal booleans:

- `arrival_activated`;
- `trial_a_completed`, `trial_b_completed`;
- `shard_a_available`, `shard_b_available`;
- `shard_a_collected`, `shard_b_collected`;
- `color_transition_started/complete`, `fog_transition_started/complete`;
- `player_in_center`, `final_return_pending`, `final_started`;
- `main_text_active`, `main_text_close_handled`;
- `portal_formation_started`, `portal_active`.

Final invariant:

```text
can_start_final =
  shard_a_collected
  and shard_b_collected
  and fog_transition_complete
  and player_in_center
  and not final_started
```

Valid flow:

`INIT → ARRIVAL_READY → ROUTES_OPEN → ONE_SHARD_COLLECTED → BOTH_SHARDS_COLLECTED → WAITING_FOR_CENTER_RETURN → FINAL_ACTIVATING → MAIN_TEXT_ACTIVE → PORTAL_FORMING → PORTAL_ACTIVE`.

Duplicate known events are ignored with at most one warning per ID; unknown canonical IDs error in debug and never mutate state.

## 15. Trial A state model — Three Beams

| Statue | World position | Initial index | Presses to correct |
|---|---|---:|---:|
| A1 | `Vector3(-50.23,0.40,29.00)` | 0 | 1 |
| A2 | `Vector3(-38.11,0.40,29.00)` | 2 | 2 |
| A3 | `Vector3(-44.17,0.40,18.50)` | 0 | 1 |

Fixed states: index 0 = -60° bypass left; index 1 = 0° inward correct; index 2 = +60° bypass right. Cycle `0→1→2→0` clockwise in player-facing presentation.

Rules:

- 0.40 s eased fixed rotation, 0.35 s accepted-interaction cooldown;
- input during rotation ignored, never queued;
- interaction distance 2.2 m using existing Player contract;
- reaching correct index locks statue permanently for current run;
- count derives from three per-statue locked booleans;
- 1/3 and 2/3 update only shell placeholder segments;
- 3/3 disables all statue interactions, runs reveal/fallback, calls `ShardSlot_A.reveal()` and emits `trial_completed(&"trial_a")` once;
- leaving/re-entering preserves exact orientations and locks;
- 35 s hint: receiver pulse; 55 s or six rotations: faint inward ghost line; 80 s: 0.7 s pause at correct state;
- no auto-solve, timer punishment, reset or free-angle optics.

## 16. Trial B state model — Echo of Light

Fixed sequence: Leaf → Sun → Wave → Star. Pad identity is a dictionary keyed by exported `symbol_id`; child order and world order are non-authoritative.

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

Stages:

1. Leaf → petal 1 permanent.
2. Leaf, Sun → petal 2 permanent.
3. Leaf, Sun, Wave → petal 3; shard glow readable.
4. Leaf, Sun, Wave, Star → petal 4; full reveal.

Timing: 0.75 s normal glow, 0.40 s gap, 1.20/0.60 assisted, 1.0 s intro, 0.8 s error settle, 1.2 s stage success, 0.6 s next-stage delay, 2.4 s final reveal, 2.0 s hint pulse.

Rules:

- Pads disabled during `SHOWING_SEQUENCE`; enter events ignored and never queued.
- Input accepted only in `WAITING_FOR_INPUT` from an armed pad.
- Activated/occupied pad remains unarmed until body exit or >1.35 m from PadCenter.
- Wrong symbol resets only `current_input_index=0` for current stage.
- Completed petals/stages never close.
- Second current-stage failure uses slower replay; third+ adds subtle next-pad pulse.
- Manual replay within 2.5 m clears partial input, replays stage and does not increment fail count.
- Leaving clears partial current input, preserves completed stages/current stage and replays on re-entry.
- Async display uses generation token/state guards after every await/timer boundary.
- Final reveal/fallback calls `ShardSlot_B.reveal()` and emits `trial_completed(&"trial_b")` once.

## 17. Environment model

| Phase | Saturation | Fog ratio | Duration |
|---|---:|---:|---:|
| INITIAL | 0.20 | 1.00 baseline | immediate |
| FIRST_SHARD_TRANSITION | 0.20→1.00 | 1.00→0.92 | 9.0 s |
| COLOR_READY | 1.00 | 0.92 | stable |
| SECOND_SHARD_TRANSITION | current→1.00 if needed | 0.92→0.55 | 7.0 s |
| FOG_READY | 1.00 | 0.55 | stable |
| PORTAL_READY | 1.00 | 0.55/calibrated | stable |

Implementation:

- one scene-local/deep-duplicated Environment assigned before mutation;
- validate `adjustment_enabled` and `fog_enabled`;
- independent `_color_tween`, `_fog_tween`, optional `_light_tween`;
- second phase may replace only fog tween, never cancel color restoration;
- missing optional EnvironmentVFX does not prevent ready signals/fallback;
- sector/channel stays active as spatial memory;
- no Player/camera lock.

## 18. UI and portal model

Short reward flow:

`Trial reveal → ShardSlot.reveal → Player E → SoulShard.reward_sequence_requested → existing shared controller/overlay → SoulShard.complete_collection_sequence → SoulShard.collected → ShardSlot.shard_collected(id) → Progress environment phase`.

Main text:

- only after both short reward flows are complete, fog ready, center gate and final visual completion;
- verify ShardRewardOverlay is not active;
- call `PoemRewardUI.show_placeholder_reward(main_text)` once;
- disable Player only while main text is visible;
- accepted `closed` re-enables controls and starts portal formation once.

Portal:

- remains inactive throughout gameplay/main text;
- capability-based formation as Section 4.4;
- core target exactly `res://scenes/levels/Level_03.tscn`;
- adapter never scene-loads;
- duplicate completion/fallback/close events produce one activation;
- early-overlap is P0.

## 19. Traversal and no-softlock baseline

- Four explicit `SafeAnchor`s; nearest chosen by horizontal distance, not name.
- `SoftReturnVolume` covers complete envelope below Y=-6 and filters only configured Player.
- Recovery zeroes velocity, teleports to anchor, preserves all puzzle/progression facts and has a re-entry cooldown.
- No death, health, scene reload, punishment or puzzle reset.
- Boundary blockers sit inside visible rims and preserve all ≥6 m route openings.
- Optional VFX failure cannot prevent shard reveal, environment ready, text or portal.
- MVP scene reload is a clean deterministic reset; partial contradictory restoration is forbidden.

# Slice 0 — Full Preflight

## Goal

Establish exact current repository/API/PR baseline and produce an implementation plan with zero changes.

## Preconditions

Four source documents available; GitHub access available; no implementation branch created from an unverified base.

## Expected files to change

None.

## Forbidden

All files. In particular: `project.godot`, all Level_01/active PR branches, shared Player/Camera/SoulShard/reward UI/LevelPortal, `level_manager.gd`, Level_03, Level_07–15, raw GLB/import/art and autoload/save/framework files.

## Inspection

- applicable AGENTS;
- current `Level_02.tscn`;
- Player, camera, SoulShard, ShardRewardSequenceController, ShardRewardOverlay, PoemRewardUI, LevelPortal, LevelManager;
- project settings, DevLevelMenu and existence/path of Level_03;
- PR #47 factual status and active PRs, especially PR #83;
- Level_01 only for read-only wrapper/controller conventions;
- exact proposed files and shared files to remain untouched.

## Steps

1. Record current branch, base SHA, head SHA and clean working tree.
2. Reconcile active PRs/shared API drift.
3. Confirm approved base and exact portal capability.
4. Produce dependency graph, file ownership, implementation order, tests and stop conditions.
5. Wait for explicit `APPLY`.

## Acceptance/checks

- Zero diff and no pushed runtime branch.
- Exact APIs and expected files documented; no unknown silently guessed.
- Portal mode and reward registration strategy resolved.
- Full plan, risks and `WAITING FOR APPLY` status delivered.

## Rollback

No rollback; accidental changes must be restored and zero-diff proof rerun.

## Risks

Stale source snapshot, active PR conflict, missing Level_03, unclean branch. Any is a stop condition until resolved.

## Handoff

Branch/base/head SHAs, active PR map, `git diff --name-only`, inspected contracts, exact file plan, tests, blockers, `APPLY/WAIT/REBASE/STOP` recommendation.

# Slice 1 — Level_02 Scene Shell and Spatial Greybox

## Goal

Replace obsolete placeholder with walkable primitive 1+3 layout, exact paths/boundaries, Player/Camera, safe fall recovery and passive portal socket. No puzzles.

## Preconditions

Slice 0 approved; runtime branch created from approved clean base; shared Player/Camera contracts confirmed.

## Expected files

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

## Forbidden

All shared files, project settings, Level_01/03/07–15, art imports. No puzzles, shards, environment controller or functional portal.

## Implementation

- Build exact discs, routes and ≥6 m boundary openings from primitive meshes/collision.
- Place floor-reference spawn then derive collision-safe Player transform.
- Instance existing Player and camera, validate target path/collision.
- Add four anchors and recovery volume.
- Add passive center socket placeholder only.
- No catch floor, mandatory jump or route obstruction.

## Methods/signals

`recover_player(body)` filters Player, chooses nearest horizontal anchor, zeroes velocity and teleports; optional debug `recovered(anchor_id)` has no progression effect.

## Acceptance/checks

- Level opens without missing resources/parser errors.
- Player safely spawns and can walk Arrival→Center→A→Center→B→Center.
- Clear width ≥5 m, slope ≤8°, openings ≥6 m.
- Camera does not trap/clip persistently.
- Falling from each platform/route recovers within ~1 s and preserves scene.
- Static checks: no raw GLB, no LevelManager, no Level_01 references, no out-of-scope files; `git diff --check`.

## Rollback/risks

Revert Slice 1 commit. Risks: copied spawn Y, closed route gap, accidental catch floor, camera collision; correct in geometry owner only.

## Handoff/out of scope

Provide SHAs, files, static/manual evidence, coordinates and known risks. Puzzles, UI, shards, environment and portal activation remain excluded.

# Slice 2 — Arrival and Central Arena Progress Structure

## Goal

Add non-puzzle start activation, explicit arrival/trial sector identities, placeholder channels/spirals and order-independent progress-controller shell.

## Expected files

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

## Forbidden

Shared/project/Level_01/03 files; no Trial A/B logic, shards, environment transition or functional portal.

## Implementation/API

- Validate every exported NodePath at startup.
- Configure one shared reward controller with explicit overlay/player paths and empty scan scope for later registration.
- Arrival accepts first meaningful movement/camera activity or a 4 s idle fallback, once.
- Activate arrival sector/channel and leave both trial routes equally idle/readable.
- Build explicit dictionary/records for arrival/trial_a/trial_b sector, channel and spiral NodePaths.
- Center zone emits presence only; no final logic yet.
- Optional debug snapshot/state display defaults off.

## Acceptance/checks

Arrival one-shot and fallback each work; controls remain enabled; child reorder does not break identity; no recursive critical lookup; no shard/puzzle/portal behavior. Harness confirms duplicate arrival produces one side effect. Revert Slice 2 to retain complete Slice 1 walkability.

# Slice 3 — Trial A: Three Beams

## Goal

Complete standalone deterministic Trial A with three statues, fixed orientations, permanent locks, reveal-safe Shard_03 and leave/re-enter preservation.

## Expected files

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

## Forbidden

Shared files, Trial B, environment, final center/portal, final beams/particles/materials/audio.

## Implementation

- Build exact three statue instances and targets with primitive visuals.
- Apply initial indices A1=0, A2=2, A3=0, correct=1.
- Implement clockwise fixed rotation, anti-spam and generation/stale callback guard.
- Lock correct statue permanently and derive 0/3–3/3 from explicit booleans.
- At 3/3 disable interactions, run placeholder shell reveal with fallback, then reveal local ShardSlot A.
- Set canonical `Shard_03`, exact phrase, hidden contract and explicit shared-controller registration.
- Progress records trial/availability/collection facts but environment remains unchanged.
- Implement 35/55/80 s non-solving assistance.

## Acceptance/checks

Exactly three states/statues; correct locks; leave/re-enter persists; no hidden collection; duplicate signals ignored; one `trial_completed` then one availability and one collection; missing VFX callback falls back; shared reward text is exact. Parser/resource checks, state harness, changed-file whitelist and manual E/spam/re-entry tests pass.

## Rollback/risks

Revert Slice 3; Slice 2 remains functional. Risks: yaw sign, stale tween callback, early shard enable, trial completion driving environment. Mitigate with visual cycle check, generation guard, full hidden fact disable and zero transition-counter assertion.

# Slice 4 — Trial B: Echo of Light

## Goal

Complete standalone fixed cumulative Trial B with four typed pads, persistent petals, stage-only reset, replay, assistance, leave/re-enter safety and Shard_04.

## Expected files

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

Reuse the generic Level02ShardSlot from Slice 3; do not modify Trial A unless a proven generic adapter defect is fixed with Trial A regression evidence.

## Implementation

- Build four pads with exact IDs/positions and a dedicated direct-child registry root.
- Validate `pads_by_id` has exactly leaf/sun/wave/star and no duplicate/empty IDs.
- Implement fixed sequence and FSM; guard every async boundary with state/generation token.
- Disable/discard pad events during display.
- On WAITING start, occupied pads begin unarmed and require step-off.
- Correct input advances; wrong input resets only current stage index.
- Stage success opens exactly one persistent petal/ring sector.
- Second same-stage failure slows replay; third+ subtly pulses next pad.
- Manual replay only while WAITING, no fail increment.
- Leave/re-enter preserves stages, clears partial input and replays current stage.
- Final reveal/fallback reveals ShardSlot B with canonical `Shard_04` and exact text.

## Acceptance/checks

Correct 1/2/3/4 run; wrong input preserves earlier petals; pad input never queues during display; occupied pad cannot auto-repeat; replay/fail assistance correct; reorder/move pads preserving IDs does not change sequence; leave/re-enter and missing-VFX paths do not softlock. Parser/FSM/registry/debounce/generation/duplicate harnesses and manual tests pass.

# Slice 5 — Two-Shard and Environment Progression

## Goal

Integrate unique collection events into matching sectors and two non-blocking, race-safe environment phases, supporting A→B and B→A identically.

## Expected files

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

## Forbidden

Shared/project/Level_01/03 files; no puzzle redesign, main text, portal formation or final art.

## Implementation

- Connect both ShardSlot collection signals explicitly.
- Map Shard_03→trial_a sector/channel and Shard_04→trial_b.
- First unique collection sets per-ID boolean, derives count, activates matching spatial memory and starts first phase once.
- Second unique collection starts second phase once and enables return guidance.
- Deep-duplicate/reassign Environment, validate adjustment/fog and capture baseline.
- Own independent color/fog/light tweens; second phase never kills color.
- Guarantee saturation target 1.0 if second collection arrives before first phase ends.
- Controls/camera/puzzles remain enabled throughout.
- Optional environment VFX failure uses local fallback.

## Acceptance/checks

A→B, B→A and “solve both then collect B→A” produce identical final flags/count/environment and correct sectors. Environment does not react to trial completion or availability. Duplicate/unknown IDs have no repeated side effect. Race test reaches saturation 1.0 and fog 0.55. Resource is unique/local. No `set_controls_enabled(false)` exists in environment scripts. Final center event remains disabled.

# Slice 6 — Central Return, Main Text and Portal

## Goal

Complete chapter after both collections: guidance, strict center gate, non-canceling final placeholder, exact main text and safe delayed portal activation to Level_03.

## Expected files

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

## Forbidden

Shared LevelPortal modifications unless a separately approved blocker task; no Level_03 content, shared UI replacement, final art/audio/cinematic or long camera takeover.

## Implementation

- After both shards, set return pending and persistent central guidance.
- Combine fog ready and center presence strictly through invariant; never start remotely/early.
- If Player is inside when fog finishes, start once; if Player left, wait for next entry.
- Latch final; leaving center does not cancel.
- Run primitive timing: 0–1.2 s sector sync; 1.2–4.2 s staggered spirals; 4.2–5.5 s thin beam; stable/fallback by ~6 s.
- Before main text, ensure short reward overlay is not active.
- Disable Player only while exact main text is visible.
- Accept close once; restore controls and begin capability-based portal formation.
- Set target exactly Level_03; adapter does not scene-load.
- Run early-overlap and duplicate activation tests.

## Acceptance/checks

No final before both shards and fog ready. Center-early/leave/re-enter cases behave correctly. Main text exact and once. Portal never activates during text/formation, begins only after close and activates once. Early overlap produces one transition or documented hard blocker. Rapid entry produces one load. Static scan proves adapter has no `change_scene_to_file`; target path exact; changed-file whitelist clean.

# Slice 7 — Stabilization and Acceptance

## Goal

Harden the complete greybox, remove duplicate/stale paths, execute full test and softlock matrices, clean introduced warnings/logging, verify duration and create factual summary.

## Expected files

```text
scenes/levels/Level_02.tscn
scenes/levels/level_02/**/*.tscn
scripts/levels/level_02/*.gd
docs/development/Level_02_Greybox_Implementation_Summary.md
```

Only corrective edits in owners of failing behavior. No new gameplay architecture unless required by an accepted blocker.

## Implementation

- Review changed-file list against master whitelist.
- Parse/resource-load every new scene/script.
- Exercise duplicate trial/shard/environment/UI/portal paths.
- Run both orders and compare final snapshots.
- Run all leave/re-enter, missing-VFX, fall-recovery and reload cases.
- Review route collision, camera clearance, interaction volumes and portal volume.
- Measure first completion target 6–8 min, maximum with mistakes ≤10 min, repeat 4–6 min.
- Resolve only introduced warnings/errors; separate pre-existing baseline warnings.
- Remove temporary debug UI, set verbose flags false, prohibit per-frame spam.
- Create final summary with SHAs, files, tests, manual evidence and limitations.

## Acceptance/checks

All P0 rows pass; A→B/B→A final state parity; no invalid NodePath/parser/null errors; no duplicate side effects; no control lock during environment transitions; portal only after text and one Level_03 transition; no forbidden/shared/Level_01 files in diff; factual summary exists. Any required manual item marked `NOT VERIFIED` blocks final acceptance.

## Rollback/risks

Use separate corrective commits where practical. If a fix expands scope or requires shared modification, stop and split a separately approved prerequisite. If branch becomes entangled, revert last corrective commit rather than rewrite accepted slices.

## Per-slice handoff requirements

Every Slice 1–7 handoff must include branch, base SHA, slice-start SHA, final head/commit SHA, PR link, exact `git diff --name-only`, implemented behavior, untouched files, static/headless outputs, manual PASS/FAIL/NOT VERIFIED, risks, fallback paths, producer recommendation and confirmation that no shared/Level_01 files changed.

## 20. Master file ownership matrix

| Area | Policy |
|---|---|
| `scenes/levels/Level_02.tscn` | Only existing runtime file expected to be replaced/modified. |
| `scenes/levels/level_02/**` | New Level_02-local scene files only. |
| `scripts/levels/level_02/**` | New Level_02-local GDScript only. |
| implementation summary | Created in Slice 7. |
| shared Player/Camera/SoulShard/UI/Portal | Read/reuse only; any write is hard stop/separate task. |
| `project.godot` | No change without approved blocker. |
| Level_01/active PR | Never touched. |
| Level_03 | Target only; never modified. |
| raw art/imports | Not part of greybox. |

## 21. Acceptance test matrix

| ID | Test | Expected | Priority |
|---|---|---|---|
| T01 | Load Level_02 | Readable initial state; hidden shards/portal; no new errors | P0 |
| T02 | Move/look immediately | Arrival one-shot; controls active | P1 |
| T03 | Idle 4 s | Arrival one-shot fallback | P1 |
| T04 | Complete/collect A then B | Color then fog; final waits center | P0 |
| T05 | Complete/collect B then A | Same final state as T04 | P0 |
| T06 | Solve both, collect B then A | No environment before collection; same final | P0 |
| T07 | Duplicate same shard | Count and all side effects unchanged | P0 |
| T08 | Cycle Trial A 0→1→2→0 | Fixed 0.40 s; no queued spam | P1 |
| T09 | Reach Trial A correct index | Locks, prompt disabled, receiver stable | P0 |
| T10 | Lock 2/3, leave/return | Exact indices and locks persist | P0 |
| T11 | Wait/rotate without progress | 35/55/80 hints; no auto-solve | P2 |
| T12 | Stand at A shard before reveal | Cannot collect | P0 |
| T13 | Complete Trial B stages 1–4 | One permanent petal per stage; reveal once | P0 |
| T14 | Wrong symbol in stage 3 | Only current input resets; earlier petals persist | P0 |
| T15 | Fail same B stage 3+ times | Slow after second; next-pad hint after third | P1 |
| T16 | Manual replay while waiting | Input clears/replays; fail count unchanged | P1 |
| T17 | Stand/step on pad during display | No queued input | P0 |
| T18 | Remain on pad across state | No activation until step-off/re-enter | P0 |
| T19 | B stage 2 + partial stage 3, leave/return | Stage 2 persists; partial clears; stage 3 replays | P0 |
| T20 | Move during first transition | No controls/camera/puzzle lock | P0 |
| T21 | Move during second transition | No lock; guidance active | P0 |
| T22 | Enter center before fog ready | No early final; starts only when valid | P0 |
| T23 | Enter then leave before fog ready | Waits for next valid entry | P0 |
| T24 | Exit after final starts | Sequence continues; text once | P1 |
| T25 | Inspect/close main text | Exact text; lock only while visible | P0 |
| T26 | Emit close twice | One formation | P0 |
| T27 | Enter visual before portal complete | No transition | P0 |
| T28 | Stand inside future portal until activation | Exactly one transition or hard blocker documented | P0 |
| T29 | Rapid portal enter/exit | One load request | P0 |
| T30 | Disable each optional VFX adapter | Fallback; no softlock | P0 |
| T31 | Fall below every route/platform | Nearest-anchor recovery; state preserved | P0 |
| T32 | Reload during partial progress | Clean deterministic reset | P1 |
| T33 | Open shard overlay and PoemRewardUI | Mouse/camera behavior matches current shared API | P1 |
| T34 | Enter active portal | Loads exact Level_03 path | P0 |
| T35 | Parser/runtime checks | No new parser/NodePath errors | P0 |
| T36 | Inspect canonical IDs | A=`Shard_03`, B=`Shard_04`; no deprecated IDs | P0 |
| T37 | Reorder sector/channel/spiral children | Explicit mapping still correct | P0 |
| T38 | Reorder/move pads preserving IDs | Sequence unchanged | P0 |
| T39 | Interact at hidden shard before reveal | No hidden collection; all collection facts disabled | P0 |
| T40 | Collect second shard before first color phase ends | Fog independent; saturation reaches 1.0 | P0 |
| T41 | Invalid/shared Environment in test copy | Clear blocker; production resource local/enabled | P0 |
| T42 | Validate exact NodePaths from owner nodes | All resolve; no absolute/global lookup | P0 |

## 22. Softlock matrix

| Risk | Prevention | Fallback |
|---|---|---|
| Leave Trial A halfway | Persist local indices/locks | Resume exact state |
| Leave Trial B halfway | Persist completed stages; clear partial | Replay current stage |
| Pad during replay/display | Disable/discard events | Occupied pad unarmed |
| Remain on pad | Armed latch + step-off distance | No auto-repeat |
| Collect shard early | Slot disables all collection facts | Reveal timeout only |
| Duplicate trial/shard | Per-ID booleans | Ignore/warn once |
| Second shard during color tween | Independent tween owners | Saturation still reaches target |
| Center before fog ready | Store presence, strict gate | Start only when valid |
| Leave center before fog ready | Presence false | Wait next entry |
| Leave after final starts | Final one-shot latch | Continue sequence |
| Main text close twice | Close latch | One formation |
| Formation callback/fallback race | Single guarded handler | One activation |
| Portal early overlap | Mandatory shared-core test | Separate approved prerequisite |
| Missing optional VFX | Controller fallback timers | Core progression continues |
| Fall | Explicit anchors + SoftReturn | Zero velocity, preserve facts |
| Reload partial state | MVP clean reset | No half-state restore |
| Unknown ID | Validation/safe ignore | No mutation |
| Missing NodePath | Startup validation | Fail closed, clear error |
| Reward overlay unavailable | Existing safe-completion contract | Complete safely or document blocker |
| Controls remain locked | Shared reset + main-text guarded exit | Restore in all safe exits |

## 23. Producer approval gates

| Gate | After | Evidence | Decision |
|---|---:|---|---|
| G0 Preflight | 0 | base SHA, PR map, APIs, file plan, zero diff | APPLY / WAIT / REBASE / STOP |
| G1 Spatial | 1 | walkability, coordinates, routes, boundaries, recovery | ACCEPT / CORRECT |
| G2 Progress shell | 2 | arrival one-shot, explicit identity, no scan/puzzles | ACCEPT / CORRECT |
| G3A Trial A | 3 | Trial A matrix, hidden shard, persistence, exact text | ACCEPT / CORRECT |
| G3B Trial B | 4 | FSM, identity, replay/assistance, hidden shard | ACCEPT / CORRECT |
| G4 Integration | 5 | A→B/B→A, race, non-blocking controls | ACCEPT / CORRECT |
| G5 Chapter completion | 6 | center gate, text, portal order/overlap/Level_03 | ACCEPT / BLOCK PREREQUISITE |
| G6 Final acceptance | 7 | full P0 matrix, duration, clean diff, summary | READY TO MERGE / CORRECT / REJECT |

## 24. Definition of Done

- Complete playable primitive-only Level_02 greybox.
- Exact 1+3 layout and coordinates within ±0.25 m; route width/slope/opening locks pass.
- Existing Player/camera/shared reward systems reused without shared modifications.
- Arrival, explicit central identities, Trial A, Trial B, two shards, two exact short texts, environment phases, strict center event, exact main text and Level_03 portal all function.
- Trial completion, availability and collection remain distinct.
- A→B and B→A yield identical final authoritative state.
- Environment is idempotent, non-blocking, race-safe and finishes saturation at 1.0.
- Portal activates only after main-text close and core owns one scene transition.
- Fall, leave/re-enter, duplicates, missing optional VFX and reload never softlock.
- All P0 tests pass; manual NOT VERIFIED items are explicit and block acceptance when required.
- No `project.godot`, Level_01, shared, Level_03, Level_07–15, raw art, save or GameState changes.
- No new parser/resource/NodePath errors, no per-frame log spam, verbose debug false.
- Factual implementation summary exists.

## 25. Branch, commits and PR

| Item | Recommendation |
|---|---|
| Documentation branch | `docs/level-02-greybox-development-reference` |
| Documentation PR | `Document Level 02 greybox implementation reference` |
| Runtime branch | `feature/level-02-living-light-greybox` |
| Runtime PR | `Build Level 02 Living Light greybox` |
| Runtime base | Current main after active Level_01 PR decision unless producer approves another integration base |

Recommended slice commits:

```text
level02: build spatial greybox shell
level02: add arrival and central progress shell
level02: implement Three Beams trial
level02: implement Echo of Light trial
level02: integrate two-shard environment progression
level02: complete center text and portal flow
level02: stabilize greybox and add implementation summary
```

A required shared prerequisite must be a separate minimal PR, never mixed into Level_02 runtime work.

## 26. Final Codex implementation prompt requirements

The implementation prompt must:

- state the repository, approved base and senior Godot role;
- require all applicable AGENTS plus this reference;
- run Slice 0 with no changes and wait for `APPLY`;
- record exact branch/base/head SHAs and active PR conflicts;
- treat this document as implementation authority;
- execute Slice 1→7 sequentially, one slice at a time;
- enforce every slice’s allowed/forbidden files and producer gate;
- use explicit NodePaths/typed references, upward signals and downward commands;
- preserve canonical IDs, exact texts, either-order behavior and callback+fallback VFX;
- run A→B/B→A, duplicate, environment-race, fall, missing-VFX and early-overlap tests;
- stop before any shared, project, Level_01 or Level_03 write;
- commit and provide factual handoff after every slice;
- create final implementation summary in Slice 7;
- open/update only the dedicated Level_02 runtime PR.

Hard stops: unadaptable shared API drift, unrelated/Level_01 changes in branch, required project/autoload/save change, absent/renamed Level_03 target, progression attached to imported nodes, any P0 softlock failure, failed early-overlap without approved prerequisite, or missing producer approval.

## 27. Slice handoff template

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
- Runtime gameplay implemented: YES / NO
- Recommendation: PROCEED / CORRECT / STOP
```

## 28. Final implementation summary requirements

Include reference version/base SHA, branch/PR/ordered slice SHAs, full changed-file list, implemented node trees/APIs, canonical IDs/texts, A→B/B→A evidence, trial acceptance, environment race/non-blocking evidence, portal capability and early-overlap result, fall/reload/missing-VFX/duplicate results, measured duration, introduced vs pre-existing warnings, manual NOT VERIFIED items, known limitations/post-greybox work and confirmation of no final art/audio/save/GameState/Level_03/Level_01 changes.

## 29. Post-greybox boundary

Only after greybox approval may final art production begin under a separate reference/PR. Art wrappers replace visual children without moving gameplay-owned pivots, markers, collision zones or state controllers. The greybox PR must not add Blender assets, raw GLBs, final materials, particles, sound or production dressing.

## 30. Final verdict

> **APPROVED IMPLEMENTATION PLAN:** Level-local explicit-reference architecture with two independent either-order trials, two canonical shards, non-blocking environment progression, strict center-return gating, safe shared-system reuse and mandatory fallback/no-softlock coverage. The reference task itself introduces no runtime code.