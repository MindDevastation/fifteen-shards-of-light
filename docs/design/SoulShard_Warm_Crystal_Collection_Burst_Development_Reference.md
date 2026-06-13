# SoulShard Warm Crystal Collection Burst - Development Reference

## 1. Назначение документа

Этот документ является единым техническим референсом для разработки:

```text
SoulShard Warm Crystal Collection Burst
```

в проекте:

```text
Fifteen Shards of Light
```

Репозиторий:

```text
MindDevastation/fifteen-shards-of-light
```

Движок и язык:

```text
Godot 4.x
GDScript
```

Канонический путь документа в репозитории:

```text
docs/design/SoulShard_Warm_Crystal_Collection_Burst_Development_Reference.md
```

Документ предназначен для:

- подготовки и выполнения Codex-задачи;
- безопасной декомпозиции разработки на небольшие slices;
- сохранения принятого Charge Anticipation;
- визуальной переработки только Collection Burst;
- code review фактического GitHub diff;
- runtime validation;
- ручной визуальной приемки;
- контроля scope;
- предотвращения случайных изменений Reward Overlay, Interaction Prompt, SoulOrb и gameplay flow;
- создания implementation summary после завершения разработки.

Этот документ является source of truth для текущего slice.

Если фактический репозиторий расходится с этим документом, Codex должен:

1. выполнить preflight;
2. описать расхождение;
3. не выдумывать отсутствующую архитектуру;
4. предложить минимальную адаптацию;
5. ждать `APPLY` перед изменениями.

---

## 2. Актуальный проектный baseline

На момент подготовки reference завершены и приняты:

- SoulShard idle VFX;
- World Interaction Prompt;
- Charge Anticipation;
- исправление terminal hidden state Interaction Prompt;
- reward sequence integration;
- Reward Overlay functional flow;
- SoulOrb return flow.

Последний подтвержденный merge, относящийся к этому flow:

```text
PR #75
Fix Charge Anticipation timing and prompt hide state
Merge commit: 940cdbbe61fa9385b9ded9f93dbaffb57f6c6ad8
```

Codex не должен считать этот SHA автоматически актуальным `main`.

Перед началом разработки необходимо получить фактический текущий `main`.

Полный interaction flow:

```text
Игрок подходит к SoulShard
→ появляется WorldInteractionPrompt
→ игрок нажимает E
→ prompt проигрывает confirm и исчезает
→ Charge Anticipation длительностью 1.2 секунды
→ свет собирается внутрь
→ один мягкий Heart Response
→ restrained compression
→ terminal hold 0.06 секунды
→ _play_world_burst()
→ Collection Burst
→ reward_sequence_requested
→ Reward Overlay
→ подтверждение
→ свет возвращается к SoulOrb
→ SoulShard завершает collection sequence
→ управление восстанавливается
```

Граница нового slice:

```text
вход:
_on_charge_finished()
→ _play_world_burst()

выход:
существующий reward request/completion flow
```

---

## 3. Эмоциональная цель

Текущий Collection Burst выполняет функцию технического исчезновения:

```text
кристалл скрывается
→ холодные mint-green particles быстро разлетаются
```

Целевой эмоциональный beat:

```text
сжатый внутренний свет раскрывается
→ появляется короткое теплое кристальное сияние
→ золотистые искры мягко расходятся наружу
→ несколько световых лепестков остаются в воздухе
→ мир принимает освобожденный свет
```

Центральный визуальный образ:

```text
не взрыв, а раскрытие света
```

Дополнительный образ:

```text
теплый кристалл рассыпается не на осколки,
а на живые частицы света
```

Эмоциональный смысл:

```text
внутренний свет освобожден бережно
```

Эффект должен ощущаться:

- теплым;
- романтическим;
- локальным;
- кристальным;
- мягко магическим;
- чистым;
- светлым;
- коротким;
- эмоционально читаемым;
- связанным с предыдущим Charge Anticipation;
- более красивым, чем текущий технический burst;
- достаточно restrained, чтобы Reward Overlay оставался следующим главным beat.

Эффект не должен выглядеть как:

- взрыв;
- граната;
- fireworks;
- confetti;
- боевое заклинание;
- ice shatter;
- sci-fi teleport;
- healing spell зеленого цвета;
- poison cloud;
- электрический разряд;
- ударная волна;
- shockwave ring;
- torus;
- bubble aura;
- дым;
- пыль;
- агрессивный flash;
- fullscreen bloom;
- camera-facing spectacle;
- boss death;
- power-up;
- screen wipe.

---

## 4. Результаты предыдущей ручной приемки

Charge Anticipation принят по видео.

Подтверждено:

```text
Idle preservation: PASS
Prompt confirm/hide: PASS
Charge continuity: PASS
Gathering inward: PASS
Heart response: PASS
Compression: PASS
Micro-pause: PASS
Charge overexposure: PASS
Burst handoff: PASS
Reward flow for one shard: PASS
```

Текущий burst остается отдельным незавершенным визуальным элементом.

Наблюдаемая проблема текущего burst:

- цвет заметно холоднее принятого SoulShard;
- dominant hue уходит в mint/cyan-green;
- частицы крупные;
- скорость разлета высокая;
- форма читается как стандартный radial particle explosion;
- отсутствует теплый локальный bloom;
- отсутствует мягкий lingering accent;
- burst эмоционально не продолжает Charge Anticipation;
- текущий burst выглядит техническим placeholder относительно принятого idle/charge polish.

---

## 5. Фактическая текущая архитектура

Основные файлы:

```text
scenes/core/SoulShard.tscn
scripts/soul/soul_shard.gd
```

Текущий particle node:

```text
SoulShard/CollectionBurst
```

Тип:

```text
GPUParticles3D
```

Текущий script reference:

```gdscript
@onready var collection_burst: GPUParticles3D = $CollectionBurst
```

Текущий handoff:

```gdscript
func _play_world_burst() -> void:
    _state = CollectionState.BURSTING
    visual_root.visible = false
    ground_vfx_root.visible = false
    collection_burst.global_position = global_position
    collection_burst.restart()
    collection_burst.emitting = true
```

После `_play_world_burst()` текущий flow немедленно продолжает:

```gdscript
_request_or_complete_collection()
```

Reward flow не ожидает завершения particles.

Это поведение сохраняется.

---

## 6. Текущие параметры CollectionBurst

Текущий `CollectionBurst`:

```text
amount = 28
lifetime = 0.9
one_shot = true
explosiveness = 0.92
randomness = 0.45
fixed_fps = 30
visibility_aabb = 3.6 × 3.6 × 3.6
```

Текущий process material:

```text
emission_shape = sphere
emission_sphere_radius = 0.12
spread = 180 degrees
initial_velocity = 0.85-1.45
angular_velocity = -2.0...2.0
gravity = Vector3(0, 0.04, 0)
damping = 0.15-0.35
scale = 0.10-0.22
color = pale mint
```

Текущий draw material:

```text
texture = assets/vfx/soul_shard_spark.png
albedo = pale mint
emission = cyan-green
emission_energy_multiplier = 1.35
billboard = enabled
```

Текущая проблема не в том, что node не работает.

Проблема в:

- palette;
- scale;
- speed;
- lack of visual hierarchy;
- lack of local bloom;
- lack of lingering warm accent.

---

## 7. Что уже принято и заморожено

### 7.1 Charge Anticipation

Charge Anticipation завершен.

Заморожены:

```text
charge_duration = 1.2
CHARGE_TERMINAL_HOLD_SECONDS = 0.06

Phase A: 0.00-0.15
Phase B: 0.15-0.70
Phase C: 0.70-0.88
Phase D: 0.88-1.00
```

Заморожены:

- normalized `_charge_progress`;
- один stored `_charge_tween`;
- heartbeat continuity capture;
- gathering multipliers;
- Heart Response;
- compression;
- charge runtime ownership;
- `_on_charge_finished()` guard;
- место вызова `_play_world_burst()`.

Warm Crystal Collection Burst не должен менять Charge Anticipation.

### 7.2 WorldInteractionPrompt

Заморожены:

```text
scenes/ui/WorldInteractionPrompt.tscn
scripts/ui/world_interaction_prompt.gd
```

Не менять:

- prompt styling;
- prompt text;
- show/hide/confirm animations;
- screen tracking;
- terminal hidden-state fix;
- PromptAnchor;
- interaction semantics.

### 7.3 Reward flow

Заморожены:

```text
scripts/core/shard_reward_sequence_controller.gd
scenes/core/ShardRewardSequenceController.tscn
scripts/ui/shard_reward_overlay.gd
scenes/ui/ShardRewardOverlay.tscn
```

Не менять:

- `reward_sequence_requested`;
- controller state machine;
- control locking;
- Reward Overlay opening;
- confirmation;
- return-to-SoulOrb;
- completion;
- player control restoration.

### 7.4 SoulShard public API

Не менять:

```gdscript
signal collected
signal reward_sequence_requested(...)

func can_player_interact(...)
func interact(...)
func complete_collection_sequence()
```

### 7.5 Gameplay

Не менять:

- player;
- camera;
- levels;
- portals;
- save/progress;
- InputMap;
- collisions;
- interaction range;
- shard IDs;
- reward text.

---

## 8. Scope

### 8.1 Разрешенные production files

Основные разрешенные файлы:

```text
scenes/core/SoulShard.tscn
scripts/soul/soul_shard.gd
```

Обязательный новый summary:

```text
docs/development/SoulShard_Warm_Crystal_Collection_Burst_Implementation_Summary.md
```

Этот design reference может быть обновлен только для:

- фактических final values;
- результатов video review;
- обнаруженных ограничений;
- metadata реализации.

### 8.2 Допустимые новые scene nodes

Допускается добавить только burst-specific nodes:

```text
CollectionPetalBurst
CollectionBloomRoot
CollectionOuterBloom
CollectionInnerBloom
```

Названия могут незначительно отличаться, но ответственность должна оставаться очевидной.

Существующий node:

```text
CollectionBurst
```

должен сохраниться.

Не переименовывать его без доказанной необходимости.

### 8.3 Допустимые ресурсы

Разрешено использовать только существующие runtime textures:

```text
assets/vfx/soul_shard_spark.png
assets/vfx/soul_shard_light_petal.png
assets/vfx/soul_shard_halo.png
```

Допускается использование:

```text
assets/vfx/soul_shard_light_arc.png
```

только если preflight докажет, что он дает полезный restrained crystal accent без ring/shockwave эффекта.

По умолчанию light arc в реализации не требуется.

### 8.4 Запрещено

Не добавлять:

- новые PNG;
- новые imported assets;
- новые shaders;
- new shader files;
- new audio;
- new lights;
- camera shake;
- post-processing;
- fullscreen CanvasLayer flash;
- SubViewport;
- autoload;
- singleton;
- global VFX manager;
- object pooling framework;
- gameplay event bus;
- new state machine;
- delayed reward request;
- await particle completion before reward flow.

---

## 9. Целевая многослойная структура

Burst должен состоять максимум из четырех визуальных компонентов:

```text
Layer 1 - Inner Bloom
Layer 2 - Outer Bloom
Layer 3 - Warm Crystal Sparks
Layer 4 - Soft Petal Accents
```

Компоненты должны работать как один короткий beat.

### 9.1 Layer 1 - Inner Bloom

Функция:

```text
короткий теплый центр освобождения
```

Визуально:

- маленький;
- яркий;
- warm ivory;
- быстро раскрывается;
- быстро исчезает;
- не становится белым fullscreen flash.

Рекомендуемая реализация:

```text
MeshInstance3D
QuadMesh
billboard StandardMaterial3D
texture: soul_shard_spark.png
```

### 9.2 Layer 2 - Outer Bloom

Функция:

```text
мягко раскрыть свет вокруг точки кристалла
```

Визуально:

- больше Inner Bloom;
- ниже по яркости;
- теплый gold/peach;
- плавно расширяется;
- исчезает раньше lingering petals;
- не выглядит круговой ударной волной.

Рекомендуемая реализация:

```text
MeshInstance3D
QuadMesh
billboard StandardMaterial3D
texture: soul_shard_halo.png
```

### 9.3 Layer 3 - Warm Crystal Sparks

Функция:

```text
основное кристальное освобождение
```

Это существующий `CollectionBurst`, переработанный в warm spark layer.

Визуально:

- небольшие sparks;
- теплый gold/ivory;
- короткий radial release;
- быстро замедляются;
- не летят далеко;
- не выглядят как крупные снежки;
- не имеют cyan-green dominant hue.

### 9.4 Layer 4 - Soft Petal Accents

Функция:

```text
дать эмоциональный мягкий хвост после основного release
```

Визуально:

- 5-8 частиц;
- peach/rose-gold;
- медленнее sparks;
- немного поднимаются;
- расходятся неравномерно;
- исчезают мягко;
- не выглядят как confetti.

Рекомендуемая реализация:

```text
GPUParticles3D
texture: soul_shard_light_petal.png
```

---

## 10. Целевой runtime beat

Нормализованная временная последовательность после `_play_world_burst()`:

```text
T+0.00
VisualRoot и GroundVFXRoot скрываются
Inner Bloom появляется
Outer Bloom появляется
Warm Crystal Sparks запускаются

T+0.04
Soft Petal Accents запускаются или уже начинают движение

T+0.08-0.18
Inner Bloom достигает пика и исчезает

T+0.18-0.42
Outer Bloom расширяется и мягко исчезает

T+0.00-0.72
Warm Crystal Sparks расходятся и затухают

T+0.04-1.00
Soft Petal Accents поднимаются и исчезают

reward flow
запускается без дополнительной задержки,
как и до изменения burst
```

Сильнейшая визуальная точка должна приходиться на:

```text
первые 0.08-0.18 секунды
```

К моменту, когда Reward Overlay становится визуально доминирующим:

- burst уже должен ослабевать;
- world effect не должен конкурировать с UI;
- lingering petals могут оставаться, но не должны отвлекать.

---

## 11. Цветовая палитра

Основная палитра:

```text
Warm ivory
Golden amber
Soft peach
Restrained rose accent
```

Запрещенный dominant hue:

```text
cyan
mint green
cold turquoise
electric blue
acid green
```

Reference colors в sRGB-смысле:

```text
Warm ivory: #FFF1CF
Soft gold:  #FFD083
Peach:      #FFAA82
Rose accent:#F9909D
```

Допустимые Godot-style стартовые значения:

```gdscript
Color(1.0, 0.92, 0.75, 0.80)
Color(1.0, 0.70, 0.34, 0.68)
Color(1.0, 0.46, 0.32, 0.42)
Color(1.0, 0.35, 0.42, 0.24)
```

Это initial targets, а не требование копировать значения без проверки.

Ограничения:

- warm ivory может быть самым ярким только в Inner Bloom;
- gold должен быть dominant particle color;
- peach и rose используются как accents;
- burst не должен становиться полностью розовым;
- burst не должен становиться белым пятном;
- цвет персонажа и окружения должен сохраняться.

---

## 12. Initial target values - Warm Crystal Sparks

Существующий `CollectionBurst` сохраняется как основной spark layer.

Рекомендуемые стартовые значения:

```text
amount = 24
lifetime = 0.72
one_shot = true
explosiveness = 0.96
randomness = 0.38
fixed_fps = 30
```

Process material:

```text
emission_shape = sphere
emission_sphere_radius = 0.08
spread = 180
initial_velocity_min = 0.48
initial_velocity_max = 0.88
angular_velocity_min = -1.4
angular_velocity_max = 1.4
gravity = Vector3(0, 0.04, 0)
damping_min = 0.48
damping_max = 0.85
scale_min = 0.045
scale_max = 0.11
```

Draw material:

```text
texture = soul_shard_spark.png
transparency = enabled
blend_mode = additive
billboard = enabled
albedo = warm ivory/gold
emission = warm gold
emission_energy_multiplier = 0.95-1.15
```

Recommended starting material:

```gdscript
albedo_color = Color(1.0, 0.84, 0.58, 0.70)
emission = Color(1.0, 0.62, 0.28, 1.0)
emission_energy_multiplier = 1.05
```

Tuning boundaries:

```text
amount: 20-28
lifetime: 0.62-0.82
velocity max: 0.75-1.00
scale max: 0.09-0.13
emission energy: 0.85-1.25
```

Не выходить за boundaries без video evidence.

---

## 13. Initial target values - Soft Petal Accents

Новый node:

```text
CollectionPetalBurst
```

Рекомендуемые стартовые значения:

```text
amount = 7
lifetime = 1.0
one_shot = true
explosiveness = 0.90
randomness = 0.72
fixed_fps = 24
```

Process material:

```text
emission_shape = sphere
emission_sphere_radius = 0.10
direction = Vector3(0, 1, 0)
spread = 145
initial_velocity_min = 0.18
initial_velocity_max = 0.42
angular_velocity_min = -1.2
angular_velocity_max = 1.2
gravity = Vector3(0, 0.035, 0)
damping_min = 0.24
damping_max = 0.52
scale_min = 0.035
scale_max = 0.075
```

Draw material:

```text
texture = soul_shard_light_petal.png
transparency = enabled
blend_mode = additive
billboard = enabled
albedo = peach/rose-gold
emission = warm peach
emission_energy_multiplier = 0.45-0.70
```

Recommended starting material:

```gdscript
albedo_color = Color(1.0, 0.48, 0.36, 0.34)
emission = Color(1.0, 0.38, 0.24, 1.0)
emission_energy_multiplier = 0.58
```

Tuning boundaries:

```text
amount: 5-8
lifetime: 0.85-1.15
velocity max: 0.34-0.50
scale max: 0.06-0.085
emission energy: 0.40-0.75
```

Petals должны оставаться вторичным accent.

---

## 14. Initial target values - Inner Bloom

Новый node:

```text
CollectionBloomRoot/CollectionInnerBloom
```

Recommended mesh:

```text
QuadMesh
size approximately 0.34 × 0.34
```

Recommended texture:

```text
soul_shard_spark.png
```

Initial animation:

```text
duration = 0.18 seconds
start scale = 0.18
peak scale = 0.62
start alpha = 0.56
end alpha = 0.0
start emission = 1.25
end emission = 0.20
```

Character:

- compact;
- bright;
- no overshoot;
- no bounce;
- no hard white frame;
- does not fill more than local shard area.

Tuning boundaries:

```text
duration: 0.14-0.22
peak scale: 0.50-0.72
start alpha: 0.42-0.64
start emission: 1.0-1.45
```

---

## 15. Initial target values - Outer Bloom

Новый node:

```text
CollectionBloomRoot/CollectionOuterBloom
```

Recommended mesh:

```text
QuadMesh
size approximately 0.90 × 1.05
```

Recommended texture:

```text
soul_shard_halo.png
```

Initial animation:

```text
duration = 0.42 seconds
start scale = 0.22
end scale = 0.92
start alpha = 0.28
end alpha = 0.0
start emission = 0.72
end emission = 0.12
```

Character:

- soft;
- warm;
- local;
- expands without ring edge;
- no shockwave;
- no hard geometric circle.

Tuning boundaries:

```text
duration: 0.34-0.48
end scale: 0.78-1.02
start alpha: 0.20-0.34
start emission: 0.52-0.88
```

---

## 16. Target scene structure

Предпочтительная структура:

```text
SoulShard
├── GroundVFXRoot
├── VisualRoot
├── CollisionShape3D
├── PromptAnchor
├── WorldInteractionPrompt
├── CollectionBurst
├── CollectionPetalBurst
├── CollectionBloomRoot
│   ├── CollectionOuterBloom
│   └── CollectionInnerBloom
└── ...
```

`CollectionBurst` остается существующим node.

`CollectionPetalBurst`:

- root-level sibling;
- one_shot;
- emitting false;
- локализуется в точке SoulShard.

`CollectionBloomRoot`:

- root-level Node3D;
- по умолчанию hidden;
- устанавливается в world position shard;
- не является child скрываемого `VisualRoot`;
- не является child скрываемого `GroundVFXRoot`.

Bloom nodes:

- cast_shadow = off;
- billboard materials;
- hidden through root until burst;
- materials duplicated per SoulShard instance.

---

## 17. Target script architecture

Новые references:

```gdscript
@onready var collection_petal_burst: GPUParticles3D = $CollectionPetalBurst
@onready var collection_bloom_root: Node3D = $CollectionBloomRoot
@onready var collection_outer_bloom: MeshInstance3D = $CollectionBloomRoot/CollectionOuterBloom
@onready var collection_inner_bloom: MeshInstance3D = $CollectionBloomRoot/CollectionInnerBloom
```

Новые private state fields допускаются:

```gdscript
var _collection_bloom_tween: Tween
var _collection_bloom_progress := 0.0
var _collection_outer_bloom_material: StandardMaterial3D
var _collection_inner_bloom_material: StandardMaterial3D
```

Рекомендуемая ответственность:

```text
_setup_collection_bloom_materials()
→ duplicate per-instance materials
→ assign material_override

_start_collection_burst_visuals()
→ reset burst-specific state
→ position all layers
→ restart particle emitters
→ start bloom tween

_set_collection_bloom_progress(value)
→ clamp normalized progress
→ apply deterministic scale/alpha/emission

_apply_collection_bloom_visuals(progress)
→ no cumulative multiplication
→ baseline-derived values only

_finish_collection_bloom()
→ hide bloom root
→ clear tween reference
```

Допускаются другие private names, если ownership остается очевидным.

---

## 18. Modified `_play_world_burst()` contract

`_play_world_burst()` должен оставаться единственным central handoff.

Целевой contract:

```gdscript
func _play_world_burst() -> void:
    _state = CollectionState.BURSTING
    visual_root.visible = false
    ground_vfx_root.visible = false
    _start_collection_burst_visuals()
```

После него существующий caller продолжает:

```gdscript
_request_or_complete_collection()
```

Запрещено:

- переносить reward request в bloom tween callback;
- await burst lifetime;
- await bloom;
- добавлять reward delay;
- менять controller state;
- вызывать reward signal второй раз;
- завершать shard из burst callback.

Burst является presentation-only layer.

---

## 19. Bloom progress architecture

Рекомендуется один stored tween только для bloom meshes:

```text
_collection_bloom_progress: 0.0 → 1.0
```

Общий tween duration:

```text
0.42 seconds
```

Inner Bloom использует remapped subrange:

```text
0.00-0.43
```

что приблизительно соответствует:

```text
0.18 seconds
```

Outer Bloom использует полный range:

```text
0.00-1.00
```

Пример:

```gdscript
var inner_progress := _remap_clamped(progress, 0.0, 0.43)
var outer_progress := progress
```

Easing:

```text
scale: SINE / EASE_OUT
alpha: smooth fade
emission: smooth fade
```

Не использовать:

- elastic;
- back overshoot;
- bounce;
- stepped animation;
- multiple competing bloom tweens.

---

## 20. Baseline and reset safety

До запуска burst необходимо детерминированно сбрасывать:

```text
particle positions through restart()
particle emitting state
bloom root position
bloom root visibility
inner bloom scale
outer bloom scale
inner material alpha
outer material alpha
inner emission
outer emission
bloom progress
```

Повторный вызов на другом SoulShard instance не должен наследовать:

- scale;
- alpha;
- emission;
- tween;
- global position;
- visibility;
- particle state.

Все bloom material mutations должны выполняться на per-instance duplicated materials.

Запрещено изменять shared material subresources напрямую во время runtime.

---

## 21. Particle lifecycle safety

Для каждого `GPUParticles3D`:

```gdscript
global_position = global_position
restart()
emitting = true
```

Порядок должен быть детерминирован.

Не полагаться на previous `emitting` state.

Scene defaults:

```text
emitting = false
one_shot = true
```

Не добавлять manual timers только для выключения one-shot particles.

Не queue_free burst nodes.

Они принадлежат SoulShard instance.

---

## 22. Visual ownership

Ownership:

```text
Charge Anticipation
→ управляет VisualRoot до handoff

Collection Burst
→ начинает ownership после _play_world_burst()

Reward Overlay
→ screen-space UI, начинается существующим flow
```

После `_play_world_burst()`:

- Charge Anticipation больше не пишет visual properties;
- VisualRoot hidden;
- bloom и burst layers независимы от VisualRoot;
- Reward Overlay не управляет burst nodes;
- burst не управляет overlay.

Не создавать cross-system references.

---

## 23. Reward timing

Текущий reward request запускается сразу после burst handoff.

Это сохраняется.

Причины:

- gameplay flow уже работает;
- player controls уже блокируются controller;
- Reward Overlay opening имеет собственный визуальный темп;
- burst должен стать достаточно коротким, чтобы не требовать дополнительной задержки;
- изменение reward timing расширит scope.

Acceptance:

```text
burst начинает визуальный release
→ reward flow запускается как раньше
→ сильнейшая часть burst уже проходит,
когда overlay становится читаемым
```

Если video показывает жесткую конкуренцию burst и overlay:

- сначала тюнинговать burst duration/intensity;
- не добавлять reward delay без отдельного решения.

---

## 24. Performance constraints

Максимально допустимая target complexity:

```text
2 GPUParticles3D emitters
2 MeshInstance3D bloom layers
1 short bloom tween
0 new lights
0 new shaders
0 new textures
```

Particle budget:

```text
Warm sparks: 20-28
Petal accents: 5-8
Total: not more than 36
```

Ожидаемый burst duration:

```text
visible primary effect: <= 0.8 sec
lingering accent: <= 1.15 sec
```

Не добавлять:

- continuous emitters;
- preprocess for one-shot burst;
- excessive AABB;
- dynamic mesh creation every burst;
- material duplication every burst;
- per-frame allocation-heavy loops.

Materials duplicate один раз в `_ready()`.

---

## 25. Visual acceptance criteria

### 25.1 Warm palette

PASS:

- dominant hue warm gold/ivory;
- peach/rose только accents;
- нет mint-green impression;
- нет cold cyan core.

FAIL:

- burst выглядит зеленым;
- burst выглядит ледяным;
- burst выглядит blue-white.

### 25.2 Local scale

PASS:

- эффект остается возле shard;
- particles не заполняют экран;
- bloom не перекрывает персонажа полностью;
- мир сохраняет детали.

FAIL:

- fullscreen flash;
- большая белая сфера;
- particles улетают далеко;
- burst перекрывает UI.

### 25.3 Emotional continuity

PASS:

```text
compression
→ warm release
→ soft lingering light
```

FAIL:

```text
compression
→ unrelated mint explosion
```

### 25.4 Crystal readability

PASS:

- sparks небольшие;
- движение быстрое, но не агрессивное;
- начало compact;
- particles быстро замедляются;
- bloom создает ощущение crystal light release.

FAIL:

- крупные blobs;
- snowballs;
- smoke;
- dust;
- confetti.

### 25.5 Petal restraint

PASS:

- 5-8 accents;
- low alpha;
- lingering;
- secondary.

FAIL:

- dominant petals;
- цветочный фейерверк;
- розовое confetti;
- слишком медленные крупные карточки.

### 25.6 Bloom restraint

PASS:

- Inner Bloom читается как compact light release;
- Outer Bloom мягко расширяется;
- нет hard edge;
- нет ring.

FAIL:

- shockwave;
- bubble;
- torus;
- white flash;
- camera lens flare.

---

## 26. Known risks

### Risk 1 - Green tint remains

Причина:

- старый process material color не заменен;
- draw material emission остается cyan-green;
- texture/material tint mix дает холодный результат.

Mitigation:

- проверять process material и draw material вместе;
- review на светлом и темном фоне.

### Risk 2 - Particles remain explosive

Причина:

- velocity остается 0.85-1.45;
- damping слишком низкий;
- scale слишком большой.

Mitigation:

- уменьшить velocity;
- повысить damping;
- уменьшить particle scale.

### Risk 3 - Bloom looks like shockwave

Причина:

- слишком большой Outer Bloom;
- высокий alpha;
- резкая граница halo texture;
- слишком линейное расширение.

Mitigation:

- restrained scale;
- low alpha;
- short fade;
- no arc/ring texture by default.

### Risk 4 - Reward Overlay competes with burst

Причина:

- burst слишком яркий или длинный;
- petals слишком многочисленные;
- bloom остается visible.

Mitigation:

- primary effect <= 0.8 sec;
- outer bloom <= 0.48 sec;
- petals low alpha;
- do not delay reward flow.

### Risk 5 - Shared material drift

Причина:

- runtime mutates scene subresource;
- multiple shards share material.

Mitigation:

- duplicate materials per instance in `_ready()`.

### Risk 6 - Second shard inherits state

Причина:

- bloom values not reset;
- tween not killed;
- visibility not reset;
- particle restart order inconsistent.

Mitigation:

- deterministic reset;
- stored tween lifecycle;
- two-shard runtime test.

### Risk 7 - Burst disappears when VisualRoot hides

Причина:

- new burst layers placed under VisualRoot.

Mitigation:

- burst layers must be root-level siblings.

### Risk 8 - Multiple burst handoffs

Причина:

- new callback invokes burst or reward flow again.

Mitigation:

- `_play_world_burst()` remains one call site;
- no reward call from tween callbacks.

---

## 27. Development decomposition

Разработка разделена на mandatory preflight и пять implementation/validation slices.

```text
WB-0 Baseline Inspection
WB-1 Burst Lifecycle Foundation
WB-2 Warm Crystal Spark Layer
WB-3 Soft Petal Accent Layer
WB-4 Local Bloom and Integration Polish
WB-5 Runtime and Visual Validation
```

WB-0 не является implementation slice.

Пять основных slices:

```text
WB-1
WB-2
WB-3
WB-4
WB-5
```

Перед реализацией Codex должен выполнить preflight всех пяти slices и ждать `APPLY`.

После `APPLY`:

- выполнять slices строго последовательно;
- полностью завершать slice;
- выполнять checks;
- создавать отдельный commit;
- сразу переходить к следующему slice;
- не ждать дополнительной команды между slices.

---

# WB-0 - Baseline Inspection

## Цель

Подтвердить фактическую архитектуру до изменений.

## Обязательная проверка

Проверить:

```text
current main SHA
working tree
applicable AGENTS.md
SoulShard.tscn node tree
CollectionBurst resources
soul_shard.gd burst handoff
reward request flow
PR #75 merged state
existing VFX textures
serialized overrides
```

Зафиксировать:

```text
current CollectionBurst values
current _play_world_burst()
current reward handoff
current changed-file expectations
```

## Запрещено

- изменять файлы;
- создавать ветку;
- создавать commits;
- создавать PR;
- добавлять resources.

## Результат

Полный preflight report для WB-1...WB-5.

---

# WB-1 - Burst Lifecycle Foundation

## Цель

Подготовить безопасную runtime foundation для новых burst layers без визуального финального тюнинга.

## Разрешенные файлы

```text
scenes/core/SoulShard.tscn
scripts/soul/soul_shard.gd
```

## Задачи

1. Добавить burst-specific node references.
2. Добавить `CollectionPetalBurst`.
3. Добавить `CollectionBloomRoot`.
4. Добавить `CollectionOuterBloom`.
5. Добавить `CollectionInnerBloom`.
6. Настроить defaults:

```text
particles emitting = false
particles one_shot = true
bloom root visible = false
cast shadows = false
```

7. Duplicate bloom materials per instance.
8. Добавить stored bloom tween lifecycle.
9. Добавить deterministic reset methods.
10. Сохранить существующий CollectionBurst path.
11. Не менять reward handoff.
12. Не выполнять final palette tuning в этом slice.

## Acceptance criteria

- project parses;
- nodes resolve;
- no null references;
- bloom materials are instance-local;
- bloom root is outside VisualRoot;
- existing burst still can play;
- reward flow unchanged;
- no new public API.

## Commit

```text
Add Warm Crystal Collection Burst lifecycle foundation
```

---

# WB-2 - Warm Crystal Spark Layer

## Цель

Переработать существующий `CollectionBurst` из mint explosion в warm restrained crystal spark release.

## Разрешенные файлы

```text
scenes/core/SoulShard.tscn
```

`soul_shard.gd` изменять только при доказанной lifecycle необходимости.

## Задачи

1. Изменить palette.
2. Уменьшить particle scale.
3. Уменьшить velocity.
4. Повысить damping.
5. Сократить lifetime.
6. Настроить amount.
7. Сохранить one-shot.
8. Сохранить existing spark texture.
9. Не добавлять новый emitter для тех же sparks.
10. Проверить visibility AABB.

## Initial targets

Использовать значения раздела 12.

## Acceptance criteria

- dominant hue warm;
- no cyan-green;
- particles smaller;
- release local;
- no snowballs;
- no major overexposure;
- one-shot remains stable.

## Commit

```text
Retune SoulShard collection sparks to warm crystal release
```

---

# WB-3 - Soft Petal Accent Layer

## Цель

Добавить мягкий lingering accent после primary spark release.

## Разрешенные файлы

```text
scenes/core/SoulShard.tscn
scripts/soul/soul_shard.gd
```

## Задачи

1. Настроить `CollectionPetalBurst`.
2. Использовать existing light petal texture.
3. Установить restrained amount.
4. Сделать particles slower than sparks.
5. Добавить slight upward drift.
6. Установить low alpha warm peach/rose palette.
7. Запускать emitter в existing central burst start method.
8. Не менять reward flow.
9. Не добавлять timer для emitter.
10. Не делать petals dominant.

## Initial targets

Использовать значения раздела 13.

## Acceptance criteria

- petals visible but secondary;
- no confetti;
- no pink explosion;
- no large cards;
- particles fade within accepted duration;
- repeated shard instances work independently.

## Commit

```text
Add soft petal accents to SoulShard collection burst
```

---

# WB-4 - Local Bloom and Integration Polish

## Цель

Добавить compact Inner Bloom и soft Outer Bloom, затем интегрировать все layers в единый emotional beat.

## Разрешенные файлы

```text
scenes/core/SoulShard.tscn
scripts/soul/soul_shard.gd
```

## Задачи

1. Настроить Inner Bloom resource.
2. Настроить Outer Bloom resource.
3. Реализовать normalized bloom progress.
4. Реализовать deterministic scale/alpha/emission.
5. Запускать bloom вместе с particles.
6. Скрывать bloom root после tween.
7. Kill previous valid tween before start.
8. Не изменять Charge Anticipation.
9. Не изменять `_on_charge_finished()` semantics.
10. Не изменять reward request timing.
11. Не добавлять new light.
12. Проверить second-instance reset.

## Initial targets

Использовать значения разделов 14-15.

## Acceptance criteria

- compact warm center;
- soft local outer bloom;
- no shockwave;
- no ring;
- no fullscreen flash;
- no cumulative material drift;
- one burst start;
- reward flow preserved.

## Commit

```text
Add local bloom to Warm Crystal Collection Burst
```

---

# WB-5 - Runtime and Visual Validation

## Цель

Проверить production safety и подготовить implementation summary.

## Разрешенные файлы

Кодовые fix-файлы только при обнаруженном доказанном defect.

Обязательный summary:

```text
docs/development/SoulShard_Warm_Crystal_Collection_Burst_Implementation_Summary.md
```

## Static validation

Выполнить:

```bash
git diff --check
godot --headless --path . --check-only --quit
timeout 20s godot --headless --path . --quit
```

Searches:

```bash
rg -n "_play_world_burst\\(" scripts/soul/soul_shard.gd
rg -n "reward_sequence_requested|_request_or_complete_collection" scripts/soul/soul_shard.gd
rg -n "CollectionBurst|CollectionPetalBurst|CollectionBloom" scenes/core/SoulShard.tscn scripts/soul/soul_shard.gd
rg -n "create_tween|tween_method|tween_interval" scripts/soul/soul_shard.gd
```

## Runtime checks

Проверить:

```text
idle
→ prompt
→ E
→ accepted Charge Anticipation
→ Warm Crystal Collection Burst
→ Reward Overlay
→ confirmation
→ return
→ controls restored
```

Обязательно два SoulShard подряд:

```text
collect SoulShard A
→ complete reward
→ collect SoulShard B
```

Проверить:

- second prompt works;
- second charge works;
- second burst starts;
- no inherited bloom alpha;
- no inherited bloom scale;
- no inherited material state;
- no duplicate particles;
- burst handoff once;
- reward flow twice;
- Output/Debugger without new errors.

## Visual video

Нужен ролик 10-16 секунд на один interaction или более длинный ролик с двумя shards.

Минимальный визуальный фрагмент:

```text
idle
→ prompt
→ E
→ full charge
→ full burst
→ beginning of overlay
```

Условия:

```text
three-quarter or frontal angle
side angle preferred
bright sky
dark rocks or foliage
player visible
```

Review checklist:

```text
warm dominant hue
no mint/cyan
compact inner bloom
soft outer bloom
small sparks
petals secondary
no shockwave
no fullscreen flash
no player overexposure
burst reads after compression
overlay not visually blocked
```

## Summary

Создать:

```text
docs/development/SoulShard_Warm_Crystal_Collection_Burst_Implementation_Summary.md
```

## Commit

```text
Validate and document Warm Crystal Collection Burst
```

---

## 28. Implementation summary requirements

Summary должен содержать:

```text
1. Task reference
2. Repository instructions used
3. Initial architecture
4. Final architecture
5. Files modified
6. Files created
7. Public API status
8. WB-1 implementation
9. WB-2 implementation
10. WB-3 implementation
11. WB-4 implementation
12. WB-5 validation
13. Final node tree
14. Final particle values
15. Final bloom values
16. Tween lifecycle
17. Material duplication
18. Reset behavior
19. Burst handoff
20. Reward flow preservation
21. Automated validation
22. Runtime validation
23. Manual video requirements/results
24. Known limitations
25. Branch and commits
26. PR metadata
27. Scope confirmation
```

Summary должен отличать:

```text
PASS BY CODE
PASS BY HEADLESS CHECK
PASS BY VIDEO
NOT VERIFIED
```

Не утверждать visual PASS без видео.

---

## 29. Git workflow

Предпочтительная ветка:

```text
feature/soul-shard-warm-crystal-collection-burst
```

Создавать от фактического актуального `main`.

Предпочтительный PR title:

```text
Polish SoulShard warm crystal collection burst
```

Ожидаемые commits:

```text
1. Add Warm Crystal Collection Burst lifecycle foundation
2. Retune SoulShard collection sparks to warm crystal release
3. Add soft petal accents to SoulShard collection burst
4. Add local bloom to Warm Crystal Collection Burst
5. Validate and document Warm Crystal Collection Burst
```

Если GitHub tooling squash-ит commits:

- сохранить локальные commit SHAs в summary;
- фактический GitHub head считать authoritative;
- не выдумывать remote history.

Не merge PR автоматически.

Final merge verdict до video review:

```text
WAIT FOR VIDEO
```

---

## 30. Changed-files expectation

Ожидаемые production changes:

```text
scenes/core/SoulShard.tscn
scripts/soul/soul_shard.gd
```

Expected documentation:

```text
docs/development/SoulShard_Warm_Crystal_Collection_Burst_Implementation_Summary.md
```

Reference может быть обновлен:

```text
docs/design/SoulShard_Warm_Crystal_Collection_Burst_Development_Reference.md
```

Не должны изменяться:

```text
scripts/ui/world_interaction_prompt.gd
scenes/ui/WorldInteractionPrompt.tscn
scripts/core/shard_reward_sequence_controller.gd
scenes/core/ShardRewardSequenceController.tscn
scripts/ui/shard_reward_overlay.gd
scenes/ui/ShardRewardOverlay.tscn
scripts/player/*
scenes/levels/*
project.godot
assets/vfx/*
*.import
.godot/*
```

Assets используются, но не изменяются.

---

## 31. Test-impact checklist

Перед каждым slice Codex должен проверить влияние на:

```text
SoulShard state machine
interaction gating
prompt hide
charge tween
charge handoff
VisualRoot visibility
GroundVFXRoot visibility
burst one-shot state
particle restart
reward request
overlay opening
player controls
collection completion
second shard instance
legacy no-listener flow
```

Особенно важно:

```text
presentation change не должна становиться gameplay dependency
```

---

## 32. Failure conditions

Задача считается невыполненной, если:

- burst остается mint/cyan;
- новый burst выглядит как explosion;
- bloom становится fullscreen;
- добавлена камера shake;
- добавлен новый light;
- Reward Overlay задержан;
- reward request перенесен в tween callback;
- Charge Anticipation изменен;
- prompt изменен;
- public API изменен;
- particles находятся под VisualRoot и исчезают вместе с ним;
- shared materials мутируют между shards;
- второй shard наследует burst state;
- нет implementation summary;
- visual PASS заявлен без видео;
- unrelated files изменены.

---

## 33. Definition of Done

Implementation DoD:

```text
- WB-0 preflight complete
- WB-1 complete
- WB-2 complete
- WB-3 complete
- WB-4 complete
- WB-5 static/headless validation complete
- implementation summary created
- scope clean
- PR created
- video requested
```

Visual DoD:

```text
- warm palette accepted
- crystal sparks accepted
- petal restraint accepted
- inner bloom accepted
- outer bloom accepted
- no overexposure
- no UI competition
- two-shard sequence accepted
```

Merge DoD:

```text
- code review PASS
- runtime PASS
- visual PASS
- two-shard PASS
- GitHub head verified
- no blockers
```

---

## 34. Final scope statement

В этот slice входят только:

```text
Warm Crystal Collection Burst
```

В него входят:

- retune existing CollectionBurst;
- warm spark palette;
- smaller slower sparks;
- new soft petal accent emitter;
- local Inner Bloom;
- local Outer Bloom;
- safe burst lifecycle;
- per-instance material safety;
- runtime validation;
- visual validation;
- implementation summary.

В него не входят:

- Charge Anticipation changes;
- Prompt changes;
- Reward Overlay changes;
- SoulOrb changes;
- audio;
- camera effects;
- level changes;
- narrative changes;
- player changes;
- Collection UI redesign;
- global VFX architecture.

Финальный emotional beat:

```text
внутренний свет сжимается
→ раскрывается теплым кристальным сиянием
→ мягко расходится искрами и лепестками
→ уступает место награде
```
