# SoulShard Charge Anticipation - Development Reference

## 1. Назначение документа

Этот документ является единым техническим референсом для разработки `SoulShard Charge Anticipation` в проекте:

```text
Fifteen Shards of Light
```

Репозиторий:

```text
MindDevastation/fifteen-shards-of-light
```

Движок:

```text
Godot 4.x + GDScript
```

Документ предназначен для:

- подготовки узких задач для Codex;
- реализации Charge Anticipation по безопасным шагам;
- code review фактического GitHub diff;
- проверки runtime safety;
- ручной визуальной приемки;
- контроля scope;
- предотвращения случайных изменений уже принятого SoulShard idle VFX;
- предотвращения преждевременной переработки Collection Burst или Reward Overlay.

---

## 2. Текущий контекст проекта

Stage 1 завершен.

Текущий playable route:

```text
StartScene
→ Level_01
→ ...
→ Level_15
→ FinalScene
→ E pedestal
→ EndingOverlay
```

Позже проект будет сокращен до 5-6 более сильных эмоциональных глав, но текущая техническая цепочка сохраняется до отдельной задачи.

Narrative flow, уровни и route не входят в Charge Anticipation.

---

## 3. Эмоциональная цель Charge Anticipation

Текущий технический beat:

```text
нажатие E
→ scale
→ усиление света
→ исчезновение
→ burst
```

Целевой эмоциональный beat:

```text
прикосновение
→ кристалл откликается
→ свет собирается внутрь
→ сердце делает один мягкий импульс
→ энергия сжимается
→ короткая микропауза
→ существующий burst
```

Центральный образ:

```text
вдох перед освобождением света
```

Эмоциональный смысл:

```text
внутренний свет ответил
```

Charge Anticipation должен ощущаться:

- теплым;
- бережным;
- живым;
- локальным;
- романтическим;
- спокойным;
- эмоционально читаемым;
- мягко магическим;
- неагрессивным.

Charge Anticipation не должен выглядеть как:

- взрыв;
- power-up;
- электрический заряд;
- boss attack;
- боевая магия;
- sci-fi эффект;
- энергетическая перегрузка;
- strobe;
- fullscreen flash;
- агрессивное overexposure;
- резиновая squash-анимация;
- teleport частиц;
- camera-facing spectacle.

---

## 4. Общий runtime flow

Полная последовательность вокруг текущего slice:

```text
Игрок подходит к SoulShard
→ появляется Interaction Prompt
→ игрок нажимает E
→ prompt проигрывает confirm и скрывается
→ запускается Charge Anticipation
→ вызывается существующий Collection Burst
→ запускается существующий reward flow
→ появляется reward overlay
→ игрок подтверждает reward
→ свет возвращается к SoulOrb
→ управление восстанавливается
```

Граница текущего slice:

```text
нажатие E
→ Charge Anticipation
→ вызов существующего _play_world_burst()
```

Внутренности Collection Burst не меняются.

Reward Overlay не меняется.

---

## 5. Что уже принято и заморожено

### 5.1 Interaction Prompt

Interaction Prompt завершен.

Основные файлы:

```text
scenes/ui/WorldInteractionPrompt.tscn
scripts/ui/world_interaction_prompt.gd
```

Charge Anticipation не должен менять:

- prompt scene;
- prompt styling;
- show/hide/confirm animation;
- world-to-screen tracking;
- PromptAnchor;
- camera controller;
- input behavior prompt.

### 5.2 SoulShard idle VFX

Idle VFX принят и не подлежит переработке без доказанной визуальной или технической проблемы.

Не менять без отдельного согласования:

- `CrystalHalo`;
- `HeartPulseHalo`;
- `CoreGlow`;
- orbit arcs;
- spiral motes в idle;
- ambient sparks;
- rare light petals;
- `GroundGlow`;
- `GlowLight`;
- `UnderGlowLight`;
- модель;
- runtime VFX textures;
- particle count;
- node count;
- scene composition.

Принятая архитектура:

```text
GroundVFXRoot
VisualRoot
```

`GroundVFXRoot` является sibling для `VisualRoot`.

Ground glow не должен подпрыгивать вместе с кристаллом.

### 5.3 Collection Burst

Collection Burst полностью заморожен в рамках этого slice.

Запрещено менять:

- particle amount;
- lifetime;
- explosiveness;
- particle material;
- fragment behavior;
- spark behavior;
- petal behavior;
- burst timing internals;
- burst textures;
- burst node tree.

Единственное допустимое действие:

```gdscript
_play_world_burst()
```

должен быть вызван после завершения Charge Anticipation.

### 5.4 Reward flow

Не менять:

- reward sequence;
- `ShardRewardSequenceController`;
- reward signals;
- SoulOrb flow;
- player control restoration;
- level progression;
- portal logic;
- save/progress;
- публичный interaction API;
- state machine semantics существующей коллекции.

---

## 6. Предпочтительные файлы

Основной файл:

```text
scripts/soul/soul_shard.gd
```

Допустим только при доказанной необходимости:

```text
scenes/core/SoulShard.tscn
```

Не менять:

```text
scenes/ui/WorldInteractionPrompt.tscn
scripts/ui/world_interaction_prompt.gd
scripts/ui/shard_reward_overlay.gd
scenes/ui/ShardRewardOverlay.tscn
scripts/core/shard_reward_sequence_controller.gd
scenes/core/ShardRewardSequenceController.tscn
scripts/player/player_controller.gd
project.godot
scenes/levels/*
assets/vfx/*
*.import
```

Не создавать:

- новые PNG;
- новые particle nodes;
- новые lights;
- новые shaders;
- новые global managers;
- autoload;
- fullscreen effects;
- camera shake;
- SubViewport;
- post-processing pipeline.

---

## 7. Общая стратегия реализации

Charge Anticipation реализуется как один функциональный PR, но через несколько безопасных подзадач и логических коммитов:

```text
CA-0 Baseline Inspection
→ CA-1 Charge Progress Foundation
→ CA-2 Settling + Gathering Inward
→ CA-3 Heart Response
→ CA-4 Compression + Burst Handoff
→ CA-5 Runtime and Visual Validation
```

Рекомендуемая ветка:

```text
feature/soul-shard-charge-anticipation
```

Рекомендуемый PR title:

```text
Polish SoulShard charge anticipation
```

Каждая подзадача должна быть проверяема отдельно.

---

# 8. CA-0 - Baseline Inspection

## 8.1 Цель

Установить фактическую архитектуру текущего SoulShard charge до внесения изменений.

На этом этапе код не меняется.

## 8.2 Обязательная инспекция

Перед работой:

1. Прочитать применимые `AGENTS.md`.
2. Проверить текущий Git branch.
3. Проверить GitHub head SHA.
4. Проверить рабочее дерево.
5. Убедиться, что нет unrelated uncommitted changes.
6. Найти текущую точку взаимодействия.
7. Найти текущий charge flow.
8. Найти текущий burst handoff.
9. Найти все tween, влияющие на те же свойства.
10. Найти idle logic, которую нельзя случайно сломать.

Инспектировать:

```text
scripts/soul/soul_shard.gd
scenes/core/SoulShard.tscn
```

При необходимости только для понимания integration flow:

```text
scripts/core/shard_reward_sequence_controller.gd
scenes/core/ShardRewardSequenceController.tscn
```

Без изменений этих файлов.

## 8.3 Что нужно найти в soul_shard.gd

- interaction entry point;
- условие доступности взаимодействия;
- защита от повторного interaction;
- текущий charge method;
- текущий tween или набор tween;
- использование `charge_duration`;
- момент вызова `_play_world_burst()`;
- момент запроса reward sequence;
- управление `VisualRoot.scale`;
- hover logic;
- rotation logic;
- spiral motes update;
- spiral phase storage;
- base radius;
- base speed;
- vertical spread;
- halo modulation;
- core glow modulation;
- light energy;
- cleanup;
- reset;
- state transitions;
- any `await`;
- any `call_deferred`;
- any animation callback;
- any signal callback.

## 8.4 Что нужно найти в SoulShard.tscn

- точные NodePath;
- реальные имена узлов;
- исходный `VisualRoot.scale`;
- исходный transform;
- исходные alpha/modulate;
- исходные light energy;
- наличие `AnimationPlayer`;
- наличие других Tween-driven компонентов;
- scene-owned значения;
- script-exported values;
- возможные override на инстансах уровней.

## 8.5 Карта baseline-параметров

Перед изменениями нужно зафиксировать:

| Свойство | Узел | Источник baseline | Кто обновляет в idle | Кто обновляет во время charge |
|---|---|---|---|---|
| VisualRoot scale | TBD after inspect | scene/script | TBD | current charge |
| Hover amplitude | TBD | script | idle process | current charge |
| Rotation | TBD | script | idle process | current charge |
| Spiral phase | TBD | script | idle process | current charge |
| Spiral radius | TBD | script | idle process | current charge |
| Spiral speed | TBD | script | idle process | current charge |
| Vertical spread | TBD | script | idle process | current charge |
| CrystalHalo scale/alpha | TBD | scene/script | idle process | current charge |
| HeartPulseHalo scale/alpha | TBD | scene/script | idle pulse | current charge |
| CoreGlow scale/alpha | TBD | scene/script | idle process | current charge |
| GlowLight energy | TBD | scene/script | idle process | current charge |
| UnderGlowLight energy | TBD | scene/script | idle process | current charge |

## 8.6 Обязательный результат CA-0

Краткая карта фактического flow:

```text
interaction entry
→ prompt confirm
→ charge start
→ charge tween/update
→ burst call
→ reward request
→ collection completion
```

Дополнительно:

- список свойств, которые можно безопасно умножать;
- список свойств, которые нельзя перезаписывать напрямую;
- список конфликтующих tween;
- подтверждение, что burst можно вызвать без изменения его реализации;
- подтверждение, что spiral phase может быть сохранена;
- подтверждение, что idle process не нужно полностью выключать.

## 8.7 Acceptance criteria CA-0

- код не изменен;
- все baseline-свойства найдены;
- все NodePath подтверждены;
- найден burst handoff;
- найден interaction lock;
- найдено место для одного normalized progress;
- выявлены конфликтующие tween;
- известны reset requirements;
- неизвестные не маскируются догадками.

---

# 9. CA-1 - Charge Progress Foundation

## 9.1 Цель

Создать устойчивую техническую основу Charge Anticipation без полноценного визуального тюнинга.

Предпочтительная архитектура:

```gdscript
var _charge_progress: float = 0.0
var _charge_tween: Tween
```

Единая точка изменения progress:

```gdscript
func _set_charge_progress(value: float) -> void:
    _charge_progress = clampf(value, 0.0, 1.0)
    _apply_charge_visuals(_charge_progress)
```

Пример запуска:

```gdscript
func _start_charge_anticipation() -> void:
    _kill_charge_tween()

    _charge_progress = 0.0
    _charge_tween = create_tween()
    _charge_tween.tween_method(
        _set_charge_progress,
        0.0,
        1.0,
        charge_duration
    )
    _charge_tween.finished.connect(_on_charge_finished)
```

Точные имена функций должны соответствовать существующему коду и не создавать ненужное дублирование.

## 9.2 Архитектурный принцип

Все временные изменения charge должны применяться через множители baseline-значений.

Правильно:

```gdscript
current_radius = base_radius * charge_radius_multiplier
current_light_energy = base_light_energy * charge_light_multiplier
current_scale = base_scale * charge_scale_multiplier
```

Неправильно:

```gdscript
current_radius = 0.4
current_light_energy = 8.0
current_scale = Vector3.ONE * 1.05
```

Причина:

- сохраняется принятый idle;
- не ломаются scene overrides;
- не накапливаются изменения;
- проще reset;
- проще визуальный тюнинг;
- меньше риск конфликтов.

## 9.3 Baseline capture

Baseline должен быть стабильным.

Запрещено повторно считывать baseline из уже измененного состояния.

Предпочтительно:

- сохранить baseline один раз после готовности сцены;
- использовать отдельные поля;
- не переопределять baseline на каждом interaction;
- не умножать текущее значение повторно;
- не допускать cumulative scale/energy drift.

Пример полей:

```gdscript
var _base_visual_scale: Vector3
var _base_crystal_halo_scale: Vector3
var _base_crystal_halo_alpha: float
var _base_heart_halo_scale: Vector3
var _base_heart_halo_alpha: float
var _base_core_glow_scale: Vector3
var _base_core_glow_alpha: float
var _base_glow_light_energy: float
var _base_under_glow_light_energy: float
```

Создавать только реально необходимые поля.

Не создавать большую абстракцию ради будущего reuse.

## 9.4 Tween safety

Нужен controlled tween lifecycle.

Предпочтительно:

```gdscript
func _kill_charge_tween() -> void:
    if _charge_tween != null and _charge_tween.is_valid():
        _charge_tween.kill()

    _charge_tween = null
```

Правила:

- не запускать второй charge tween;
- не создавать overlapping sequences;
- не оставлять callback старого tween;
- не вызывать burst из нескольких мест;
- не использовать несколько независимых tween для каждой фазы без необходимости;
- не использовать `await` в нескольких параллельных путях.

## 9.5 Защита от повторного interaction

Повторное нажатие E после начала collection не должно:

- запускать второй charge;
- повторно скрывать prompt;
- вызывать второй burst;
- повторно эмитить reward signal;
- ломать state flow.

Использовать существующую state semantics.

Не создавать новую глобальную state machine, если существующая локальная защита достаточна.

## 9.6 Progress semantics

Нормализованный progress:

```text
0.0 → 1.0
```

Временные фазы:

```text
Phase A - Settling: 0.00-0.15
Phase B - Gathering: 0.15-0.70
Phase C - Heart response: 0.70-0.88
Phase D - Compression: 0.88-1.00
```

Удобная helper-функция:

```gdscript
func _remap_clamped(
    value: float,
    input_min: float,
    input_max: float
) -> float:
    if is_equal_approx(input_min, input_max):
        return 1.0

    return clampf(
        (value - input_min) / (input_max - input_min),
        0.0,
        1.0
    )
```

Можно использовать существующий `inverse_lerp` и `clampf`, если это делает код проще.

## 9.7 Что пока не входит

На CA-1 не требуется финальный визуальный результат.

Пока не реализовывать:

- выраженное inward gathering;
- финальный heart pulse;
- compression tuning;
- новые particle systems;
- новые exported parameters без необходимости.

## 9.8 Acceptance criteria CA-1

- progress проходит от `0.0` до `1.0`;
- используется один controlled charge tween;
- burst вызывается ровно один раз;
- interaction не дублируется;
- spiral phase не сбрасывается;
- rotation не получает snap;
- idle до interaction не меняется;
- API не изменен;
- Collection Burst не изменен;
- reward flow не изменен;
- reset не создает cumulative drift;
- GDScript parse проходит.

---

# 10. CA-2 - Settling and Gathering Inward

## 10.1 Диапазоны

```text
Phase A - Settling: 0.00-0.15
Phase B - Gathering inward: 0.15-0.70
```

## 10.2 Phase A - Settling

### Цель

Создать continuity между idle и charge.

Игрок должен ощущать, что кристалл:

- заметил прикосновение;
- успокоил внешнее движение;
- начинает собирать свет;
- не переключился механически в другую анимацию.

### Поведение

Не выключать idle process целиком.

Не обнулять hover.

Не сбрасывать rotation.

Не сбрасывать spiral phase.

Вместо этого применять временные коэффициенты.

Ориентир:

```text
hover amplitude multiplier:
1.0 → 0.25-0.40
```

Рекомендуемый initial target:

```text
0.32
```

Rotation:

- сохранить направление;
- сохранить phase;
- можно умеренно замедлить;
- не останавливать полностью;
- не возвращать к фиксированному rotation.

Ориентир:

```text
rotation speed multiplier:
1.0 → 0.65-0.85
```

Рекомендуемый initial target:

```text
0.75
```

### Easing

Для settling предпочтительно:

```text
smoothstep
sine ease-out
```

Пример:

```gdscript
var settle_eased := smoothstep(0.0, 1.0, settle_progress)
```

Нельзя делать резкий linear cutoff hover.

## 10.3 Phase B - Gathering inward

### Цель

Свет должен визуально собираться в центр.

Главный носитель этого beat:

```text
spiral motes
```

Вторичные носители:

- CoreGlow;
- HeartPulseHalo;
- CrystalHalo;
- restrained scale;
- local lights.

### Spiral motes

Ориентиры:

```text
speed multiplier:
1.0 → 1.8-2.2
```

Рекомендуемый initial target:

```text
2.0
```

```text
radius multiplier:
1.0 → 0.28-0.38
```

Рекомендуемый initial target:

```text
0.34
```

```text
vertical spread multiplier:
1.0 → 0.45-0.65
```

Рекомендуемый initial target:

```text
0.55
```

Критические правила:

- phase не сбрасывается;
- angle не сбрасывается;
- частицы не teleport;
- particle nodes не пересоздаются;
- траектория остается спиральной;
- скорость изменения radius должна быть плавной;
- vertical collapse не должен превращать спираль в плоское кольцо;
- motes не должны сливаться в одну яркую точку слишком рано.

### Phase continuity

Если spiral phase обновляется через накопление:

```gdscript
_spiral_phase += delta * base_speed * speed_multiplier
```

нужно сохранять `_spiral_phase`.

Нельзя:

```gdscript
_spiral_phase = 0.0
```

при начале charge.

### VisualRoot scale

Ориентир:

```text
baseline → 1.04-1.06
```

Рекомендуемый initial peak:

```text
1.05
```

Правила:

- scale растет постепенно;
- scale не должен быть главным эффектом;
- не использовать сильный overshoot;
- не превышать 1.06 без ручного согласования;
- использовать baseline scale;
- сохранять local aspect.

Пример:

```gdscript
var growth_multiplier := lerpf(1.0, 1.05, gather_eased)
visual_root.scale = _base_visual_scale * growth_multiplier
```

### CoreGlow

CoreGlow должен усиливаться постепенно.

Ориентир:

```text
alpha multiplier:
1.0 → 1.25-1.55
```

Рекомендуемый initial target:

```text
1.40
```

Scale ориентир:

```text
1.0 → 1.04-1.10
```

Рекомендуемый initial target:

```text
1.07
```

Не допускать:

- clipping;
- hard white center;
- потери формы кристалла;
- чрезмерной bloom-засветки.

### HeartPulseHalo pre-emphasis

До Phase C сердце становится заметнее, но не достигает эмоционального пика.

Ориентир:

```text
alpha multiplier:
1.0 → 1.10-1.30
```

Рекомендуемый initial target:

```text
1.18
```

Scale:

```text
1.0 → 1.02-1.05
```

Это только подготовка.

Главный pulse будет в CA-3.

### CrystalHalo

CrystalHalo может слегка стянуться к силуэту.

Ориентир:

```text
scale multiplier:
1.0 → 0.92-0.97
```

Рекомендуемый initial target:

```text
0.95
```

Alpha не должен резко расти.

Внешний halo не должен стать главным источником света.

### Local lights

Локальные lights усиливаются умеренно.

Ориентир:

```text
energy multiplier:
1.0 → 1.10-1.30
```

Рекомендуемый initial target:

```text
1.18
```

Проверить:

- персонаж не пересвечен;
- terrain не становится белым;
- яркий sky не уничтожает эффект;
- темные rocks не получают жесткое пятно.

### Orbit arcs

Не усиливать все три arc одновременно.

На этом этапе предпочтительно:

- сохранить idle;
- максимум дать мягкий общий restrained multiplier;
- не делать arcs главным акцентом;
- не менять arc lifecycle.

## 10.4 Пример progress mapping

```gdscript
var settle_progress := _remap_clamped(progress, 0.00, 0.15)
var gather_progress := _remap_clamped(progress, 0.15, 0.70)

var settle_eased := smoothstep(0.0, 1.0, settle_progress)
var gather_eased := smoothstep(0.0, 1.0, gather_progress)
```

## 10.5 Acceptance criteria CA-2

- transition после E начинается без snap;
- hover мягко успокаивается;
- rotation сохраняет continuity;
- spiral phase сохраняется;
- motes ускоряются;
- radius уменьшается плавно;
- vertical spread уменьшается плавно;
- траектория остается спиральной;
- кристалл растет не выше согласованного диапазона;
- свет собирается внутрь;
- персонаж не пересвечен;
- idle до E визуально не изменен;
- Collection Burst не изменен.

## 10.6 Manual verification CA-2

Записать участок:

```text
idle
→ interaction
→ первые 70% charge
```

Проверить минимум:

- frontal angle;
- side angle;
- bright sky;
- dark foliage или rocks.

На этом этапе не оценивать финальный heart pulse и compression как завершенные.

---

# 11. CA-3 - Heart Response

## 11.1 Диапазон

```text
Phase C - 0.70-0.88
```

## 11.2 Цель

Создать один ясный мягкий эмоциональный импульс.

Главный акцент:

```text
HeartPulseHalo
```

Поддержка:

```text
CoreGlow
```

Вторичная поддержка:

```text
restrained local light
```

Не использовать как основной акцент:

- все orbit arcs;
- ambient sparks;
- petals;
- GroundGlow;
- fullscreen UI;
- camera;
- Collection Burst particles.

## 11.3 Локальный progress

```gdscript
var heart_progress := _remap_clamped(progress, 0.70, 0.88)
```

Предпочтительная pulse-форма:

```gdscript
var heart_wave := sin(heart_progress * PI)
```

Свойства:

```text
0.0 at phase start
1.0 at midpoint
0.0 at phase end
```

Для более мягкой формы можно дополнительно применить:

```gdscript
heart_wave = smoothstep(0.0, 1.0, heart_wave)
```

Не создавать второй независимый tween для того же halo, если pulse может вычисляться из общего progress.

## 11.4 HeartPulseHalo

Ориентиры alpha:

```text
pre-emphasized baseline
→ peak multiplier 1.35-1.70
→ restrained settle
```

Рекомендуемый initial peak:

```text
1.50
```

Ориентиры scale:

```text
1.0
→ 1.08-1.16
→ 1.02-1.05
```

Рекомендуемый initial peak:

```text
1.12
```

Правила:

- один pulse;
- без strobe;
- без второго отскока;
- без резкого disappearance;
- без потери центра;
- halo не должен закрывать кристалл;
- pulse должен читаться фронтально и сбоку.

## 11.5 CoreGlow support

CoreGlow поддерживает heart beat, но остается вторичным.

Ориентир дополнительного pulse:

```text
+10%-25% поверх текущего gather level
```

Рекомендуемый initial:

```text
+18%
```

CoreGlow не должен превратиться в hard flash.

## 11.6 VisualRoot support

Допустима очень небольшая поддержка scale.

Ориентир:

```text
gather scale
→ дополнительный peak не более +0.01
```

Пример:

```text
1.05 → максимум 1.06
```

Scale не должен быть главным pulse.

## 11.7 Light support

Дополнительный local light peak:

```text
+5%-15% поверх gather energy
```

Рекомендуемый initial:

```text
+10%
```

Проверить bright environment.

## 11.8 Конфликт с idle HeartPulseHalo

Если HeartPulseHalo уже пульсирует в idle:

- не запускать отдельную несинхронизированную анимацию;
- не перезаписывать idle phase;
- применить charge multiplier поверх idle output;
- при необходимости временно уменьшить idle contribution;
- после Phase C вернуть control общей charge-функции;
- не создавать постоянный drift.

Предпочтительная модель:

```gdscript
final_heart_alpha =
    idle_heart_alpha
    * gather_multiplier
    * charge_pulse_multiplier
```

## 11.9 Acceptance criteria CA-3

- виден ровно один эмоциональный pulse;
- pulse мягкий;
- pulse локальный;
- pulse не похож на strobe;
- HeartPulseHalo остается главным акцентом;
- CoreGlow поддерживает, а не конкурирует;
- arcs не перетягивают внимание;
- персонаж не пересвечивается;
- spiral motes продолжают движение;
- phase не сбрасывается;
- burst не запускается раньше времени;
- scale остается restrained.

## 11.10 Manual verification CA-3

Смотреть отдельно диапазон:

```text
примерно 70%-88% charge
```

Проверить:

- фронт;
- бок;
- яркий фон;
- темный фон;
- читаемость сердца;
- отсутствие двойного pulse;
- отсутствие общего flash.

---

# 12. CA-4 - Compression and Burst Handoff

## 12.1 Диапазон

```text
Phase D - 0.88-1.00
```

## 12.2 Цель

Создать короткое ощущение:

```text
энергия собралась
→ внешнее движение удержалось
→ центр остался ярким
→ вдох
→ освобождение
```

## 12.3 Compression

VisualRoot target:

```text
0.93-0.95 от baseline
```

Рекомендуемый initial target:

```text
0.94
```

Важно:

- compression считается от baseline;
- переход идет от gather peak;
- не происходит snap;
- не использовать squash по одной оси;
- не использовать cartoon overshoot;
- не опускаться ниже 0.93 без отдельного согласования.

Пример:

```gdscript
var compression_progress := _remap_clamped(progress, 0.88, 1.00)
var compression_eased := smoothstep(
    0.0,
    1.0,
    compression_progress
)

var scale_multiplier := lerpf(
    1.05,
    0.94,
    compression_eased
)
```

Реальный start multiplier должен использовать фактическое значение конца предыдущей фазы.

## 12.4 Spiral motes compression

Radius:

```text
gather target 0.28-0.38
→ final 0.12-0.22
```

Рекомендуемый initial final:

```text
0.18
```

Vertical spread:

```text
gather target 0.45-0.65
→ final 0.25-0.40
```

Рекомендуемый initial final:

```text
0.32
```

Speed:

- не обнулять;
- не останавливать резко;
- можно сохранить high speed;
- можно немного снизить near end;
- movement должен ощущаться удержанным, не мертвым.

Ориентир end speed:

```text
1.5-1.9 baseline
```

## 12.5 Внешний свет

CrystalHalo:

- слегка ослабевает;
- может дополнительно стянуться;
- не исчезает;
- не становится черным или прозрачным snap-ом.

Ориентир alpha multiplier:

```text
end:
0.75-0.90 от gather level
```

Рекомендуемый initial:

```text
0.82
```

## 12.6 Центр

CoreGlow должен оставаться ярким.

Ориентир:

```text
core remains at 1.25-1.50 baseline
```

Рекомендуемый initial:

```text
1.38
```

HeartPulseHalo уходит с пика к restrained state.

Не гасить сердце полностью перед burst.

## 12.7 Микропауза

Микропауза должна ощущаться визуально.

Предпочтительно не вводить отдельный долгий `await`.

Ощущение паузы создается через:

- завершение compression;
- уменьшение скорости изменения scale;
- удержание яркого центра;
- уменьшение внешнего glow;
- сохранение внутреннего движения;
- короткий terminal hold в конце общего progress.

Допустимый terminal hold:

```text
0.04-0.10 sec
```

Рекомендуемый initial:

```text
0.06 sec
```

Только если текущий `charge_duration` и tween architecture это позволяют без рассинхронизации.

Если hold реализуется как часть общей easing-кривой, отдельный await не нужен.

## 12.8 Burst handoff

После завершения charge:

```gdscript
func _on_charge_finished() -> void:
    _charge_tween = null
    _play_world_burst()
```

Критические правила:

- `_play_world_burst()` вызывается ровно один раз;
- burst implementation не меняется;
- burst parameters не меняются;
- reward flow остается прежним;
- никаких параллельных вызовов;
- никаких дублирующих callbacks;
- никаких новых particle emissions до burst.

## 12.9 Acceptance criteria CA-4

- compression заметен;
- scale не ниже согласованного диапазона;
- кристалл не выглядит резиновым;
- motes продолжают движение;
- motes не teleport;
- внешний glow ослабевает мягко;
- центр остается ярким;
- микропауза ощущается;
- микропауза не воспринимается как input lag;
- burst запускается ровно один раз;
- burst визуально и технически прежний;
- reward flow не изменен;
- interaction не дублируется.

---

# 13. CA-5 - Runtime and Visual Validation

## 13.1 Цель

Проверить полную цепочку и доказать, что Charge Anticipation:

- работает;
- не ломает gameplay;
- не меняет idle;
- не меняет burst;
- не создает runtime risks;
- визуально соответствует emotional target.

## 13.2 Static validation

Обязательно проверить:

- GDScript parse;
- scene loading;
- отсутствующие NodePath;
- отсутствующие resources;
- отсутствие новых assets;
- отсутствие новых particle nodes;
- отсутствие новых lights;
- отсутствие изменений InputMap;
- отсутствие изменений project.godot;
- отсутствие изменений Collection Burst;
- отсутствие изменений reward flow;
- отсутствие изменений signals;
- отсутствие unrelated files;
- один charge tween;
- один burst call;
- baseline capture;
- reset safety;
- no cumulative transform drift.

## 13.3 Gameplay validation

Проверить:

1. Игрок подходит к SoulShard.
2. Prompt появляется как раньше.
3. E запускает interaction один раз.
4. Prompt confirm работает независимо.
5. Повторное E не запускает второй charge.
6. Charge проходит полностью.
7. Burst запускается ровно один раз.
8. Reward flow начинается как раньше.
9. SoulOrb flow не изменен.
10. Управление игроком возвращается как раньше.
11. Ошибок в Output нет.
12. Ошибок в Debugger нет.
13. Второй shard работает после первого.
14. Второй shard не наследует scale/alpha первого.
15. Переход уровня не сломан.

## 13.4 Обязательный видеоматериал

Нужен ролик длительностью:

```text
8-12 секунд
```

Содержание:

```text
idle
→ approach
→ prompt
→ interaction
→ charge
→ начало старого burst
```

Минимум четыре условия:

- frontal angle;
- side angle;
- bright sky;
- dark foliage или rocks.

Допустимо предоставить несколько коротких роликов, если один ролик не покрывает все условия.

## 13.5 Визуальная проверка idle

До нажатия E:

- hover прежний;
- rotation прежняя;
- CrystalHalo прежний;
- HeartPulseHalo прежний;
- CoreGlow прежний;
- arcs прежние;
- spiral motes прежние;
- ambient sparks прежние;
- petals прежние;
- GroundGlow прежний;
- local lights прежние;
- density прежняя.

Любое заметное изменение idle считается regression.

## 13.6 Визуальная проверка Settling

- нет snap;
- hover не обрывается;
- rotation не перескакивает;
- phase не сбрасывается;
- кристалл не замирает механически;
- prompt confirm не конфликтует с VFX.

## 13.7 Визуальная проверка Gathering

- motes ускоряются;
- radius уменьшается;
- vertical spread уменьшается;
- свет движется внутрь;
- форма спирали сохраняется;
- частицы не teleport;
- scale restrained;
- CoreGlow усиливается мягко;
- CrystalHalo не доминирует.

## 13.8 Визуальная проверка Heart Response

- один pulse;
- pulse читается;
- pulse мягкий;
- pulse локальный;
- нет strobe;
- нет fullscreen flash;
- нет одновременного сильного усиления всех arcs;
- персонаж не пересвечен;
- кристалл остается читаемым.

## 13.9 Визуальная проверка Compression

- compression заметен;
- compression не cartoonish;
- внешний свет немного отступает;
- центр удерживает яркость;
- motes собраны внутрь;
- есть ощущение вдоха;
- нет ощущения задержки или зависания.

## 13.10 Визуальная проверка Burst Handoff

- burst начинается естественно;
- burst не запускается раньше;
- burst не запускается дважды;
- burst выглядит как раньше;
- новый charge не делает burst визуально слабым;
- reward flow продолжает работать.

---

# 14. Риски и меры контроля

## 14.1 Baseline drift

### Риск

Текущие измененные scale/alpha/energy повторно используются как baseline.

### Последствия

- cumulative scale;
- cumulative brightness;
- второй shard выглядит иначе;
- repeated dev tests ломают сцену.

### Контроль

- capture baseline один раз;
- всегда умножать baseline;
- reset на исходные значения;
- тестировать два playback подряд.

---

## 14.2 Conflicting tweens

### Риск

Idle tween и charge tween пишут в одно свойство.

### Последствия

- jitter;
- snap;
- unpredictable alpha;
- pulse становится двойным;
- finished callback вызывается в неправильный момент.

### Контроль

- inspect всех tween;
- один central charge progress;
- charge multiplier поверх idle output;
- kill old tween before start;
- не создавать независимый tween на каждое свойство без необходимости.

---

## 14.3 Spiral phase reset

### Риск

При interaction phase обнуляется.

### Последствия

- teleport;
- визуальный snap;
- motes меняют расположение;
- continuity ломается.

### Контроль

- не трогать phase;
- менять только speed/radius/spread multipliers;
- проверить slow-motion видео.

---

## 14.4 Excessive scale

### Риск

Scale становится главным эффектом.

### Последствия

- power-up;
- cartoon squash;
- потеря романтического тона.

### Контроль

- growth максимум 1.04-1.06;
- compression 0.93-0.95;
- без overshoot;
- сравнение front/side.

---

## 14.5 Overexposure

### Риск

Halo и lights усиливаются одновременно слишком сильно.

### Последствия

- кристалл теряет форму;
- персонаж становится белым;
- burst выглядит слабее;
- bright environment уничтожает читаемость.

### Контроль

- умеренные multipliers;
- HeartPulseHalo главный;
- CoreGlow secondary;
- arcs restrained;
- проверка bright sky.

---

## 14.6 Double interaction

### Риск

E запускает несколько charge sequences.

### Последствия

- два burst;
- два reward signal;
- broken controller state;
- duplicate completion.

### Контроль

- existing interaction lock;
- guarded start;
- one tween reference;
- one burst callback;
- spam E test.

---

## 14.7 Micro-pause as input lag

### Риск

Pause слишком длинная.

### Последствия

- interaction кажется сломанным;
- кристалл зависает;
- emotion превращается в delay.

### Контроль

- 0.04-0.10 sec;
- initial 0.06 sec;
- prefer visual hold over long await;
- оценка полной длительности.

---

## 14.8 Burst becomes weaker than charge

### Риск

Charge слишком яркий и масштабный.

### Последствия

- burst теряет функцию освобождения;
- sequence эмоционально переворачивается.

### Контроль

- charge локальный;
- без новых particles;
- без flash;
- center bright but restrained;
- burst comparison before/after.

---

# 15. Рекомендуемые экспортируемые параметры

Добавлять только параметры, которые действительно нужны для ручного tuning.

Не создавать десятки insignificant exports.

Возможная структура:

```gdscript
@export_category("Charge Anticipation")
@export_range(0.50, 2.50, 0.05)
var charge_duration: float = 1.20

Accepted after Video Review Round 1: `charge_duration: 1.2 seconds`.

@export_range(0.20, 0.50, 0.01)
var charge_hover_end_multiplier: float = 0.32

@export_range(0.50, 1.00, 0.01)
var charge_rotation_end_multiplier: float = 0.75

@export_range(1.50, 2.50, 0.05)
var charge_spiral_speed_peak: float = 2.00

@export_range(0.20, 0.50, 0.01)
var charge_spiral_radius_gather: float = 0.34

@export_range(0.10, 0.30, 0.01)
var charge_spiral_radius_compressed: float = 0.18

@export_range(0.35, 0.75, 0.01)
var charge_vertical_spread_gather: float = 0.55

@export_range(0.20, 0.50, 0.01)
var charge_vertical_spread_compressed: float = 0.32

@export_range(1.00, 1.08, 0.005)
var charge_growth_scale: float = 1.05

@export_range(0.90, 1.00, 0.005)
var charge_compression_scale: float = 0.94

@export_range(1.10, 1.80, 0.05)
var charge_heart_peak_multiplier: float = 1.50

@export_range(1.00, 1.50, 0.05)
var charge_core_glow_multiplier: float = 1.40

@export_range(1.00, 1.40, 0.05)
var charge_light_multiplier: float = 1.18
```

Важно:

- сначала inspect существующие exports;
- не дублировать `charge_duration`;
- не добавлять export, если значение достаточно локальной константы;
- сохранить понятные имена;
- не вводить generic VFX framework.

---

# 16. Suggested internal helper structure

Финальная структура зависит от фактического кода после inspect.

Предпочтительное направление:

```gdscript
func _start_charge_anticipation() -> void
func _set_charge_progress(value: float) -> void
func _apply_charge_visuals(progress: float) -> void
func _apply_charge_motion(progress: float) -> void
func _apply_charge_spiral(progress: float) -> void
func _apply_charge_glow(progress: float) -> void
func _apply_charge_heart(progress: float) -> void
func _apply_charge_compression(progress: float) -> void
func _finish_charge_anticipation() -> void
func _kill_charge_tween() -> void
func _restore_charge_baseline() -> void
```

Не обязательно создавать все функции.

Правило:

- одна функция должна иметь ясную ответственность;
- не разбивать код на десятки микрометодов;
- не смешивать burst internals с charge;
- не менять public API;
- не создавать reusable-компонент без реальной необходимости.

---

# 17. Формулы фаз

## 17.1 Remap

```gdscript
func _phase_progress(
    progress: float,
    phase_start: float,
    phase_end: float
) -> float:
    return clampf(
        inverse_lerp(phase_start, phase_end, progress),
        0.0,
        1.0
    )
```

## 17.2 Settling

```gdscript
var settle := _phase_progress(progress, 0.00, 0.15)
settle = smoothstep(0.0, 1.0, settle)
```

## 17.3 Gathering

```gdscript
var gather := _phase_progress(progress, 0.15, 0.70)
gather = smoothstep(0.0, 1.0, gather)
```

## 17.4 Heart pulse

```gdscript
var heart := _phase_progress(progress, 0.70, 0.88)
var heart_wave := sin(heart * PI)
```

## 17.5 Compression

```gdscript
var compression := _phase_progress(progress, 0.88, 1.00)
compression = smoothstep(0.0, 1.0, compression)
```

Формулы являются референсом, а не обязательным копипастом.

Фактическая реализация должна соответствовать существующей архитектуре.

---

# 18. Commit plan

## Commit 1

```text
Add normalized SoulShard charge progress foundation
```

Содержит:

- baseline inspection-driven changes;
- one progress;
- controlled tween;
- guarded finish;
- preserved burst handoff;
- no final visual tuning.

## Commit 2

```text
Add settling and inward gathering behavior
```

Содержит:

- hover settling;
- rotation continuity;
- spiral speed;
- spiral radius;
- vertical spread;
- restrained scale;
- restrained glow/light gathering.

## Commit 3

```text
Add restrained heart response pulse
```

Содержит:

- one HeartPulseHalo pulse;
- CoreGlow support;
- restrained light support;
- no arc burst;
- no new particles.

## Commit 4

```text
Add final compression and preserve burst handoff
```

Содержит:

- scale compression;
- final spiral compression;
- outer glow reduction;
- center hold;
- micro-pause;
- unchanged burst call.

## Commit 5

```text
Harden SoulShard charge reset and runtime safety
```

Содержит только при необходимости:

- tween cleanup;
- reset safety;
- duplicate interaction protection;
- second-playback correctness;
- no unrelated refactor.

---

# 19. Review format

Для каждого review использовать:

- Scope
- Architecture
- Gameplay safety
- Visual correctness
- Runtime risks
- Required fixes
- Manual verification
- Merge verdict

## После CA-1

```text
Scope: PASS
Architecture: REVIEW
Gameplay safety: REQUIRED
Visual quality: BASELINE ONLY
Merge: NO
```

## После CA-2

```text
Scope: PASS
Architecture: PASS
Gameplay safety: PASS
Gathering visual: NEEDS VIDEO
Heart response: NOT IMPLEMENTED
Merge: NO
```

## После CA-3

```text
Scope: PASS
Architecture: PASS
Gameplay safety: PASS
Gathering visual: REVIEWED
Heart response: NEEDS VIDEO
Merge: NO
```

## После CA-4 и CA-5

```text
Scope: PASS
Architecture: PASS
Gameplay safety: PASS
Visual correctness: NEEDS FULL VIDEO
Runtime risks: NEEDS GODOT CHECK
Merge: WAIT FOR VIDEO
```

Финальный merge возможен только после runtime evidence.

---

# 20. TEST-IMPACT CHECK

Перед изменениями подтвердить, что задача не должна ломать:

- interaction gating;
- prompt confirm;
- `_play_world_burst()`;
- reward sequence request;
- SoulShard completion;
- SoulOrb flow;
- player control restoration;
- level route;
- portal logic;
- save/progress;
- two sequential shards;
- existing signal semantics;
- idle VFX;
- current particle count;
- current model;
- current VFX textures.

---

# 21. Manual checklist

## До interaction

- [ ] Idle визуально не изменился.
- [ ] Hover прежний.
- [ ] Rotation прежняя.
- [ ] Spiral phase прежняя.
- [ ] CrystalHalo прежний.
- [ ] HeartPulseHalo прежний.
- [ ] CoreGlow прежний.
- [ ] Arcs прежние.
- [ ] Ambient sparks прежние.
- [ ] Petals прежние.
- [ ] GroundGlow прежний.
- [ ] Lights прежние.

## Interaction start

- [ ] E срабатывает один раз.
- [ ] Prompt confirm работает.
- [ ] Charge начинается без snap.
- [ ] Hover успокаивается плавно.
- [ ] Rotation сохраняет continuity.
- [ ] Spiral phase не сбрасывается.

## Gathering

- [ ] Motes ускоряются.
- [ ] Radius уменьшается.
- [ ] Vertical spread уменьшается.
- [ ] Motes не teleport.
- [ ] Спираль остается читаемой.
- [ ] CoreGlow усиливается.
- [ ] CrystalHalo не доминирует.
- [ ] Scale не превышает 1.06 baseline.
- [ ] Игрок не пересвечивается.

## Heart response

- [ ] Один pulse.
- [ ] Pulse мягкий.
- [ ] Pulse локальный.
- [ ] HeartPulseHalo главный акцент.
- [ ] CoreGlow вторичный.
- [ ] Arcs не усиливаются все одновременно.
- [ ] Нет strobe.
- [ ] Нет fullscreen flash.
- [ ] Форма кристалла остается читаемой.

## Compression

- [ ] Scale приходит к 0.93-0.95 baseline.
- [ ] Compression не cartoonish.
- [ ] Spiral radius сжимается сильнее.
- [ ] Motes продолжают движение.
- [ ] Внешнее свечение ослабевает.
- [ ] Центр остается ярким.
- [ ] Микропауза ощущается.
- [ ] Микропауза не выглядит как lag.

## Burst handoff

- [ ] Burst вызывается один раз.
- [ ] Burst не изменен.
- [ ] Burst начинается естественно.
- [ ] Reward flow начинается как раньше.
- [ ] Interaction не дублируется.
- [ ] Ошибок в Output нет.
- [ ] Ошибок в Debugger нет.
- [ ] Второй shard работает после первого.
- [ ] Второй shard не наследует modified state.

---

# 22. Final acceptance criteria

Charge Anticipation считается завершенным только если полная последовательность выглядит так:

```text
idle без изменений
→ мягкий переход после E
→ свет собирается внутрь
→ motes ускоряются и сжимаются
→ один мягкий сердечный pulse
→ restrained compression
→ короткая микропауза
→ неизмененный старый burst
```

Обязательные технические условия:

- один normalized progress;
- один controlled charge tween;
- no duplicate interaction;
- no phase reset;
- no rotation snap;
- no new particles;
- no new lights;
- no camera shake;
- no fullscreen flash;
- no Collection Burst changes;
- no Reward Overlay changes;
- no public API changes;
- no unrelated files;
- runtime evidence;
- visual evidence;
- two sequential shard test;
- no Godot errors.

---


## Video Review Round 1

- Idle preservation: PASS
- Charge continuity: PASS
- Gathering inward: PASS
- Heart response at 0.6 sec: NOT READABLE
- Compression at 0.6 sec: NOT READABLE
- Burst handoff: PASS
- Decision: increase charge_duration from 0.6 to 1.2 without changing phase ranges or visual multipliers
- Prompt bug: tracked as corrective fix in scripts/ui/world_interaction_prompt.gd

---

# 23. Final scope statement

В этот reference входят только:

```text
SoulShard Charge Anticipation
```

Не входят:

```text
Warm Crystal Collection Burst
ShardRewardOverlay polish
Narrative flow changes
Level restructuring
Player controller changes
Camera changes
New VFX assets
New audio
New global systems
```

Любая такая работа должна быть вынесена в отдельный slice и отдельный PR.

---

# 24. Final merge verdict template

```text
Scope: PASS
Architecture: PASS
Gameplay safety: PASS
Idle preservation: PASS
Charge continuity: PASS
Gathering inward: PASS
Heart response: PASS
Compression: PASS
Burst preservation: PASS
Runtime validation: PASS
Visual validation: PASS
Merge: APPROVED
```

Если нет видео:

```text
Visual quality: NOT VERIFIED
Merge: WAIT FOR VIDEO
```

Если burst изменен:

```text
Scope: FAIL
Burst preservation: FAIL
Merge: BLOCKED
```

Если idle изменен:

```text
Idle preservation: FAIL
Merge: BLOCKED
```

Если interaction или reward flow дублируется:

```text
Gameplay safety: FAIL
Runtime risks: BLOCKER
Merge: BLOCKED
```
