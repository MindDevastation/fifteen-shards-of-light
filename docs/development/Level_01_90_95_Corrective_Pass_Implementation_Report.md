# Level 01 90–95 Corrective Pass Implementation Report

## PR facts
- PR number: #85.
- PR URL: https://github.com/MindDevastation/fifteen-shards-of-light/pull/85
- PR base reported by review prompt: `feature/implement-level-01-finale-and-portal-transitions`.
- PR head branch reported by review prompt: `feature/complete-level-01-corrective-pass`.
- Reviewed remote head SHA from review prompt: `5c1f6297e282e8295cef645be1850901716f964e`.
- Local branch in this checkout: `work`.
- Local baseline before this follow-up: `baa18b9a559cd50e38d01391bcb498c4b41c063d`.
- Remote verification: unverified in this container because no Git remote is configured and `gh pr view 85` could not return PR data.

## New commits after review
- `aaa126f` — Add gated portal entry confirmation flow.
- `852893d` — Move Level 01 final text to portal interaction.
- `6d91154` — Persist portal transition veil across scene loading.
- `a18c605` — Correct portal spiral shader math and direction.
- `d2e0c8c` — Polish woven light portal materialization.
- `6db69cd` — Build two-sided rectangular vine finale frame.
- `ef24bba` — Harden finale text layout and progressive reveal.
- `d6e1b8c` — Fix reusable fox button focus hover and hit mask.
- `f6015f7` — Refine finale overlay opening and closing timing.
- `8c7536a` — Complete verified soft cloud material correction.
- This report update commit follows these changes.

## Replaced finale flow
The previous flow has been replaced. Landmark trigger no longer opens final text and no longer starts transition.

Current intended flow:
1. Barrier opens.
2. Landmark trigger becomes active.
3. Player enters Landmark trigger.
4. Landmark beam appears.
5. Portal materializes.
6. Portal becomes interactable.
7. Player retains movement control until portal interaction.
8. Player presses `E` at the portal.
9. Portal requests entry confirmation from `Level01FinaleController`.
10. Controller locks controls and opens final text overlay in the same frame.
11. Player closes overlay.
12. Overlay closing animation completes fully and emits `closed`.
13. Controller calls `portal.continue_entry_after_confirmation(player)`.
14. Persistent `SceneTransition` fades to opaque, changes to Level_02, waits briefly/camera-ready, then fades out.

## Portal gate implementation
- `LevelPortal` remains reusable and keeps `target_scene_path`, `entry_mode`, `activate()`, `can_player_interact(player)`, and `interact(player)`.
- Added `require_entry_confirmation`, `entry_confirmation_requested(player)`, `transition_failed(player, error_code)`, `transition_completed`, `WAITING_FOR_CONFIRMATION`, `continue_entry_after_confirmation(player)`, and `cancel_entry_confirmation(player)`.
- Level_01 sets `entry_mode = INTERACT` and `require_entry_confirmation = true`.
- Older portal instances keep `require_entry_confirmation = false`, preserving direct AUTO_ENTER/INTERACT transitions.
- Repeated input is ignored while the portal is waiting for confirmation or entering.

## Persistent transition
- Added `SceneTransition` autoload using `scenes/core/SceneTransition.tscn` and `scripts/core/scene_transition.gd`.
- Transition veil color is `Color(0.035, 0.020, 0.028, 1.0)`.
- Transition flow fades to opaque before `change_scene_to_file()`, keeps the veil across scene replacement, waits two process frames plus camera or timeout, then fades out.
- On scene change failure, the veil fades back to transparent and emits failure so the portal/controller can restore interaction and controls.
- Old portal-local `TransitionVeil` was removed from `LevelPortal.tscn` to avoid competing fade systems.

## Portal shader and visual correction
- Removed reversed-edge `smoothstep` from portal surface and ground ring shaders.
- Portal surface now uses one dominant slow clockwise angular sign, restrained alpha, and lower emission to avoid clipping/sphere impression.
- Added a soft `BackVeil` layer behind the surface.
- Portal light target is restrained to 0.50 energy with 4.25 range and shadows off.
- Portal materialization is staged: ground, rings, surface, back veil, particles, and light animate on different offsets.
- Portal motes are restrained to 22 particles with ring-like orbital emission settings.

## Finale overlay
- Finale overlay now uses two independent vines: left and right both emerge from the fox button area and form a rectangular frame without heart or crystal motifs.
- Branches are generated as short curved triple-line branches.
- Leaves are generated 8 per side, 16 total, with tangent-aligned rotation and scale variation.
- Progressive text reveal remains line-based and only enables the fox button after left vine, right vine, and text reveal complete.
- Closing now waits for text fade, vine retract/fade, atmosphere fade, and button fade before emitting `closed`.

## Text wrapping
- Finale text layout now uses word-aware wrapping with explicit newline support.
- Maximum output is 3 lines.
- Font size attempts 48 px target, 44 px fallback, then 40 px minimum scaled to viewport.
- Text safe width is clamped to keep text inside the vine frame and avoid array overflow.

## Fox button
- `FoxConfirmButton` explicitly applies the displayed texture for every state.
- Hover texture is used only when the mouse is inside the button.
- Keyboard focus uses the idle texture with warm tint and mild scale.
- The reusable button creates its own alpha-based click mask in `_ready()`.
- Duplicate click-mask/state responsibility was removed from `ShardRewardOverlay` while preserving its public API.

## Cloud diagnosis and correction
- Diagnostic status: partially verified by static asset inspection and material override design; not visually confirmed in a graphical gameplay run.
- Confirmed facts: the cloud asset has baked BaseColor and MetallicRoughness textures and no separate normal map file was found in `assets/nature/cloud_01`.
- Likely root cause remains embedded baked material channel contribution from the imported GLB/material textures rather than runtime brightness alone.
- Final correction replaces the flat beige material with a shared stylized cloud shader material using a soft blue-grey vertical gradient and low-frequency procedural noise.
- Cloud traversal remains one-time in `_ready()` with no per-frame material traversal.
- Cloud shadow casting and GI are disabled for cloud geometry.

## Actual automated tests
- `git status --short --branch`.
- `git diff --check`.
- `godot --headless --path . --quit` completed with exit code 0.
- Static search confirmed no old reversed portal smoothstep patterns remained.

## Graphical/runtime tests
- Not performed in this headless non-interactive container.
- No claims are made that runtime visual quality, FPS gates, exact control timing, portal motion readability, cloud black-spot removal, or Level_02 transition concealment are fully validated.

## Manual QA still required
- Full Shard_01 → Shard_02 and Shard_02 → Shard_01 playthroughs.
- Verify final overlay does not appear from Landmark trigger.
- Verify portal `E` opens final overlay and does not transition immediately.
- Verify repeated `E` and repeated click are ignored.
- Verify transition starts once and only after overlay closing completes.
- Verify Level_02 first frame is concealed by persistent veil.
- Verify load failure restores controls and prompt.
- Verify player movement in Level_02.
- Verify no hidden portal emitters/process before activation.
- Verify no cloud black spots or high-frequency grain in gameplay camera.
- Verify portal spiral is clearly clockwise in motion.
- Verify two vines visibly emerge from fox, leaves align to tangents, no crystals appear.
- Verify keyboard focus does not show hover texture and click mask is non-rectangular.
- Verify 1, 2, and 3 line text layouts at 1280×720 and 1920×1080.
- Capture FPS and frame-time metrics.

## Requirement audit
| Area | Status | Notes |
| --- | --- | --- |
| New portal-gated finale flow | implemented | Static/headless validated; manual runtime QA pending. |
| Portal confirmation gate | implemented | Reusable API preserved. |
| Persistent transition service | implemented | Headless startup validated; runtime transition QA pending. |
| Portal shader math/direction | implemented | Reversed smoothstep patterns removed from portal shaders. |
| Portal materialization polish | implemented | Staged tween and restrained light/particles. |
| Two-vine finale frame | implemented | Two independent path sets and 16 leaves. |
| Text layout hardening | implemented | Word-aware max-three-line layout. |
| Fox button state/click mask | implemented | Explicit texture assignment and component-owned mask. |
| Overlay timing refinement | implemented | `closed` emitted after close animation completion. |
| Cloud material correction | partial | Static correction done; graphical validation pending. |
| Runtime FPS gates | missing | Requires graphical gameplay benchmark. |
| Audio verification | not applicable | No audio changes. |

## Merge confirmation
- No merge was performed.
- Auto-merge was not enabled.
