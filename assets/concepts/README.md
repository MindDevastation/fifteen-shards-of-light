# Concept Art References

This folder contains visual reference images and planning notes only.

These files are not gameplay assets and must not be imported or used directly in Godot scenes.

Godot import rule:
- This folder contains `.gdignore`.
- Do not remove `.gdignore`.
- Do not move concept references into active gameplay asset folders.

Usage rules for Codex / agents:
- Use these images as visual references only.
- Written layout notes and technical specs are the source of truth.
- Do not instantiate PNG concept images in gameplay scenes.
- Do not convert concept images into textures unless explicitly requested.
- Do not treat this folder as part of the runtime asset pipeline.

Gameplay assets should live in project asset folders such as:
- assets/models/
- assets/materials/
- scenes/environment/assets/
- scenes/levels/

Concept references should stay here.