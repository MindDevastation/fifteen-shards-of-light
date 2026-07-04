# Level_03 Greybox Implementation Summary

## PR #111 Targeted T-Failure Triage

- Branch: `work`.
- Current PR: `#111`.
- Starting HEAD for this triage continuation: `459b41d` (`Enforce portal activation_duration (1.8s) and update Level_03 greybox summary/evidence`).
- Final HEAD at summary edit time: `PENDING_COMMIT`.
- Worktree preflight: clean before this continuation.
- Previous local commit `21f1241`: not present in this checkout history; the current checkout contains the squashed PR #111 continuation commit `459b41d`.
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

## Authoritative Group 6 Counts After Triage

- ST-01–ST-19: `19 PASS`, `0 FAIL`, `0 NOT_VERIFIED`.
- T count before this triage: `27 PASS`, `15 FAIL`, `10 NOT_VERIFIED`.
- T count after this triage: `36 PASS`, `0 FAIL`, `16 NOT_VERIFIED`.
- Rows converted `FAIL → PASS`: `T07, T11, T20, T23, T25, T26, T27, T39, T40`.
- Rows converted `FAIL → NOT_VERIFIED`: `T04, T05, T06, T08, T29, T34`.
- Rows still `FAIL`: `None`.
- Remaining `NOT_VERIFIED` rows: `T03, T04, T05, T06, T08, T16, T17, T22, T24, T29, T30, T31, T33, T34, T48, T49`.
- Group 6 factual P0: `NOT COMPLETE` because 16 runtime rows remain NOT_VERIFIED, including route, recovery volume contexts, Wind overlap edges, Spark destination overlap, full Meadow permutation/dwell matrix, Shard_07 exact-once signal proof, and portal overlap transition rows.

## Previously Failing T-Row Triage

| Row |
|---|
| `T04 | previous_status=FAIL | classification=TEST_METHOD_INVALID | expected=CP0-CP4 readability using camera/frustum/raycast evidence against readable landmarks | actual=previous harness raycast targeted CP marker positions rather than the reference landmark/readability target, so CP3 obstruction result is not a valid T04 failure | action=reclassify; no source change | final_status=NOT_VERIFIED | evidence=logs/remaining_runtime.json:T04_raycast; docs/design/Level_03_Greybox_Development_Reference_v1.1.md:T04` |
| `T05 | previous_status=FAIL | classification=TEST_METHOD_INVALID | expected=actual fall/OOB volume trigger proves one recovery for RA0-RA6 | actual=previous harness called RecoveryController APIs directly in a cooldown-sensitive loop rather than driving actual recovery volumes; corrected attempt still mixed cooldown with per-anchor evidence | action=reclassify; no source change | final_status=NOT_VERIFIED | evidence=logs/triage_recovery.json:T05` |
| `T06 | previous_status=FAIL | classification=TEST_METHOD_INVALID | expected=standing/slow/blocker/overlook contexts do not trigger recovery | actual=previous harness used invalid anchor/API calls, not the reference no-recovery contexts | action=reclassify; no source change | final_status=NOT_VERIFIED | evidence=logs/triage_recovery.json:T06` |
| `T07 | previous_status=FAIL | classification=HARNESS_DEFECT | expected=recovery suspended under reward/text lock remains pending and runs once after unlock if still overlapping | actual=corrected fresh-instance harness observed request=false while suspended, pending=suspended, recovered_to_RA2=true after unlock | action=harness-only fix | final_status=PASS | evidence=logs/triage_recovery.json:T07` |
| `T08 | previous_status=FAIL | classification=TEST_METHOD_INVALID | expected=enter under lock then exit before unlock clears pending and causes no recovery | actual=previous and corrected harness did not drive actual Area3D exit/body signal sequence; direct API sequence produced ambiguous stayed_at_original=false | action=reclassify; no source change | final_status=NOT_VERIFIED | evidence=logs/triage_recovery.json:T08` |
| `T11 | previous_status=FAIL | classification=HARNESS_DEFECT | expected=Shard_05 reward serializes through shared controller and returns idle | actual=corrected harness waited for SoulShard collection pre-reward animation; requested=true collected=true reward_state=0 macro=PLAYFUL_SPARK_ACTIVE | action=harness-only fix | final_status=PASS | evidence=logs/triage_reward_spark.json:T11` |
| `T20 | previous_status=FAIL | classification=HARNESS_DEFECT | expected=Shard_05 natural lifecycle arms Spark | actual=Wind->Slot_05 available->Player interact->reward request->confirm->return->collected; completed=[&"Shard_05"] macro=PLAYFUL_SPARK_ACTIVE spark_state=INTRO | action=harness-only fix | final_status=PASS | evidence=logs/triage_reward_spark.json:T20` |
| `T23 | previous_status=FAIL | classification=HARNESS_DEFECT | expected=Spark A->B hop/fallback advances once with first terminal wins | actual=before=[] after_A=[&"Perch_A"] expected_after_A=Perch_B | action=harness-only fix | final_status=PASS | evidence=logs/triage_reward_spark.json:T23` |
| `T25 | previous_status=FAIL | classification=HARNESS_DEFECT | expected=Spark leave after A/B preserves current perch | actual=expected_after_B=Perch_C slot06_revealed=true spark_completed=true | action=harness-only fix | final_status=PASS | evidence=logs/triage_reward_spark.json:T25` |
| `T26 | previous_status=FAIL | classification=HARNESS_DEFECT | expected=Spark fallback preserves sequence to Shard_06 availability | actual=slot06_available=true spark_completed=true | action=harness-only fix | final_status=PASS | evidence=logs/triage_reward_spark.json:T26` |
| `T27 | previous_status=FAIL | classification=HARNESS_DEFECT | expected=Shard_06 reward lifecycle arms Meadow | actual=requested=true collected=true completed=[&"Shard_05", &"Shard_06"] macro=BREATHING_MEADOW_ACTIVE meadow_state=ACTIVE | action=harness-only fix | final_status=PASS | evidence=logs/triage_reward_spark.json:T27` |
| `T29 | previous_status=FAIL | classification=TEST_METHOD_INVALID | expected=all six Meadow petal permutations complete one reveal with dwell/edge-case evidence | actual=corrected harness proved prerequisite-chain issue and one representative W-SE-NE completion, but did not rerun all six permutations with production dwell evidence | action=reclassify; no source change | final_status=NOT_VERIFIED | evidence=logs/triage_meadow_finale.json:T29` |
| `T34 | previous_status=FAIL | classification=TEST_METHOD_INVALID | expected=Shard_07 lifecycle emits all_rewards_completed exactly once and finale readiness only after shared collection | actual=corrected harness proved Shard_07 collection and finale readiness, but signal-count instrumentation connected too late and did not prove exactly-one emission | action=reclassify; no source change | final_status=NOT_VERIFIED | evidence=logs/triage_meadow_finale.json:T34` |
| `T39 | previous_status=FAIL | classification=HARNESS_DEFECT | expected=remain inside final gate after rewards starts synthesis/main text once | actual=after completed reward chain finale_state=3 overlay_opened=true player_inside=true | action=harness-only fix | final_status=PASS | evidence=logs/triage_meadow_finale.json:T39` |
| `T40 | previous_status=FAIL | classification=HARNESS_DEFECT | expected=leaving after synthesis/main text start does not cancel finale | actual=state_after_exit=3 overlay_opened=true portal_requested=false | action=harness-only fix | final_status=PASS | evidence=logs/triage_meadow_finale.json:T40` |

## Runtime Evidence Notes

- T11/T20 were previous harness defects: the old harness triggered confirmation/return before the shared SoulShard finished its pre-reward collection animation; the corrected harness waited for the reward request and then completed the shared overlay path.
- T23/T25/T26/T27 were previous harness defects because Spark was exercised before the Shard_05 reward chain had actually armed `PLAYFUL_SPARK_ACTIVE`; corrected prerequisite sequencing produced Spark progression, Shard_06 availability, and Meadow arming.
- T39/T40 were previous harness defects because finale entry was tested before the reward prerequisite chain had actually completed; corrected sequencing reached main text state and confirmed that leaving after start did not cancel it.
- T04/T05/T06/T08/T29/T34 were reclassified to NOT_VERIFIED because the previous methods did not execute the exact reference behavior strongly enough to support PASS or FAIL.

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

`CORRECTION REQUIRED — GROUP 6 FACTUAL P0 NOT COMPLETE`
