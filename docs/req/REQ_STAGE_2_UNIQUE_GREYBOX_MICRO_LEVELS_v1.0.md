# REQ: Stage 2 — Revised Narrative / Route / Shard Model v1.0

## 1. Superseded / revised-by note

This document is revised by **Stage 2A-R1 — Revised Stage 2 Narrative / Route / Matrix Docs**.

The previous Stage 2 model described **15 unique playable greybox micro-levels**, one reward phrase per level, and a one-to-one relationship between level count and the hidden acrostic phrase. That model is now superseded by Producer + Narrative approval.

The active Stage 2 source of truth is now:

- **6 emotional playable chapters** for the MVP route.
- **15 soul shards** distributed across those 6 chapters.
- The acrostic confession **“Алена, я люблю тебя”** revealed separately in `FinalScene`.
- `Level_07` through `Level_15` treated as legacy/dev-only placeholder scenes for now.

Historical references to 15 playable unique levels in older docs, branch discussions, or previous planning should be treated as background only unless explicitly reapproved.

## 2. Baseline dependency

Stage 2A-R1 depends on the accepted Stage 1 route skeleton documented in:

- `docs/qa/STAGE_1K_GREYBOX_ACCEPTANCE.md`

Current accepted technical skeleton exists as:

`StartScene -> Level_01 -> Level_02 -> ... -> Level_15 -> FinalScene -> EndingOverlay`

Stage 2A-R1 changes the **active MVP design target**, not the runtime route in this docs-only slice.

## 3. Active Stage 2 goal

Stage 2 should convert the accepted greybox skeleton toward a short, gentle, playable narrative route using 6 emotional chapters and 15 collectible soul shards.

The goal is to support a 15–20 minute personal gift build with:

- readable greybox environments;
- simple non-punitive traversal or interaction beats;
- placeholder UI/text implementation only;
- all 15 shards represented across the active 6 levels;
- a careful final acrostic reveal in `FinalScene`.

Stage 2 remains a greybox narrative implementation stage. It is not an art, audio, cinematic, final poetry, or final typography stage.

## 4. Active MVP route target

The new active MVP route target is:

`StartScene -> Level_01 -> Level_02 -> Level_03 -> Level_04 -> Level_05 -> Level_06 -> FinalScene -> EndingOverlay`

This route target supersedes the old active 15-playable-level route for Stage 2 planning.

Future runtime work should reduce the active route to this 6-level path in a separate implementation slice. This docs task must not rewrite portals or route files.

## 5. Legacy/dev-only placeholder levels

`Level_07` through `Level_15` must be treated as legacy/dev-only placeholder scenes for now.

Requirements:

- Do not delete `Level_07` through `Level_15` in this docs slice.
- Do not require them as active MVP route levels.
- Do not assign Stage 2A-R1 shard progression to them.
- Do not polish them as part of the active 6-chapter route unless a future task explicitly scopes legacy cleanup or dev-menu support.
- Future cleanup, route rewrite, or dev-only organization must be handled as a separate implementation slice.

## 6. Active emotional chapters

| Level ID | Approved title | Active route status | Shard count |
|---|---|---:|---:|
| `Level_01` | First Warmth | Active MVP chapter | 2 |
| `Level_02` | Her Light / Aliveness | Active MVP chapter | 2 |
| `Level_03` | Voice, Laughter, Ease | Active MVP chapter | 3 |
| `Level_04` | Her Real Self | Active MVP chapter | 2 |
| `Level_05` | Small Details | Active MVP chapter | 3 |
| `Level_06` | Quiet Admiration | Active MVP chapter | 3 |
| `Level_07`–`Level_15` | Legacy/dev-only placeholders | Not active MVP route levels | 0 active Stage 2A-R1 shards |

## 7. Shard model requirements

Keep exactly **15 soul shards**.

Distribute them across the 6 active chapters as follows:

| Level ID | Assigned shards | Count |
|---|---|---:|
| `Level_01` | `Shard_01`, `Shard_02` | 2 |
| `Level_02` | `Shard_03`, `Shard_04` | 2 |
| `Level_03` | `Shard_05`, `Shard_06`, `Shard_07` | 3 |
| `Level_04` | `Shard_08`, `Shard_09` | 2 |
| `Level_05` | `Shard_10`, `Shard_11`, `Shard_12` | 3 |
| `Level_06` | `Shard_13`, `Shard_14`, `Shard_15` | 3 |

Shard total check: `2 + 2 + 3 + 2 + 3 + 3 = 15`.

## 8. FinalScene acrostic requirement

The acrostic remains:

**“Алена, я люблю тебя”**

It is no longer tied one-to-one to 15 playable levels.

Requirements:

- The collected light should reveal the acrostic confession in `FinalScene`.
- The final meaning should be: these are real feelings, shown carefully, without asking for an answer immediately, and simply so she knows.
- `FinalScene` should remain gentle and non-pressuring.
- This requirement is emotional direction only for Stage 2A-R1.

Do not write the final poem, final acrostic poem rewrite, final confession text, final voiceover, cinematic shot text, Veo prompts, final video, or polished typography in Stage 2A-R1.

## 9. Narrative safety guardrails

Stage 2 documentation and future implementation must preserve the following guardrails:

- Do not frame the heroine as broken.
- Do not save, fix, heal, or unlock her.
- Do not force her inner light open.
- Do not use proof-of-love mechanics.
- Do not use boss fight, combat, or “defeat guardian” structure.
- Do not demand or imply an immediate answer.
- Do not imply ownership, entitlement, permanence, pressure, or obligation.
- Keep the tone warm, careful, personal, respectful, and non-pressuring.
- Keep Stage 2 as greybox narrative implementation with placeholder UI/text.

Forbidden wording patterns:

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

These phrases may appear in documentation only as forbidden examples.

## 10. Out of scope for Stage 2A-R1

Do not implement or specify final production content in this slice:

- route rewrite;
- `Level_06 -> FinalScene` portal change;
- `Level_07`–`Level_15` deletion;
- new shard system;
- `GameState` expansion;
- save/progress systems;
- acrostic manager;
- final video;
- final voiceover;
- final poem;
- final confession/cinematic text;
- Veo prompts;
- gameplay scenes;
- runtime scripts;
- art assets;
- audio assets;
- typography polish;
- project settings changes.

Also out of scope:

- combat;
- inventory;
- dialogue systems;
- online/network features;
- open-world structure;
- complex AI;
- RPG systems.

## 11. Documentation dependencies

Stage 2A-R1 requirements depend on:

- `docs/spec/SPEC_STAGE_2_UNIQUE_GREYBOX_MICRO_LEVELS_v1.0.md`
- `docs/design/STAGE_2_LEVEL_MATRIX.md`
- `docs/qa/STAGE_1K_GREYBOX_ACCEPTANCE.md`

The level matrix is the source of truth for:

- approved level titles;
- shard assignment;
- small shard phrases;
- main shard monologues;
- level narrative/gameplay intent;
- risks, fallbacks, and per-level out-of-scope notes.

## 12. Acceptance criteria

Stage 2A-R1 docs are acceptable when:

- REQ, SPEC, and Level Matrix clearly state that the 6-chapter model is the active Stage 2 source of truth.
- The active MVP route target is documented as `StartScene -> Level_01 -> Level_02 -> Level_03 -> Level_04 -> Level_05 -> Level_06 -> FinalScene -> EndingOverlay`.
- `Level_07` through `Level_15` are documented as legacy/dev-only placeholders for now.
- All 15 soul shards are assigned across `Level_01` through `Level_06`.
- Shard counts per level match `2 / 2 / 3 / 2 / 3 / 3`.
- All approved small shard phrases are present in the matrix.
- All approved main shard monologues are present in the matrix.
- FinalScene acrostic direction is documented without writing final poem, voiceover, cinematic text, or video prompts.
- Narrative guardrails and forbidden wording patterns are documented.
- Runtime files, scenes, assets, and `project.godot` remain unchanged in this docs-only slice.

## 13. Future implementation order

Recommended future implementation order after Stage 2A-R1 docs approval:

1. **Route planning / route rewrite slice**: decide how to preserve dev access while reducing active route to `Level_01` through `Level_06`, then route `Level_06` to `FinalScene`.
2. **Shard/reward data planning slice**: define minimal placeholder approach for multiple shards per level without introducing unapproved save/progress complexity.
3. **Level_01 implementation slice**: implement “First Warmth” with `Shard_01` and `Shard_02` only, or reconcile any active PR work against this new model.
4. **Level_02 implementation slice**: implement “Her Light / Aliveness” with `Shard_03` and `Shard_04`.
5. **Level_03 implementation slice**: implement “Voice, Laughter, Ease” with `Shard_05` through `Shard_07`.
6. **Level_04 implementation slice**: implement “Her Real Self” with `Shard_08` and `Shard_09`.
7. **Level_05 implementation slice**: implement “Small Details” with `Shard_10` through `Shard_12`.
8. **Level_06 implementation slice**: implement “Quiet Admiration” with `Shard_13` through `Shard_15` and verify future `FinalScene` transition behavior if route rewrite has already been approved.
9. **FinalScene acrostic placeholder slice**: implement only approved placeholder reveal behavior, not final poem/video/voiceover.
10. **Legacy cleanup/dev-only slice**: decide what to do with `Level_07` through `Level_15` after the active route is stable.

## 14. Required verification for Stage 2A-R1

For this docs-only slice:

- Diff scope check confirms only the three expected Markdown files changed.
- Static review confirms no runtime, scene, asset, tool, or project settings file changed.
- Shard count review confirms 15 total shards across 6 active chapters.
- Narrative review confirms guardrails are present and final content remains deferred.
- Producer review confirms the matrix matches approved text exactly.

For future implementation slices:

- Confirm scene loads for touched levels.
- Confirm shard collection and reward UI behavior for each assigned shard.
- Confirm route continuity and intended active MVP route behavior.
- Confirm `FinalScene` and `EndingOverlay` behavior remain intact unless explicitly scoped.
- Confirm no forbidden systems or pressure-based mechanics are introduced.
