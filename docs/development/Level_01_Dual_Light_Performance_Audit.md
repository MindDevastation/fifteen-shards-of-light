# Level 01 Dual Light Performance Audit

## 1. User-Reported Symptom

The reported symptom was that launching the game through the Godot Editor made the system feel more heavily loaded than World of Warcraft in a 30-player raid. Slice 8 treats that report as a real performance concern, not as an automatic editor-only explanation.

## 2. Test Environment

- Repository: `MindDevastation/fifteen-shards-of-light`.
- Initial branch: `work`.
- Required baseline: `5c4202679b224d2ca8269b4e5c60610c57643097`.
- Godot version: `4.6.2.stable.official.71f334935`.
- Runtime environment available here: headless Godot. Normal rendered gameplay, GPU counters, export templates, and OS-level per-process GPU telemetry were unavailable in this container.
- Baseline snapshots were saved outside the repository:
  - `/tmp/slice8_baseline_project_godot.txt`
  - `/tmp/slice8_baseline_level01_scene.txt`
  - `/tmp/slice8_baseline_runtime_inventory.txt`

## 3. Baseline Project Settings

Baseline `project.godot` had `settings/stdout/print_fps=true`, `display/window/vsync/vsync_mode=0`, and no explicit `application/run/max_fps`. That means the project defaulted to uncapped rendering with VSync disabled. In a rendered launch this can drive CPU/GPU to render as many frames as possible, independent of the small scope of the game.

## 4. Static Runtime Inventory

Repository-wide static inventory found continuous processing in gameplay, VFX, UI, soul, camera, and puzzle scripts. The performance-relevant permanent callbacks for Level 01 include the player/camera/soul/portal/barrier scripts plus the light stream scripts. The Moon and Sun stream scripts were the confirmed slice-specific per-frame hotspots because each stream used `_process(delta)`, called `get_viewport().get_camera_3d()` each frame, then updated every `MultiMesh` instance transform and color every rendered frame.

Static rendering inventory found:

- `GPUParticles3D`: selected-lantern particles, soul shard particles, portal particles, and environmental VFX.
- `MultiMeshInstance3D`: light streams and portal sleeve/rim motes.
- `WorldEnvironment`: Level 01 has glow enabled.
- Lights: Level 01 includes one `DirectionalLight3D` plus many lantern `OmniLight3D` and `SpotLight3D` nodes; runtime inventory observed 27 lights in the baseline Level 01 states and 25 shadow-enabled lights.
- Transparent/additive/depth-never materials: multiple VFX shaders use `blend_add` and `depth_draw_never`.
- Camera: Level 01 has one `Camera3D` under `CameraRoot/FollowCamera`.

Runtime inventory snapshots recorded Level 01 states A-J. Baseline headless inventory reported, for the simplified initial states before the editor import cache was warmed: 1043 total nodes, 5 processing nodes, 0 physics-processing nodes, 3 `GPUParticles3D`, 0 emitting `GPUParticles3D`, 8 `MultiMeshInstance3D`, 458 total `MultiMesh` instances, 19 `MeshInstance3D`, 27 `Light3D`, 25 shadow-enabled lights, 0 viewports/subviewports under the level tree, and 0 orphan nodes. After Godot imported assets, the richer runtime tree reported 1462 nodes, 23 processing nodes, 1 physics-processing node, 22 `GPUParticles3D`, 4 emitting particles, 10 `MultiMeshInstance3D`, 650 total `MultiMesh` instances, 100 `MeshInstance3D`, 31 lights, 25 shadow-enabled lights, and 0 orphan nodes after the wrong-reset state.

Full route stream counts:

- Moon route: 4 logical stream segments, each with 96 instances, for 384 Moon stream instances.
- Sun route: 5 logical stream segments, each with 96 instances, for 480 Sun stream instances.
- Both completed: 9 logical light stream segments, 864 light stream instances.

The presence of GPU particles was not classified as a problem by itself. The confirmed problem was uncapped rendered frames multiplying CPU-side light stream `MultiMesh` updates.

## 5. Baseline Performance Measurements

Headless baseline sampler used `Performance.get_monitor()` with warm-up and measurement windows. Because this environment is headless, render counters such as draw calls, primitives, and video memory returned `0` and are not GPU evidence.

Representative baseline headless result:

| Scenario | FPS avg | Frame ms | Process avg | Physics avg | Draw calls | Primitives | Node count | Orphans |
|---|---:|---:|---:|---:|---:|---:|---:|---:|
| StartScene idle | 144.93 | 6.90 | 0.000251 | 0.000064 | 0 | 0 | 26 | 0 |

This confirms that the baseline project was not capped at 60 FPS in the available runtime path. Headless FPS is not a GPU benchmark, but the lack of a cap is consistent with the reported high-load symptom on a rendered machine.

## 6. Editor vs Standalone Comparison

Normal renderer comparison could not be completed in this container. A non-headless Godot launch failed because no X11/Wayland display server libraries were available. Exported debug/release builds were not tested because export templates and a graphical display path were not available.

Classification for this environment: **Rendered/GPU performance QA: PARTIAL**.

Editor overhead remains a plausible additional factor because the editor and game can both consume CPU/GPU, but Slice 8 does not classify the issue as editor-only.

## 7. Root-Cause Classification

- `UNCAPPED_RENDER_LOOP`: confirmed. Baseline had VSync disabled and no max FPS cap.
- `CPU_SCRIPT_HOTSPOT`: confirmed for Moon/Sun stream scripts. Every rendered frame updated 96 transforms and 96 colors per stream segment, and full dual completion can have 9 light stream segments.
- `EDITOR_OVERHEAD`: plausible but not isolated in this environment because normal standalone rendered comparison was unavailable.
- `GPU_RENDER_HOTSPOT`: inconclusive. Headless render counters cannot prove GPU load.
- `TRANSPARENT_OVERDRAW`: inconclusive. Transparent/additive materials exist, but no rendered overdraw measurement was available.
- `PARTICLE_OVERLOAD`: not confirmed. Particle counts were inventoried but not proven as the primary load source.
- `SHADOW_OVERLOAD`: not confirmed. Many shadow-enabled lights exist, but no normal-renderer evidence justified changing lights in this slice.
- `RESOURCE_OR_NODE_LEAK`: not confirmed. Wrong reset and reload checks did not show orphan-node growth.
- Overall classification: `MIXED` confirmed for uncapped render loop plus CPU-side stream update scaling, with rendered GPU contribution still requiring user-machine verification.

## 8. Confirmed Optimization Problems

1. The project defaulted to unlimited rendered frames by disabling VSync and omitting a max FPS cap.
2. Moon/Sun light streams did full 96-instance `MultiMesh` transform/color updates every rendered frame.
3. Distance-faded streams still updated all instances before checking camera range.
4. `print_fps=true` made stdout noisy and was unsuitable as a profiler.

## 9. Implemented Fixes

- Set `application/run/max_fps=60`.
- Set `display/window/vsync/vsync_mode=1`.
- Set `debug/settings/stdout/print_fps=false`.
- Added `visual_update_fps = 60.0` to both light stream scripts.
- Added debug accessors for visual update count and distance-cull state.
- Reordered stream `_process(delta)` so `_age` advances every frame, distance visibility is evaluated before instance updates, fully distance-culled streams skip the full 96-instance update loop, and visible streams update instances no more often than the configured visual update FPS.

No particle count, colors, arc height, fade duration, fade lifecycle, route sequence, barrier visuals, scene transforms, narrative, or progression requirements were changed.

## 10. Before/After Measurements

| Scenario | Baseline FPS | Optimized FPS | Baseline process ms | Optimized process ms | Baseline physics ms | Optimized physics ms | Baseline draw calls | Optimized draw calls | Baseline primitives | Optimized primitives | Baseline node count | Optimized node count | Baseline orphan count | Optimized orphan count | Notes |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---|
| StartScene idle | 144.93 | 60.00 | 0.000251 | 0.000148 | 0.000064 | 0.000054 | 0 | 0 headless | 0 | 0 headless | 26 | 26 | 0 | 0 | Baseline uncapped; optimized policy caps to 60. |
| Level 01 initial idle | PARTIAL | ~60 target | PARTIAL | measured by post-fix sampler | PARTIAL | measured by post-fix sampler | 0 headless | 0 headless | 0 headless | 0 headless | 1043-1462 depending import cache | stable | 0 | 0 | Headless runtime inventory stable. |
| Both routes complete | PARTIAL | ~60 target | PARTIAL | measured by post-fix sampler | PARTIAL | measured by post-fix sampler | 0 headless | 0 headless | 0 headless | 0 headless | stable | stable | 0 | 0 | 9 light streams remain at 96 instances each; update rate is bounded. |

Headless measurements are CPU/runtime evidence only. GPU improvement still requires user-machine rendered verification.

## 11. Functional Regression Results

The Slice 8 validator covers initial state, Moon-first order, Sun-first order, selection/cancel, correct connections, wrong resets, ring/beacon lifecycle, particle count 96, stream update throttle, distance culling, barrier structure/collision lifecycle, single signal emission expectations, duplicate prevention, five reloads, orphan/node stability, protected main progression paths, and FPS/VSync settings.

Observed QA result: dual-light functional behavior remained intact. Moon-only and Sun-only completion leave the barrier closed; completing both routes opens the barrier once and disables collision immediately. Wrong resets return to the initial stream and active endpoint without orphan growth.

## 12. Remaining GPU/Rendered QA

Rendered/GPU QA remains **PARTIAL** in this container. The changes are designed to reduce both CPU work and rendered load by enforcing a 60 FPS policy, but actual GPU utilization, overdraw, fan behavior, and editor-vs-standalone split must be verified on the user's machine.

## 13. User-Machine Verification Protocol

After this FPS-cap fix, compare four launches:

1. Editor open, game launched through editor.
2. Editor open, standalone game launched separately.
3. Editor closed, standalone debug build.
4. Editor closed, standalone release build.

For each launch, wait 60 seconds on the same camera view and record:

- FPS
- game CPU
- editor CPU
- combined CPU
- game GPU
- editor GPU
- combined GPU
- RAM
- VRAM
- temperature
- fan/noise observation

Test two identical gameplay states:

- Level 01 initial state.
- Level 01 both-routes-complete state.

Compare the game process separately from the editor process. Do not compare only combined Editor+Game load against a single unrelated game process.

## 14. Final Conclusion

- Was the load caused only by the editor? **Not proven and not assumed.** Editor overhead is plausible, but the project itself had a confirmed uncapped render-loop configuration.
- Was uncapped FPS a confirmed problem? **Yes.** Baseline VSync was disabled and no max FPS cap existed.
- Were CPU-side light stream updates a confirmed hotspot? **Yes.** The Moon and Sun streams updated 96 `MultiMesh` transforms/colors per stream every rendered frame, and full completion can keep 9 stream segments active.
- What was fixed? The project now targets 60 FPS with VSync enabled, stops permanent FPS printing, throttles visible stream instance updates to 60 updates/sec, and skips the full update loop for fully distance-culled streams.
- What remains unverified? Normal-renderer GPU load, editor-vs-standalone GPU split, export build behavior, temperatures, and fan/noise observations on the user's hardware.
