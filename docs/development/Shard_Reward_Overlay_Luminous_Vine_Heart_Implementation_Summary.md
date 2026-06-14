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
