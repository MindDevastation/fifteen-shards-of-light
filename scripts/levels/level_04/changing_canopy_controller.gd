extends Node
class_name ChangingCanopyController

signal target_completed(target_id)
signal puzzle_completed(branch_id)
signal configuration_error(component, message)

enum RouteContext {
	INITIAL,
	REMAINING,
}

const TARGET_CANOPY_TONE_1 := &"CANOPY_TONE_1"
const TARGET_CANOPY_TONE_2 := &"CANOPY_TONE_2"
const TARGET_CANOPY_TONE_3 := &"CANOPY_TONE_3"
const BRANCH_CANOPY := &"CANOPY"

const FOOTPRINT_MAP := {
	&"C1I": {"target_id": TARGET_CANOPY_TONE_1, "route_context": RouteContext.INITIAL},
	&"C1R": {"target_id": TARGET_CANOPY_TONE_1, "route_context": RouteContext.REMAINING},
	&"C2I": {"target_id": TARGET_CANOPY_TONE_2, "route_context": RouteContext.INITIAL},
	&"C2R": {"target_id": TARGET_CANOPY_TONE_2, "route_context": RouteContext.REMAINING},
	&"C3I": {"target_id": TARGET_CANOPY_TONE_3, "route_context": RouteContext.INITIAL},
	&"C3R": {"target_id": TARGET_CANOPY_TONE_3, "route_context": RouteContext.REMAINING},
}
const TARGET_IDS: Array[StringName] = [TARGET_CANOPY_TONE_1, TARGET_CANOPY_TONE_2, TARGET_CANOPY_TONE_3]

@export var footprint_root_path := NodePath("../FootprintRoot")
@export var progress_controller_path := NodePath("../../../../LevelRuntimeRoot/Level04ProgressController")

var _completed_targets: Array[StringName] = []
var _solved := false
var _terminal_emitted := false

func _ready() -> void:
	_connect_footprints()
	_connect_progress_controller()
	debug_validate_identity_map()

func report_presence_accepted(target_id, footprint_id, route_context: RouteContext) -> void:
	var normalized_target := StringName(target_id)
	var normalized_footprint := StringName(footprint_id)
	if not FOOTPRINT_MAP.has(normalized_footprint):
		_emit_configuration_error(&"ChangingCanopyController", "unknown footprint ID %s" % [String(normalized_footprint)])
		return
	var expected: Dictionary = FOOTPRINT_MAP[normalized_footprint]
	if expected["target_id"] != normalized_target:
		_emit_configuration_error(&"ChangingCanopyController", "wrong footprint mapping for %s" % [String(normalized_footprint)])
		return
	if expected["route_context"] != route_context:
		_emit_configuration_error(&"ChangingCanopyController", "wrong route context for %s" % [String(normalized_footprint)])
		return
	if not TARGET_IDS.has(normalized_target):
		_emit_configuration_error(&"ChangingCanopyController", "unknown target ID %s" % [String(normalized_target)])
		return
	if _completed_targets.has(normalized_target):
		return
	_completed_targets.append(normalized_target)
	target_completed.emit(normalized_target)
	if _completed_targets.size() == TARGET_IDS.size() and not _terminal_emitted:
		_solved = true
		_terminal_emitted = true
		puzzle_completed.emit(BRANCH_CANOPY)

func is_target_completed(target_id) -> bool:
	return _completed_targets.has(StringName(target_id))

func is_complete() -> bool:
	return _solved

func get_completed_target_ids() -> Array[StringName]:
	return _completed_targets.duplicate()

func request_current_hint() -> void:
	pass

func debug_validate_identity_map() -> bool:
	var ok := true
	var root := get_node_or_null(footprint_root_path)
	if root == null:
		_emit_configuration_error(&"ChangingCanopyController", "FootprintRoot missing")
		return false
	for footprint_id in FOOTPRINT_MAP.keys():
		var node := root.get_node_or_null(String(footprint_id))
		if node == null:
			_emit_configuration_error(&"ChangingCanopyController", "footprint missing %s" % [String(footprint_id)])
			ok = false
			continue
		var expected: Dictionary = FOOTPRINT_MAP[footprint_id]
		if node.target_id != expected["target_id"] or node.footprint_id != footprint_id or node.route_context != expected["route_context"]:
			_emit_configuration_error(&"ChangingCanopyController", "identity mismatch for %s" % [String(footprint_id)])
			ok = false
	return ok

func _connect_footprints() -> void:
	var root := get_node_or_null(footprint_root_path)
	if root == null:
		return
	for footprint_id in FOOTPRINT_MAP.keys():
		var footprint := root.get_node_or_null(String(footprint_id))
		if footprint != null and footprint.has_signal("presence_accepted"):
			if not footprint.presence_accepted.is_connected(report_presence_accepted):
				footprint.presence_accepted.connect(report_presence_accepted)

func _connect_progress_controller() -> void:
	var progress := get_node_or_null(progress_controller_path)
	if progress != null and progress.has_method("report_puzzle_completed"):
		if not puzzle_completed.is_connected(progress.report_puzzle_completed):
			puzzle_completed.connect(progress.report_puzzle_completed)
	else:
		_emit_configuration_error(&"ChangingCanopyController", "progress controller missing")

func _emit_configuration_error(component: StringName, message: String) -> void:
	push_error("%s: %s" % [String(component), message])
	configuration_error.emit(component, message)
