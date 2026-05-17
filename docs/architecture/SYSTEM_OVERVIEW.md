# SYSTEM_OVERVIEW

## Current State
The repository contains an existing Godot 4.x project. Stage 0B adds only documentation, prompt templates, and empty directory placeholders.

## Intended Future Organization

### Scenes
- `scenes/core` — future root/bootstrap scenes.
- `scenes/levels` — future micro-level scenes.
- `scenes/ui` — future UI scenes.

### Scripts
- `scripts/core` — future shared game flow scripts.
- `scripts/player` — future player controller scripts.
- `scripts/soul` — future soul sphere and shard scripts.
- `scripts/ui` — future UI scripts.

### Assets
- `assets/models` — future model files.
- `assets/materials` — future materials.
- `assets/audio` — future music and sound effects.
- `assets/fonts` — future font files.
- `assets/placeholders` — temporary greybox or placeholder assets when needed.

## Architectural Constraints
- Keep systems small and direct.
- Build vertical slices in small tasks.
- Avoid premature abstractions.
- Avoid adding systems outside the gift-build scope.
