extends RefCounted
class_name FoxHeroineAnimationMap

const SOURCE_TO_ACTION := {
	"Bass_Beats": "turn_right",
	"Crouch_and_Push_Forward": "run",
	"Fast_Stair_Climb": "walk",
	"Female_Walk_Pick_Put_In_Pocket": "cast_1",
	"Idle_11": "climb",
	"Push_Forward_and_Stop": "fast_run",
	"Regular_Jump": "push",
	"RunFast": "move_back",
	"Run_Turn_Left": "cast_2",
	"Run_Turn_Right": "cast_3",
	"Running": "push_and_stop",
	"Step_Forward_and_Push": "dance_test",
	"Walk_Backward": "stand_up",
	"Walking": "idle_and_pick_up",
	"mage_soell_cast": "turn_left",
	"mage_soell_cast_3": "idle",
	"mage_soell_cast_7": "jump",
}

const ACTION_TO_SOURCE := {
	"turn_right": "Bass_Beats",
	"run": "Crouch_and_Push_Forward",
	"walk": "Fast_Stair_Climb",
	"cast_1": "Female_Walk_Pick_Put_In_Pocket",
	"climb": "Idle_11",
	"fast_run": "Push_Forward_and_Stop",
	"push": "Regular_Jump",
	"move_back": "RunFast",
	"cast_2": "Run_Turn_Left",
	"cast_3": "Run_Turn_Right",
	"push_and_stop": "Running",
	"dance_test": "Step_Forward_and_Push",
	"stand_up": "Walk_Backward",
	"idle_and_pick_up": "Walking",
	"turn_left": "mage_soell_cast",
	"idle": "mage_soell_cast_3",
	"jump": "mage_soell_cast_7",
}

static func get_action_for_source(source_animation_name: String) -> String:
	return SOURCE_TO_ACTION.get(source_animation_name, "")


static func get_source_for_action(action_name: String) -> String:
	return ACTION_TO_SOURCE.get(action_name, "")


static func has_source(source_animation_name: String) -> bool:
	return SOURCE_TO_ACTION.has(source_animation_name)


static func has_action(action_name: String) -> bool:
	return ACTION_TO_SOURCE.has(action_name)


static func get_all_actions() -> Array[String]:
	var actions: Array[String] = []
	for action_name in ACTION_TO_SOURCE.keys():
		actions.append(action_name)
	actions.sort()
	return actions


static func get_all_sources() -> Array[String]:
	var sources: Array[String] = []
	for source_name in SOURCE_TO_ACTION.keys():
		sources.append(source_name)
	sources.sort()
	return sources
