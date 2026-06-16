Ты работаешь в репозитории:

```text
MindDevastation/fifteen-shards-of-light
```

Роль:

```text
senior Godot 4.6 gameplay engineer
technical artist
shader/VFX engineer
UI animation engineer
performance and regression reviewer
```

Главная задача:

Полностью реализовать документ:

```text
docs/design/Level_01_90_95_Corrective_Pass_Development_Reference.md
```

Документ является источником истины для corrective pass Level_01 до качества 90-95/100.

## 1. Критическое правило локального состояния

Gameplay-видео может показывать изменения, которые еще не отправлены в remote `main`.

До любых действий:

- проверь текущую branch;
- проверь HEAD;
- проверь `git status`;
- проверь untracked и uncommitted files;
- проверь remote `main`;
- не делай reset;
- не checkout поверх локальной работы;
- не удаляй unpushed finale/portal/UI изменения;
- сначала определи фактический current implementation.

Зафиксируй baseline в рабочих заметках и итоговом отчете.

## 2. Preflight

Полностью прочитай:

- `AGENTS.md`, если есть;
- README;
- project Codex/config instructions;
- предыдущие design references;
- весь новый corrective reference;
- текущие scene/script files.

Обязательно проверь:

```text
Level_01.tscn
cloud_001.tscn
cloud_001.glb import and mesh surfaces
current cloud materials/textures
LevelPortal.tscn
level_portal.gd
current local portal implementation
LandmarkLightColumn
LevelFinaleOverlay
Level01FinaleController
ShardRewardOverlay
fox button textures and state code
Player.set_controls_enabled()
Player interaction contract
Level_02 startup
```

Проведи baseline benchmark до визуальных изменений.

Не останавливайся после preflight, если нет destructive blocker.

## 3. Branch

Создай отдельную feature branch от безопасного фактического baseline:

```text
feature/level-01-90-95-corrective-pass
```

Когда ветка уже существует и относится к этой задаче, безопасно продолжи ее.

Не merge.

Не включай auto-merge.

## 4. Работа по slices

Выполняй строго последовательно:

```text
Slice 1 - Cloud quality reconstruction
Slice 2 - Local environment material and lighting balance
Slice 3 - Frame pacing and local performance
Slice 4 - Camera, route readability and barrier weight
Slice 5 - Landmark beam restraint
Slice 6 - Portal rebuild: Woven Light Spiral
Slice 7 - Final sequence control timing
Slice 8 - Rectangular luminous vine finale overlay
Slice 9 - Progressive final text reveal
Slice 10 - Deterministic fox button states
Slice 11 - Level_02 transition concealment
Slice 12 - Audio verification when applicable
Slice 13 - Full integration QA
```

Не начинай следующий slice, пока текущий:

- реализован;
- проверен доступными средствами;
- просмотрен через full diff;
- прошел `git diff --check`;
- не содержит посторонних изменений;
- закоммичен отдельно.

После каждого завершенного slice не останавливайся и не жди подтверждения. Сразу переходи к следующему.

## 5. Cloud fix

Сначала докажи причину черных пятен:

```text
embedded albedo/AO
normal map
self-shadow/shadow mesh
invalid normals/backfaces
overlapping geometry
```

Не маскируй проблему случайным увеличением яркости.

Целевой cloud:

- без черных пятен;
- без высокочастотной зернистости;
- мягкая крупная цветовая вариация;
- no normal map;
- no AO;
- no metallic;
- no sharp specular;
- no cloud shadows;
- shared immutable material;
- no per-frame traversal;
- no performance regression.

Создай procedural low-frequency noise и stylized cloud shader/material по reference.

При проблеме геометрии используй unshaded/wrapped-light fallback, затем cull-disabled только если это доказанно нужно.

## 6. Portal fix

Полностью убери visible placeholder:

```text
grey box portal
glowing sphere
static flat rectangle
```

Сделай:

```text
vertical Woven Light Spiral
slow clockwise motion
two TorusMesh rings
spiral surface shader
spiral light strands
ground ring
18-26 orbit particles
shadowless light
1.6-2.0 s materialization
INTERACT mode for Level_01
AUTO_ENTER compatibility for legacy
```

Сохрани:

```gdscript
@export var target_scene_path
func activate()
```

Используй Player contract:

```text
player_interactable
can_player_interact(player)
interact(player)
```

Не добавляй competing input polling.

Runtime materials с изменяемыми uniforms должны быть duplicated per portal instance.

## 7. Control timing

Исправь dead time.

Требование:

```text
lock controls
→ first visible overlay change <= 0.10 s

overlay visually gone
→ controls restored <= 0.10 s
```

Beam не блокирует управление.

После `LevelFinaleOverlay.closed`:

```text
restore Player controls immediately
then portal.activate()
```

Portal materialization идет при доступном управлении.

Добавь fail-safe restore для всех error/abort paths.

Не изменяй Player controller, если это не доказанный blocker.

## 8. Finale overlay

Финальное окно должно быть родственно `ShardRewardOverlay`, но без сердца и кристаллов.

Обязательно:

- те же fox button assets;
- те же vine colors;
- тот же leaf asset;
- Cormorant Garamond;
- matte veil;
- warm wash;
- две лозы исходят из кнопки-лисы;
- лозы образуют полную прямоугольную рамку;
- rounded organic corners;
- branches and leaves;
- text inside safe area;
- no crystals;
- no shard return animation.

Сделай responsive layout для 1280x720 и 1920x1080.

## 9. Text reveal

Убери резкое появление.

Сделай soft progressive line reveal:

```text
text begins at 0.65-0.85 s
line duration 1.35-1.65 s
line stagger 0.38-0.55 s
total 1.8-3.2 s
```

Не используй агрессивный быстрый typewriter.

Button enables only when:

```text
frame complete
and text complete
```

## 10. Fox button

Создай reusable deterministic component:

```text
scenes/ui/components/FoxConfirmButton.tscn
scripts/ui/fox_confirm_button.gd
```

Применяй к:

```text
ShardRewardOverlay
LevelFinaleOverlay
```

Текстуры:

```text
button_idle.png
button_hovered.png
button_pressed.png
```

Не полагайся только на автоматический TextureButton state priority.

Явно управляй состояниями:

```text
DISABLED
IDLE
HOVER
PRESSED
KEYBOARD_FOCUS
```

На hover обязана показываться реальная `button_hovered.png`, а не idle с измененным scale.

Hover scale:

```text
1.02-1.04
```

Не уменьшай кнопку на hover.

Pressed:

```text
pressed texture
scale 0.94-0.96
offset 3-5 px
```

Когда button становится active при курсоре уже внутри, он сразу должен показать hover texture.

Сохрани public API `ShardRewardOverlay`.

## 11. Performance

После каждого VFX/UI slice проверяй local cost.

Цели:

```text
average FPS >= 55, target 58
1% low >= 48, target 50
p95 <= 21 ms, target 20 ms
beam sustained regression <= 5%
portal sustained regression <= 7%
cloud fix no measurable regression
```

Не выполняй broad downgrade:

- не отключай Glow;
- не отключай main shadow;
- не уменьшай Camera Far ниже 60;
- не включай SSAO;
- не удаляй окружение массово.

## 12. Проверка после каждого slice

Обязательно:

```text
git status --short
git diff --check
git diff --stat
full diff review
Godot 4.6 project import/parse
GDScript validation
scene/resource validation
shader compile validation
focused runtime test when available
```

Если graphical Godot недоступен:

- не выдумывай rendered QA;
- выполни полную static validation;
- зафиксируй ограничение;
- продолжай разработку.

## 13. Commit sequence

Один slice - один commit.

Рекомендуемые commits:

```text
Rebuild Level 01 cloud material for soft clean rendering
Balance Level 01 local materials and lighting
Stabilize Level 01 VFX and environment frame pacing
Polish Level 01 camera readability and barrier weight
Refine Landmark beam into a restrained warm effect
Replace LevelPortal placeholder with woven light spiral
Correct Level 01 finale control lock timing
Rebuild finale overlay as a rectangular luminous vine frame
Add calm progressive reveal to the finale text
Fix fox confirm button idle hover and pressed states
Hide Level 02 initialization behind the portal transition
```

Audio commit создавай только при реальных изменениях.

## 14. Full integration QA

Проверь оба порядка:

```text
Shard_01 → Shard_02
Shard_02 → Shard_01
```

Полный flow:

```text
shard rewards
→ barrier
→ beam
→ finale overlay
→ progressive text
→ real hover button
→ overlay close
→ immediate control restore
→ portal materialization
→ E
→ concealed transition
→ Level_02
```

Проверь:

- clouds 360 degrees;
- no black spots;
- 1280x720;
- 1920x1080;
- 1/2/3-line finale text;
- mouse already over button on enable;
- repeated click;
- portal repeated E;
- load failure;
- no hidden particles;
- no material leaks;
- Player controls after Level_02.

## 15. Pass 2

После всех slices снова полностью прочитай:

```text
docs/design/Level_01_90_95_Corrective_Pass_Development_Reference.md
```

Создай checklist:

```text
implemented
partial
missing
not applicable with reason
```

Исправь все safe gaps.

Отдельный commit:

```text
Complete Level 01 corrective pass requirement coverage
```

Не останавливайся.

## 16. Pass 3

Прочитай reference третий раз.

Сделай final polish:

- cloud softness;
- cloud color;
- portal clockwise readability;
- portal depth;
- particle restraint;
- vine rectangle corners;
- leaf alignment;
- text spacing;
- fox hover texture;
- control timing;
- frame pacing;
- hidden processing.

Отдельный commit:

```text
Polish Level 01 clouds portal and finale presentation
```

## 17. Final report

Создай:

```text
docs/development/Level_01_90_95_Corrective_Pass_Implementation_Report.md
```

Он обязан содержать все разделы из reference, включая:

- baseline;
- local unpushed work;
- commits;
- cloud root cause;
- cloud fix;
- performance before/after;
- portal settings;
- exact control timing;
- final overlay hierarchy;
- text reveal timing;
- button state matrix;
- transition;
- QA actually performed;
- remaining QA;
- deviations;
- no-merge confirmation.

Отдельный commit:

```text
Add Level 01 corrective pass implementation report
```

## 18. Final response

Укажи:

- branch;
- baseline SHA;
- final SHA;
- ordered commit list;
- files created;
- files modified;
- actual benchmark results;
- actual runtime validation;
- blockers;
- remaining manual QA;
- report path;
- explicit confirmation that merge не выполнялся.

Не останавливайся после отдельного slice, первого прохода или второго прохода. Заверши всю задачу, три прохода и отчет в одной рабочей сессии.
