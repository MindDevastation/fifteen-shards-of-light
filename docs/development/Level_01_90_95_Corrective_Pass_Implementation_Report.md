# Level 01 90–95 Corrective Pass Implementation Report

## PR 86 remote facts
- PR number: 86.
- PR URL: https://github.com/MindDevastation/fifteen-shards-of-light/pull/86
- PR state at preflight: open.
- Mergeable at preflight: true, per task prompt.
- Base branch: `feature/implement-level-01-finale-and-portal-transitions`.
- Head branch: `feature/complete-level-01-corrective-pass-b4oa38`.
- Initial reviewed remote SHA: `f5863a1ef85dd01fa1a7ff6fe738cebead4e6a21`.
- Public PR page at preflight showed 2 commits and head commit `c75ca81` (`Document final corrective pass validation results`) plus merge commit `f5863a1`.
- Final remote SHA after this local pass: NOT VERIFIED. This container has no configured Git remote, so these local commits could not be pushed or re-read from GitHub as remote history.
- Local branch: `work`.
- Local starting HEAD for this PR 86 pass: `88854b6739ea1cec9ebda887d71b972f53fcb06d`.

## Local development history for this pass
- `dfb9406` — Recover portal flow when target scene path is invalid.
- `8e9e59c` — Remove obsolete reward button state handlers.
- `5806ca5` — Clean up paired scene transition callbacks.
- `8369cfb` — Update corrective pass report for PR 86.
- This validation note commit follows those local commits.

## Approved finale flow preserved
1. Barrier opens.
2. Landmark trigger activates.
3. Beam appears.
4. Portal materializes.
5. Player retains controls.
6. Player presses `E` at portal.
7. Final overlay opens.
8. Player closes overlay.
9. Close animation completes.
10. Persistent transition starts.
11. Level_02 loads under opaque veil.
12. Veil fades out.

## Empty target recovery
- Empty `target_scene_path` now uses the same terminal failure path as other transition failures.
- Portal sets itself into `ENTERING`/loading before validation, then calls `_handle_transition_result(player, ERR_INVALID_PARAMETER)` for an empty target.
- Direct legacy portal entry restores only portal-owned controls through `_unlock_player_controls_if_owned()`.
- Gated Level_01 entry does not unlock controls in `LevelPortal`; it emits `transition_failed(player, error)`, allowing `Level01FinaleController` to recover finale-owned controls and return to `PORTAL_READY`.
- Interaction and prompt restoration are handled by `_handle_transition_result()`.

## Callback lifecycle
- `LevelPortal` stores the transition service plus paired failed/finished Callables as fields.
- `_clear_transition_callbacks()` disconnects both callbacks if connected and resets stored Callables/service.
- Cleanup runs before every new transition request, before local fallback scene-change path, on transition failure, on transition success, on immediate transition errors, in `_handle_transition_result()` for errors, and in `_exit_tree()`.
- `SceneTransition.transition_to()` still reserves `_busy` and starts transition deferred, so callbacks can be connected after `OK` without racing the first signal.
- Callback handlers keep `scene_path` validation, but stale same-path retry callbacks are removed by paired cleanup rather than relying on path checks alone.

## Dead code cleanup
Removed obsolete `ShardRewardOverlay` button-state fields and handlers after migration to reusable `FoxConfirmButton`:
- `_button_mouse_inside`
- `_button_has_focus`
- `_on_confirm_button_mouse_entered`
- `_on_confirm_button_mouse_exited`
- `_on_confirm_button_down`
- `_on_confirm_button_up`
- `_on_confirm_button_focus_entered`
- `_on_confirm_button_focus_exited`
- `_update_button_mouse_inside`
- `_apply_button_visual_state`

`ShardRewardOverlay` still owns its public API (`play_reward`, `play_return_to`, `reset_overlay`, `confirmation_requested`, `return_completed`) and controls only enable/disable, base position, confirmation event, and existing external press feedback.

## Code-level regression audit expectations
- Overlay `show_finale_text() == false`: controller disconnects `closed`, restores finale-owned controls, cancels portal confirmation, and returns to `PORTAL_READY`.
- Empty target: portal emits failure via `_handle_transition_result()`, restores interaction/prompt, and does not leave controller in `TRANSITIONING` after `transition_failed` is delivered.
- `SceneTransition.transition_to() == ERR_BUSY`: callbacks are not stored/connected; portal handles error and recovers.
- `change_scene_to_file()` error: transition service emits failed path; portal clears paired callbacks and handles result once.
- Failure then retry success: old finished callback is disconnected during failure cleanup before retry.
- Failure then retry failure: old failed/finished callbacks are cleaned before new attempt.
- Repeated `E` in `WAITING_FOR_CONFIRMATION`: `can_player_interact()` is false because portal is not `ACTIVE`.
- Repeated confirm click during close: overlay guards with `_closed_emitted`/`_can_confirm`.
- Portal exits tree: `_exit_tree()` clears transition callbacks.

## Static/headless tests actually performed
- `git status --short --branch --untracked-files=all`.
- `git diff --check`.
- Full local diffs reviewed before commits.
- Static search for obsolete reward button handlers/fields.
- Static search for transition callback cleanup fields/method.
- Static search for invalid target path handling.
- `godot --headless --path . --quit` passed with exit code 0 after the PR 86 final pass.
- `timeout 60s godot --headless --editor --path . --quit` reached import work and timed out at approximately 43%; this is recorded as an environment/import limitation, not gameplay validation.

## Editor import / graphical tests
- `godot --headless --editor --path . --quit` may remain environment-limited due import time; do not treat timeout as gameplay failure.
- No graphical gameplay QA was performed in this container.
- Do not claim graphical cloud validation, portal motion validation, FPS gates, Level_02 first-frame concealment, or 90–95 quality without runtime evidence.

## Manual QA still required
### Full flow
- Shard_01 → Shard_02.
- Shard_02 → Shard_01.

### Finale
- Landmark trigger does not open overlay.
- Player moves during beam and materialization.
- `E` at portal opens overlay and does not transition immediately.
- Repeated `E` does not create a second overlay.
- Close animation completes fully.
- Transition starts after `closed`.

### Failure simulation
- Empty target does not lock Player.
- Invalid path does not lock Player.
- Failed load returns prompt.
- Retry after failure works.
- Success callback emits once.

### UI
- Transparent fox corner does not hover.
- Visible fox pixel hovers.
- Keyboard focus shows idle texture.
- Reward overlay has no competing old button-state handlers.

### Visual / transition / performance
- Cloud has no black spots or high-frequency grain.
- Portal motes are vertical and portal spiral reads clockwise.
- Level_02 first frame is concealed.
- Measure average FPS, 1% low, and p95 frame time on target hardware.

## Merge confirmation
- No merge was performed.
- Auto-merge was not enabled.
