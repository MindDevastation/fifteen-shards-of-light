extends Node
class_name RippleConversationController

signal marker_completed(marker_id)
signal puzzle_completed(branch_id)
signal configuration_error(component, message)

enum RouteContext {
	INITIAL,
	REMAINING,
}

const MARKER_RIPPLE_1 := &"RIPPLE_MARKER_1"
const MARKER_RIPPLE_2 := &"RIPPLE_MARKER_2"
const BRANCH_RIPPLE := &"RIPPLE"

const FOOTPRINT_MAP := {
	&"R1I": {"marker_id": MARKER_RIPPLE_1, "route_context": RouteContext.INITIAL},
	&"R1R": {"marker_id": MARKER_RIPPLE_1, "route_context": RouteContext.REMAINING},
	&"R2I": {"marker_id": MARKER_RIPPLE_2, "route_context": RouteContext.INITIAL},
	&"R2R": {"marker_id": MARKER_RIPPLE_2, "route_context": RouteContext.REMAINING},
}
const MARKER_IDS: Array[StringName] = [MARKER_RIPPLE_1, MARKER_RIPPLE_2]

@export var footprint_root_path := NodePath("../FootprintRoot")
@export var progress_controller_path := NodePath("../../../../LevelRuntimeRoot/Level04ProgressController")
@export var presentation_controller_path := NodePath("../../../../VFXRoot/RipplePresentationRoot")
@export var player_path := NodePath("../../../../PlayerRoot/Player")

var _completed_markers: Array[StringName] = []
var _solved := false
var _terminal_emitted := false

func _ready() -> void:
	_connect_footprints()
	_connect_progress_controller()
	debug_validate_identity_map()

func report_presence_accepted(marker_id, footprint_id, route_context: RouteContext) -> void:
	var normalized_marker := StringName(marker_id)
	var normalized_footprint := StringName(footprint_id)
	if not FOOTPRINT_MAP.has(normalized_footprint):
		_emit_configuration_error(&"RippleConversationController", "unknown footprint ID %s" % [String(normalized_footprint)])
		return
	var expected: Dictionary = FOOTPRINT_MAP[normalized_footprint]
	if expected["marker_id"] != normalized_marker:
		_emit_configuration_error(&"RippleConversationController", "wrong footprint mapping for %s" % [String(normalized_footprint)])
		return
	if expected["route_context"] != route_context:
		_emit_configuration_error(&"RippleConversationController", "wrong route context for %s" % [String(normalized_footprint)])
		return
	if not MARKER_IDS.has(normalized_marker):
		_emit_configuration_error(&"RippleConversationController", "unknown marker ID %s" % [String(normalized_marker)])
		return
	if _completed_markers.has(normalized_marker):
		return
	_completed_markers.append(normalized_marker)
	marker_completed.emit(normalized_marker)
	if _completed_markers.size() == MARKER_IDS.size() and not _terminal_emitted:
		_solved = true
		_terminal_emitted = true
		puzzle_completed.emit(BRANCH_RIPPLE)

func is_marker_completed(marker_id) -> bool:
	return _completed_markers.has(StringName(marker_id))

func is_complete() -> bool:
	return _solved

func get_completed_marker_ids() -> Array[StringName]:
	return _completed_markers.duplicate()

func request_current_hint() -> void:
	pass

func debug_validate_identity_map() -> bool:
	var ok := true
	var root := get_node_or_null(footprint_root_path)
	if root == null:
		_emit_configuration_error(&"RippleConversationController", "FootprintRoot missing")
		return false
	for footprint_id in FOOTPRINT_MAP.keys():
		var node := root.get_node_or_null(String(footprint_id))
		if node == null:
			_emit_configuration_error(&"RippleConversationController", "footprint missing %s" % [String(footprint_id)])
			ok = false
			continue
		var expected: Dictionary = FOOTPRINT_MAP[footprint_id]
		if node.target_id != expected["marker_id"] or node.footprint_id != footprint_id or node.route_context != expected["route_context"]:
			_emit_configuration_error(&"RippleConversationController", "identity mismatch for %s" % [String(footprint_id)])
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
		_emit_configuration_error(&"RippleConversationController", "progress controller missing")

func _emit_configuration_error(component: StringName, message: String) -> void:
	push_error("%s: %s" % [String(component), message])
	configuration_error.emit(component, message)
