# Level_01 Corrective Pass to 90-95 Quality

**Project:** Fifteen Shards of Light  
**Repository:** `MindDevastation/fifteen-shards-of-light`  
**Engine:** Godot 4.6  
**Renderer:** Forward Plus  
**Physics:** Jolt Physics  
**Target hardware:** RTX 3050 Laptop, Ryzen 5 5600H, 16 GB RAM  
**Target presentation:** 1920x1080 fullscreen, stable 60 Hz  
**Document role:** source of truth for the corrective implementation pass  
**Verified remote `main` at document creation:** `e7908f8fedcc7991ad479e0433c1c4d2a57743d4`  
**Primary level:** `res://scenes/levels/Level_01.tscn`  
**Transition target:** `res://scenes/levels/Level_02.tscn`

---

# 1. Goal

Raise the visible and technical quality of `Level_01` from the current internal vertical-slice state to a stable **90-95/100** range.

Minimum release-candidate gate:

```text
Smoothness and frame pacing >= 90
Gameplay and interaction flow >= 90
Textures and materials >= 90
Performance and load behavior >= 90
UI, VFX, camera, transition and presentation >= 90
Overall score >= 90
```

Target gate:

```text
Every category >= 95 where the current asset base permits it
No critical release blocker
No regression in the working shard-reward pipeline
```

A category may not be compensated by a higher score in another category.

---

# 2. Evidence and current problems

The full Level_01 gameplay recording showed a functioning route and complete progression, but also exposed the following corrective requirements.

## 2.1 Critical issues

1. Clouds contain black spots and a visibly rough, noisy surface.
2. The portal is still a placeholder:
   - in the repository it is a grey box frame;
   - in the recorded current implementation it reads as a large glowing sphere;
   - neither form is acceptable as final art.
3. Player controls are disabled too long before the final text becomes visible.
4. Player controls return too long after the final text disappears.
5. The finale text window is visually weaker than the shard reward window.
6. The final window must use:
   - the same fox button visual language;
   - luminous vines;
   - leaves;
   - text;
   - a complete rectangular organic frame;
   - no crystals.
7. Final text appears too quickly and sharply.
8. The fox button does not switch to the actual hover image, even though its scale changes.
9. The Landmark beam is too bright and must be made warmer and more restrained.
10. The stone barrier opens too quickly and lacks weight.
11. Dense areas require measured frame-pacing validation.
12. The transition must not expose a raw grey Level_02 frame.

## 2.2 Confirmed repository facts

At the verified remote baseline:

- `Level_01` instances `res://scenes/environment/assets/cloud_001.tscn`.
- `cloud_001.tscn` directly instances `res://assets/nature/cloud_01/cloud_001.glb`.
- The cloud GLB import has:
  - generated LODs;
  - generated shadow meshes;
  - embedded materials;
  - no extracted external material.
- The reusable `LevelPortal.tscn` is a grey-box portal made from box meshes.
- `level_portal.gd` currently supports:
  - exported `target_scene_path`;
  - `activate()`;
  - automatic `Area3D.body_entered` loading.
- `ShardRewardOverlay` already has:
  - `button_idle.png`;
  - `button_hovered.png`;
  - `button_pressed.png`;
  - luminous vines;
  - leaf texture;
  - Cormorant Garamond font.
- The current button scene assigns all three textures, but custom script logic only guarantees scale and modulate changes.
- Player already exposes:
  - `set_controls_enabled(enabled: bool)`;
  - the `player_interactable` contract;
  - `can_player_interact(player)`;
  - `interact(player)`.

The implementation must verify the actual local worktree because the gameplay video may include unpushed changes that are newer than remote `main`.

---

# 3. Authority and conflict rules

Priority order:

1. User-approved requirements in this document.
2. Current local worktree behavior shown in the gameplay recording.
3. Current repository APIs and scene composition.
4. Earlier design documents.
5. Legacy greybox behavior.

When the local worktree contains newer uncommitted or unpushed finale work:

- do not reset it;
- do not checkout over it;
- inspect and refactor it safely;
- preserve unrelated changes;
- record the baseline and deviations in the final report.

When this document conflicts with the earlier portal/finale development reference, this corrective reference takes precedence for:

- cloud quality;
- final overlay composition;
- control timing;
- text reveal timing;
- fox button states;
- portal visual acceptance;
- measured 90-95 quality gates.

---

# 4. Non-negotiable regression constraints

Do not break:

```text
Player movement
Player jump
Camera follow
SoulShard
ShardRewardSequenceController
ShardRewardOverlay public API
SoulOrb
two-shard barrier progression
Landmark one-shot trigger
Level_02 target loading
```

Do not:

- open the barrier from `reward_sequence_requested`;
- use `SoulOrb_Follow` creation as progression;
- add a second competing portal framework;
- add project-wide expensive effects to solve local issues;
- re-enable SSAO as a default fix;
- extend the accepted shadow distance beyond 25 without benchmark evidence;
- add shadow-casting portal, beam or cloud lights;
- use a visible glowing sphere as the portal;
- use a static translucent rectangle as the portal;
- use crystals in the final text overlay;
- lock Player controls during the entire beam or portal materialization sequence;
- rely only on automatic `TextureButton` texture precedence for the fox button;
- claim successful visual validation when Godot was not rendered;
- merge automatically.

---

# 5. Quality gates by category

## 5.1 Smoothness

Minimum:

```text
Average FPS >= 55 at 1920x1080
Target average FPS >= 58
1% low >= 48
Target 1% low >= 50
p95 frame time <= 21 ms
Target p95 <= 20 ms
No persistent section below 48 FPS
```

## 5.2 Gameplay

Minimum:

```text
Both shard orders complete
Barrier opens once
Finale triggers once
Player control lock is perceptually immediate and short
Portal interaction works once
Level_02 loads
No soft lock
No invisible collision
```

## 5.3 Textures and materials

Minimum:

```text
No black cloud spots in a 360-degree inspection
No harsh high-frequency cloud granulation
No large clipped portal/beam areas
Character remains readable
Stone, vegetation and path remain separable
```

## 5.4 Presentation

Minimum:

```text
Final overlay visually belongs to the shard overlay family
Rectangle is made by vines and leaves
No crystal frame in final overlay
Text reveal is progressive and calm
Fox button displays real idle/hover/pressed images
Portal reads as a vertical passage
Transition hides raw Level_02 initialization
```

---

# 6. Target architecture

Use small components and explicit signals.

```text
Level_01
├─ LevelRuntimeRoot
│  ├─ ShardRewardSequenceController
│  ├─ Level01ProgressionController
│  └─ Level01FinaleController
├─ LandmarkFinaleRoot
│  ├─ FinaleTrigger
│  ├─ LandmarkLightColumn
│  └─ LevelPortal
└─ UILayer
   ├─ ShardRewardOverlay
   ├─ LevelFinaleOverlay
   └─ TransitionLayer when not owned by LevelPortal
```

Reusable UI component:

```text
scenes/ui/components/FoxConfirmButton.tscn
scripts/ui/fox_confirm_button.gd
```

Preferred cloud structure:

```text
scenes/environment/assets/cloud_001.tscn
└─ CloudModel - imported GLB instance
```

with either:

- editor-configured material overrides on imported MeshInstance3D children; or
- a one-time `_ready()` material applier if imported child paths cannot be stored safely.

No per-frame cloud material traversal.

---

# 7. Expected file plan

The exact file list must be confirmed during preflight.

## 7.1 Likely new files

```text
shaders/environment/stylized_cloud.gdshader
resources/environment/stylized_cloud_noise.tres
resources/environment/stylized_cloud_material.tres
scripts/environment/cloud_material_applier.gd

scenes/ui/components/FoxConfirmButton.tscn
scripts/ui/fox_confirm_button.gd

scenes/ui/LevelFinaleOverlay.tscn
scripts/ui/level_finale_overlay.gd

shaders/vfx/level_portal_surface.gdshader
shaders/vfx/level_portal_ring.gdshader
shaders/vfx/level_portal_ground_ring.gdshader
resources/vfx/level_portal_swirl_noise.tres
resources/vfx/level_portal_particle_gradient.tres

docs/development/Level_01_90_95_Corrective_Pass_Implementation_Report.md
```

## 7.2 Likely modified files

```text
scenes/environment/assets/cloud_001.tscn
scenes/levels/Level_01.tscn
scenes/core/LevelPortal.tscn
scripts/core/level_portal.gd
scripts/levels/level_01_finale_controller.gd
scenes/ui/ShardRewardOverlay.tscn
scripts/ui/shard_reward_overlay.gd
```

When the local worktree already contains these files under different names, adapt instead of duplicating.

---

# 8. Slice 0 - Preflight and baseline capture

## 8.1 Required actions

1. Read all repository instructions and prior design references.
2. Record:
   - current branch;
   - current HEAD;
   - remote main HEAD;
   - working tree status;
   - untracked files;
   - related open PRs.
3. Do not reset local work.
4. Inspect:
   - current Level_01 tree;
   - current cloud instance tree and mesh surfaces;
   - current cloud embedded materials and textures;
   - current portal scene and script;
   - current Landmark beam;
   - current finale overlay;
   - current finale controller;
   - current button logic;
   - all LevelPortal instances;
   - Level_02 startup.
5. Run an initial Godot parse/import.
6. Capture baseline performance without screen recording.

## 8.2 Benchmark locations

At least three samples for each:

```text
Start area idle
Start area running and rotating camera
Bridge traversal
First shard sequence
Dense garden route
Second shard sequence
Barrier opening
Landmark beam activation
Finale overlay opening
Finale overlay closing
Portal materialization
Portal idle
Level_02 transition
```

## 8.3 Preflight deliverable

Create working notes with:

```text
baseline SHA
actual file paths
actual local unpushed files
Godot executable path
benchmark method
baseline FPS/frame-time summary
identified cloud artifact cause
identified button hover cause
identified control-lock timeline
```

No visual fix may begin before the black cloud artifact and control timing are reproduced.

Expected commit: no production commit required for pure preflight.

---

# 9. Slice 1 - Cloud quality reconstruction

## 9.1 Goal

Remove:

- black spots;
- harsh dark patches;
- grainy or rough-looking high-frequency texture;
- excessive contrast;
- obvious material repetition.

Preserve:

- existing cloud mesh silhouette when usable;
- existing transforms in Level_01;
- low rendering cost;
- atmospheric depth below and around the floating route.

## 9.2 Diagnostic procedure

Test the current cloud in isolation.

### Test A - Embedded albedo

Temporarily override the material with a flat pale color.

Interpretation:

```text
black spots disappear
→ embedded texture/AO/material is the cause

black spots remain and move with light/view
→ normals, self-shadow or mesh surface is the cause
```

### Test B - Shadows

Disable cloud shadow casting and inspect again.

Interpretation:

```text
spots disappear
→ shadow mesh or self-shadow is the cause
```

### Test C - Normal and AO inputs

Disable:

```text
normal map
ambient occlusion
height/parallax
metallic/specular detail
```

Interpretation:

```text
spots disappear
→ one of the embedded maps is invalid or too strong
```

### Test D - Unshaded fallback

Apply the approved stylized unshaded/wrapped-light material.

Interpretation:

```text
spots persist
→ problem is likely geometry, overlapping faces or texture alpha
```

Do not choose the final fix before these checks.

## 9.3 Preferred final material

Create:

```text
res://shaders/environment/stylized_cloud.gdshader
```

Target behavior:

- no metallic;
- no sharp specular;
- no normal map;
- no AO map;
- no high-frequency roughness texture;
- no black color contribution;
- soft vertical color gradient;
- low-frequency procedural variation;
- no shadow casting;
- no per-instance animation unless extremely slow and benchmark-safe.

Recommended render approach:

```text
spatial shader
opaque when the current cloud mesh has a closed silhouette
unshaded or wrapped diffuse
specular disabled
backface culling retained when normals are correct
cull disabled only when missing backfaces are proven
```

### Color targets

```text
Top color:
Color(0.91, 0.93, 0.95, 1.0)

Middle color:
Color(0.80, 0.84, 0.88, 1.0)

Bottom color:
Color(0.64, 0.70, 0.76, 1.0)

Warm scene tint contribution:
maximum 8-12%
```

No resulting pixel region should visually approach pure black.

### Noise resource

Create:

```text
res://resources/environment/stylized_cloud_noise.tres
```

Recommended:

```text
NoiseTexture2D
size = 128x128 or 256x256
seamless = true
mipmaps = true
FastNoiseLite
frequency = 0.010-0.018
fractal octaves = 2-3
fractal gain = 0.42-0.50
```

Shader noise influence:

```text
color amplitude <= 0.08
large smooth forms only
no small granular dots
no visible UV seams
```

### Surface settings

```text
roughness-equivalent = 0.85-1.0
metallic = 0
specular = 0-0.12
normal map disabled
AO disabled
cast_shadow = OFF
receive visual lighting only when it does not recreate black spots
```

Physical roughness may remain high because clouds should not be glossy. The user-visible "rough texture" must be fixed by removing high-frequency albedo/normal noise, not by making the cloud shiny.

## 9.4 Material application

Preferred order:

1. Inspect imported GLB child paths.
2. Convert `cloud_001.tscn` into a wrapper Node3D if needed.
3. Apply a shared material override to all cloud MeshInstance3D surfaces.
4. Share one immutable material across all cloud instances.
5. Do not duplicate the material per cloud unless a per-instance parameter is required.
6. Do not perform recursive material searches every frame.
7. A one-time `_ready()` traversal is allowed for a small number of instances.

## 9.5 Geometry fallback

When black spots are caused by invalid normals or overlapping geometry and cannot be solved safely by material:

- use the unshaded material first;
- if the silhouette still shows holes, disable culling only for the cloud shader;
- if severe geometry artifacts remain, create a corrected imported asset through the available asset pipeline;
- do not replace the cloud with a simple sphere or flat billboard.

## 9.6 Cloud acceptance criteria

- No black spots from any normal gameplay angle.
- No black spots during a 360-degree orbit test.
- No harsh surface granulation at 1080p.
- No visible texture seam.
- Cloud still has soft large-form variation.
- Cloud does not look like smooth plastic.
- Cloud does not cast expensive shadows.
- Existing Level_01 placement remains intact.
- Sustained cloud cost does not increase relative to baseline.
- Target visual score: 92-95.

Expected commit:

```text
Rebuild Level 01 cloud material for soft clean rendering
```

---

# 10. Slice 2 - Local environment material and lighting balance

## 10.1 Goal

Raise environment readability without a project-wide art rewrite.

Correct:

- clipped highlights;
- crushed shadow pockets;
- yellow-green material convergence;
- overbright character response;
- close-range stone flatness;
- repeated foliage appearance.

## 10.2 Technical limits

Preserve:

```text
Camera Far = 60
Directional shadow max distance = 25
PSSM 2 splits
SSAO OFF
Glow ON
```

Do not add new shadow-casting OmniLights.

## 10.3 Local corrections

### Character

- reduce material emission or excessive light response;
- preserve orange and white detail;
- keep silhouette readable;
- verify tails and hair retain internal shading.

### Lanterns

- reduce clipped core size;
- keep warm light;
- retain existing 10 m shadow fade;
- do not extend light range.

### Stone

- adjust UV scale where obviously stretched;
- use low-frequency roughness/albedo variation;
- keep material neutral enough to separate from yellow path and moss;
- no expensive parallax.

### Foliage

- introduce rotation, scale and slight color variation;
- move only clearly repetitive or camera-blocking instances;
- do not redesign the island layout.

### Shadows

- use ambient/environment tuning or local shadowless fill;
- preserve route detail;
- do not flatten all contrast.

## 10.4 Acceptance

- Character material detail is visible.
- Lanterns are bright but not large white shapes.
- Stone, path and foliage remain visually separate.
- No route-critical area becomes near-black.
- No new sustained performance regression over 3%.
- Target visual score: 90-94.

Expected commit:

```text
Balance Level 01 local materials and lighting
```

---

# 11. Slice 3 - Frame pacing and local performance

## 11.1 Goal

Reach the performance gate without lowering the accepted visual baseline.

## 11.2 Optimization order

Use measured evidence.

1. Stop hidden particle emitters.
2. Disable processing on inactive VFX.
3. Bound particle visibility AABB.
4. Remove unnecessary shadow casting.
5. Reduce transparent screen coverage.
6. Reduce particle count.
7. Share immutable materials.
8. Remove repeated runtime allocations.
9. Reduce only local light range or energy.
10. Use generated LODs and distance fade where appropriate.

Do not start by:

- disabling Glow;
- disabling the main directional shadow;
- shortening camera Far below 60;
- removing environment assets broadly.

## 11.3 Budgets

```text
Landmark beam active:
sustained GPU regression <= 5%

Portal active:
sustained GPU regression <= 7%

Finale overlay active:
sustained CPU regression <= 1.5 ms
no frame-by-frame node allocation

Cloud correction:
no measurable sustained regression
```

## 11.4 Acceptance

- Average FPS >= 55, target >= 58.
- 1% low >= 48, target >= 50.
- p95 <= 21 ms, target <= 20 ms.
- No memory growth during repeated overlay and portal use.
- No hidden active emitter after transition.
- Target performance score: 90-95.

Expected commit:

```text
Stabilize Level 01 VFX and environment frame pacing
```

---

# 12. Slice 4 - Camera, route readability and barrier weight

## 12.1 Camera

Correct only observed issues:

- close rocks and trees covering the screen;
- abrupt camera correction in narrow paths;
- insufficient obstruction handling;
- poor Player readability in dense foliage.

Preferred fixes:

- small local prop movement;
- safe camera collision tuning;
- obstruction fade only when already supported;
- no full camera rewrite.

## 12.2 Route

- strengthen the first intended route with light and negative space;
- keep exploration possible;
- avoid adding large new signs;
- frame the open barrier and Landmark more clearly after the second shard.

## 12.3 Barrier

Target:

```text
open duration = 2.2-2.7 s
TRANS_SINE or TRANS_CUBIC
EASE_IN_OUT
one-shot
visual and collision move together
```

Optional:

```text
6-12 low-cost dust/mote particles at the base
no strong camera shake
```

## 12.4 Acceptance

- Player remains readable during normal traversal.
- Camera does not remain inside geometry.
- Barrier movement takes at least 2.2 seconds.
- Barrier feels heavy.
- No invisible collision remains.
- Route to the finale is visible after opening.
- Target gameplay score: 90-93.

Expected commit:

```text
Polish Level 01 camera readability and barrier weight
```

---

# 13. Slice 5 - Landmark beam restraint

## 13.1 Goal

Keep the emotional idea while removing overexposure.

## 13.2 Target visual

```text
narrow ivory core
soft warm-gold outer beam
procedural breakup
restrained ground ring
18-24 falling motes
optional 6-8 rising motes
shadowless local light
```

## 13.3 Limits

```text
beam screen width at standard view <= 8-10%
core opacity = 0.26-0.42
outer opacity = 0.10-0.20
halo opacity <= 0.07
idle opacity pulse amplitude <= 0.06
light energy = 0.35-0.65
shadow = OFF
```

Use procedural noise with large-scale breakup. Avoid white clipping.

## 13.4 Timing

```text
appearance duration = 1.3-1.7 s
particles begin around 0.40-0.55 s
appearance_completed at visual settle
```

The beam may start before the final overlay, but must not lock Player controls by itself.

## 13.5 Acceptance

- Beam starts from Landmark center.
- Internal texture remains visible.
- Falling motes are readable.
- No white-hot column.
- No persistent FPS drop above 5%.
- Target VFX score: 92-95.

Expected commit:

```text
Refine Landmark beam into a restrained warm effect
```

---

# 14. Slice 6 - Portal rebuild: Woven Light Spiral

## 14.1 Goal

Replace every placeholder representation with a readable vertical portal made from slow spiraling light.

Remove or hide:

```text
grey box posts
grey top beam
grey floor marker
static inner rectangle
glowing sphere placeholder
```

The final portal must not contain visible placeholder geometry.

## 14.2 Target scene structure

```text
LevelPortal - Node3D
├─ VisualRoot
│  ├─ GroundRing
│  ├─ OuterRing
│  ├─ InnerRing
│  ├─ SpiralStrandA
│  ├─ SpiralStrandB
│  ├─ PortalSurface
│  ├─ BackVeil
│  ├─ OrbitMotes
│  └─ PortalLight
├─ InteractionArea
│  └─ CollisionShape3D
├─ PromptAnchor
├─ WorldInteractionPrompt
└─ TransitionLayer
   └─ TransitionVeil
```

## 14.3 Geometry

### Portal dimensions

```text
visible width = 1.9-2.3 m
visible height = 2.4-2.8 m
bottom clearance = 0.10-0.20 m
depth = visually thin
```

It must read as a doorway, not a ball.

### Rings

Use two TorusMesh rings or equivalent curved meshes:

```text
OuterRing major radius = 1.10-1.28
OuterRing minor radius = 0.045-0.075

InnerRing major radius = 0.88-1.02
InnerRing minor radius = 0.025-0.050
```

Both vertical.

## 14.4 Portal surface shader

Create:

```text
res://shaders/vfx/level_portal_surface.gdshader
```

Requirements:

- spatial;
- unshaded;
- additive or premultiplied transparent;
- cull disabled;
- depth draw disabled or safe alpha depth strategy;
- polar-coordinate UV;
- slow clockwise angular movement;
- 3-5 spiral strands;
- procedural low-frequency noise;
- soft center;
- readable edge;
- no opaque disc.

Target parameters:

```text
clockwise_speed = 0.035-0.060 revolutions-equivalent per second
strand_count = 3-5
distortion_strength = 0.24-0.42
base_alpha = 0.06-0.14
strand_alpha = 0.22-0.38
edge_alpha = 0.12-0.22
emission = 0.8-1.4
```

The exact shader syntax must be valid for Godot 4.6.

## 14.5 Spiral movement

The main visual read must be clockwise.

```text
Outer ring revolution = 18-24 s
Inner ring revolution = 28-36 s
Ground ring revolution = 35-50 s
Portal surface shader = clockwise
```

A small secondary counter-motion may exist only as texture breakup. It must not reverse the overall clockwise impression.

## 14.6 Spiral strands

Preferred implementation:

- two or three Curve3D/Path3D-derived ribbon or particle strands; or
- shader-defined spiral bands inside the portal surface;
- no large solid tube.

Strands should:

- curve inward;
- vary opacity slowly;
- have soft ends;
- remain within the portal bounds.

## 14.7 Particles

`OrbitMotes`:

```text
amount = 18-26
lifetime = 3.5-5.0 s
scale = 0.018-0.060
low tangential velocity
low radial drift
warm ivory to gold gradient
soft fade in/out
bounded visibility AABB
shadow = OFF
```

Optional entry burst:

```text
6-10 particles
one-shot
short inward spiral
no explosion
```

## 14.8 Portal light

```text
OmniLight3D
energy = 0.30-0.55
range = 3.5-5.0
shadow = OFF
distance fade = ON
```

## 14.9 Materialization

```text
duration = 1.6-2.0 s

0.00-0.40:
ground ring appears

0.15-1.25:
rings scale and fade in

0.30-1.55:
spiral surface activation 0 → 1

0.50:
particles start

0.40-1.20:
portal light energy 0 → target

1.55-2.00:
small visual settle

end:
state = ACTIVE
interaction enabled
activation_completed emitted
```

The Player must be able to move during portal materialization after the final overlay closes.

## 14.10 Interaction and compatibility

Retain:

```gdscript
@export var target_scene_path: String
func activate() -> void
```

Add or retain:

```gdscript
enum EntryMode {
    AUTO_ENTER,
    INTERACT,
}
```

Default:

```text
AUTO_ENTER
```

Level_01 override:

```text
INTERACT
```

Use the current Player contract:

```text
group = player_interactable
can_player_interact(player)
interact(player)
```

No separate gameplay input polling.

## 14.11 Acceptance

- No sphere is visible.
- No grey box frame is visible.
- Portal is vertical and doorway-shaped.
- Slow clockwise spiral is obvious.
- Player remains visible in front of the portal.
- Prompt remains readable.
- Portal does not overlap terrain.
- Interaction triggers once.
- Load failure recovers controls.
- Idle performance regression <= 7%.
- Target VFX score: 93-95.

Expected commit:

```text
Replace LevelPortal placeholder with woven light spiral
```

---

# 15. Slice 7 - Final sequence control timing

## 15.1 Current defect

The Player loses control substantially before the text appears and regains control substantially after the text disappears.

This creates dead time with no visible reason.

## 15.2 Required timing contract

### Before overlay

The beam and trigger may begin while Player controls remain enabled.

Player controls are locked only when the final overlay begins presenting visible content.

Maximum allowed lead:

```text
control lock → first visible veil/frame change <= 0.10 s
```

Recommended:

```text
same frame
```

### While overlay is open

Controls remain disabled from overlay opening through confirmation and closing animation.

### After overlay

Controls return when all are true:

```text
overlay alpha <= 0.05
overlay no longer blocks mouse
final text is no longer visible
```

Maximum allowed delay:

```text
overlay visually gone → controls restored <= 0.10 s
```

Portal activation must not extend this lock.

Required order:

```text
overlay closed
→ restore Player controls immediately
→ activate/materialize portal
→ Player may move while portal appears
```

## 15.3 Ownership

`Level01FinaleController` must track whether it owns the lock.

Recommended:

```gdscript
var _controls_locked_by_finale := false
```

Functions:

```gdscript
func _lock_player_for_finale_overlay() -> void
func _unlock_player_after_finale_overlay() -> void
func _restore_player_controls_on_failure() -> void
```

Only restore controls when the finale controller locked them.

## 15.4 Failure safety

Restore controls on:

- overlay node failure;
- interrupted sequence;
- portal activation failure;
- scene reload cleanup where applicable;
- controller reset;
- debug abort.

Do not leave the Player disabled.

## 15.5 Signals

Preferred overlay signals:

```gdscript
signal opening_started
signal content_visible
signal confirmation_enabled
signal closing_started
signal closed
```

Controller behavior:

```text
call overlay.show_finale()
→ lock controls immediately before or in opening_started
→ await closed
→ unlock
→ portal.activate()
```

## 15.6 Acceptance

- No perceptible dead time before overlay visibility.
- No perceptible dead time after overlay disappearance.
- Beam does not lock controls.
- Portal materialization does not lock controls.
- All failure paths restore controls.
- Target UX score: 95.

Expected commit:

```text
Correct Level 01 finale control lock timing
```

---

# 16. Slice 8 - Final overlay: rectangular luminous vine frame

## 16.1 Visual relationship

The final overlay belongs to the same visual family as `ShardRewardOverlay`, but it is not a copy of the heart.

Use:

- the same fox button assets;
- the same vine color language;
- the same leaf texture;
- the same Cormorant Garamond typography;
- a similar matte veil and warm wash.

Do not use:

- crystal frame particles;
- heart shape;
- shard return animation;
- SoulOrb target logic;
- dense sparkling border.

## 16.2 Required composition

```text
LevelFinaleOverlay - Control
├─ Atmosphere
│  ├─ MatteVeil
│  └─ WarmWash
├─ VineCanvas
│  ├─ LeftFrameVine
│  │  ├─ OuterGlow
│  │  ├─ MainGold
│  │  └─ InnerIvory
│  ├─ RightFrameVine
│  │  ├─ OuterGlow
│  │  ├─ MainGold
│  │  └─ InnerIvory
│  ├─ BranchLayer
│  ├─ LeafLayer
│  ├─ LeftTipGlow
│  └─ RightTipGlow
├─ TextRoot
│  └─ FinaleText
└─ ButtonRoot
   └─ FoxConfirmButton
```

## 16.3 Frame design

The fox button is centered at the bottom.

Two main vines emerge from behind or directly above the fox:

```text
left vine:
fox center
→ lower center-left
→ lower-left corner
→ upper-left corner
→ top center

right vine:
fox center
→ lower center-right
→ lower-right corner
→ upper-right corner
→ top center
```

Together they create one complete rectangular frame with organic rounded corners.

The vines must not form a heart.

## 16.4 Responsive frame dimensions

At 1920x1080:

```text
frame width = 980-1080 px
frame height = 430-500 px
frame top = approximately 250-310 px
frame bottom = approximately 760-820 px
fox button center = approximately 920-970 px Y
text safe width = 720-860 px
text safe height = 180-250 px
```

At 1280x720:

```text
scale factor = approximately 0.70-0.76
minimum side margin = 56 px
minimum top margin = 44 px
button remains fully visible
```

Use clamped responsive scaling, not fixed 1080p-only offsets.

## 16.5 Vine rendering

Reuse the triple-Line2D language:

```text
Outer glow width = 16-20 px at 1080p
Main gold width = 7-9 px
Inner ivory width = 2.5-3.5 px
```

Colors:

```text
Outer:
Color(1.0, 0.60, 0.18, 0.18-0.24)

Main:
Color(1.0, 0.67, 0.26, 0.86-0.92)

Inner:
Color(1.0, 0.92, 0.70, 0.94-0.98)
```

Use rounded joins and caps.

## 16.6 Leaves

Use:

```text
res://assets/ui/shard_reward_overlay/vine_leaf.png
```

Target:

```text
7-9 leaves per side
14-18 total
vary scale by 0.82-1.12
alternate side of vine
rotate along local tangent
avoid text overlap
```

Leaves appear progressively as the vine reaches their threshold.

## 16.7 No crystals

The final overlay must not create:

```text
LightFrameLayer crystal particles
crystal return animation
crystal border targets
shard-origin particles
```

Removing crystals is a hard requirement.

## 16.8 Atmosphere

Target:

```text
Matte veil alpha = 0.48-0.56
Warm wash alpha = 0.08-0.12
fade-in = 0.35-0.50 s
```

The finale should feel calm and intimate, not darker or louder than the shard overlay.

## 16.9 Public API

```gdscript
signal opening_started
signal content_visible
signal confirmation_enabled
signal closing_started
signal closed

func show_finale(text: String) -> void
func close_finale() -> void
func reset_overlay() -> void
func is_open() -> bool
```

No shard-return API.

## 16.10 Acceptance

- Complete rectangular vine frame.
- Vines visibly originate from the fox button.
- No heart shape.
- No crystals.
- Leaves are attached and aligned.
- Text remains inside the safe frame.
- Correct at 1280x720 and 1920x1080.
- Target UI score: 93-95.

Expected commit:

```text
Rebuild finale overlay as a rectangular luminous vine frame
```

---

# 17. Slice 9 - Progressive final text reveal

## 17.1 Goal

Replace the current fast, sharp text appearance with a calm progressive reveal.

## 17.2 Chosen animation

Use a soft line reveal, not an aggressive character-by-character typewriter.

For each line:

- label exists at final position;
- alpha begins at 0;
- a clipped reveal mask expands;
- a faint warm glint may lead the mask;
- the line alpha rises gradually;
- no hard one-frame text pop.

## 17.3 Timing

Recommended:

```text
overlay atmosphere starts at 0.00 s
vines start at 0.12-0.18 s
text starts at 0.65-0.85 s
line reveal duration = 1.35-1.65 s
line stagger = 0.38-0.55 s
text fade support = 0.30-0.45 s
total text reveal = 1.8-3.2 s
```

For one short line:

```text
minimum reveal duration = 1.35 s
```

For three lines:

```text
maximum reveal duration = 3.2 s
```

## 17.4 Text layout

Target:

```text
maximum lines = 3
default font size = 46-50 px at 1080p
fallback font size = 40-44 px
centered
Cormorant Garamond SemiBold Italic
warm ivory color
dark warm outline
```

Do not shrink below readable size to force too much text.

## 17.5 Confirmation gate

Fox button is disabled until both are complete:

```text
vine frame growth
text reveal
```

Condition:

```gdscript
_frame_complete and _text_complete
```

Then:

- enable button;
- sample current mouse position;
- apply correct idle or hover visual immediately;
- emit `confirmation_enabled`.

## 17.6 Closing

Target:

```text
button confirm feedback = 0.12-0.18 s
text fade = 0.35-0.50 s
vines retract/fade = 0.55-0.85 s
atmosphere fade = 0.55-0.75 s
closed emitted after mouse blocking is disabled
```

Do not hold controls for a long crystal-return sequence.

## 17.7 Acceptance

- No abrupt text pop.
- Text reveal is visibly progressive.
- Button cannot be clicked early.
- Button activates immediately after the slower of frame/text completes.
- Closing does not exceed the control timing contract.
- Target UI motion score: 95.

Expected commit:

```text
Add calm progressive reveal to the finale text
```

---

# 18. Slice 10 - Deterministic fox button states

## 18.1 Problem

The current button:

- correctly displays disabled idle;
- correctly becomes active;
- changes scale on hover;
- fails to display the actual hover image.

The fix must not rely only on Godot's automatic texture-state precedence.

## 18.2 Reusable component

Preferred:

```text
res://scenes/ui/components/FoxConfirmButton.tscn
res://scripts/ui/fox_confirm_button.gd
```

Use the same component in:

```text
ShardRewardOverlay
LevelFinaleOverlay
```

Preserve `pressed` behavior expected by the overlays.

## 18.3 Textures

```text
idle:
res://assets/ui/shard_reward_overlay/button_idle.png

hover:
res://assets/ui/shard_reward_overlay/button_hovered.png

pressed:
res://assets/ui/shard_reward_overlay/button_pressed.png
```

## 18.4 Explicit state machine

```gdscript
enum VisualState {
    DISABLED,
    IDLE,
    HOVER,
    PRESSED,
    KEYBOARD_FOCUS,
}
```

Required state transitions:

```text
disabled:
DISABLED

enabled + mouse outside:
IDLE

enabled + mouse inside:
HOVER

mouse button down:
PRESSED

mouse button up inside:
HOVER

mouse button up outside:
IDLE

keyboard focus without mouse:
KEYBOARD_FOCUS

disabled during any state:
DISABLED
```

## 18.5 Guaranteed texture application

When a state changes, explicitly assign the displayed texture.

Robust approach:

```gdscript
func _apply_display_texture(texture: Texture2D) -> void:
    texture_normal = texture
    texture_hover = texture
    texture_pressed = texture
    texture_focused = texture
```

This prevents the engine from replacing the manually selected image with a different internal state texture.

Alternative implementations are allowed only when visual tests prove exact state switching.

## 18.6 Visual parameters

### Disabled

```text
texture = idle
alpha = 0.58
scale = 1.0
not clickable
hover ignored
```

### Active idle

```text
texture = idle
alpha = 1.0
scale = 1.0
```

### Hover

```text
texture = hovered
alpha = 1.0
scale = 1.02-1.04
duration = 0.10-0.14 s
```

Do not shrink the button on hover.

### Pressed

```text
texture = pressed
scale = 0.94-0.96
vertical offset = 3-5 px
duration = 0.06-0.09 s
```

### Release

```text
inside → hovered texture
outside → idle texture
```

### Keyboard focus

Keyboard focus must not permanently masquerade as mouse hover.

Preferred:

- idle texture;
- subtle 1.03 scale or warm outline;
- pressed texture only on keyboard activation.

## 18.7 Enable-under-cursor case

When the animation completes while the cursor is already above the button:

```text
button enables
→ sample local mouse position
→ enter HOVER immediately
→ display hovered texture immediately
```

No mouse-exit/re-enter should be required.

## 18.8 Hit area

- use the visible alpha mask;
- hit area must not include the entire lower screen;
- generate mask from the idle texture alpha;
- verify hover only when over the fox/button visual.

## 18.9 Existing overlay compatibility

When migrating `ShardRewardOverlay`:

- retain:
  - `confirmation_requested`;
  - `return_completed`;
  - `play_reward(...)`;
  - `play_return_to(...)`;
  - `reset_overlay()`;
- do not alter heart geometry;
- do not alter shard text layout unless required by component migration;
- only replace duplicated button-state code.

## 18.10 Button acceptance matrix

Test both overlays:

| State | Required texture | Required scale |
|---|---|---:|
| Animation active | idle | 1.00 |
| Active, mouse outside | idle | 1.00 |
| Active, mouse enters | hovered | 1.02-1.04 |
| Mouse pressed | pressed | 0.94-0.96 |
| Release inside | hovered | 1.02-1.04 |
| Release outside | idle | 1.00 |
| Disabled while hovered | idle | 1.00 |
| Enabled while cursor already inside | hovered | 1.02-1.04 |

Target button score: 95-100.

Expected commit:

```text
Fix fox confirm button idle hover and pressed states
```

---

# 19. Slice 11 - Level_02 transition concealment

## 19.1 Goal

Never expose an uninitialized grey Level_02 frame.

## 19.2 Required flow

```text
portal interact
→ disable Player controls
→ portal entry pulse
→ warm dark veil fades to opaque
→ change scene
→ new scene confirms camera/environment ready
→ veil fades out
→ controls restored
```

## 19.3 Timing

```text
entry pulse = 0.18-0.30 s
veil fade-in = 0.45-0.70 s
scene change only after veil alpha >= 0.98
new-scene hold = minimum required initialization only
veil fade-out = 0.55-0.85 s
```

Do not use a full white flash.

Color:

```text
deep warm brown/plum-black
approximately Color(0.035, 0.020, 0.028, 1.0)
```

## 19.4 Failure recovery

When scene loading fails:

- fade veil out;
- restore Player controls;
- return portal to ACTIVE;
- re-enable interaction;
- show prompt when Player remains in range;
- log the error and target path.

## 19.5 Acceptance

- No grey void is visible.
- No one-frame flash.
- Scene loads once.
- Controls return in Level_02.
- Level_02 movement and interaction work.
- Target transition score: 95.

Expected commit:

```text
Hide Level 02 initialization behind the portal transition
```

---

# 20. Slice 12 - Audio verification

The reviewed recording contains effectively silent audio. First determine whether this is a capture problem.

## 20.1 When game audio exists

Verify:

```text
footsteps
jump/landing
shard charge
shard burst
reward UI
barrier
beam
portal materialization
portal idle
portal entry
transition
```

Check no clipping and no overlapping loops after scene exit.

## 20.2 When game audio does not exist

Do not generate a large audio system inside this corrective pass unless project instructions already define it.

Create a blocker entry in the implementation report and, when safe, add only minimal existing-project cues.

Audio must remain warm and restrained.

## 20.3 Acceptance

- Recording/capture cause documented.
- No active loop leaks across Level_02.
- No clipping.
- Audio status is factual.

Expected commit only when code/assets change:

```text
Verify and correct Level 01 interaction audio
```

---

# 21. Slice 13 - Full integration QA

## 21.1 Gameplay matrix

Test:

```text
Shard_01 → Shard_02
Shard_02 → Shard_01
```

For both:

```text
reward sequence
→ barrier
→ Landmark beam
→ final overlay
→ button
→ control restore
→ portal materialization
→ E interaction
→ Level_02
```

## 21.2 Cloud matrix

Inspect clouds:

```text
front
back
left
right
above where camera permits
during warm light
during shadowed view
during movement
at 1280x720
at 1920x1080
```

## 21.3 Final UI matrix

Test:

```text
1-line text
2-line text
3-line text
longest intended Level_01 text
1280x720
1920x1080
mouse outside on enable
mouse inside on enable
keyboard focus
rapid repeated click
```

## 21.4 Portal matrix

Test:

```text
inactive
activating
active
approach from left
approach from right
leave range
re-enter range
repeated E
load failure
scene success
```

## 21.5 Performance matrix

Repeat all Slice 0 measurements.

Compare baseline vs final.

No score may be assigned from visual impression alone when a benchmark is available.

---

# 22. Pass 2 - Complete requirement audit

After all implementation slices:

1. Read this document again from beginning to end.
2. Build a requirement checklist.
3. Mark every item:
   - implemented;
   - partial;
   - missing;
   - not applicable with reason.
4. Correct all safe partial and missing items.
5. Re-run parse and focused QA.
6. Commit separately.

Expected commit:

```text
Complete Level 01 corrective pass requirement coverage
```

---

# 23. Pass 3 - Final polish

Read this document a third time.

Polish:

## 23.1 Clouds

- color balance;
- smoothness;
- no black spots;
- no plastic look;
- no obvious repetition.

## 23.2 Portal

- readable clockwise spiral;
- depth between rings and surface;
- subtle particles;
- no overexposure;
- no sphere impression;
- no terrain overlap.

## 23.3 Final overlay

- vine corners;
- leaf placement;
- text spacing;
- fox button position;
- hover image;
- timing;
- control lock boundaries.

## 23.4 Performance

- inactive processing;
- hidden emitters;
- material sharing;
- particle bounds;
- no leaks.

Expected commit:

```text
Polish Level 01 clouds portal and finale presentation
```

---

# 24. Automated validation

Required when tools are available:

```text
git status --short
git diff --check
Godot 4.6 project import
GDScript parse
scene load validation
resource load validation
shader compile validation
headless smoke test
benchmark capture
```

Inspect all changed `.tscn`, `.tres`, `.gdshader`, `.gd` for:

- invalid paths;
- invalid UIDs;
- wrong NodePaths;
- shared runtime material mutation;
- unsupported shader syntax;
- missing signals;
- disabled controls not restored.

---

# 25. Definition of done

The corrective pass is complete only when:

## Clouds

- black spots are gone;
- surface is soft and clean;
- visual variation remains;
- performance is not worse.

## Portal

- no placeholder sphere;
- no grey box frame;
- slow clockwise woven-light motion;
- visible particles;
- doorway silhouette;
- correct interaction and transition.

## Controls

- lock begins no earlier than 0.10 s before visible overlay change;
- unlock occurs no later than 0.10 s after overlay disappears;
- portal materializes while Player can move;
- failure paths restore controls.

## Final overlay

- same visual family as shard reward overlay;
- same fox button assets;
- vines start from fox;
- full rectangular frame;
- leaves;
- text;
- no crystals;
- gradual reveal;
- correct hover texture.

## Performance

- minimum benchmark gates pass;
- no persistent hidden work;
- no VFX leaks.

## Transition

- no grey Level_02 frame;
- Player works after load.

## Final approval target

```text
Every review category >= 90
Target 95
No critical blocker
```

---

# 26. Required implementation report

Create:

```text
docs/development/Level_01_90_95_Corrective_Pass_Implementation_Report.md
```

Required sections:

```text
1. Executive summary
2. Baseline branch and SHA
3. Local unpushed work detected
4. Final branch and SHA
5. Slice-by-slice commits
6. Files created
7. Files modified
8. Cloud diagnosis
9. Cloud final solution
10. Environment and lighting corrections
11. Performance baseline
12. Performance final comparison
13. Camera and barrier corrections
14. Landmark beam correction
15. Portal final architecture and parameters
16. Finale control timing before and after
17. Finale overlay final structure
18. Text reveal final timing
19. Fox button state implementation
20. Level_02 transition
21. Audio status
22. Automated validation
23. Manual/runtime validation actually performed
24. Manual QA still required
25. Deviations from this reference
26. Known limitations
27. Final 90-95 acceptance checklist
28. Confirmation that no merge was performed
```

Do not claim a visual or runtime test that was not actually performed.

---

# 27. Recommended commit sequence

```text
1. Rebuild Level 01 cloud material for soft clean rendering
2. Balance Level 01 local materials and lighting
3. Stabilize Level 01 VFX and environment frame pacing
4. Polish Level 01 camera readability and barrier weight
5. Refine Landmark beam into a restrained warm effect
6. Replace LevelPortal placeholder with woven light spiral
7. Correct Level 01 finale control lock timing
8. Rebuild finale overlay as a rectangular luminous vine frame
9. Add calm progressive reveal to the finale text
10. Fix fox confirm button idle hover and pressed states
11. Hide Level 02 initialization behind the portal transition
12. Complete Level 01 corrective pass requirement coverage
13. Polish Level 01 clouds portal and finale presentation
14. Add Level 01 corrective pass implementation report
```

Audio receives a separate commit only when implementation changes are required.

---

# 28. Final architectural verdict

Approved target:

```text
clean shared stylized cloud material
+ measured local performance corrections
+ weighted barrier
+ restrained Landmark beam
+ reusable vertical woven-light portal
+ exact final-overlay control timing
+ rectangular vine finale overlay
+ progressive text reveal
+ deterministic reusable fox button state machine
+ concealed Level_02 loading
```

This is sufficient to raise the visible Level_01 presentation into the 90-95 range without replacing the working core gameplay architecture.
