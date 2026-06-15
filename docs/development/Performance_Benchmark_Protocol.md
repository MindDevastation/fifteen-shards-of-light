# Performance Benchmark Protocol

Instrumentation-only package after PR #81 restored the baseline. It does not modify gameplay, rendering, physics, VFX, SoulShard, SoulOrb, camera behavior, levels, or the reward overlay.

## Launch

1. Open `res://scenes/dev/PerformanceBenchmarkRunner.tscn` in Godot.
2. Run the current scene.
3. Choose a target scene.
4. Wait until loading settles.
5. Press `F4` for the lightweight benchmark, or `Shift+F4` for the GPU/render timing diagnostic.
6. Wait through 5 seconds of warm-up and 30 seconds of capture.
7. Copy the CSV path printed in the output console.

F8 is not used because Godot Editor reserves it for Stop.

## Probe cost

Before capture, both probes are sleeping: no process callback, metric polling, file writes, or scene-tree traversal.

`F4` records frame time, smoothed FPS, process time, physics time, draw calls, objects drawn, object count, and static memory.

`Shift+F4` temporarily enables viewport render-time measurement and records render CPU time, render GPU time, frame setup CPU time, draw calls, objects drawn, active video adapter, rendering method, rendering driver, API version, and viewport size. Measurement is disabled immediately after capture.

Neither probe inspects scene nodes, meshes, materials, lights, shadows, or transparency.

CSV files are written under `user://performance`. The absolute path is printed after capture.

## Test matrix

Use 1280x720 fullscreen, the same run mode, no screen recording, and three runs per test.

- Level_01 idle: stand still and do not rotate the camera.
- Level_01 movement: move, rotate the camera, and jump after warm-up.
- Level_01 shard sequence: include charge, burst, overlay, confirmation, and SoulOrb return.
- StartScene.
- Level_10.
- Level_15.
- FinalScene.

The lightweight CSV summary includes average FPS from frame times, median, p95, p99, 1% low, minimum FPS, maximum frame time, process time, physics time, draw calls, and objects drawn.

The GPU diagnostic summary includes average render CPU time, average render GPU time, average frame setup CPU time, p95 GPU time, draw calls, objects drawn, and the actual video adapter used by Godot.

This package measures performance only. It does not prove that 60 FPS has been achieved.
