# Shard Reward Overlay - Luminous Vine Heart Implementation Summary

## Status

Implemented as a static/headless-validated reward overlay update for `ShardRewardOverlay`.

Visual quality still requires video review before merge.

## Source of Truth

Implemented against:

```text
docs/design/Shard_Reward_Overlay_Luminous_Vine_Heart_Development_Reference.md
```

The previous Warm Soul Memory overlay reference was not used for implementation decisions.

## Files Changed

Production files:

```text
scenes/ui/ShardRewardOverlay.tscn
scripts/ui/shard_reward_overlay.gd
```

Documentation:

```text
docs/development/Shard_Reward_Overlay_Luminous_Vine_Heart_Implementation_Summary.md
```

## Asset Usage

Runtime assets:

```text
assets/ui/shard_reward_overlay/button_idle.png
assets/ui/shard_reward_overlay/button_hovered.png
assets/ui/shard_reward_overlay/button_pressed.png
assets/ui/shard_reward_overlay/vine_leaf.png
```

Design-only reference:

```text
docs/design/references/shard_reward_overlay/vine_heart_shape_reference.png
```

The design-only vine reference is not instantiated by the production scene and is not rendered as a full overlay sprite.

## Scene Architecture

The overlay now uses explicit ownership layers:

```text
ShardRewardOverlay
├── Atmosphere
│   ├── MatteVeil
│   ├── WarmWash
│   └── TextHaze
├── LightFrameLayer
├── VineCanvas
│   ├── LeftVine
│   │   ├── OuterGlow
│   │   ├── MainGold
│   │   └── InnerIvory
│   ├── RightVine
│   │   ├── OuterGlow
│   │   ├── MainGold
│   │   └── InnerIvory
│   ├── BranchLayer
│   ├── LeafLayer
│   ├── LeftTipGlow
│   └── RightTipGlow
├── TextRoot
│   └── RewardText
└── ButtonRoot
    └── ConfirmButton
```

## Matte Values

Initial matte tuning:

```gdscript
MatteVeil = Color(0.045, 0.028, 0.020, 0.38)
WarmWash = Color(0.46, 0.22, 0.10, 0.10)
```

`TextHaze` is a low-alpha rounded `Panel` intended to support readability without becoming a heavy card.

## TextHaze Values

Responsive sizing is driven from the viewport:

- width: clamped from viewport width, targeting the approved 980-1220 range at 1920x1080
- height: clamped from viewport height, targeting the approved 270-390 range at 1920x1080
- low alpha warm fill
- no visible border
- soft warm shadow through `StyleBoxFlat`

## Text Configuration

The reward text remains:

- `RichTextLabel`
- BBCode-enabled
- centered
- italic
- external text driven
- fallback-backed by `DEFAULT_REWARD_TEXT = "..."`
- BBCode escaped for `[` and `]`

## TextureButton Configuration

`ConfirmButton` is now a `TextureButton`:

```text
normal  -> button_idle.png
hover   -> button_hovered.png
pressed -> button_pressed.png
focused -> button_hovered.png
```

There is no separate `Хорошо` text label.

## Pressed Feedback

The code-enhanced pressed feedback uses:

- scale: `0.945`
- vertical offset: `+5 px`
- alpha reduction: `0.82`
- press duration: `0.07 sec`
- recovery duration: `0.14 sec`
- SINE easing

## Procedural Rectangular Light Frame

The light frame uses 40 procedural particles:

```text
top = 12
bottom = 12
left = 8
right = 8
```

Responsive frame geometry:

```text
x = 0.09 viewport width
y = 0.08 viewport height
width = 0.82 viewport width
height = 0.80 viewport height
```

Particles originate from the shard screen position, form over approximately `0.86 sec`, drift subtly in the living state, and return to the SoulOrb target before `return_completed`.

## Hybrid Vine-Heart

The vine-heart uses authored `Curve2D` paths converted to baked points, then progressively truncates those points into `Line2D` layers.

Each side contains:

```text
OuterGlow Line2D
MainGold Line2D
InnerIvory Line2D
```

The right side is mirrored from the left side.

Growth duration:

```text
2.3 sec
```

The vine reverses during return.

## Branches

Decorative branches are authored from simplified curve data:

- 3 major curls per side
- 1 upper curl per side
- mirrored left/right placement
- progressive reveal based on vine progress thresholds

## Leaves

The overlay uses six total leaf sprites, three per side.

Thresholds:

```text
0.28
0.52
0.74
```

Each leaf uses the approved `vine_leaf.png` texture with restrained scale, alpha, rotation, and mirroring variation.

## Opening Choreography

Implemented timing:

```text
T+0.00 overlay reset and visible, matte starts, disabled dim button visible
T+0.05 light-frame formation starts
T+0.12 vine growth starts
T+0.25 TextHaze appears
T+0.50 text reveal starts
T+0.20-2.30 branches/leaves appear through vine progress
T+0.86 light frame mostly formed
T+2.30 vine completes
```

Button enablement is gated on both text completion and vine completion.

## Return Choreography

Return flow:

```text
button disabled
pressed feedback grace period
text / TextHaze / button fade
vine retracts
leaves shrink/fade through reverse progress
frame particles fly to SoulOrb target
atmosphere fades
overlay hides
return_completed emits once
```

## Async Lifecycle Safety

Implemented:

```gdscript
var _sequence_generation := 0
```

The generation advances on:

- `play_reward`
- `play_return_to`
- `reset_overlay`

Async entrypoints check generation after awaited timers and awaited animation phases. Overlay-owned tweens are tracked and killed on reset.

## Public API Preservation

Preserved exactly:

```gdscript
signal confirmation_requested
signal return_completed

func play_reward(display_text: String, origin_screen_position: Vector2)
func play_return_to(target_screen_position: Vector2)
func reset_overlay()
```

## Frozen Systems

No changes were made to:

```text
scripts/core/shard_reward_sequence_controller.gd
scenes/core/ShardRewardSequenceController.tscn
scenes/core/SoulShard.tscn
SoulOrb files
player files
camera files
level files
project.godot
InputMap
```

## Validation Status

Static/headless validation was run during implementation.

Video/manual validation is still required for:

- matte balance
- world visibility
- TextHaze subtlety
- heart silhouette quality
- leaf readability
- hover/focus/pressed visual feel
- return readability
- two sequential shards

## Merge Recommendation

```text
Merge: WAIT FOR VIDEO
```

## Corrective Review Round 1

PR metadata for this corrective pass:

```text
PR number: #77
PR URL: https://github.com/MindDevastation/fifteen-shards-of-light/pull/77
Base branch: main
Base SHA: 581338125954ac2894027e08ad04dccce5ec0c40
Current GitHub branch: feature/develop-luminous-vine-heart-overlay
Previous GitHub head SHA: 9194a885b4223a1a6b6f48b55ab8a4d5f1d1ad53
Corrective commit SHA: this corrective commit; exact local SHA is reported in final handoff
Final GitHub head SHA after update: NOT VERIFIED in this local environment unless push tooling confirms it
```

Corrective fixes applied before video review:

- Return choreography was parallelized into a single central return presentation sequence so text, TextHaze, button, atmosphere, vine retraction, and frame-particle return start together and share one synchronization await.
- Decorative branch curves were upgraded from a single flat `Line2D` to triple-line glow data using outer, main, and inner branch lines.
- Tip glows now fade during the final growth range and reach alpha `0.0` at complete vine progress.
- Procedural frame side targets now avoid corner duplication by placing left/right-side particles between top/bottom corner particles.
- Tuning constants/resources were cleaned by using leaf threshold constants, using vine color constants as runtime tuning source, and removing the unused scene leaf ext_resource while keeping the script preload.

Corrective validation status:

```text
Code review: PASS AFTER CORRECTIVE UPDATE
Visual quality: NOT VERIFIED
Merge: WAIT FOR VIDEO
```

## Visual Corrective Pass V2

Status: corrective implementation completed by static/headless validation only. Final visual PASS is not claimed; a new gameplay/video capture is still required before merge.

### Font choice / font status

- Reward text now uses the existing repository asset `assets/fonts/cormorant_garamond/CormorantGaramond-SemiBoldItalic.otf`.
- The font is assigned both in the scene theme overrides and at runtime for the RichTextLabel normal/italic/bold-italic slots so the existing `[i]` BBCode path keeps the intended centered italic feel.
- Starting font size is now `48`, with responsive scaling from viewport height.

### Text layout changes

- The text remains a `RichTextLabel` driven by external `display_text`, fallback-backed by `DEFAULT_REWARD_TEXT`, and escaped through the existing BBCode escape helper.
- The responsive text rectangle was narrowed and shifted upward inside the vine heart so 2-4 lines favor the broader upper/middle heart area and avoid dropping into the narrow lower point.
- Text color was tuned to light golden cream with a softer dark outline for readability against the darker matte world.

### TextHaze removal

- The separate TextHaze Panel node, stylebox resource, runtime onready reference, fade-in choreography, reset handling, and return fade were removed from production files.
- Readability now relies on typography, outline, placement inside the heart, and the darker global atmosphere rather than a text card/backing.

### Darker atmosphere

- `MatteVeil` is deeper and warmer while still translucent enough to leave the world visible.
- `WarmWash` was reduced and warmed so it supports the overlay instead of competing with the text and vine.

### Vine smoothing / curls / leaves

- The main authored Curve2D heart path uses a lower bake interval and additional curve point shaping for a smoother, more organic silhouette.
- Decorative curls increased from four authored thresholds per side to six per side, including a lower source curl that visually bridges the fox button and the heart split.
- Leaves increased from three per side to five per side while using smaller scales to avoid crowding the text opening.

### Leaf integration

- Leaf scale was reduced roughly into the 20-30% smaller visual range relative to the prior pass.
- Leaf rotation now samples the main vine tangent near each reveal threshold and blends that tangent into the authored rotation, making leaves read more like growths from the vine instead of stickers.

### Vine-button connection changes

- The vine origin was adjusted lower and the first lower curl starts near the button/source area.
- The fox button was slightly tightened and raised so the button reads as the source feeding the lower stem and split.

### Crystal frame density changes

- Procedural frame particles increased from 40 to 76:
  - top: 22
  - bottom: 22
  - left: 16
  - right: 16
- Formation and return still preserve the rectangular perimeter but use varied offsets, sizes, rotations, phase, speed, and alpha shimmer for a more living non-uniform frame.

### Button hover / hit area fix

- The button visual rect is smaller and no longer reaches the bottom edge of the window.
- Runtime setup now creates a TextureButton alpha click mask from `button_idle.png` and assigns it to `texture_click_mask` so hover/click behavior follows the button texture instead of feeling window-sized.
- ButtonRoot remains mouse-passive; the TextureButton remains the only stopped mouse target in that layer.

### Retract timing change

- Vine growth duration remains `2.3` seconds.
- Vine retract now also uses `VINE_GROWTH_DURATION`, making the vine close symmetrically over `2.3` seconds.
- Return choreography remains parallel: text, button, atmosphere, vine, and frame return start together under one return sequence.

### Optimization review

- The production path still creates overlay-owned decorative nodes only during overlay reset/build phases, not during every animation frame.
- Baked main vine points are cached after building the Curve2D paths.
- Point truncation now uses `PackedVector2Array.slice()` instead of manually appending into a new array for every reveal update.
- Frame living updates are throttled to about 30 Hz via `FRAME_LIVING_UPDATE_INTERVAL` instead of updating all frame particles every rendered frame.
- The particle count was increased only to a moderate 76 to strengthen the frame while keeping the pass lightweight.

### Tests

Required validation for this pass:

```text
git diff --check
godot --headless --path . --check-only --quit
timeout 20s godot --headless --path . --quit
```

### Remaining limitations

- Visual quality is NOT VERIFIED until a new video capture is reviewed.
- Runtime/responsive behavior is only partially validated through static/headless checks in this environment.
- Push proof and GitHub PR head SHA can only be verified when a Git remote is configured and push access is available.

### Need for new video

A fresh PR #77 video capture is required to confirm text readability, heart composition, button-source feel, frame readability, hover area feel, and performance smoothness in the actual gameplay viewport.

## Final Visual Corrective Pass V3

Actual PR #77 head before pass:

```text
NOT VERIFIED by GitHub CLI in this environment; local base before pass was e3a2ae6337cf289974e58e17122a5adaf63c69a4.
```

Actual corrective commit:

```text
Recorded in final handoff from `git rev-parse HEAD` after the final amend.
```

Final GitHub head after push:

```text
NOT VERIFIED; no git remote/push destination is configured in this environment.
```

Cormorant font path:

```text
res://assets/fonts/cormorant_garamond/CormorantGaramond-SemiBoldItalic.otf
```

Text layout algorithm:

- The overlay keeps `display_text` external and normalizes repeated spaces without adding shard-specific phrase logic.
- Explicit line breaks are respected when they can fit the three-line heart-safe layout.
- Otherwise, word-aware split candidates are evaluated for one, two, and three lines.
- Each candidate is measured with the actual Cormorant Garamond SemiBold Italic font and scored for balance.
- Single-word dangling lines receive a generic penalty when better balanced candidates exist.
- Words are not split mid-word.

Per-line width limits at 1920x1080:

```text
line 1 = 720 px
line 2 = 650 px
line 3 = 560 px
```

The limits scale from viewport height.

Font size and fallback:

```text
default = 48 px at 1920x1080
emergency fallback = 44 px at 1920x1080
```

The fallback is universal and only exists for cases where a valid three-line layout is not otherwise possible.

Text reveal architecture:

- The unstable `visible_ratio` typewriter reveal was removed from the active presentation path.
- The overlay now creates reusable `TextRevealRoot`-style line masks in code: `LineRevealMask1..3`, each with a final text copy and a small golden glint.
- Layout is completed before animation starts.
- Reveal changes only mask width, line alpha, and glint position/alpha; it does not mutate text wrapping during the reveal.

Text reveal timing:

```text
line reveal duration = 1.25 sec
line stagger = 0.55 sec
```

Vine cap/join settings:

- Main vine and branch `Line2D` nodes use rounded joint mode.
- Main vine and branch `Line2D` nodes use rounded begin and end caps.
- Branch starts are overlapped slightly into the main path to reduce visible seams.

Leaf path/tangent attachment:

- Leaves are sampled from the baked main vine path rather than arbitrary viewport coordinates.
- Each leaf stores a source path, progress threshold, side offset, target scale, rotation, and mirrored scale state.
- Tangent angle is calculated from neighboring baked points and combined with the authored rotation offset.

Crystal count and distribution:

```text
total = 72
top = 22
bottom = 22
left = 14
right = 14
```

Distribution remains rectangular but uses deterministic clustered offsets and small jitter for heterogeneous density.

Crystal X/Y drift:

- Each pooled crystal stores target, size/aspect via polygon, base rotation, X/Y phase, X/Y speed, X/Y amplitude, and alpha amplitude.
- Living motion updates at approximately 30 Hz and changes only position, rotation, and alpha.

Button focus/hover fix:

- `texture_focused` now uses the idle texture rather than the hover expression.
- Mouse hover state is tracked with `mouse_entered`/`mouse_exited` and recalculated after enable/button-up.
- Keyboard focus remains available via `grab_focus()`, but focus now uses subtle scale/warm modulation instead of the hover face.

Return fade timings:

```text
vine retract = 2.30 sec
atmosphere fade = 2.20 sec
crystal return/fade = approximately 1.97-2.15 sec plus small stagger
text fade = 1.55 sec
button fade = 0.65 sec
```

Optimization changes:

- Frame particles are pooled once and reused instead of being freed/recreated at reward start.
- Text reveal mask/label/glint nodes are created once and reset per reward.
- Branch and leaf nodes are reused across rewards for the same viewport size.
- Geometry is rebuilt only when needed for first use or viewport-size changes.
- Per-frame crystal living motion remains simple and allocation-light at a 0.033 sec cadence.

Node reuse strategy:

- Reuse crystal `Polygon2D` nodes.
- Reuse text reveal controls.
- Reuse branch `Line2D` and leaf `Sprite2D` nodes unless viewport geometry changes.

Cache strategy:

- Cache the last viewport size used for vine/leaf/branch geometry.
- Cache frame targets for the current viewport/origin setup.
- Keep baked main/branch points and leaf attachment data for reset-safe reuse.

Tests:

- Static diff whitespace validation.
- Godot headless parse/check-only.
- Godot headless launch.
- Required `rg` inspections for font, reveal, TextHaze, line caps, button focus/mouse signals, frame counts, return timing, allocation calls, and frozen public API.
- Temporary runtime script attempted the required one-line, two-line, and three-line generic Russian text cases; full runtime asset loading was limited by missing generated `.godot/imported` cache files in this environment.

Remaining limitations:

- Visual quality is not marked final without a new user video capture.
- Profiler/monitor frame-time and script-time confidence remains partial without an interactive profiler capture.
- GitHub PR head/push proof depends on remote access from the environment.

New video required:

```text
YES. Do not mark final visual PASS until a new 1920x1080 and 1280x720 video review confirms the result.
```
