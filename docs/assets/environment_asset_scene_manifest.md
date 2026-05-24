# Environment Asset Scene Manifest

| Source .glb path | Wrapper .tscn path | Collision type | Collision status | Notes |
|---|---|---|---|---|
| `assets/architecture/Full_Gate/Full_Gate.glb` | `scenes/environment/assets/Full_Gate.tscn` | 3 × BoxShape3D | BLOCKING | Arch opening left passable by split pillar/top collision. |
| `assets/architecture/Ruined_Gate_01/Ruined_Gate_01.glb` | `scenes/environment/assets/Ruined_Gate_01.tscn` | 3 × BoxShape3D | NEEDS_MANUAL_REVIEW | Conservative arch approximation; opening intent should be checked in-level. |
| `assets/architecture/Ruined_Gate_02/Ruined_Gate_02.glb` | `scenes/environment/assets/Ruined_Gate_02.tscn` | 3 × BoxShape3D | NEEDS_MANUAL_REVIEW | Conservative arch approximation; opening intent should be checked in-level. |
| `assets/architecture/Stone_Steps/Stone_Steps.glb` | `scenes/environment/assets/Stone_Steps.tscn` | BoxShape3D | WALKABLE | Single stable walkable top volume. |
| `assets/architecture/Stone_Block_01/Stone_Block_01.glb` | `scenes/environment/assets/Stone_Block_01.tscn` | BoxShape3D | WALKABLE | Simple stable slab/platform collision. |
| `assets/architecture/landmark_01/landmak_01.glb` | `scenes/environment/assets/landmak_01.tscn` | CylinderShape3D | BLOCKING | Landmark wrapper independent from core gameplay landmark scenes. |
| `assets/nature/Stone_Cliff_01/Stone_Cliff_01.glb` | `scenes/environment/assets/Stone_Cliff_01.tscn` | BoxShape3D | BLOCKING | Main cliff body approximation only. |
| `assets/nature/Medium_Rock_01/Medium_Rock_01.glb` | `scenes/environment/assets/Medium_Rock_01.tscn` | SphereShape3D | BLOCKING | Rounded volume approximation for stability. |
| `assets/nature/Tree_01/Tree_01.glb` | `scenes/environment/assets/Tree_01.tscn` | CylinderShape3D | SOFT_BLOCKER | Trunk-only collider; canopy has no collision. |
| `assets/nature/Tree_02/Tree_02.glb` | `scenes/environment/assets/Tree_02.tscn` | CylinderShape3D | SOFT_BLOCKER | Trunk-only collider; canopy has no collision. |
| `assets/nature/Bush_01/Bush_01.glb` | `scenes/environment/assets/Bush_01.tscn` | None | DECORATIVE_NO_COLLISION | Decorative foliage wrapper. |
| `assets/nature/Bush_02/Bush_02.glb` | `scenes/environment/assets/Bush_02.tscn` | None | DECORATIVE_NO_COLLISION | Decorative foliage wrapper. |
| `assets/nature/Bush_03/Bush_03.glb` | `scenes/environment/assets/Bush_03.tscn` | None | DECORATIVE_NO_COLLISION | Decorative foliage wrapper. |
| `assets/nature/Bush_04/Bush_04.glb` | `scenes/environment/assets/Bush_04.tscn` | None | DECORATIVE_NO_COLLISION | Decorative foliage wrapper. |
| `assets/nature/Bush_05/Bush_05.glb` | `scenes/environment/assets/Bush_05.tscn` | None | DECORATIVE_NO_COLLISION | Decorative foliage wrapper. |
| `assets/nature/Bush_06/Bush_06.glb` | `scenes/environment/assets/Bush_06.tscn` | None | DECORATIVE_NO_COLLISION | Decorative foliage wrapper. |
