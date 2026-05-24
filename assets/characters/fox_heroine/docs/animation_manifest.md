# Fox Heroine Animation Manifest

## Source
- Source GLB (identified): `assets/models/Character/Base Animations/Character_Base_Animations.glb`
- Imported AnimationPlayer: **not found in repository snapshot** (no imported `.godot` scene artifacts available in this environment at inspection time).

## Mapping Table

| Raw imported animation name | Working action name | Status | Notes |
|---|---|---|---|
| `Bass_Beats` | `turn_right` | mapped | Preserve raw Meshy name exactly. |
| `Crouch_and_Push_Forward` | `run` | mapped | Preserve raw Meshy name exactly. |
| `Fast_Stair_Climb` | `walk` | mapped | Preserve raw Meshy name exactly. |
| `Female_Walk_Pick_Put_In_Pocket` | `cast_1` | mapped | Preserve raw Meshy name exactly. |
| `Idle_11` | `climb` | mapped | Preserve raw Meshy name exactly. |
| `Push_Forward_and_Stop` | `fast_run` | mapped | Preserve raw Meshy name exactly. |
| `Regular_Jump` | `push` | mapped | Preserve raw Meshy name exactly. |
| `RunFast` | `move_back` | mapped | Preserve raw Meshy name exactly. |
| `Run_Turn_Left` | `cast_2` | mapped | Preserve raw Meshy name exactly. |
| `Run_Turn_Right` | `cast_3` | mapped | Preserve raw Meshy name exactly. |
| `Running` | `push_and_stop` | mapped | Preserve raw Meshy name exactly. |
| `Step_Forward_and_Push` | `dance_test` | mapped | Preserve raw Meshy name exactly. |
| `Walk_Backward` | `stand_up` | mapped | Preserve raw Meshy name exactly. |
| `Walking` | `idle_and_pick_up` | mapped | Preserve raw Meshy name exactly. |
| `mage_soell_cast` | `turn_left` | mapped | Preserve raw Meshy name exactly (including spelling). |
| `mage_soell_cast_3` | `idle` | mapped | Preserve raw Meshy name exactly (including spelling). |
| `mage_soell_cast_7` | `jump` | mapped | Preserve raw Meshy name exactly (including spelling). |

## Warning
Raw Meshy animation names are import-source identifiers and should **not** be used directly in gameplay code. Gameplay-facing systems should use clean working action names and resolve to raw source names through a dedicated mapping layer.
