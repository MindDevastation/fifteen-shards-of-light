# QA Review Prompt Template

Review the latest task output for this Godot 4.x gift game.

## Check
- Did the change stay within the requested slice?
- Were unrelated files changed?
- Were project canon and hard constraints preserved?
- Was gameplay added only if explicitly requested?
- Were Godot project files preserved unless explicitly changed?
- Are manual verification steps clear?
- Are risks and NOT VERIFIED items explicit?

## Output
Return findings grouped as:
- Blocking issues.
- Non-blocking issues.
- Questions.
- Suggested next slice.
