# Project Performance Optimization Report

Branch: `perf/project-wide-60fps`
Base SHA: `dcb148e6761e0d4eff148051fd9ceda0ff698098`
Target: 1280×720 fullscreen, standalone rendered build, target user hardware.
Frame budget: 60 FPS = 16.67 ms/frame.

## Measurement honesty

Codex environment has no rendered GPU target. Headless checks can validate script loading and project startup, but cannot prove GPU FPS.

**Stable 60 FPS:** NOT VERIFIED ON TARGET HARDWARE.

## Benchmark protocol

For before/after comparison on target hardware:

1. Use the same standalone debug or release build mode for both runs.
2. Disable screen recording and unrelated overlays.
3. Use 1280×720 fullscreen.
4. Warm up for 5 seconds.
5. Capture for 30 seconds.
6. Repeat three times.
7. Use the median run.
8. Test StartScene, Level_01, a middle level, Level_10, Level_15, FinalScene, DevLevelMenu closed/open, SoulShard idle/charge/burst, reward overlay, and SoulOrb return.

If no preserved pre-optimization executable exists, the user-observed 15–20 FPS baseline is a coarse observation, not a profiler-grade baseline.

## Optimization ledger

| ID | Bottleneck | Evidence | Files | Change | Risk | Visual impact | Before metrics | After metrics | FPS gain | Frame-time gain | Status | Verification source |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| PERF-INST-001 | Lack of repeatable target-hardware capture | Preflight showed no rendered GPU in Codex environment | `scripts/dev/performance_probe.gd`, this report | Added disabled-by-default CSV probe with 5s warm-up and 30s capture support | Low | None | Not available in Codex | Pending user target run | Not claimed | Not claimed | Implemented | Headless/static checks pending |

| PERF-CPU-001 | Decorative firefly clusters processing every rendered frame while active | Static audit found `FireflyCluster3D._process`; decorative drift/flicker is visually tolerant of 30 Hz updates | `scripts/vfx/firefly_cluster_3d.gd` | Added configurable `visual_update_hz` defaulting to 30 Hz and accumulator-gated transform/flicker updates | Low | Expected none/indistinguishable; no particle count or composition change | No rendered metrics in Codex | Pending user target run | Not claimed | Not claimed | Implemented | Headless/static checks pass |
| PERF-CPU-002 | SoulShard idle presentation updates every rendered frame | Static audit found `SoulShard._process` runs idle presentation while idle | `scripts/soul/soul_shard.gd` | Kept charge animation full-rate, gated idle hover/glow to ~30 Hz, and disabled processing after burst/collection states where tweens/particles continue independently | Low | Expected none/indistinguishable for idle decorative motion; charge/burst timing preserved | No rendered metrics in Codex | Pending user target run | Not claimed | Not claimed | Implemented | Headless/static checks pass |
| PERF-CPU-003 | Overlay sequence setup repeated avoidable allocation/work | Static audit found reward overlay rebuilds frame targets and click masks during sequence/resizes | `scripts/ui/shard_reward_overlay.gd` | Cached frame targets per viewport, reused click mask, and reduced repeated viewport queries during text preparation | Low | None | No rendered metrics in Codex | Pending user target run | Not claimed | Not claimed | Implemented | Headless/static checks pass |
| PERF-CPU-004 | Camera scanned UI tree every rendered frame for blocking overlays | Static audit found `camera_controller.gd` recursively checks named controls from `_process()` via `_update_mouse_mode()` | `scripts/player/camera_controller.gd` | Cached DevLevelMenu panel and refreshed blocking UI state on input plus a 0.25s poll instead of every frame | Low | None; worst-case mouse-mode response delay up to 0.25s for non-input overlay state changes | No rendered metrics in Codex | Pending user target run | Not claimed | Not claimed | Implemented | Headless/static checks pass |
| PERF-VFX-001 | SoulOrb decorative rings/petals/glow updated every rendered frame | Static audit found `SoulOrb_Base._process` updates decorative-only orb visuals each frame | `scripts/soul/soul_orb_base.gd` | Added configurable 30 Hz visual update gate while preserving accumulated animation time | Low | Expected none/indistinguishable for decorative orb motion | No rendered metrics in Codex | Pending user target run | Not claimed | Not claimed | Implemented | Headless/static checks pass |
| PERF-VFX-002 | World SoulOrb idle hover processed every rendered frame and still entered callback after collection | Static audit found `SoulOrb_World._process` hover loop | `scripts/soul/soul_orb_world.gd` | Added 30 Hz hover update gate and explicitly disables processing when collected | Low | Expected none/indistinguishable for idle hover | No rendered metrics in Codex | Pending user target run | Not claimed | Not claimed | Implemented | Headless/static checks pass |
| PERF-DEV-001 | Debug FPS stdout printing can add avoidable runtime I/O noise | `project.godot` had `settings/stdout/print_fps=true`; this is diagnostic output, not gameplay/UI | `project.godot` | Disabled stdout FPS printing for normal runs; performance probe replaces it for explicit benchmark captures | Low | None; no in-game display changed | No rendered metrics in Codex | Pending user target run | Not claimed | Not claimed | Implemented | Headless/static checks pass |

## Tier B proposals requiring approval

No Tier B visual-risk change has been applied. Renderer switches, global shadow changes, visible VFX reductions, texture downscaling, mesh simplification, physics tick changes, and visual composition changes remain proposal-only until user approval.

## Physics and collision audit notes

- Existing collection flows already disable monitoring/monitorable state after shard/orb/portal interaction where appropriate.
- No physics tick, player controller movement, collision shape simplification, or collision layer/mask change was applied in Codex because behavior-identical gains were not provable without rendered/runtime scene profiling.
- Physics optimization status: PASS BY STATIC REVIEW for avoiding risky unmeasured edits; target-hardware profiler should still capture physics frame time and active collision pairs.

## Rendering and lighting audit notes

- SoulShard and FireflyCluster local glow lights have shadows disabled in existing scenes.
- Static audit found multiple shadow-enabled lantern/level lights, including Level_01/Main_Island omni lights. These are potential GPU hotspots, but changing shadows/lights is Tier B and was not applied without visual approval.

### Tier B proposal: reduce simultaneous shadow-casting local lights

CHANGE: Audit Level_01/Main_Island lantern/omni lights and test disabling shadows or reducing shadow range on non-critical local lights.

MEASURED BOTTLENECK: Not measured in Codex; static evidence shows several shadow-enabled OmniLight3D nodes in the Level_01 environment.

EXPECTED GAIN: Potentially significant on low-end GPUs if Forward Plus shadow maps are the bottleneck; exact gain not claimed.

VISUAL COST: Possible loss of local shadow depth around lantern/ruin lighting.

TECHNICAL RISK: Medium; requires A/B screenshots/video and target hardware GPU-time comparison.

RECOMMENDATION: WAITING FOR USER VISUAL APPROVAL after target benchmark identifies GPU/shadow bottleneck.

## Validation summary

Commands run in Codex after optimization slices:

- `git diff --check`
- `godot --headless --path . --check-only --quit`
- `timeout 30s godot --headless --path . --quit`

Results: PASS in the Codex headless environment after final changes.

## Scene/regression coverage available in Codex

Headless startup confirms project load/check-only success, but does not prove rendered visuals, controls, collisions, reward overlay timing, SoulOrb return, or GPU frame time. The following remain required on target hardware:

- StartScene rendered startup.
- Level_01 movement, jumping, camera, interaction prompt, SoulShard idle/charge/burst, reward overlay, SoulOrb return, and level transition.
- Representative middle level and heaviest identified level.
- Level_15 and FinalScene.
- DevLevelMenu closed/open.
- Visual parity for glow, shadows, transparency, particles, Line2D overlay, and lighting.

## Final Codex verdict

- Static safety: PASS
- Gameplay safety: PASS BY AVAILABLE HEADLESS TESTS
- Low-risk optimization pass: COMPLETE
- Visual-risk changes: NOT APPLIED WITHOUT APPROVAL
- Performance instrumentation: READY
- CPU optimization: PASS BY CODE / STATIC REVIEW
- GPU optimization: PARTIAL; Tier B shadow/renderer/visual proposals require target profiling and approval
- Physics optimization: PASS BY STATIC REVIEW; no risky physics changes applied
- Stutter reduction: PARTIAL; overlay/probe/cache changes reduce avoidable runtime work, but target benchmark is required
- Stable 60 FPS: NOT VERIFIED ON TARGET HARDWARE
- Merge: WAIT FOR USER BENCHMARK

## Pre-Benchmark Corrective Pass

### PR #80 reconciliation

- Reported local SHA from previous handoff: `f86b181ac23375011852e08d837dec5be218a4fd`.
- Actual GitHub head before this corrective pass, per user-provided PR state: `20afb056f9bf1a34048db653ccb86af11f17747c` on `feature/conduct-project-wide-performance-audit` with 1 commit.
- Local checkout before this corrective pass: branch `work`, SHA `840883793f9f86fb8dbca1b121e77ec01b256de2`.
- Remote/GitHub re-read in Codex: unavailable because this checkout has no configured Git remote and `gh pr view 80` returned no data.
- Content equivalence: local branch contains the same file set described in PR #80, but exact GitHub tree equivalence could not be proven from Codex without remote access.
- Missing commits: previous multi-commit local history was represented locally as a single squashed commit before this corrective pass.
- Missing files: none detected in local PR content; the expected report, probe, and low-risk script/config edits are present.
- Selected authoritative state: current local working tree on top of the PR #80 content, with this corrective pass applied.

### Camera recursion fix

The previous camera change still allowed `_unhandled_input()` to call `_is_blocking_ui_open()`, which refreshed blocking UI state and could recursively scan named controls during high-frequency mouse motion.

Corrective behavior:

- `_unhandled_input()` now reads cached `_blocking_ui_open` only.
- Camera code caches direct references to DevLevelMenu, `UILayer/PoemRewardUI`, `UILayer/EndingOverlay`, and `UILayer/ShardRewardOverlay`.
- Cached references refresh when the current scene changes or when cached instances become invalid.
- Blocking UI state is refreshed from direct cached references, not recursive `get_children()` traversal.
- A low-frequency forced reference refresh remains as a fallback; ordinary overlay visibility response is immediate because direct cached visibility is read every frame without recursion.

### Visual accumulator correction

Corrected the newly introduced visual accumulators in:

- `scripts/soul/soul_orb_base.gd`
- `scripts/soul/soul_orb_world.gd`
- `scripts/soul/soul_shard.gd`
- `scripts/vfx/firefly_cluster_3d.gd`

The selected strategy is simple accumulated-time consumption:

```gdscript
var visual_delta := _visual_update_accumulator
_visual_update_accumulator = 0.0
```

For absolute-time visuals, the accumulator is reset to `0.0` after the update threshold. This avoids double-counting a preserved remainder while keeping animations time-based.

### PerformanceProbe overhead correction

Capture-time overhead was reduced by replacing per-frame formatted CSV strings with numeric sample arrays. CSV string formatting is deferred until `_write_csv()`.

- Frame time source for authoritative percentiles and 1% low: `delta * 1000.0`.
- `Engine.get_frames_per_second()` remains a secondary smoothed FPS sample only.
- Node/diagnostic counting is optional and runs no more than once per second.
- 1% low method: `1000 / average(slowest ceil(sample_count * 0.01) frame times)`.
- Summary metrics written/printed: sample count, average FPS from frame times, median frame time, p95, p99, 1% low FPS, minimum FPS, maximum frame time, average process time, average physics time, average draw calls, and diagnostic max counts.

### Probe launch instructions

Dev-only hotkey workflow:

1. Run the standalone build or editor run on target hardware.
2. Navigate to the scene/test phase to benchmark.
3. Press `F8` to start the default 5-second warm-up plus 30-second capture.
4. Wait for the console message `PerformanceProbe wrote ...`.
5. Repeat `F8` for a second or third capture; each run clears stale samples and writes a new timestamped CSV.
6. CSV files are written under `user://performance` and include scene and phase labels in the filename.

This workflow is disabled by default until the user presses `F8`; it does not add a production autoload.

### 30 Hz visual gating impact reassessment

At the reported 15–20 FPS, each rendered frame is already about 50–66 ms, which exceeds the 33.3 ms interval for a 30 Hz visual gate. Therefore these gates do not skip most frames at the current reported baseline.

Interpretation:

- They may reduce CPU work and improve headroom once the game is near or above 60 FPS.
- They may reduce unnecessary decorative work in lighter scenes.
- They are not sufficient evidence that the current 15–20 FPS bottleneck has been solved.
- Target-hardware rendered profiling remains required to identify whether the main bottleneck is GPU, draw calls, shadows, overdraw, physics, loading, or script.

### Diagnostic counts and likely hotspot candidates

Static scene text counts from Codex before target runtime capture:

| Counter | Static count / availability |
| --- | --- |
| FireflyCluster3D scenes | 1 source scene |
| Total MeshInstance3D nodes in `.tscn` files | 62 |
| SoulOrb/SoulShard named petal nodes in `.tscn` files | 52 |
| Light nodes in `.tscn` files | 30 |
| Explicit `shadow_enabled = true` entries | 9 |
| Particle nodes | 4 |
| Line2D nodes | 6 |
| Runtime draw calls | Available from `PerformanceProbe` CSV |
| Runtime objects drawn | Available from `PerformanceProbe` CSV |
| Runtime visible meshes/lights/shadow lights/transparent materials | Available from `PerformanceProbe` once-per-second diagnostic counts |

Candidates for target A/B testing, not applied automatically:

| Candidate | Current count | Expected bottleneck type | Risk | Recommended A/B test |
| --- | --- | --- | --- | --- |
| Shadow-enabled local lights | 9 static `shadow_enabled = true` entries | GPU shadow-map cost / Forward Plus lighting | Medium visual risk | Capture before/after with selected non-critical local shadows disabled in a throwaway branch; compare screenshots and GPU/frame-time CSV |
| Many decorative MeshInstance3D VFX nodes | 62 static mesh nodes; runtime visible count via probe | Draw calls / object submission | Medium if converted visually incorrectly | Measure visible mesh and draw-call counts during Level_01, shard charge, and overlay; consider MultiMesh only after metrics |
| Transparent VFX and UI lines | 4 particle nodes and 6 Line2D nodes statically; runtime transparent material count via probe | Overdraw / blending | Medium visual risk | Capture overlay and burst phases; compare p95/max frame time and visual parity before reducing any effect |
| SoulOrb/SoulShard petal/mote nodes | 52 static named petal nodes | Script transform cost and draw-call cost | Low-to-medium | Use probe visible counts and draw calls during orb/shard scenes; consider pooling/MultiMesh only with A/B screenshots |

### Remaining Tier B approvals

Still not applied without target metrics and user approval:

- renderer switch;
- global shadow disabling;
- light removal;
- texture reduction;
- mesh simplification;
- visible VFX or particle-count reduction;
- physics behavior changes;
- resolution reduction.

### Target benchmark status

Corrective pass improves benchmark readiness and removes a real input-path CPU regression, but target-hardware rendered benchmark is still required before claiming stable 60 FPS.
