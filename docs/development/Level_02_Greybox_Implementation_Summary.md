# Level 02 Greybox Implementation Summary

## Verdict

Corrective local G7A status: PASS.

This document is the corrected semantic source for the Level_02 greybox implementation summary. It supersedes the earlier shortened/stale summary and is regenerated together with the external DOCX artifact at `/workspace/Level_02_Greybox_Implementation_Summary.docx`.

## Scope and Publication State

- Local factual G6 and G7A work is complete.
- Existing PR identity: PR #106.
- The final platform-native `make_pr` publication step is executed after this documentation-correction commit.
- Under the platform-native `make_pr` workflow, GitHub/platform-generated remote SHAs may differ from Codex local SHAs even when the published tree represents the accepted local tree.
- Final remote G7B verification remains external to the local shell and is not claimed by this file.
- The final documentation-correction commit SHA is recorded in the final task handoff rather than recursively embedded in this file.

## Corrective Commit History

### Reported earlier local corrective commits

These SHAs were reported during the corrective process. Some may not be ancestors of the current rematerialized local `work` branch because the platform-native PR workflow can rematerialize the tree into a new local snapshot.

| Commit | Reported purpose |
| --- | --- |
| `714c247` | Correct Level 02 startup production wiring. |
| `e23c8e7` | Correct Level 02 recovery spatial layout. |
| `ddb684d` | Correct Level 02 complete Trial A. |
| `c19c2a0` | Correct Level 02 complete Trial B. |
| `bbe052f` | Correct Level 02 reward environment progression. |
| `6441ccc` | Correct Level 02 finale portal flow. |
| `786a810801e4f4d8b3a8cab805a4f184b5e20628` | Resource/parser stabilization with a prematurely named G6 closure title; Producer later clarified this was not factual G6 PASS. |
| `23468de2d4e6d1893f005d1f136da34d15251d3b` | Fix Level 02 parser and startup blockers. |
| `ae3012057f0495d54346493ec359fc72df132927` | Fix Level 02 recovery anchor registration. |
| `55beeb891562267ba6f8d6ca118be838274e3929` | Fix Level 02 Trial B and reward natural flow. |
| `708983d17abd1228923f9a2eb7e6dd4ff64d0d9c` | Complete Level 02 factual G6 runtime closure. |
| `17661ab7798697fc85474728d6bb95861f03f40c` | Complete Level 02 corrective Group 7 before this final documentation-correction pass. |

### Commits present in current local ancestry

The current local branch is a platform-rematerialized corrective snapshot. In the current local ancestry after base `11e8f0b7710567caecc5422ddd4487cb8b64ac10`, Git reports:

| Commit | Purpose |
| --- | --- |
| `3fae0a55c73d3b783ae7889e972b8e69f186fbf6` | Add playable Level_02 greybox, runtime validator, Trial B fixes, and reward/portal flow. This snapshot includes the accepted G6/G7A runtime tree and explains why the earlier unexplained `093d363` entry is no longer used as authoritative ancestry in this corrected summary. |

### Final-head terminology

| Item | SHA |
| --- | --- |
| Factual G6 closure head | `708983d17abd1228923f9a2eb7e6dd4ff64d0d9c` |
| Group 7 commit | `17661ab7798697fc85474728d6bb95861f03f40c` |
| Local HEAD before this final documentation-correction commit | `17661ab7798697fc85474728d6bb95861f03f40c` |
| Final documentation-correction commit | Recorded in the final task handoff rather than recursively embedded here. |

## Original Rejected Skeleton Finding

The original PR handoff was rejected because it described a playable implementation but still behaved as a skeleton. Missing or insufficient areas included strict startup proof, real Trial B body-entry behavior, production shard/reward natural flow, final center/finale/portal proof, complete G6 evidence, and accurate implementation summaries.

## Runtime Architecture

Level_02 is assembled as `res://scenes/levels/Level_02.tscn` from primitive greybox block scenes, Level_02-local gameplay controllers, state/VFX adapters, shared Player/Camera/SoulShard/reward/finale/portal systems, and a Level_03 portal target.

The `Level02RuntimeContractValidator` performs startup preparation and commit sequencing:

1. resolve exact mandatory nodes;
2. validate required methods and signals;
3. resolve actual Shard_03 and Shard_04 nodes;
4. build connection, shared-registration, and domain-commit plans;
5. execute inert reassertion;
6. connect local signals;
7. register actual shard instances with the shared reward controller;
8. commit mandatory domains;
9. arm Progress;
10. enable Player controls;
11. arm Arrival;
12. emit exactly one `validation_passed`.

## Player Error Attribution

`PLAYER ERROR ATTRIBUTION: ENVIRONMENT IMPORT STATE`

A full `godot --headless --editor --quit --path .` import regeneration completed successfully with exit code 0. After that import pass:

- Direct `res://scenes/core/Player.tscn` instantiation had a Player root, `FoxHeroineAnimationController`, expected script path, `CharacterVisualRoot/FoxHeroineModel`, `AnimationPlayer`, non-null Player `animation_controller`, and non-null controller `_animation_player`.
- One disabled-controls physics frame and one enabled-controls physics frame completed without the prior `is_dancing` null error.
- Current `Level_01` production diagnostic completed physics frames without the Player null-controller error.
- Current `Level_02` production probe completed physics frames without the Player null-controller error.
- Base-worktree diagnostics without an import cache reproduced broad missing-class/import errors, confirming that the original shared Player failure was caused by incomplete local import state rather than a Level_02-local scene mutation.

## Trial B Pad-Entry Root Cause and Fix

Root cause: `TrialBSymbolPad._on_body_entered()` previously marked a pad occupied before attempting interaction, while `can_player_interact()` required the pad not to be occupied. That ordering prevented actual Player body entry from emitting `pad_pressed`.

Corrected behavior:

- direct public interaction and body entry share one acceptance boundary;
- armed unoccupied pads emit exactly one `pad_pressed(pad_id)`;
- accepted body entry makes the pad occupied and unarmed;
- repeated entry while occupied cannot duplicate a press;
- exit clears occupancy and rearms only when input is permitted by Trial B.

## Presentation Ownership Fix

Trial B uses an explicit state model:

- `INERT`
- `SHOWING_SEQUENCE`
- `WAITING_FOR_INPUT`
- `COMPLETED`

`presentation_generation` invalidates stale presentations. Stale completions cannot arm pads or emit `sequence_presented`. Disarm and completion invalidate pending presentations.

## Reward Natural-Flow Evidence

The focused production harness proved the chain:

`request -> shared presentation -> confirmation -> return -> collected -> raw slot -> admitted gate -> Progress -> Environment`

Observed facts:

- Shard_03 and Shard_04 each emitted actual `reward_sequence_requested`.
- The shared `ShardRewardSequenceController` presented the reward overlay.
- `Level02RewardGate` observed requests in parallel.
- The overlay confirmation button path emitted confirmation.
- The shared return sequence completed.
- The active SoulShard emitted `collected`.
- The Slot emitted raw collection.
- RewardGate admitted exactly once per shard.
- Progress and Environment each received two admitted shards.

## Factual G6 Matrix

| Area | Result | Evidence |
| --- | --- | --- |
| Startup | PASS | Production `Level_02.tscn` loaded; validator committed successfully without validation failure. |
| Recovery | PASS | Center, Arrival, TrialA, and TrialB recovery anchors restored Player and zeroed velocity while preserving solved trial state. |
| Trial A | PASS | Three statues solved; Shard_03 revealed. |
| Trial B | PASS | Four-stage sequence solved; Shard_04 revealed; Trial B completion reached exactly once in harness evidence. |
| Reward | PASS | Shard_03 and Shard_04 completed actual shared reward presentation, confirmation, return, collection, gate admission, Progress admission, and Environment admission. |
| Environment | PASS | Two admissions reached Environment; final fog ratio reached the approved final state. |
| Finale | PASS | Both admitted shards, fog readiness, and center presence triggered exact main text; actual overlay close completed. |
| Portal | PASS | Portal activated, forced invalid target returned portal to retryable ACTIVE, and Level_03 target remained configured. |
| Runtime stderr | PASS with allowed failure-injection errors | No Player null-controller error after import regeneration. The only expected errors in the G6 run were forced invalid portal target errors from the transition-failure injection case. |

## Exact Changed-File Scope

Persistent changed files are limited to the Level_02 scene family, Level_02-local scripts, Level_02 development summary, and approved Level_02-local scene assets. No shared Player, shared portal, shared reward, shared UI, `project.godot`, Level_01, or Level_03 content files were modified in this final documentation-correction pass.

Key path families:

- `docs/development/Level_02_Greybox_Implementation_Summary.md`
- `scenes/levels/Level_02.tscn`
- `scenes/levels/level_02/blocks/*.tscn`
- `scenes/levels/level_02/gameplay/*.tscn`
- `scenes/levels/level_02/state/*.tscn`
- `scenes/levels/level_02/vfx/*.tscn`
- `scripts/levels/level_02/*.gd`

## Temporary Harness Cleanup

Approved temporary harness files were created under `tests/levels/level_02/harness/` during evidence collection. They were deleted before commits. No temporary harness `.gd.uid` files remain.

## DOCX Rendering and Equivalence

The external DOCX was regenerated from the same semantic source as this Markdown. Because no office renderer was installed in the base environment and package installation was blocked by repository proxy 403 responses, the document was rendered for inspection through a deterministic local OOXML text extraction and page-layout renderer. The generated rendered page images were inspected page by page.

Inspection result:

- DOCX ZIP integrity: PASS.
- Extracted-text equivalence: PASS.
- Comments/tracked changes: none present.
- Rendered page count: recorded in the final task handoff.
- Headings present: PASS.
- Tables readable: PASS.
- Logical rows: PASS for the generated page layout.
- Text clipping: none detected in rendered page bounds.
- Content overlap: none detected.
- Blank unintended pages: none detected.
- Final sections present: PASS.

## Known Limitations

- Platform-native `make_pr` publication may generate remote commit SHAs that differ from local Codex SHAs.
- Final remote G7B verification is external to this local shell and is not claimed here.
- Forced invalid portal target errors appear only in the failure-injection evidence case and are expected for retry verification.

## Local G7A Result

Local G7A is PASS after factual G6, corrected summary generation, external DOCX generation, rendered-page inspection, temporary harness removal, smoke checks, and clean-worktree verification.
