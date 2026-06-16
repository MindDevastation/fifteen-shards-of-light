# Level 01 90–95 Corrective Pass Implementation Report

## PR and remote facts
- PR number: 85.
- PR URL: https://github.com/MindDevastation/fifteen-shards-of-light/pull/85
- PR state: open, per prompt and public GitHub page.
- Mergeable: true, per prompt.
- Actual base branch: `feature/implement-level-01-finale-and-portal-transitions`.
- Actual head branch: `feature/complete-level-01-corrective-pass`.
- Previous reviewed remote SHA: `2bffb12c795e7cb7d796cae64a73fbed4d562eb8`.
- New final remote SHA after this local pass: NOT VERIFIED. This checkout has no configured Git remote, and local commits have not been proven present on GitHub.
- Actual remote commit count visible before this pass: 2 commits.
- Actual remote commit list visible before this pass: `5c1f629` and `2bffb12` from the public PR page.
- Local branch: `work`.
- Local starting HEAD for this final pass: `c69954afcd1c2c6668274f116ce547e4ccc4af89`.

## Local development commits in this final pass
- `69c9744` — Recover safely when finale overlay cannot open.
- `6387b0a` — Enforce player control ownership during portal entry.
- `6e33fe7` — Prevent stale scene transition callbacks.
- `a637927` — Reduce cloud surface noise frequency.
- `c46b677` — Use fox alpha mask for hover state.
- `879bebc` — Align portal motes with vertical spiral plane.
- `7c7ac35` — Remove obsolete cloud material resource.
- `ae648d0` — Synchronize corrective pass report with remote PR.
- `974d674` — Complete final PR 85 corrective audit.
- `3bddc24` — Polish final Level 01 portal transition safeguards.

## Current approved finale flow
1. Barrier opens.
2. Landmark trigger activates.
3. Player enters Landmark trigger.
4. Beam appears.
5. Portal materializes.
6. Player retains controls.
7. Portal becomes interactable.
8. Player presses `E`.
9. Final overlay opens.
10. Player closes overlay.
11. Closing animation completes and emits `closed`.
12. Persistent transition starts immediately.
13. Level_02 loads under opaque veil.
14. Veil fades out.

## Targeted fixes completed
### Soft-lock on overlay open failure
`Level01FinaleController` now treats `show_finale_text()` as a boolean open request. If it returns false, the controller disconnects any pending `closed` connection and recovers to `PORTAL_READY`, restoring controls only if the finale owned the lock and canceling portal confirmation.

### Player controls ownership
`LevelPortal` now has `_controls_locked_by_portal`. Direct legacy portal entry locks/unlocks controls through portal-owned helpers. Gated Level_01 entry does not set this flag, so portal failure does not re-enable controls owned by `Level01FinaleController`; instead it emits `transition_failed` for the controller to recover.

### SceneTransition stale callbacks
`SceneTransition.transition_to()` now reserves `_busy` and starts `_run_transition()` deferred. `LevelPortal` checks `transition_to()` result before connecting callbacks and validates `scene_path` in transition callbacks. `transition_finished` now carries `scene_path`.

### Cloud frequency correction
Cloud noise was reduced from high frequency to `frequency = 0.014`, `fractal_octaves = 3`, `fractal_lacunarity = 1.8`, `fractal_gain = 0.44`, `generate_mipmaps = true`. The shader now uses two large low-frequency samples (`UV * 0.48`, `UV * 0.82`) and `noise_influence = 0.045`.

### Alpha-aware fox hover
`FoxConfirmButton` now samples its alpha click mask for hover state. Rectangular `mouse_entered` only triggers alpha-aware sampling; transparent corners remain idle, visible fox pixels hover, and mouse motion inside the control updates state.

### Portal particle orientation
Portal motes were aligned to the portal surface transform. Ring emission axis is now local `Z`, ring height is shallow, visibility AABB is flattened in depth, and runtime orbit rotates around local `Z` for a vertical doorway-plane spiral rather than horizontal foot-level tornado.

### Obsolete cloud material removal
The obsolete first-pass shared cloud material resource was deleted after checking for references. The active cloud material is `resources/environment/stylized_cloud_material.tres`.

## Persistent transition implementation
- `SceneTransition` remains a small autoload with `transition_to(scene_path, fade_in_duration, fade_out_duration)`.
- The veil fades to alpha 1.0 before scene change, remains opaque during replacement, waits at least two process frames plus camera-or-timeout, then fades out.
- On failure, it fades back to transparent and emits `transition_failed(scene_path, error_code)`.

## Portal gate implementation
- `LevelPortal` keeps reusable public API: `target_scene_path`, `entry_mode`, `activate()`, `can_player_interact(player)`, `interact(player)`.
- Level_01 uses `entry_mode = INTERACT` and `require_entry_confirmation = true`.
- Legacy levels keep `require_entry_confirmation = false` and direct entry behavior.
- `WAITING_FOR_CONFIRMATION` and `ENTERING` prevent repeated `E` from starting duplicate overlays or transitions.

## Cloud diagnosis status
- Confirmed by static inspection: baked cloud BaseColor and MetallicRoughness textures exist in the cloud asset folder; no separate normal map file was found.
- Likely root cause: embedded baked material channel contribution from imported GLB/material textures.
- Not fully confirmed: graphical before/after validation was not performed in this container.
- Final material: shared unshaded stylized cloud shader, no normal map, no metallic, no AO, no specular, no per-frame traversal, cloud shadow casting off, GI off.

## Automated/static tests actually run
- `git status --short --branch --untracked-files=all`.
- `git diff --check`.
- Full local diffs reviewed before commits.
- `godot --headless --path . --quit` completed with exit code 0 after the final pass.
- `godot --headless --editor --path . --quit` was attempted with a 45 s timeout and reached import work before timing out; this is recorded as an environment/time limitation, not a gameplay validation pass.
- Static search for old reversed portal `smoothstep` patterns returned no code hits.
- Static search for obsolete first-pass cloud material references returned no production code/resource hits after deletion.

## Graphical/runtime tests not performed
No graphical gameplay QA was performed in this non-interactive headless environment. Do not treat cloud visual quality, portal motion readability, exact control timing, Level_02 transition concealment, or FPS gates as confirmed.

## Manual QA still required
### Full flow
- Shard_01 → Shard_02 order.
- Shard_02 → Shard_01 order.

### Finale
- Landmark trigger does not show overlay.
- Player moves during beam and portal materialization.
- `E` opens overlay and does not start transition immediately.
- Repeated `E` is ignored.
- Close animation completes fully.
- Transition starts no later than 0.10 s after `closed`.

### Failure
- Overlay open failure does not lock Player.
- Transition failure restores Player if the owner locked controls.
- Prompt returns and portal can be reused.

### Fox button
- Transparent corner: no hover.
- Visible fox: hover.
- Keyboard focus: idle texture.
- Pressed texture and offset work.

### Clouds
- No black spots.
- No high-frequency grain.
- No stone/plastic appearance.
- Natural gradient and no UV-island seams.

### Portal
- Spiral reads clockwise.
- Particles rotate in vertical plane, not horizontal tornado.
- Light restrained, no clipping, no opaque sphere impression.

### Transition and performance
- Level_02 first frame hidden by opaque veil.
- Veil fades out after camera readiness.
- Player moves in Level_02.
- FPS gates measured on target hardware before claiming pass.

## Merge confirmation
- No merge was performed.
- Auto-merge was not enabled.
