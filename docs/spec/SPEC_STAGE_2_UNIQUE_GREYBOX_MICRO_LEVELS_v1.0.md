# SPEC: Stage 2 — Revised 6-Chapter / 15-Shard Greybox Narrative v1.0

## 1. Superseded / revised-by note

This specification is revised by **Stage 2A-R1 — Revised Stage 2 Narrative / Route / Matrix Docs**.

The previous technical objective of converting `Level_01` through `Level_15` into 15 unique playable micro-levels is superseded. The active Stage 2 implementation target is now a 6-chapter MVP route with 15 soul shards distributed across those 6 chapters.

## 2. Technical objective

Define safe future implementation boundaries for moving from the accepted Stage 1 skeleton toward this active MVP route:

`StartScene -> Level_01 -> Level_02 -> Level_03 -> Level_04 -> Level_05 -> Level_06 -> FinalScene -> EndingOverlay`

The implementation must remain greybox-first, small-slice, route-safe, and non-pressuring in narrative tone.

## 3. Documentation dependency

Required source documents:

- `docs/req/REQ_STAGE_2_UNIQUE_GREYBOX_MICRO_LEVELS_v1.0.md`
- `docs/design/STAGE_2_LEVEL_MATRIX.md`
- `docs/qa/STAGE_1K_GREYBOX_ACCEPTANCE.md`

The level matrix is the source of truth for per-level narrative content and shard assignments.

## 4. Current route preservation and planned route reduction

### 4.1 Current accepted skeleton

Stage 1 acceptance established the existing technical skeleton:

`StartScene -> Level_01 -> Level_02 -> ... -> Level_15 -> FinalScene -> EndingOverlay`

### 4.2 Active MVP route target

Stage 2A-R1 active target:

`StartScene -> Level_01 -> Level_02 -> Level_03 -> Level_04 -> Level_05 -> Level_06 -> FinalScene -> EndingOverlay`

### 4.3 Route preservation requirement for this docs slice

This docs-only slice must not change runtime routing.

Do not modify:

- scene files;
- portal target paths;
- `LevelManager` behavior;
- `DevLevelMenu` behavior;
- `FinalScene` behavior;
- `EndingOverlay` behavior;
- `project.godot`.

### 4.4 Planned route reduction boundary

A future implementation slice may reduce the active route so that `Level_06` transitions to `FinalScene`, but only when explicitly scoped.

That future slice must decide how `Level_07` through `Level_15` remain accessible for development, QA, or archival purposes, if needed.

## 5. Legacy/dev-only level handling

`Level_07` through `Level_15` are not active MVP route levels under Stage 2A-R1.

Future implementation must not treat them as required player-facing chapters unless Producer/Narrative approval changes again.

Allowed future handling options, only when explicitly scoped:

- keep them as dev-menu-only placeholders;
- archive them in documentation;
- remove or reorganize them after route stability is proven;
- repurpose them only with separate approval.

## 6. Future implementation boundaries

Future Stage 2 runtime work must:

- stay in small reviewable slices;
- avoid unrelated systems;
- prefer local scene/data updates over new global architecture;
- preserve Stage 1 accepted behavior unless a route-rewrite slice explicitly changes it;
- keep greybox placeholder presentation;
- avoid polished art/audio/cinematics;
- avoid final poem, final voiceover, final video, and final confession copy.

Do not introduce a new global shard manager, acrostic manager, save/progress system, or expanded `GameState` without a separate approved task.

## 7. Shard and reward UI expectations

Stage 2A-R1 keeps 15 shards, distributed across 6 active levels.

Future placeholder implementation should support:

- multiple shard collection beats within a single active level;
- a small shard phrase for each collected shard;
- a main shard monologue per level after that level's assigned shard set is complete;
- simple placeholder UI/text only;
- no final typography polish;
- no final voiceover;
- no final cinematic presentation.

Exact UI structure is not approved in this docs slice. A future implementation slice should choose the smallest route-safe placeholder approach.

## 8. Per-level expected shard counts

| Level ID | Title | Expected active shards | Assigned shards |
|---|---|---:|---|
| `Level_01` | First Warmth | 2 | `Shard_01`, `Shard_02` |
| `Level_02` | Her Light / Aliveness | 2 | `Shard_03`, `Shard_04` |
| `Level_03` | Voice, Laughter, Ease | 3 | `Shard_05`, `Shard_06`, `Shard_07` |
| `Level_04` | Her Real Self | 2 | `Shard_08`, `Shard_09` |
| `Level_05` | Small Details | 3 | `Shard_10`, `Shard_11`, `Shard_12` |
| `Level_06` | Quiet Admiration | 3 | `Shard_13`, `Shard_14`, `Shard_15` |

Total: 15 shards.

## 9. Main shard monologue behavior

Each active level has one approved main shard monologue in the level matrix.

Future behavior expectation:

- Small shard phrases may appear when individual shards are collected.
- The main monologue should appear after the active level's assigned shard set is complete.
- The monologue should feel like a gentle level-level emotional completion beat, not a demand or reward-for-proof statement.
- Monologue text must not be paraphrased without Producer/Narrative approval.
- Placeholder UI is acceptable for Stage 2; polished presentation is out of scope.

## 10. FinalScene acrostic direction

`FinalScene` should eventually reveal the acrostic confession:

**“Алена, я люблю тебя”**

Technical direction for future work:

- The reveal is tied to collected light / completed shard journey, not to 15 separate playable levels.
- The reveal should be gentle and clear.
- The final meaning is that the feelings are real, shown carefully, with no request for an immediate answer.
- Implementation should begin with placeholder text/UI only if explicitly scoped.

Forbidden in Stage 2A-R1 and until separately approved:

- final poem;
- final acrostic poem rewrite;
- final confession text;
- final voiceover;
- cinematic shot text;
- Veo prompts;
- final video implementation;
- typography polish.

## 11. Narrative and mechanic safety requirements

Future implementation must preserve these rules:

- No brokenness framing.
- No save/fix/heal framing.
- No forced unlocking framing.
- No forced opening of her inner light.
- No proof-of-love gates.
- No boss fights, combat, guardian defeat, or trial-by-worthiness structure.
- No pressure for an immediate answer.
- No ownership, entitlement, coercion, or permanence framing.
- No mechanics that imply the player earns or deserves a response.

Forbidden wording patterns may appear only in guardrail documentation, not player-facing content:

- “ты спасла меня”
- “ты мой смысл”
- “без тебя я не живу”
- “я доказал”
- “я заслужил ответ”
- “я буду ждать вечно”
- “я всегда буду рядом”
- “я никогда не отпущу”
- “ты моя навсегда”
- “я исцелю тебя”
- “я раскрою тебя”
- “я растоплю твой лед”
- “теперь ты должна ответить”

## 12. Forbidden runtime systems

Do not introduce under Stage 2 without separate approval:

- combat systems;
- inventory systems;
- dialogue systems;
- online/network systems;
- open-world progression systems;
- save/progress frameworks;
- complex AI;
- complex companion control;
- RPG systems;
- cinematic/video runtime systems;
- final audio/voiceover systems.

## 13. Future implementation order recommendation

Recommended order after Stage 2A-R1 docs approval:

1. Route-rewrite planning and implementation slice for active 6-level route, including dev-only handling decision for `Level_07`–`Level_15`.
2. Minimal shard/reward placeholder design slice for multiple shards per level.
3. `Level_01` revised implementation or PR #47 reconciliation slice.
4. `Level_02` implementation slice.
5. `Level_03` implementation slice.
6. `Level_04` implementation slice.
7. `Level_05` implementation slice.
8. `Level_06` implementation slice and `FinalScene` transition sanity if route rewrite is in scope.
9. Placeholder `FinalScene` acrostic reveal slice.
10. Legacy/dev-only cleanup slice for `Level_07`–`Level_15`.

## 14. Review checklist

For Stage 2A-R1 docs review:

- REQ, SPEC, and matrix all identify the 6-chapter model as active source of truth.
- Active route target is exactly `StartScene -> Level_01 -> Level_02 -> Level_03 -> Level_04 -> Level_05 -> Level_06 -> FinalScene -> EndingOverlay`.
- `Level_07` through `Level_15` are legacy/dev-only placeholders.
- Shard count is exactly 15 across 6 active levels.
- Approved shard phrases and monologues match the matrix.
- FinalScene acrostic direction is present without final poem/voiceover/cinematic text.
- Narrative guardrails and forbidden wording patterns are present.
- No runtime files changed.

For future implementation slice review:

- Scope: only intended levels/systems touched.
- Route: active MVP route remains clear and manually testable.
- Shards: expected shard count for touched levels is implemented or explicitly deferred.
- Reward UI: placeholder behavior is readable and non-polished.
- Monologue behavior: level completion beat appears only after assigned shard set completion.
- Tone safety: no guardrail violation.
- Systems: no forbidden runtime system introduced.
- Legacy levels: `Level_07`–`Level_15` are not accidentally required for MVP completion.

## 15. Blocker handling

If future implementation pressure conflicts with this specification:

- stop;
- document the contradiction;
- propose the smallest compliant alternative;
- ask for explicit Producer/Narrative approval before changing route contracts, final text, final presentation, or system scope.
