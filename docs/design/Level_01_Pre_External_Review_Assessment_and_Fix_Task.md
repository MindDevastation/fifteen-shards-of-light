# Level_01 — Pre-External-Review Assessment and Corrective Task

## Purpose
This document is the current source of truth for the next corrective pass before Level_01 is handed off to other review chats.

Scope of this pass:
1. Final technical/gameplay review of the current Level_01 build based on the latest gameplay video and the four design screenshots for the side-island lamp puzzle.
2. Corrective fixes for the remaining blocking issues.
3. Implementation of the new side-island mini-game.
4. Final polish of the finale overlay and portal presentation.

Out of scope:
- Full Level_02 implementation.
- Large narrative rewrite.
- Replacing the baked Help Stone inscription; keep the original baked inscription for now.

---

## Review Basis
### Materials reviewed
- Latest gameplay video: `2026-06-18 17-22-57.mp4`
- Design screenshot 1: island with 7 small lamps placed along the road.
- Design screenshot 2: same island with two lamp groups color-marked.
- Design screenshot 3: same island with start-beam examples from the two starting lamps.
- Design screenshot 4: same island with the intended correct connection solution.

### Accepted review categories
All scoring in this document uses the previously accepted categories:
1. Smoothness of play
2. Gameplay
3. Texture / visual quality
4. Load / performance risk
5. Additional parameters

---

## Detailed Assessment

## A. Overall current Level_01 state

### 1. Smoothness of play — **86 / 100**
**What is good**
- The level reads better than earlier passes.
- The main route is visually clearer.
- The game flow from movement to collectibles to finale is understandable.

**What is still weak**
- The player still snags on collisions, especially near the spawn/start area.
- This is a hard blocker because it directly damages the “feel” of movement.
- The finale pacing is inconsistent: text reveal was fixed once, but the current state still causes readability issues due to clipping and small text.
- Portal motion still feels visually unresolved; the VFX moves, but not in the intended readable structure.

**Assessment summary**
The level is no longer rough in a catastrophic sense, but it still does not feel fully reliable. The collision snag near spawn alone keeps this category below a handoff-ready score.

---

### 2. Gameplay — **84 / 100**
**What is good**
- Core Level_01 flow exists and is understandable.
- The Soul Orb / shard / portal loop is much more readable than before.
- The level has enough structure to be playable and reviewable.

**What is still weak**
- One large side island is still effectively dead space.
- The player sees a substantial playable-looking area that currently behaves like a visual stub.
- The portal sequence still does not fully pay off visually.
- Finale text delivery is better structured than before, but the presentation still does not support the final emotional beat strongly enough.

**Assessment summary**
Gameplay completeness is the biggest design weakness now. The proposed lamp mini-game is the correct direction because it turns a currently dead island into a purposeful optional/secondary puzzle segment with clear logic and reward.

---

### 3. Texture / visual quality — **89 / 100**
**What is good**
- Environment art and color mood are attractive.
- Vegetation, road, and general island composition already create a warm stylized atmosphere.
- The level now looks significantly more like a real game space and less like a technical blockout.

**What is still weak**
- The portal is still the least convincing visual element.
- Clouds improved, but still need stronger volumetric read.
- Finale text is technically inside the frame area now, but the text treatment is still too small and visually constrained.
- Finale frame decoration is improved, but it still needs a stronger relationship between vines, branches, and leaves.

**Assessment summary**
Environment visuals are close to presentable. The main remaining visual quality debt is concentrated in VFX and UI: portal, clouds, and finale overlay.

---

### 4. Load / performance risk — **83 / 100**
**What is good**
- The current build has not shown a confirmed collapse in performance in the reviewed materials.
- Most systems are still structurally lightweight.

**What is still weak / risky**
- Portal rework is approaching the point where visual ambition can start damaging performance.
- A particle-heavy galaxy-style portal can become expensive if built naïvely.
- The upcoming lamp puzzle will add beam rendering and additional state updates.
- More finale decoration and cloud volume can also add overhead if implemented carelessly.

**Assessment summary**
Performance is not yet proven safe. The next pass must keep VFX scalable and add explicit fallback logic where necessary.

---

### 5. Additional parameters — **87 / 100**
Includes: clarity, UX, readability, emotional presentation, reuse quality, implementation architecture.

**What is good**
- Reusability direction is much better now.
- Soul Orb prompt specialization is the correct pattern.
- Finale overlay is moving toward a reusable per-level system.

**What is still weak**
- Finale overlay still needs better responsive layout.
- Current maximum line count and text sizing are too conservative for the approved narrative text.
- Portal architecture is still not at a clearly “final-art-intent” state.
- The side island has high potential but currently low functional value.

**Assessment summary**
The project is now in a good “almost ready for external review” zone, but it still needs one more coherent pass that addresses function, clarity, and emotional finish together.

---

## B. Per-frame assessment of the 4 design screenshots

## Frame 1 — Island layout with 7 lamps only
**What the frame communicates well**
- The island has enough physical space for a mini-game.
- The road naturally suggests a path-based logic puzzle.
- Lamp spacing is good enough to support a chain-connection mechanic.
- The far end reads as a destination zone.

**Weaknesses / risks**
- Without color or state cues, all lamps currently look functionally identical.
- There is no readable distinction between:
  - start lamps,
  - relay lamps,
  - goal/end lamps,
  - inactive decorative lamps.
- If left like this, the mechanic will be hard to read.

**Conclusion**
Excellent candidate area for a side puzzle, but it needs strong state language and clear role separation.

---

## Frame 2 — Island layout with two color groups
**What the frame communicates well**
- Color coding immediately clarifies the two channels/groups.
- The concept of two separate light paths is readable.
- The puzzle becomes understandable at a glance.

**Weaknesses / risks**
- The shown red/blue colors are technical, not final-art colors.
- Final palette must feel magical/warm and must fit the level.
- If colors are too saturated, they may clash with the environment.

**Conclusion**
The two-channel concept is correct and should be preserved, but final colors must be art-directed.

---

## Frame 3 — Start lamps and first beam links
**What the frame communicates well**
- Start conditions are easy to understand.
- The first step of the puzzle is legible: each channel begins from its own source lamp.
- Curved beam routing looks promising.

**Weaknesses / risks**
- Beam presentation is still only conceptual.
- If the final beams are too thin, too bright, or clip through geometry badly, readability will suffer.
- The player still needs interaction feedback beyond just lines appearing.

**Conclusion**
The beam-connection mechanic is viable, but it needs strong activation feedback and a polished beam renderer.

---

## Frame 4 — Intended correct solution path
**What the frame communicates well**
- The full intended solution is readable.
- The puzzle has a satisfying chained-route structure.
- The dual-path structure creates a good “guided but not trivial” mini-game.

**Weaknesses / risks**
- Lamp states must become unmistakable, because the solution includes multiple relays.
- Already activated lamps must visibly lock to prevent ambiguity.
- Cross-side linking must be allowed technically, but the correct route must still remain visually readable.

**Conclusion**
This is a solid puzzle concept for the currently empty island and should be implemented as a reusable light-routing system.

---

## C. Technical element assessment

### 1. Player movement and collision
Current status: **blocking issue**.
- Snagging near spawn/start is unacceptable for a near-final pass.
- Likely causes:
  - decorative foliage/rocks with overly aggressive collision;
  - overlap between player collider and nearby geometry at spawn;
  - narrow path margins combined with collision shapes that stick out beyond the visual mesh;
  - collision on assets that do not need precise blocking.

Required outcome:
- The player must be able to move cleanly in the start area and along early-path edges without micro-stuttering or getting caught.

---

### 2. Side-island gameplay value
Current status: **underused space**.
- The side island is visually large enough to imply gameplay.
- Leaving it empty weakens the level’s perceived completeness.

Required outcome:
- Turn the island into a functioning lamp-connection mini-game with barrier unlock.

---

### 3. Portal VFX
Current status: **largest remaining VFX weakness**.

Current problems:
- The existing particles still read as a spiral rising upward.
- That is not the intended structure.
- The portal does not yet read as a dense magical field / galaxy interior.

Required target structure:
1. Keep a spiral vortex only in the **lower third** of the portal.
2. From the center, create **5 vertical spiral sleeves** made of the same particle family, reaching outward toward the rim.
3. The sleeves rotate **counterclockwise**.
4. Between the sleeves, add sparse floating particles with slight motion to create a galaxy interior feel.
5. Build the portal rim itself from the same particle language.
6. If this implementation is too expensive or unstable, remove the current upward spiral particles rather than keeping the wrong behavior.

---

### 4. Clouds
Current status: **improved, but still not finished**.
- The clouds are much better than earlier, but still not fully volumetric.
- The player should read them as soft stylized volume, not as mostly flat masses with shader dressing.

Required outcome:
- Increase volume read while preserving the warm cream stylized direction.
- Keep the result clean and avoid grain/noise regression.

---

### 5. Finale overlay
Current status: **structurally improved, visually still constrained**.

Current problems:
- The text safe area now sits inside the frame, but the text is clipped.
- Text feels too small.
- 3-line limitation is too restrictive.
- The final approved text needs more room and better visual weight.

Required target:
1. Use a text area equal to **80% of the vine-frame inner area**.
2. Allow **up to 6 lines** instead of 3.
3. Increase text size.
4. Ensure text never clips horizontally or vertically for the approved final Level_01 text.
5. Add subtle volume/depth styling to the text.
6. Keep the overlay reusable for future levels.

---

## Final Review Scores
- Smoothness of play: **86 / 100**
- Gameplay: **84 / 100**
- Texture / visual quality: **89 / 100**
- Load / performance risk: **83 / 100**
- Additional parameters: **87 / 100**

### Overall readiness score: **85.8 / 100**

## Final conclusion
The level has clearly improved and is much closer to a presentable state. However, it is **not yet ready** for final external review because it still fails the previously accepted threshold of **95 / 100**.

The remaining work is no longer broad chaos; it is concentrated in a small number of specific, high-impact issues:
1. player collision reliability;
2. turning the dead side island into a real mini-game;
3. finishing the portal VFX language;
4. improving cloud volume;
5. finishing the finale text layout and readability.

Once these are fixed coherently, Level_01 should be suitable for handoff to other review chats.

---

# Corrective Implementation Task

## Priority classification
### P0 — must fix before external review
1. Fix player snagging / collision issues near spawn and other early-level sticky spots.
2. Implement the side-island lamp mini-game with barrier unlock.
3. Rework the portal to the requested particle/galaxy structure or remove the wrong upward-spiral behavior if needed for performance/stability.
4. Fix finale text clipping and resize the text system to 80% of frame area, 6-line support, and larger text.

### P1 — strong quality fixes
5. Improve cloud volume while preserving current art direction.
6. Improve finale text styling and final readability.
7. Ensure lamp puzzle UX and visual states are strong and unambiguous.

### P2 — polish / validation
8. Validate performance around active portal and active lamp puzzle.
9. Validate the entire level flow from spawn to finale after fixes.
10. Update implementation report with honest QA status.

---

## Slice-based implementation plan

## Slice 0 — Preflight and baseline lock
### Task
- Start from the current branch/worktree state.
- Record branch name, starting SHA, and working tree status.
- Do not alter unrelated systems.

### Acceptance criteria
- Baseline recorded.
- Working tree state understood.
- Scope locked to this corrective pass.

---

## Slice 1 — Player collision reliability pass
### Task
Investigate and fix snagging/sticky movement, especially near the spawn/start area.

### Required work
- Inspect player spawn placement and nearby static geometry.
- Inspect collision shapes on nearby rocks, bushes, walls, props, and terrain edges.
- Remove or simplify unnecessary collisions on decorative foliage/props.
- Ensure collision shapes do not protrude beyond what the player visually expects.
- Check any narrow passage at the start area and early path.
- If needed, slightly adjust spawn placement or surrounding decorative layout.

### Acceptance criteria
- Player can move cleanly around the spawn/start area without getting caught.
- Early-route movement feels smooth and predictable.
- No new collision regressions introduced elsewhere.

---

## Slice 2 — Side-island lamp puzzle architecture
### Task
Implement a reusable two-channel lamp-routing mini-game on the large side island.

### Puzzle concept
- There are 7 small relay lamps along the road: 4 on the left side path/channel and 3 on the right side path/channel in the concept screenshots.
- At the start of the island there are 2 source lamps (user places them manually).
- At the end of the island there are 2 destination/end lamps (user places them manually).
- At the far end there is a light barrier blocking progress.
- Each source lamp emits a beam of a different channel color into its first valid relay lamp.
- The player must continue each beam through the correct lamp chain until each channel reaches its matching end lamp.
- When both correct chains are complete, the barrier dissolves and opens the passage.

### Interaction rules
- The player interacts with lamps using a dedicated prompt for this mini-game.
- Suggested prompt text for idle lamps: `Направить свет`.
- Suggested prompt text after selecting a source/relay lamp: `Соединить свет сюда`.
- First, the player activates the current lit endpoint lamp.
- That lamp enters “selected for connection” state and emits a short local light column in its channel color.
- Then the player activates the next lamp in the chain.
- If the connection is valid, a beam is created and the next lamp becomes the new lit endpoint.
- Already activated lamps cannot be selected again.
- Invalid targets should be rejected gracefully with no broken state.
- Cross-side linking is allowed technically, but only the defined correct sequence solves the puzzle.

### Required implementation direction
Build the system as reusable puzzle logic, not as a one-off hardcoded Level_01 hack.

### Minimum architecture
Create reusable concepts such as:
- `LightRoutePuzzleController`
- `LightRouteLamp`
- `LightRouteBeam`
- `LightRouteBarrierGate`

### Required configuration model
The system must support inspector-driven references for:
- source lamps;
- destination lamps;
- relay lamps;
- correct channel paths as ordered arrays of lamp references/IDs;
- channel color definitions;
- completion barrier reference.

### Visual state requirements
Every lamp must clearly show one of these states:
- inactive;
- currently lit / available endpoint;
- selected;
- already linked/locked;
- completed destination.

### Beam requirements
- Use curved or spline-like beams.
- Beam thickness should be readable but not oversized.
- Colors must be more thematic than the temporary technical red/blue.
- Favor warm magical hues that fit Level_01.
- Beams must update cleanly and not flicker.

### Barrier behavior
- Barrier exists closed at puzzle start.
- On full success it dissolves/fades and disables collision.
- Completion must be one-time and robust.

### Acceptance criteria
- Both channels can be routed only through valid sequential activation.
- Already activated lamps cannot be re-used.
- The intended solution from screenshot 4 works.
- Invalid actions do not soft-lock the puzzle.
- Barrier opens only when both channels are complete.
- Puzzle logic is reusable and inspector-configurable.

---

## Slice 3 — Lamp puzzle UX / prompt / state polish
### Task
Polish readability and clarity of the new lamp mini-game.

### Required work
- Add dedicated prompt text for this puzzle.
- Ensure source lamps, relay lamps, and end lamps are visually distinguishable if needed.
- Add clear feedback for:
  - successful connection;
  - invalid target;
  - completed path;
  - total puzzle completion.
- Add a short colored vertical light column on the currently selected endpoint lamp.
- Make sure active beams and active lamp colors are visible from normal gameplay camera height.

### Acceptance criteria
- A first-time player can understand the interaction flow.
- Lamp state readability is strong without needing debug explanation.

---

## Slice 4 — Portal structural VFX rework
### Task
Refactor the portal so it matches the intended structure more closely.

### Required target behavior
1. Keep a spiral vortex only in the lower third of the portal.
2. Build **5 spiral vertical sleeves** using the same particle family.
3. Sleeves should emerge from the portal center region and reach toward the portal rim.
4. Sleeves rotate counterclockwise.
5. Between sleeves, place sparse drifting particles with subtle motion.
6. Build a particle-based rim/halo using the same visual language.
7. Preserve a magical galaxy-like interior feel.

### Performance rule
If this design becomes too heavy or unstable:
- remove the current wrong upward-rising spiral particles rather than keeping incorrect behavior.
- prefer a cleaner, cheaper correct read over a noisy expensive incorrect read.

### Acceptance criteria
- Portal no longer reads as just particles rising upward.
- The five-sleeve structure is visually readable.
- Portal interior reads like a magical galaxy field.
- Performance remains acceptable and visually coherent.

---

## Slice 5 — Cloud volume refinement
### Task
Improve cloud volume read without breaking the current warm stylized direction.

### Required work
- Preserve current color family.
- Improve structural volume/parallax.
- Increase soft volumetric read.
- Avoid noisy/speckled look.
- Keep shadow/GI disabling behavior correct for generated cloud parts.

### Acceptance criteria
- Clouds read more clearly as soft stylized volume.
- No regression into flatness or heavy noise.

---

## Slice 6 — Finale overlay text layout and readability pass
### Task
Finish the finale text system so it is truly ready for approved narrative text.

### Required work
- Compute text safe area from vine frame geometry.
- Use **80%** of the inner frame area for text.
- Support **up to 6 lines**.
- Increase text size.
- Prevent clipping for the approved Level_01 finale text.
- Add subtle text depth/volume styling (for example a soft shadow, glow, bevel-like treatment, or layered outline) without making it gaudy.
- Keep the overlay reusable for later levels.

### Acceptance criteria
- Text stays fully inside the frame.
- Text is larger and easier to read.
- Approved Level_01 text fits cleanly without truncation.
- Overlay remains reusable.

---

## Slice 7 — Finale overlay animation polish
### Task
Polish final overlay pacing after layout corrections.

### Required work
- Re-check reveal timing after the larger 6-line text layout.
- Keep reveal readable and emotionally soft.
- Closing animation should remain slower and graceful.
- Ensure reveal does not look abrupt or broken after the layout resize.

### Acceptance criteria
- Finale pacing feels intentional and readable.
- Larger text layout does not break reveal behavior.

---

## Slice 8 — Integrated validation pass
### Task
Run a final validation pass after all fixes.

### Required checks
- Lamp puzzle works from start to finish.
- Barrier opens correctly.
- Puzzle cannot be soft-locked by invalid interactions.
- Spawn/start collision snag is gone.
- Portal activates and reads correctly.
- Finale text fits, reveals, and closes correctly.
- Whole Level_01 flow still works.

### Acceptance criteria
- No obvious regressions in the corrected systems.
- Level_01 is materially closer to external-review readiness.

---

## Slice 9 — Final report
### Task
Create/update an implementation report documenting:
- baseline;
- files changed;
- slice completion;
- tests performed;
- graphical QA actually performed vs not performed;
- performance actually measured vs not measured;
- remaining manual QA.

### Acceptance criteria
- Report is honest, specific, and complete.

---

## Final acceptance target
This pass is considered successful when:
1. the player no longer snags near spawn;
2. the side island has a working lamp-routing mini-game with barrier unlock;
3. the portal reads as an intentional magical galaxy portal rather than an unfinished spiral particle lift;
4. clouds read more volumetrically;
5. finale text is larger, unclipped, 6-line capable, and readable inside the frame;
6. Level_01 is ready for the next external review round.
