# REQ: Stage 2 — Unique Spacious Greybox Micro-Levels v1.0

## 1. Purpose
Define product requirements for Stage 2 documentation and future implementation planning: replacing repeated placeholder micro-levels with 15 unique spacious greybox micro-levels while preserving the accepted Stage 1K playable route.

## 2. Current accepted baseline
The accepted baseline route is:

StartScene -> Level_01 -> Level_02 -> Level_03 -> Level_04 -> Level_05 -> Level_06 -> Level_07 -> Level_08 -> Level_09 -> Level_10 -> Level_11 -> Level_12 -> Level_13 -> Level_14 -> Level_15 -> FinalScene -> E pedestal interaction -> EndingOverlay.

Stage 1K acceptance artifact: `docs/qa/STAGE_1K_GREYBOX_ACCEPTANCE.md`.

## 3. Stage 2 goal
Transform the 15 repeated placeholder levels into 15 short unique spacious greybox micro-levels with one emotional idea per level, without breaking accepted flow.

## 4. Scope
In scope for Stage 2 (implementation slices after this docs slice):
- Unique greybox-level redesign per Level_01 through Level_15.
- Spacious but readable level layouts.
- Per-level symbolic motif and one simple mechanic.
- Preservation of shard/reward/portal loop per level.
- Preservation of transition to FinalScene and ending overlay route.

## 5. Out of scope
- Runtime implementation in this Stage 2A docs slice.
- Final art, model polish, audio, voiceover, video, typography, and cinematic text.
- Final poem/acrostic rewrite, final confession/personal message, final EndingOverlay message.
- Save/progress systems, GameState expansions, online features.
- New combat, inventory, dialogue, open-world, or complex AI systems.

## 6. Product requirements
- Stage 2 must keep the game short, gentle, and non-punitive.
- Each level should target approximately 45–90 seconds of completion time.
- Controlled 2.5D / guided 3D readability must be preserved.
- One level = one emotional idea, one symbol, one simple mechanic, one shard, one reward screen, one portal transition.

## 7. Level design requirements
Each of 15 levels must:
- Be unique in layout and scene feeling.
- Stay short and readable.
- Avoid maze complexity or open-world sprawl.
- Keep completion simple and non-punitive.
- Keep one shard objective and one forward portal transition.

## 8. Spacious greybox requirements
Spacious means:
- Wider readable layouts.
- More negative space.
- Stronger sense of place.
- Small fairy-tale scene feeling.
- Clear visual landmarks.
- Optional decorative side space.

Spacious must not mean:
- Open world.
- Maze navigation.
- Multiple required objectives.
- Long backtracking.
- Hidden required objects.
- Complex exploration.

## 9. Route preservation requirements
Stage 2 implementation must preserve:
- StartScene startup flow.
- Sequential route Level_01 through Level_15.
- Level_15 -> FinalScene transition.
- FinalScene E-only pedestal interaction behavior.
- EndingOverlay behavior.
- DevLevelMenu sanity routing.

## 10. Reward-screen phrase requirements
The player-facing large reward-screen phrase for each level must match the approved phrase exactly (no paraphrase, rewrite, punctuation normalization, translation, shortening, or substitution). Source of truth: `docs/design/STAGE_2_LEVEL_MATRIX.md`.

## 11. Narrative safety requirements
Stage 2 documentation and future implementation must preserve:
- No “she is broken” framing.
- No “I will save/fix/heal you” framing.
- No demand for immediate answer.
- No pressure to change.
- No boss fight framing.
- No proof-of-love gating.
- No forced unlocking framing.
- Warm, careful, personal, non-pressuring tone.

## 12. Sensitive level guardrails
- Level_02: cracked ice is present, but safe bypass is the intended meaning; breaking ice is not required.
- Level_04: no punitive failure around bird nests; use soft correction/reset/hints.
- Level_05: large bird shadow is non-threatening; not an enemy or pursuer.
- Level_06: soul sphere helps without control/leash feeling.
- Level_07: presence-zone warmth must not feel like forced closeness.
- Level_09: use bridge/path language; no implication of fixing her inner state.
- Level_10: preserve “Я умею идти рядом, не торопя” meaning; no pulling/control framing.
- Level_14: warmth may gather around closed inner light; do not force opening, healing, unlocking, or changing her.
- Level_15: blue rose garden and final shard remain non-combat and non-boss; no proving love, no defeating guardian, no breaking protection.

## 13. Approved mechanic set
Only these mechanics may be required by Stage 2 docs/spec/matrix:
- Reveal path.
- Presence zone.
- Activate 3 points.
- Soft bypass path.
- Simple light bridge.
- Simple follow companion (simplified/risky form only).

## 14. Level matrix dependency
Stage 2 requirements depend on the level-by-level source-of-truth matrix:
- `docs/design/STAGE_2_LEVEL_MATRIX.md`.

## 15. Acceptance criteria
Stage 2A docs are acceptable when:
- REQ, SPEC, and Level Matrix files exist and are internally consistent.
- All 15 approved reward-screen phrases are present exactly in the matrix.
- Spacious-level rules are documented with explicit do/don't constraints.
- Route preservation and Stage 1K baseline dependency are explicit.
- Narrative and sensitive-level guardrails are explicit.
- First implementation recommendation is Level_01–Level_03.

## 16. Non-goals
- Implementing gameplay, scene edits, or runtime code edits in Stage 2A.
- Defining final art production details.
- Rewriting approved narrative phrase set.

## 17. Risks / constraints
- Risk of accidental route breakage if future slices alter portal or target paths.
- Risk of phrase drift if reward text is manually retyped instead of copied from matrix.
- Risk of scope creep into unapproved systems or final-presentation work.
- Constraint: keep greybox-friendly and implementation-small per slice.

## 18. Required verification
For Stage 2A docs-only slice:
- Diff scope check to approved docs files only.
- Static scan for forbidden-system proposals in the new docs.
- Phrase exactness review against approved phrase list.
- Confirm no runtime/scenes/project settings were changed.

For future implementation slices:
- Slice-by-slice route-preservation verification.
- Manual play checks for updated levels.
- DevLevelMenu and FinalScene sanity checks.

## 19. Done definition
This REQ is done when it provides complete, reviewable Stage 2 requirements that can drive small implementation slices without ambiguity or runtime changes in Stage 2A.

## 20. Next implementation recommendation
First Stage 2 implementation slice after docs approval should cover only Level_01–Level_03.
