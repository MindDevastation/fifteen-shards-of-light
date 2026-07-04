# Level_03 Greybox Implementation Summary

## PR #111 Remaining T-Runtime Continuation

- Branch: `work`.
- Current PR: `#111`.
- Starting HEAD for this continuation: `edefbbe` (`Enforce portal activation_duration (1.8s) and update Level_03 greybox summary/evidence (PR #111 continuation)`).
- Final HEAD at summary edit time: `PENDING_COMMIT`.
- Worktree preflight: clean before this continuation.
- Current summary status at preflight: `docs/development/Level_03_Greybox_Implementation_Summary.md` clean in git.
- Existing source fix verified present: `activation_duration = 1.8` is serialized on the production `PortalCore`, and `portal.activation_duration = 1.8` is enforced by the Level_03 portal adapter before shared activation.
- New source fixes in this continuation: `None`.
- Temporary harness location: `/tmp/level03_group6` outside the repository.

## Import and Load Health

- Full import regeneration command: `timeout 600s godot --headless --editor --quit --path .`.
- Import regeneration result: `exit 0`.
- Level_03 check-only command: `godot --headless --path . --quit --check-only scenes/levels/Level_03.tscn`.
- Level_03 check-only result: `exit 0`.
- Project startup command: `godot --headless --path . --quit`.
- Project startup result: `exit 0`.
- Error counts across import/check/startup logs: `ERROR:=0`, `SCRIPT ERROR:=0`, parse errors `0`, failed resource loads `0`, failed script loads `0`.

## Authoritative Group 6 Counts

- ST-01–ST-19: `19 PASS`, `0 FAIL`, `0 NOT_VERIFIED`.
- T01–T52: `27 PASS`, `15 FAIL`, `10 NOT_VERIFIED`.
- Newly passed T rows in this continuation: `T10, T13, T18, T19, T32, T36, T37, T41, T42, T43, T44, T46, T47, T50`.
- Failed T rows in this continuation: `T04, T05, T06, T07, T08, T11, T20, T23, T25, T26, T27, T29, T34, T39, T40`.
- Remaining NOT_VERIFIED T rows: `T03, T16, T17, T22, T24, T30, T31, T33, T48, T49`.
- Group 6 factual P0: `NOT COMPLETE` because factual runtime failures remain and some production overlap/route/portal-transition rows remain NOT_VERIFIED.

## T01–T52 Evidence Rows

| Row |
|---|
| `T01 | PASS | expected=production Level_03 startup prepares and commits E0/Wind active | actual=macro=WIND_TRACE_ACTIVE wind_armed=true env=E0 | evidence=logs/runtime_group6.json:T01` |
| `T02 | PASS | expected=5 fresh production loads expose a Player spawn | actual=loads=5 spawn_positions=["(-6.0, 0.641833, -49.45532)", "(-6.0, 0.633668, -49.05901)", "(-6.0, 0.633667, -49.00764)", "(-6.0, 0.641833, -49.0)", "(-6.0, 0.641833, -49.0)"] | evidence=logs/runtime_group6.json:T02` |
| `T03 | NOT_VERIFIED | expected=actual Player route P00-P16 using production input | actual=production input moved player 6.64m from spawn but harness did not complete P00-P16 route; grounded=true collisions=0 | evidence=logs/remaining_runtime.json:T03_partial_input` |
| `T04 | FAIL | expected=CP0-CP4 readable by headless camera-to-marker ray geometry | actual=camera=(-6.0, 1.734631, -45.26866) results=["CP0 dist=1.79 obstructed=false", "CP1 dist=10.72 obstructed=false", "CP2 dist=44.23 obstructed=false", "CP3 dist=73.79 obstructed=true", "CP4 dist=93.06 obstructed=false"] | evidence=logs/remaining_runtime.json:T04_raycast` |
| `T05 | FAIL | expected=RA0-RA6 recovery trigger teleports once to anchor, zeroes velocity, preserves state | actual=["RA0 started=true dxz=0.000 y=0.209 v=0.000 phase=E0", "RA1 started=true dxz=0.000 y=1.110 v=0.000 phase=E0", "RA2 started=true dxz=0.000 y=1.109 v=0.000 phase=E0", "RA3 started=true dxz=0.000 y=0.899 v=3.757 phase=E0", "RA4 started=true dxz=0.000 y=1.510 v=0.000 phase=E0", "RA5 started=true dxz=0.000 y=1.509 v=0.000 phase=E0", "RA6 started=true dxz=0.000 y=1.809 v=0.000 phase=E0"] | evidence=logs/remaining_runtime.json:T05_recovery` |
| `T06 | FAIL | expected=invalid/ordinary contexts do not recover legally | actual=bad_explicit=false bad_anchor_volume=true current_anchor=RA6 | evidence=logs/remaining_runtime.json:T06_legality` |
| `T07 | FAIL | expected=recovery suspended while in volume and runs once after unlock if still overlapping | actual=request=false unchanged=false pending_after_lock=suspended recovered_to_RA2=false | evidence=logs/remaining_runtime.json:T07_suspend_remain` |
| `T08 | FAIL | expected=pending recovery clears when exiting before unlock | actual=request=false stayed=false pending= | evidence=logs/remaining_runtime.json:T08_suspend_exit` |
| `T09 | PASS | expected=Shard_05/06/07 hidden and unavailable before reveal | actual=["Slot_05 visible=false available=false valid_hidden=true", "Slot_06 visible=false available=false valid_hidden=true", "Slot_07 visible=false available=false valid_hidden=true"] | evidence=logs/runtime_group6.json:T09` |
| `T10 | PASS | expected=Shard_05 reveal becomes available once and duplicate reveal is rejected | actual=available=true duplicate_reveal_rejected=true generation=2 | evidence=logs/remaining_runtime.json:T10_shard05_reveal` |
| `T11 | FAIL | expected=Shard_05 reward serializes through shared controller and returns idle | actual=completed=[] macro=SHARD_05_AVAILABLE reward_state=0 overlay_visible=false | evidence=logs/remaining_runtime.json:T11_reward05` |
| `T12 | PASS | expected=movement/camera activity confirms Wind immediately | actual=activity_confirmed=true | evidence=logs/runtime_group6.json:T12` |
| `T13 | PASS | expected=Wind idle auto-confirms after 4s fallback | actual=activity=true index=0 | evidence=logs/remaining_runtime.json:T13_idle_fallback` |
| `T14 | PASS | expected=future Wind arch before expected does not advance completion | actual=index_before=0 index_after=0 completed_after_wrong=false | evidence=logs/runtime_group6.json:T14` |
| `T15 | PASS | expected=Arch_01->Arch_02->Arch_03 completes exactly once and duplicate Arch_01 ignored | actual=a=1 dup=1 b=2 completed=true count=0 | evidence=logs/runtime_group6.json:T15` |
| `T16 | NOT_VERIFIED | expected=Wind future-overlap remain advances on activation without re-entry | actual=Area3D overlap could not be produced deterministically without teleport/physics overlap fabrication | evidence=logs/remaining_runtime.json:T16_blocker` |
| `T17 | NOT_VERIFIED | expected=Wind future-overlap exit before activation gives zero advance | actual=Area3D future-overlap exit path not produced by production movement | evidence=logs/remaining_runtime.json:T17_blocker` |
| `T18 | PASS | expected=Wind leave/return preserves current arch index | actual=index_after_arch1=1 index_after_return_arch2=2 | evidence=logs/remaining_runtime.json:T18_persistence` |
| `T19 | PASS | expected=Wind VFX missing still reveals Shard_05 | actual=vfx_removed=true slot_available=true completed=true | evidence=logs/remaining_runtime.json:T19_missing_vfx` |
| `T20 | FAIL | expected=natural Shard_05 lifecycle reaches Spark arm through shared reward chain | actual=request_state=0 collected=false env=E0 spark_state=LOCKED | evidence=logs/remaining_runtime.json:T20_lifecycle` |
| `T21 | PASS | expected=Spark locked before Shard_05 completion | actual=state=LOCKED | evidence=logs/runtime_group6.json:T21` |
| `T22 | NOT_VERIFIED | expected=Spark wrong future perch while Spark is active after Shard_05 completion | actual=harness did not reach PLAYFUL_SPARK_ACTIVE through a verified natural reward chain, so wrong-perch result was not a valid T22 execution | evidence=logs/remaining_runtime.json:T22_prereq_blocker` |
| `T23 | FAIL | expected=Spark A->B hop/fallback advances once with first terminal wins | actual=completed_after_A=[] expected_after_wait=Perch_A | evidence=logs/remaining_runtime.json:T23_hop_race` |
| `T24 | NOT_VERIFIED | expected=Spark destination pre-overlap without exit/re-enter advances once after settle | actual=production overlap-at-destination not generated without teleport fabrication | evidence=logs/remaining_runtime.json:T24_blocker` |
| `T25 | FAIL | expected=Spark leave after A/B preserves current perch | actual=expected_after_B=Perch_A slot06_revealed=false | evidence=logs/remaining_runtime.json:T25_persistence` |
| `T26 | FAIL | expected=Spark disabled/missing VFX fallback preserves sequence to Shard_06 availability | actual=slot06_available=false spark_completed=false | evidence=logs/remaining_runtime.json:T26_fallback` |
| `T27 | FAIL | expected=natural Shard_06 reward lifecycle arms Meadow | actual=completed=[&"Shard_05"] macro=PLAYFUL_SPARK_ACTIVE meadow_state=LOCKED reward_state=0 | evidence=logs/remaining_runtime.json:T27_lifecycle` |
| `T28 | PASS | expected=Meadow locked before Shard_06 reward | actual=state=LOCKED | evidence=logs/runtime_group6.json:T28` |
| `T29 | FAIL | expected=all six Meadow petal permutations complete one reveal | actual=["[&\"Petal_W\", &\"Petal_SE\", &\"Petal_NE\"] visited=[&\"Petal_W\", &\"Petal_SE\", &\"Petal_NE\"] available=false", "[&\"Petal_W\", &\"Petal_NE\", &\"Petal_SE\"] visited=[&\"Petal_W\", &\"Petal_NE\", &\"Petal_SE\"] available=false", "[&\"Petal_SE\", &\"Petal_W\", &\"Petal_NE\"] visited=[&\"Petal_SE\", &\"Petal_W\", &\"Petal_NE\"] available=false", "[&\"Petal_SE\", &\"Petal_NE\", &\"Petal_W\"] visited=[&\"Petal_SE\", &\"Petal_NE\", &\"Petal_W\"] available=false", "[&\"Petal_NE\", &\"Petal_W\", &\"Petal_SE\"] visited=[&\"Petal_NE\", &\"Petal_W\", &\"Petal_SE\"] available=false", "[&\"Petal_NE\", &\"Petal_SE\", &\"Petal_W\"] visited=[&\"Petal_NE\", &\"Petal_SE\", &\"Petal_W\"] available=false"] | evidence=logs/remaining_runtime.json:T29_permutations` |
| `T30 | NOT_VERIFIED | expected=Meadow 0.30s/0.64s early exit prevents activation | actual=precise Area3D dwell timers not driven through production overlap; direct completion not used for PASS | evidence=logs/remaining_runtime.json:T30_blocker` |
| `T31 | NOT_VERIFIED | expected=Meadow airborne/jump dwell does not accumulate | actual=airborne production player overlap not driven through petal zones | evidence=logs/remaining_runtime.json:T31_blocker` |
| `T32 | PASS | expected=Meadow duplicate completed-zone callbacks do not recount | actual=before=0 after_duplicate=1 | evidence=logs/remaining_runtime.json:T32_duplicate` |
| `T33 | NOT_VERIFIED | expected=Meadow real/fallback simultaneous race accepts one segment/effect/id | actual=independent VFX race not reproducible without direct terminal calls as primary path | evidence=logs/remaining_runtime.json:T33_blocker` |
| `T34 | FAIL | expected=natural Shard_07 reward emits all_rewards_completed once and arms finale readiness | actual=completed=[&"Shard_05"] macro=PLAYFUL_SPARK_ACTIVE slot07_text=Рядом с тобой я и сам чаще смеюсь и ненадолго перестаю быть таким серьёзным. reward_state=0 | evidence=logs/remaining_runtime.json:T34_lifecycle` |
| `T35 | PASS | expected=E1->E2->E5 monotonic progression rejects stale lower phase | actual=phase=E5 generation=4 | evidence=logs/runtime_group6.json:T35` |
| `T36 | PASS | expected=movement/camera remain unlocked during environment phases | actual=controls_enabled=true env_phase=E4 | evidence=logs/remaining_runtime.json:T36_controls` |
| `T37 | PASS | expected=guidance lifecycle toggles without blocking logical flow | actual=guidance_on=true guidance_off=true active=false | evidence=logs/remaining_runtime.json:T37_guidance` |
| `T38 | PASS | expected=finale early arrival before rewards does not start text/portal | actual=state_before=0 state_after=0 | evidence=logs/runtime_group6.json:T38` |
| `T39 | FAIL | expected=remain inside final gate until rewards complete starts synthesis/main text once | actual=finale_state=0 overlay_opened=false | evidence=logs/remaining_runtime.json:T39_stored_presence` |
| `T40 | FAIL | expected=leaving after synthesis/main text start does not cancel finale | actual=state_after_exit=0 portal_requested=false | evidence=logs/remaining_runtime.json:T40_noncancel` |
| `T41 | PASS | expected=exact main text delivered to shared finale overlay | actual=chars=284 prefix=Сначала я просто заметил, что жд | evidence=logs/remaining_runtime.json:T41_text` |
| `T42 | PASS | expected=missing finale overlay API fails closed with portal inactive | actual=state=2 portal_requested=false controls_locked=false | evidence=logs/remaining_runtime.json:T42_failclosed` |
| `T43 | PASS | expected=duplicate/stale finale close requests portal only once | actual=portal_requested=true activation_requested=true | evidence=logs/remaining_runtime.json:T43_duplicate_close` |
| `T44 | PASS | expected=portal dormant before text and activates only after finale close | actual=activation_after_close=true active=false | evidence=logs/remaining_runtime.json:T44_dormant` |
| `T45 | PASS | expected=Portal exact config Level_04 AUTO_ENTER no confirmation 1.8s | actual=target=res://scenes/levels/Level_04.tscn entry=0 confirm=false duration=1.80 | evidence=logs/runtime_group6.json:T45` |
| `T46 | PASS | expected=local portal VFX absence/stall does not block shared activation request | actual=activation_requested=true | evidence=logs/remaining_runtime.json:T46_vfx` |
| `T47 | PASS | expected=duplicate shared portal completion emits/keeps one active state | actual=active_after_first=true active_after_second=true | evidence=logs/remaining_runtime.json:T47_duplicate_completion` |
| `T48 | NOT_VERIFIED | expected=stationary future portal overlap auto-enters Level_04 exactly once | actual=actual shared SceneTree transition not executed in headless harness to avoid changing scene during evidence collection | evidence=logs/remaining_runtime.json:T48_blocker` |
| `T49 | NOT_VERIFIED | expected=rapid enter/exit/enter around activation causes no early/duplicate transition | actual=actual shared portal InteractionArea overlap transition not driven | evidence=logs/remaining_runtime.json:T49_blocker` |
| `T50 | PASS | expected=shared LevelPortal target Level_04 PackedScene loads; no local success fallback | actual=target=res://scenes/levels/Level_04.tscn level04_load=true adapter_local_change_scene=false | evidence=logs/remaining_runtime.json:T50_level04_load` |
| `T51 | PASS | expected=unknown/future puzzle IDs do not mutate macro state | actual=macro=SHARD_05_AVAILABLE completed_shards=[] | evidence=logs/runtime_group6.json:T51` |
| `T52 | PASS | expected=fresh instances return clean initial macro/E0 state | actual=states=["WIND_TRACE_ACTIVE/E0", "WIND_TRACE_ACTIVE/E0", "WIND_TRACE_ACTIVE/E0"] | evidence=logs/runtime_group6.json:T52` |

## Runtime Evidence Notes

- Route: `T03` remains `NOT_VERIFIED`; production input moved the Player 6.64 m in headless physics, but the harness did not complete P00–P16 without teleporting.
- Readability: `T04` now has headless camera-to-marker ray evidence and failed because CP3 was obstructed in that geometry query.
- Recovery: `T05` through `T08` failed in the production recovery-controller matrix; evidence includes anchor offsets, velocity reset checks, invalid-anchor behavior, and suspended-overlap behavior.
- Early reward and Wind: `T10`, `T13`, `T18`, and `T19` newly passed; `T11` and `T20` failed because the attempted actual Player/shared reward chain did not complete Shard_05 collection/progress.
- Spark and Meadow: Spark/Meadow lifecycle rows dependent on verified Shard_05/Shards_06 shared rewards did not complete; `T32` duplicate Meadow completion handling passed, while `T23`, `T25`, `T26`, `T27`, `T29`, and `T34` failed in the executed harness path.
- Environment/finale/portal: `T36`, `T37`, `T41`, `T42`, `T43`, `T44`, `T46`, `T47`, and `T50` newly passed; `T39` and `T40` failed because the finale did not reach the expected ready/text state through the reward prerequisite path; `T48` and `T49` remain NOT_VERIFIED because actual shared portal scene transition/overlap was not driven.

## Rendering Checks

`RENDERED RUNTIME EVIDENCE: NOT VERIFIED — renderer unavailable`

- `DISPLAY` was empty.
- `WAYLAND_DISPLAY` was empty.
- No virtual display/capture tool was used.
- No packages were installed.
- No synthetic screenshots were created.

## DOCX Status

- External DOCX regenerated from this Markdown semantic source at `/workspace/Level_03_Greybox_Implementation_Summary.docx`.
- DOCX checks passed: ZIP integrity, `[Content_Types].xml`, root relationships, `word/document.xml`, `word/styles.xml`, extracted text, and semantic comparison.
- DOCX is outside the repository and must not be committed.

## Handoff

- Gameplay implemented in this continuation: `No`.
- New source fixes in this continuation: `None`.
- Godot project structure preserved: `Yes`.
- Repository harness/log/import/DOCX artifacts added: `No`.
- Push proof: `NOT VERIFIED — no push performed`.
- Manual publication handoff: commit locally, then manually publish this continuation into existing PR #111.

## Final Status

`CORRECTION REQUIRED`
