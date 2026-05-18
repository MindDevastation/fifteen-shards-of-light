# SPEC: Stage 2 — Unique Spacious Greybox Micro-Levels v1.0

## 1. Technical objective
Define implementation constraints and slice strategy for converting Level_01..Level_15 from repeated placeholders into unique spacious greybox micro-levels while preserving accepted routing and runtime contracts.

## 2. Documentation dependency
Required source documents:
- `docs/req/REQ_STAGE_2_UNIQUE_GREYBOX_MICRO_LEVELS_v1.0.md`
- `docs/design/STAGE_2_LEVEL_MATRIX.md`
- `docs/qa/STAGE_1K_GREYBOX_ACCEPTANCE.md`

## 3. Implementation strategy for future slices
- Implement Stage 2 in small level-group slices.
- Keep each slice reviewable and route-safe.
- Prefer local per-level updates over introducing new global systems.
- Validate each slice against Stage 1K flow before merging.

## 4. Hard preservation requirements
Future Stage 2 runtime work must preserve:
- StartScene route entry.
- Sequential Level_01–Level_15 route.
- Level_15 -> FinalScene transition.
- FinalScene E-only pedestal interaction semantics.
- EndingOverlay behavior and exits.
- DevLevelMenu sanity for direct level/final scene loading.

## 5. Future slice boundaries
- First implementation slice: Level_01–Level_03 only.
- Later slices must remain small and reviewable (for example, 2–4 levels per slice).
- Do not modify final flow systems unless explicitly scoped.

## 6. Per-level scene update expectations
For each updated level scene in future runtime slices:
- Keep one required SoulShard loop.
- Keep PoemRewardUI integration.
- Keep one outgoing portal behavior to the correct route target.
- Keep LevelManager integration/contract.
- Keep Player and Camera compatibility.
- Preserve route target path consistency.

## 7. Greybox layout requirements
- Spacious but readable layout.
- Controlled 2.5D / guided 3D navigation.
- No maze topology.
- No open-world structure.
- Include visible landmarks for orientation.
- Keep optional side-space decorative only (not required objective paths).

## 8. Mechanic implementation rules for future work
- Approved mechanics only:
  - Reveal path
  - Presence zone
  - Activate 3 points
  - Soft bypass path
  - Simple light bridge
  - Simple follow companion (simplified/risky)
- Keep mechanic logic simple and local to level needs.
- Reuse existing simple scripts where appropriate.
- Do not introduce new global runtime systems unless separately approved.

## 9. Reward-screen integration requirement
- Large reward-screen text per level must match the matrix phrase exactly.
- No paraphrasing, rewriting, punctuation normalization, or substitutions.
- Treat matrix phrases as strict content locks.

## 10. Portal / transition rules
- Portal behavior remains single forward progression per level.
- Portal targets must preserve canonical order.
- Level_15 target remains FinalScene.
- No Level_16 introduction.
- No alternate required branching route that breaks accepted flow.

## 11. Safety / non-pressure requirements
Future runtime slices must preserve warm, careful, non-pressuring tone:
- No brokenness framing.
- No save/fix/heal framing.
- No forced unlocking framing.
- No demand for immediate answer.
- No proof-of-love gating.
- No boss/combat framing.
- Respect sensitive-level guardrails from REQ + matrix.

## 12. Testing requirements for future implementation slices
Per runtime slice:
- Confirm scene loads for touched levels.
- Confirm shard collection still triggers reward UI.
- Confirm portal target and route continuity.
- Confirm Level_15 -> FinalScene remains correct if touched.
- Confirm FinalScene E-only interaction remains unchanged unless explicitly scoped.
- Confirm DevLevelMenu sanity remains intact.

## 13. Forbidden runtime systems
Do not introduce under Stage 2 without separate approval:
- Combat systems.
- Inventory systems.
- Dialogue systems.
- Online/network systems.
- Open-world progression systems.
- Save/progress frameworks not already approved.
- Complex AI or companion control systems.
- New cinematic/video runtime systems.

## 14. Acceptance gates
A Stage 2 implementation slice should be blocked from acceptance if any of the following occur:
- Canon route breaks or mismatched portal targets.
- Reward phrase mismatch with matrix.
- Sensitive-level guardrail violation.
- Introduction of forbidden systems/scope.
- Excessive level complexity (maze/open-world/long backtrack).

## 15. Review checklist
For each future Stage 2 slice review:
- Scope: only intended levels/files touched.
- Route: StartScene -> ... -> Level_15 -> FinalScene intact.
- Reward text: exact phrase lock maintained.
- Tone safety: guardrails preserved.
- Mechanics: approved list only.
- Layout: spacious + readable, not maze/open-world.

## 16. Blocker handling
If implementation pressure conflicts with these constraints:
- Stop and document blocker.
- Propose smallest viable alternative that stays within approved mechanics.
- Escalate for explicit approval before adding new systems or changing route contracts.

## 17. Future implementation order recommendation
Recommended order after Stage 2A docs:
1. Slice 2B: Level_01–Level_03.
2. Slice 2C: Level_04–Level_06.
3. Slice 2D: Level_07–Level_09.
4. Slice 2E: Level_10–Level_12.
5. Slice 2F: Level_13–Level_15 with FinalScene transition sanity.
