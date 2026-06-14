# Shard Reward Overlay - Luminous Vine Heart Development Reference

## 1. Статус документа

Этот документ является финальным source of truth для разработки нового визуального и технического состояния:

```text
Shard Reward Overlay - Luminous Vine Heart
```

Проект:

```text
Fifteen Shards of Light
Godot 4.x
GDScript
```

Репозиторий:

```text
MindDevastation/fifteen-shards-of-light
```

Канонический путь:

```text
docs/design/Shard_Reward_Overlay_Luminous_Vine_Heart_Development_Reference.md
```

Предыдущий документ:

```text
docs/design/Shard_Reward_Overlay_Warm_Soul_Memory_Development_Reference.md
```

считается замененным и не должен использоваться как production reference.

Причина замены:

- центральная тяжелая memory-card больше не является утвержденной концепцией;
- принят воздушный декоративный overlay;
- добавлены процедурная прямоугольная рамка света;
- добавлена hybrid-лоза-сердце;
- утверждены отдельные PNG-состояния лисьей кнопки;
- утвержден отдельный декоративный leaf sprite;
- утвержден конкретный vine-heart shape reference.

---

# 2. Финальный technical pipeline verdict

## 2.1 Утвержденная композиция

Финальный overlay состоит из пяти визуальных уровней:

```text
1. Matte Atmosphere
2. Procedural Light Frame
3. Hybrid Luminous Vine Heart
4. Text Haze + Reward Text
5. Fox TextureButton
```

Визуальная иерархия:

```text
1. Reward Text
2. Luminous Vine Heart
3. Fox Button
4. Procedural Light Frame
5. Matte Background
```

## 2.2 Матовый экран

Игровой мир остается видимым.

Используются:

```text
MatteVeil
WarmWash
TextHaze
```

Не используется:

- черный экран;
- тяжелая карточка;
- белая панель;
- большая непрозрачная плашка;
- offset ColorRect blocks.

Матовость и яркость считаются tuning-sensitive и могут корректироваться после видео.

## 2.3 Квадратная рамка

Прямоугольная рамка света создается процедурно кодом.

Отдельный PNG рамки не нужен.

Рамка:

- собирается из позиции SoulShard;
- образует мягкий прямоугольный периметр;
- находится позади лозы и текста;
- не является жесткой сплошной линией;
- возвращается к SoulOrb после подтверждения.

## 2.4 Лоза-сердце

Лоза реализуется hybrid-подходом:

```text
authored shape
+
Curve2D / Path2D
+
code-driven progressive reveal
+
separate leaf sprites
```

Форма не генерируется случайно.

Форма трассируется по утвержденному референсу.

Основные ветви рисуются кодом одновременно влево и вправо от нижней центральной точки.

Общая длительность роста:

```text
2.0-2.5 seconds
default target = 2.3 seconds
```

## 2.5 Листики

Используется один утвержденный leaf PNG.

Он переиспользуется:

- с разным scale;
- с разным rotation;
- с mirror по X;
- в нескольких порогах роста.

Листья появляются тогда, когда tip лозы достигает соответствующей зоны.

## 2.6 Кнопка

Используется `TextureButton`.

Состояния:

```text
texture_normal   = button_idle.png
texture_hover    = button_hovered.png
texture_pressed  = button_pressed.png
texture_focused  = button_hovered.png
```

Pressed-state дополнительно усиливается кодом:

```text
scale down
small downward offset
modulate reduction
short recovery
```

PNG pressed-state не деформируется дополнительно в asset pipeline.

## 2.7 Текст

Текст остается внешним reward text.

Не добавляются:

- heading;
- progress;
- reward title;
- chapter name;
- response choice.

Под текстом используется мягкая полупрозрачная haze-подложка.

Она не должна читаться как карточка.

## 2.8 Return flow

После подтверждения:

```text
button reacts
→ text fades
→ haze dissolves
→ vine retracts toward button
→ leaves shrink/fade
→ procedural frame particles fly to SoulOrb
→ overlay hides
→ return_completed emits
```

Reward controller, SoulOrb и gameplay flow не меняются.

---

# 3. Актуальный baseline

Последний подтвержденный merge:

```text
PR #76
Polish SoulShard warm crystal collection burst

Merge commit:
376b3435eb9d28a292cda5e6cc0e6ddc3f8e4f16
```

На момент создания этого reference текущий `main` совпадал с этим merge commit.

Codex все равно обязан получить фактический current main перед началом разработки.

Текущий flow:

```text
WorldInteractionPrompt
→ Charge Anticipation
→ Heart Response
→ Compression
→ Warm Crystal Collection Burst
→ reward_sequence_requested
→ ShardRewardSequenceController
→ ShardRewardOverlay
→ confirmation_requested
→ return to SoulOrb
→ return_completed
→ SoulOrb absorb pulse
→ SoulShard completion
→ controls restored
```

---

# 4. Утвержденные ассеты

## 4.1 Runtime button assets

Source package:

```text
texturebutton_ready_final.zip
```

В репозиторий должны быть добавлены:

```text
assets/ui/shard_reward_overlay/button_idle.png
assets/ui/shard_reward_overlay/button_hovered.png
assets/ui/shard_reward_overlay/button_pressed.png
```

Технические параметры:

```text
1248 × 1248
RGBA PNG
true alpha
matching canvas
matching center alignment
```

Использовать нужно версии из zip.

Не использовать старые loose PNG с непрозрачным checkerboard.

## 4.2 Runtime leaf asset

Source image:

```text
fantasy_vine_leaf_transparent_1024.png
```

Repository path:

```text
assets/ui/shard_reward_overlay/vine_leaf.png
```

Технические параметры:

```text
1024 × 1024
RGBA PNG
true alpha
single decorative leaf
```

## 4.3 Design-only vine reference

Source image:

```text
vine_heart_frame_transparent_2048.png
```

Repository path:

```text
docs/design/references/shard_reward_overlay/vine_heart_shape_reference.png
```

Технические параметры:

```text
2048 × 2048
RGBA PNG
true alpha
symmetrical heart-shaped vine
single bottom-center origin
open text area
```

Этот файл:

- используется для tracing и visual comparison;
- не используется как full overlay sprite;
- не должен рендериться напрямую в production;
- не является final frame texture.

---

# 5. Asset acceptance status

```text
Fox button idle: PASS
Fox button hover: PASS
Fox button pressed: PASS
Button alpha: PASS
Button canvas alignment: PASS
TextureButton readiness: PASS

Leaf sprite: PASS
Leaf alpha: PASS
Leaf style match: PASS

Vine shape reference: PASS
Vine symmetry: PASS
Bottom origin: PASS
Text opening: PASS
Curve tracing suitability: PASS
```

---

# 6. Emotional goal

Overlay должен ощущаться как:

```text
мир мягко затих
→ свет начал рисовать личное послание
→ теплые ветви выросли вокруг строки
→ игрок спокойно прочитал ее
→ свет вернулся в сферу души
```

Overlay не должен выглядеть как:

- achievement;
- loot popup;
- level complete;
- mobile reward;
- dialogue response;
- wedding card;
- fullscreen cinematic;
- system modal;
- bright call-to-action.

Эмоциональный принцип:

```text
я рядом, не требую ответа
```

Кнопка:

```text
OK
```

уже встроена в fox-button art.

Не добавлять рядом отдельный текст `Хорошо`.

---

# 7. Frozen systems

Не менять:

```text
scripts/soul/soul_shard.gd
scenes/core/SoulShard.tscn

scripts/core/shard_reward_sequence_controller.gd
scenes/core/ShardRewardSequenceController.tscn

scripts/ui/world_interaction_prompt.gd
scenes/ui/WorldInteractionPrompt.tscn

SoulOrb scripts/scenes
player scripts/scenes
camera
levels
project.godot
InputMap
```

Не менять:

- reward request timing;
- Charge Anticipation;
- Warm Crystal Burst;
- controller states;
- control lock;
- SoulOrb target projection;
- absorb pulse;
- completion order;
- public overlay API.

---

# 8. Overlay public API

Preserve exactly:

```gdscript
signal confirmation_requested
signal return_completed
```

Preserve:

```gdscript
func play_reward(display_text: String, origin_screen_position: Vector2)
func play_return_to(target_screen_position: Vector2)
func reset_overlay()
```

Preserve:

```text
DEFAULT_REWARD_TEXT = "..."
BBCode escaping
single confirmation emission
return_completed after visual return
```

---

# 9. Allowed production scope

Allowed production files:

```text
scenes/ui/ShardRewardOverlay.tscn
scripts/ui/shard_reward_overlay.gd
```

Allowed runtime assets:

```text
assets/ui/shard_reward_overlay/button_idle.png
assets/ui/shard_reward_overlay/button_hovered.png
assets/ui/shard_reward_overlay/button_pressed.png
assets/ui/shard_reward_overlay/vine_leaf.png
```

Allowed design reference:

```text
docs/design/references/shard_reward_overlay/vine_heart_shape_reference.png
```

Mandatory summary:

```text
docs/development/Shard_Reward_Overlay_Luminous_Vine_Heart_Implementation_Summary.md
```

Optional helper script only if justified:

```text
scripts/ui/luminous_vine_renderer.gd
```

Default preference:

```text
keep implementation in shard_reward_overlay.gd
unless file responsibility becomes unclear
```

---

# 10. Forbidden scope

Do not add:

- new shaders;
- new font files;
- new audio;
- new 3D lights;
- viewport blur;
- SubViewport;
- post-processing;
- global UI manager;
- autoload;
- localization system;
- dialogue system;
- achievement system;
- progress indicators;
- extra response buttons;
- runtime use of full vine reference PNG.

Do not modify unrelated assets.

---

# 11. Target scene structure

Preferred scene tree:

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

Equivalent structure is acceptable if responsibilities remain explicit.

Render order:

```text
Atmosphere
LightFrameLayer
VineCanvas
TextRoot
ButtonRoot
```

---

# 12. Matte atmosphere

## 12.1 MatteVeil

Full-screen `ColorRect`.

Initial target:

```gdscript
Color(0.045, 0.028, 0.020, 0.38)
```

Tuning range:

```text
alpha = 0.28-0.48
```

## 12.2 WarmWash

Full-screen `ColorRect`.

Initial target:

```gdscript
Color(0.46, 0.22, 0.10, 0.10)
```

Tuning range:

```text
alpha = 0.06-0.16
```

## 12.3 TextHaze

Soft rounded `Panel` or `ColorRect`.

Purpose:

- support text readability;
- not become a visible card.

Initial geometry at 1920×1080:

```text
width = 980-1220
height = 270-390
centered
```

Initial style:

```gdscript
bg_color = Color(0.10, 0.045, 0.025, 0.18)
corner_radius = 70-110
shadow_color = Color(1.0, 0.48, 0.20, 0.08)
shadow_size = 24-44
border = none
```

Tuning-sensitive.

---

# 13. Procedural rectangular light frame

## 13.1 Purpose

Create an outer structured boundary without a static PNG.

The frame must feel:

```text
made of floating light
```

not:

```text
drawn by a ruler
```

## 13.2 Geometry

Frame target rect is based on viewport.

At 1920×1080:

```text
left = 150-220
right = 1700-1770
top = 80-130
bottom = 900-980
```

Recommended normalized rect:

```text
x = 0.09 viewport width
y = 0.08 viewport height
width = 0.82 viewport width
height = 0.80 viewport height
```

At 1280×720:

- retain minimum 54 px edge margin;
- avoid overlap with button;
- keep text zone clear.

## 13.3 Particle count

Default:

```text
40
```

Allowed tuning:

```text
32-48
```

Distribution target:

```text
top: 12
bottom: 12
left: 8
right: 8
```

Avoid corner duplicates.

## 13.4 Particle design

Dynamic `Polygon2D` or small `Node2D` composites.

Recommended:

```text
small diamond/sliver
2-7 px core
soft low-alpha outer shape
```

Palette:

```gdscript
Color(1.0, 0.86, 0.58, 0.76)
Color(1.0, 0.66, 0.32, 0.62)
Color(1.0, 0.48, 0.32, 0.38)
Color(1.0, 0.94, 0.76, 0.66)
```

## 13.5 Formation

Particles originate from:

```text
origin_screen_position
```

Formation duration:

```text
0.72-1.0 sec
default = 0.86 sec
```

Stagger:

```text
0.0-0.18 sec
```

Movement:

- cubic ease out;
- slight curved offset;
- no identical straight rays;
- no confetti spin.

## 13.6 Living state

After formation:

```text
position drift <= 1.5 px
alpha twinkle <= ±0.10
rotation <= ±0.018 rad
```

No visible orbit.

## 13.7 Return

On return:

- particles leave frame;
- move to target screen position;
- shrink;
- fade near target;
- strongest target convergence remains readable.

Return duration:

```text
0.58-0.82 sec
```

---

# 14. Hybrid vine-heart architecture

## 14.1 Authoring principle

The vine is not procedurally invented.

It is authored by tracing the approved shape reference.

Use:

```text
Path2D / Curve2D
Line2D layers
code-driven baked-point reveal
```

## 14.2 Main paths

Create two mirrored main paths:

```text
LeftMainVinePath
RightMainVinePath
```

Both start at the same bottom-center area above the fox button.

They grow simultaneously.

## 14.3 Simplified initial anchor guide

Use normalized coordinates inside `VineCanvas`.

Left main path initial anchors:

```text
P0  (0.500, 0.850)
P1  (0.435, 0.805)
P2  (0.345, 0.735)
P3  (0.275, 0.635)
P4  (0.225, 0.510)
P5  (0.205, 0.365)
P6  (0.250, 0.225)
P7  (0.335, 0.125)
P8  (0.425, 0.115)
P9  (0.500, 0.230)
```

Right path:

```text
mirror X:
x_right = 1.0 - x_left
```

These points are a starting guide, not final art truth.

Bezier handles must create smooth organic curves.

## 14.4 Main line layers

Each side uses the same sampled points for three `Line2D` layers.

### OuterGlow

```text
width = 16-24 px
color = warm orange
alpha = 0.10-0.20
antialiased = true
```

### MainGold

```text
width = 7-11 px
color = golden amber
alpha = 0.82-1.0
antialiased = true
```

### InnerIvory

```text
width = 2-4 px
color = warm ivory
alpha = 0.88-1.0
antialiased = true
```

Initial target at 1920×1080:

```text
OuterGlow = 20
MainGold = 9
InnerIvory = 3
```

Scale responsively.

## 14.5 Reveal algorithm

Store:

```gdscript
var _vine_progress := 0.0
```

Progress:

```text
0.0 → 1.0
```

Duration:

```text
2.3 sec default
allowed 2.0-2.5 sec
```

Each frame:

1. obtain baked curve length;
2. sample points from start to current length;
3. assign sampled points to all three lines;
4. update tip glow;
5. update branches;
6. update leaves.

Both sides use identical progress.

## 14.6 Tip glows

Optional procedural tip glows:

```text
small diamond/circle
warm ivory core
orange low-alpha halo
```

They move at current curve endpoints.

Do not use new texture.

Tip glows disappear when growth completes.

---

# 15. Decorative branch curves

Use simplified decorative density.

Target:

```text
3 major branch curls per side
1 optional top curl per side
```

Do not reproduce every reference curl.

Recommended attachment progress:

```text
0.24
0.48
0.70
0.86
```

Each branch:

- has authored `Curve2D`;
- has the same triple-line style;
- reveals after the main tip passes its attachment threshold;
- duration 0.16-0.34 sec;
- never becomes visually stronger than main vine.

---

# 16. Leaf sprite system

## 16.1 Asset

```text
assets/ui/shard_reward_overlay/vine_leaf.png
```

## 16.2 Count

Default:

```text
6 leaves total
3 per side
```

Allowed:

```text
4-8 total
```

## 16.3 Placement thresholds

Recommended main vine progress:

```text
0.28
0.52
0.74
```

per side.

## 16.4 Appearance

Each leaf starts:

```text
alpha = 0
scale = 0.0-0.15 target
```

Then:

```text
alpha → target
scale → target
small rotation settle
```

Duration:

```text
0.16-0.24 sec
```

Target size:

```text
62-110 px visual height at 1920×1080
```

Because the source leaf is detailed, do not reduce it below a size where all detail becomes noise.

## 16.5 Reuse

Use:

- rotation;
- scale;
- horizontal mirror;
- slight color modulate.

Do not generate multiple derivative PNG files.

---

# 17. Fox TextureButton

## 17.1 Scene node

Use:

```text
TextureButton
```

Paths:

```text
normal:
assets/ui/shard_reward_overlay/button_idle.png

hover:
assets/ui/shard_reward_overlay/button_hovered.png

pressed:
assets/ui/shard_reward_overlay/button_pressed.png

focused:
assets/ui/shard_reward_overlay/button_hovered.png
```

## 17.2 Layout

At 1920×1080:

```text
visual button size = 150-210 px
bottom center
bottom margin = 30-70 px
```

Button must not cover the vine root.

Recommended:

```text
vine starts 8-22 px above button ears
```

## 17.3 Hitbox

Clickable area should be larger than the visible face.

Recommended:

```text
180-230 px square
```

Do not rely on thin ornament pixels for clicking.

## 17.4 State behavior

### Idle

```text
scale = 1.0
position offset = 0
modulate = 1.0
```

### Hover / Focus

```text
texture = hovered
scale = 1.025-1.045
duration = 0.10-0.14 sec
```

### Pressed

Use pressed texture plus code:

```text
scale = 0.93-0.96
vertical offset = +3 to +6 px
modulate = Color(0.88, 0.82, 0.76, 1.0)
duration = 0.05-0.09 sec
```

### Release

```text
scale → 1.0
offset → 0
modulate → white
duration = 0.12-0.18 sec
```

Use restrained SINE easing.

No aggressive bounce.

## 17.5 Disabled state

Before interaction is allowed:

```text
disabled = true
modulate alpha = 0.62-0.78
```

After both vine and text are complete:

```text
disabled = false
modulate alpha = 1.0
grab_focus()
```

Button may be visible before activation because it is the source of the vine.

---

# 18. Text and haze

## 18.1 Text

Use existing `RichTextLabel`.

Preserve:

```text
external display_text
fallback "..."
BBCode escaping
centered italic text
```

No new font asset.

Use current project font in first implementation.

Initial target at 1920×1080:

```text
font size = 44-58
outline size = 4-7
line separation = 8-16
```

Text color:

```gdscript
Color(1.0, 0.94, 0.82, 1.0)
```

Outline:

```gdscript
Color(0.18, 0.055, 0.02, 0.92)
```

## 18.2 Text area

Target:

```text
width = 900-1180
height = 240-360
centered slightly above vertical center
```

Leave space below for button.

## 18.3 Reveal

Text starts while vine is growing.

Initial timing:

```text
text start = T+0.48-0.65
```

Reveal:

```text
seconds per character = 0.028-0.038
min = 1.0
max = 2.6
```

Text must not wait for vine completion.

---

# 19. Opening choreography

Target timeline:

```text
T+0.00
overlay reset
overlay visible
matte atmosphere starts
button appears disabled at reduced alpha

T+0.05
frame particles begin moving from SoulShard origin

T+0.12
vine root lights
left and right main vines begin simultaneous growth

T+0.25
TextHaze begins fading in

T+0.50
reward text begins reveal

T+0.20-2.30
branches and leaves appear at growth thresholds

T+0.86
procedural rectangular frame mostly formed

T+2.30
vine growth complete

after both:
- text reveal complete
- vine growth complete

button:
disabled = false
alpha = 1
grab_focus()
```

The button is visible earlier but inactive.

No empty decorative wait.

---

# 20. Living state

After opening:

- world remains matte;
- square light frame performs tiny twinkle;
- vine remains stable;
- leaves remain stable;
- text remains stable;
- button is active.

Do not add:

- continuous vine pulse;
- panel pulse;
- large glow breathing;
- urgent button pulse.

Optional tiny frame twinkle only.

---

# 21. Confirmation and return choreography

## 21.1 Confirmation

TextureButton press:

- executes pressed visual feedback;
- emits `confirmation_requested` once;
- controller calls `play_return_to(...)`.

## 21.2 Return target

Use existing target screen position from controller.

## 21.3 Return sequence

Target timeline:

```text
T+0.00
button disabled
button pressed feedback completes
text begins fade
TextHaze begins fade

T+0.04
vine progress reverses 1.0 → 0.0
tips retract toward button root
leaves fade and shrink

T+0.06
frame particles leave perimeter toward SoulOrb target

T+0.10-0.55
atmosphere fades out

T+0.58-0.82
frame particles reach target
shrink and fade

end
overlay hidden
return_completed emits exactly once
```

## 21.4 Vine retraction

Default:

```text
duration = 0.52-0.70 sec
```

Use reverse of the same progress.

This visually returns the drawn vine to its source.

## 21.5 Button exit

Button fades/scales down softly.

Do not fly the fox button to SoulOrb.

---

# 22. Async lifecycle safety

Current overlay uses async fire-and-forget wrappers.

New implementation must protect against stale continuation.

Use:

```gdscript
var _sequence_generation := 0
```

On:

```text
play_reward
play_return_to
reset_overlay
```

advance/capture generation.

After every `await`:

```gdscript
if generation != _sequence_generation:
    return
```

Track and kill all overlay-owned tweens.

Recommended fields:

```gdscript
var _atmosphere_tween: Tween
var _frame_tween: Tween
var _vine_tween: Tween
var _text_tween: Tween
var _button_tween: Tween
var _return_tween: Tween
```

Alternative owned tween array is acceptable.

`_reset_visual_state()` must stop every live tween.

---

# 23. Deterministic reset

Reset must restore:

```text
all tweens killed
generation invalidated
root hidden when requested
atmosphere alpha 0
TextHaze alpha 0
reward text empty
visible_ratio 0
button disabled
button visual idle
button scale/offset reset
frame particle nodes cleared/reset
frame data cleared
vine progress 0
all line points empty
tip glows hidden
branches reset
leaves hidden and reset
living process disabled
confirmation guard reset
```

Second shard must not inherit:

- line points;
- leaf alpha;
- button state;
- frame positions;
- old text;
- old async continuation.

---

# 24. Responsive behavior

Mandatory resolutions:

```text
1920×1080
1280×720
```

Recommended:

```text
2560×1440
```

Requirements:

- vine remains centered;
- button stays visible;
- text wraps;
- text does not overlap button;
- rectangular frame preserves safe margins;
- leaves remain in vine bounds;
- line widths scale reasonably;
- no clipping;
- mouse hitbox remains usable.

Use anchors and normalized geometry.

Avoid hardcoding all visual positions in absolute pixels.

---

# 25. Performance constraints

Target maximum:

```text
40 frame particles
2 main curves
up to 8 branch curves
6 leaf sprites
6 main Line2D layers
up to 24 branch Line2D layers
2 tip glows
1 RichTextLabel
1 TextureButton
3 atmosphere controls
```

No shader.

No per-frame node creation.

Create procedural frame particles once per reward sequence.

Curve baked points may be cached.

Do not recalculate curve baking every frame if avoidable.

---

# 26. Development decomposition

Mandatory preflight:

```text
LVH-0 Baseline and Asset Inspection
```

Implementation slices:

```text
LVH-1 Asset Integration and Scene Foundation
LVH-2 Matte Text Composition and Fox TextureButton
LVH-3 Procedural Rectangular Light Frame
LVH-4 Hybrid Vine-Heart Growth and Leaf Decoration
LVH-5 Integrated Choreography, Return Safety and Validation
```

Before implementation:

- complete LVH-0;
- complete preflight for LVH-1...LVH-5;
- wait for exact `APPLY`.

After `APPLY`:

- execute slices sequentially;
- validate each;
- commit each;
- continue without stopping between slices.

---

# LVH-0 - Baseline and Asset Inspection

## Goal

Confirm repository, current overlay and all required assets.

## Inspect

```text
AGENTS.md
nested AGENTS.md
current main SHA
working tree
PR #76 merged state
ShardRewardOverlay.tscn
shard_reward_overlay.gd
ShardRewardSequenceController
current fonts/themes
required asset paths
PNG dimensions
PNG alpha
vine reference presence
```

## Required asset check

Block implementation if any are missing:

```text
assets/ui/shard_reward_overlay/button_idle.png
assets/ui/shard_reward_overlay/button_hovered.png
assets/ui/shard_reward_overlay/button_pressed.png
assets/ui/shard_reward_overlay/vine_leaf.png
docs/design/references/shard_reward_overlay/vine_heart_shape_reference.png
```

No changes during LVH-0.

---

# LVH-1 - Asset Integration and Scene Foundation

## Goal

Create final static scene structure and bind approved assets.

## Files

```text
scenes/ui/ShardRewardOverlay.tscn
scripts/ui/shard_reward_overlay.gd
```

## Tasks

1. Remove old MintWash/PinkWash/OrangeWash structure.
2. Add MatteVeil.
3. Add WarmWash.
4. Add TextHaze.
5. Add LightFrameLayer.
6. Add VineCanvas and required line/path roots.
7. Add TextRoot.
8. Replace standard Button with TextureButton.
9. Bind all three button textures.
10. Bind leaf texture for reusable leaf sprites.
11. Preserve public methods/signals.
12. Update onready paths.
13. Keep root initially hidden.
14. Implement deterministic scene reset foundation.

## Acceptance

- scene parses;
- all assets load;
- no checkerboard;
- no missing paths;
- TextureButton textures resolve;
- old wash nodes removed;
- public API unchanged.

## Commit

```text
Add Luminous Vine Heart overlay scene foundation
```

---

# LVH-2 - Matte Text Composition and Fox TextureButton

## Goal

Implement matte screen, text haze, text styling and button behavior.

## Tasks

1. Add tunable matte constants/exports.
2. Add TextHaze visual.
3. Style reward text.
4. Preserve italic and escaping.
5. Implement responsive text sizing.
6. Implement button visible-disabled opening state.
7. Implement hover/focus state.
8. Implement code-enhanced pressed state.
9. Implement release recovery.
10. Preserve one confirmation signal.
11. Preserve external reward text.

## Acceptance

- world remains visible;
- no heavy panel;
- text readable;
- button art clean;
- button does not jump;
- pressed state clear;
- keyboard focus works;
- no extra narrative labels.

## Commit

```text
Add matte text composition and fox reward button
```

---

# LVH-3 - Procedural Rectangular Light Frame

## Goal

Replace full-screen confetti with structured light particles.

## Tasks

1. Build target frame rect from viewport.
2. Generate default 40 frame particles.
3. Distribute along four sides.
4. Spawn from SoulShard origin.
5. Animate formation.
6. Implement restrained palette.
7. Implement tiny living twinkle.
8. Keep center and button clear.
9. Implement return-to-target movement.
10. Cache/reset data safely.

## Acceptance

- rectangular structure readable;
- particles not a solid line;
- no confetti;
- no mint dominance;
- no text overlap;
- frame returns to SoulOrb.

## Commit

```text
Build procedural light frame for reward overlay
```

---

# LVH-4 - Hybrid Vine-Heart Growth and Leaf Decoration

## Goal

Trace and animate the approved vine shape.

## Tasks

1. Add authored left main Curve2D.
2. Mirror for right main Curve2D.
3. Add triple Line2D layers per side.
4. Implement baked-point reveal.
5. Grow both sides simultaneously.
6. Add tip glows.
7. Add simplified branch curves.
8. Add six leaf sprites.
9. Trigger leaves by progress thresholds.
10. Match approved reference at simplified 65-75% complexity.
11. Leave space for button.
12. Keep text zone open.
13. Implement reverse retraction.
14. Cache curve data.
15. Keep full reference PNG design-only.

## Acceptance

- heart silhouette readable;
- growth begins above button;
- both sides synchronized;
- growth lasts 2.0-2.5 sec;
- glow layered;
- leaves appear naturally;
- no random botany;
- no direct runtime full-reference sprite.

## Commit

```text
Add hybrid luminous vine-heart growth animation
```

---

# LVH-5 - Integrated Choreography, Return Safety and Validation

## Goal

Integrate all layers and harden async lifecycle.

## Tasks

1. Add generation token.
2. Track every overlay tween.
3. Check generation after awaits.
4. Implement final opening timeline.
5. Start text during vine growth.
6. Enable button only when text and vine complete.
7. Preserve confirmation once.
8. Implement final return choreography.
9. Emit return_completed once.
10. Test reset during opening.
11. Test second shard.
12. Test responsive resolutions.
13. Create implementation summary.

## Required summary

```text
docs/development/Shard_Reward_Overlay_Luminous_Vine_Heart_Implementation_Summary.md
```

## Commit

```text
Validate and document Luminous Vine Heart reward overlay
```

---

# 27. Static validation

Run:

```bash
git diff --check
godot --headless --path . --check-only --quit
timeout 20s godot --headless --path . --quit
```

Searches:

```bash
rg -n "signal confirmation_requested|signal return_completed" \
scripts/ui/shard_reward_overlay.gd

rg -n "func play_reward|func play_return_to|func reset_overlay" \
scripts/ui/shard_reward_overlay.gd

rg -n "button_idle|button_hovered|button_pressed|vine_leaf" \
scenes/ui/ShardRewardOverlay.tscn \
scripts/ui/shard_reward_overlay.gd

rg -n "Curve2D|Path2D|Line2D|_vine_progress|_sequence_generation" \
scenes/ui/ShardRewardOverlay.tscn \
scripts/ui/shard_reward_overlay.gd

rg -n "create_tween|await|return_completed|confirmation_requested" \
scripts/ui/shard_reward_overlay.gd

rg -n "play_reward|play_return_to|return_completed" \
scripts/core/shard_reward_sequence_controller.gd
```

---

# 28. Runtime validation

Test full sequence:

```text
collect shard
→ Warm Crystal Burst
→ matte overlay
→ frame forms
→ vine grows
→ text reveals
→ button enables
→ mouse confirm
→ vine retracts
→ particles fly to SoulOrb
→ return_completed
→ absorb pulse
→ controls restored
```

Repeat with:

```text
keyboard/gamepad focus
second shard
long reward text
short reward text
1920×1080
1280×720
bright background
dark background
```

Check Output/Debugger.

---

# 29. Video requirements

Required video:

```text
Warm Crystal Burst
→ full matte fade
→ frame formation
→ full 2.0-2.5 sec vine growth
→ text reveal
→ hover state
→ pressed state
→ return to SoulOrb
→ controls restored
```

Visual checklist:

```text
matte screen balanced
world remains visible
TextHaze not a card
text readable
square frame visible but secondary
heart silhouette readable
growth starts at button
both sides synchronized
leaf timing natural
button states clean
pressed code feedback visible
no checkerboard
no clipping
return readable
no closing pop
```

No visual PASS without video.

---

# 30. Implementation summary requirements

Summary must include:

```text
1. Reference path
2. Superseded reference
3. Repository instructions
4. Actual main SHA
5. Asset paths and validation
6. Initial architecture
7. Final scene tree
8. Matte values
9. TextHaze values
10. Typography values
11. TextureButton configuration
12. Pressed feedback values
13. Frame particle count/palette/layout
14. Main vine paths
15. Branch paths
16. Line widths/colors
17. Growth duration
18. Leaf count/transforms/thresholds
19. Tip glow
20. Opening timeline
21. Living state
22. Return timeline
23. Generation token
24. Tween ownership
25. Reset behavior
26. Responsive behavior
27. Public API preservation
28. Controller preservation
29. LVH-1...LVH-5
30. Tests
31. Runtime limitations
32. Video requirements/results
33. Branch/commits/PR
34. Scope confirmation
```

Use statuses:

```text
PASS BY CODE
PASS BY HEADLESS CHECK
PASS BY RUNTIME
PASS BY VIDEO
NOT VERIFIED
```

---

# 31. Git workflow

Preferred branch:

```text
feature/shard-reward-overlay-luminous-vine-heart
```

Preferred PR title:

```text
Build Luminous Vine Heart Shard Reward Overlay
```

Expected commits:

```text
1. Add Luminous Vine Heart overlay scene foundation
2. Add matte text composition and fox reward button
3. Build procedural light frame for reward overlay
4. Add hybrid luminous vine-heart growth animation
5. Validate and document Luminous Vine Heart reward overlay
```

Do not merge automatically.

---

# 32. Changed-files expectation

Expected production files:

```text
scenes/ui/ShardRewardOverlay.tscn
scripts/ui/shard_reward_overlay.gd
```

Expected runtime assets:

```text
assets/ui/shard_reward_overlay/button_idle.png
assets/ui/shard_reward_overlay/button_hovered.png
assets/ui/shard_reward_overlay/button_pressed.png
assets/ui/shard_reward_overlay/vine_leaf.png
```

Expected reference asset:

```text
docs/design/references/shard_reward_overlay/vine_heart_shape_reference.png
```

Expected summary:

```text
docs/development/Shard_Reward_Overlay_Luminous_Vine_Heart_Implementation_Summary.md
```

Do not change:

```text
scripts/core/shard_reward_sequence_controller.gd
scenes/core/ShardRewardSequenceController.tscn
scripts/soul/soul_shard.gd
scenes/core/SoulShard.tscn
SoulOrb files
player files
level files
project.godot
unrelated assets
```

---

# 33. Failure conditions

Task fails if:

- old offset wash blocks remain;
- full-reference vine PNG is rendered directly;
- square frame becomes a solid rectangle;
- frame particles look like confetti;
- vine is randomly generated;
- vine growth is one-sided;
- vine does not begin at button;
- growth takes less than 2.0 or more than 2.5 sec without evidence;
- text waits until all decoration finishes;
- text is unreadable;
- button checkerboard appears;
- button jumps between states;
- pressed code feedback is missing;
- button text is added separately;
- public API changes;
- controller changes;
- return to SoulOrb is removed;
- stale coroutine can continue after reset;
- return_completed emits twice;
- second shard inherits visual state;
- visual PASS claimed without video.

---

# 34. Definition of Done

Implementation DoD:

```text
LVH-0 complete
LVH-1 complete
LVH-2 complete
LVH-3 complete
LVH-4 complete
LVH-5 static/headless complete
summary created
scope clean
PR created
video requested
```

Runtime DoD:

```text
mouse confirm
keyboard focus
single confirmation
single return_completed
SoulOrb return
controls restored
second shard
no debugger errors
```

Visual DoD:

```text
matte atmosphere accepted
text readability accepted
particle frame accepted
vine shape accepted
growth timing accepted
leaf timing accepted
button idle accepted
button hover accepted
button pressed accepted
return accepted
bright background accepted
dark background accepted
```

Merge DoD:

```text
code review PASS
runtime PASS
visual PASS
GitHub head verified
no blockers
```

---

# 35. Final emotional beat

```text
теплый свет освобождается
→ мир становится матовым и тихим
→ частицы собирают внешнюю рамку
→ от лисьей кнопки одновременно растут две золотые ветви
→ вокруг строки замыкается сердце
→ игрок спокойно читает
→ нажимает светящуюся лисицу
→ лоза возвращается к источнику
→ частицы несут свет в SoulOrb
```
