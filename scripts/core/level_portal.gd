extends Node3D

const PORTAL_LAYER_PHASE_OFFSETS: Array[float] = [0.000, 0.012, -0.012, 0.022, -0.022, 0.032]
const PORTAL_LAYER_ROTATION_SPEEDS: Array[float] = [0.670, 0.680, 0.660, 0.690, 0.665, 0.675]
const PORTAL_LAYER_ALPHAS: Array[float] = [0.30, 0.38, 0.48, 0.48, 0.38, 0.30]
const PORTAL_LAYER_RADIAL_DENSITIES: Array[float] = [15.6, 15.9, 15.4, 16.1, 15.5, 15.8]


signal activation_started
signal activation_completed
signal entry_confirmation_requested(player: Node)
signal transition_started
signal transition_failed(player: Node, error_code: int)
signal transition_completed

enum PortalState { INACTIVE, ACTIVATING, ACTIVE, WAITING_FOR_CONFIRMATION, ENTERING }
enum EntryMode { AUTO_ENTER, INTERACT }

@export var target_scene_path: String = ""
@export var entry_mode: EntryMode = EntryMode.AUTO_ENTER
@export var require_entry_confirmation: bool = false
@export var interaction_prompt_text: String = "Шагнуть к свету"
@export_range(0.2, 5.0, 0.1) var activation_duration: float = 1.75
@export_range(0.1, 2.0, 0.05) var transition_duration: float = 0.55
@export_range(0.1, 2.0, 0.05) var transition_fade_out_duration: float = 0.70

var _state := PortalState.INACTIVE
var _is_loading_scene := false
var _player_in_range := false
var _current_player: Node
var _confirmation_player: Node
var _strand_materials: Array[ShaderMaterial] = []
var _strand_target_scales: Array[Vector3] = []
var _strand_target_transforms: Array[Transform3D] = []
var _back_veil_material: ShaderMaterial
var _ring_materials: Array[ShaderMaterial] = []
var _ground_material: ShaderMaterial
var _activation_tween: Tween
var _controls_locked_by_portal := false
var _transition_service: Node
var _transition_failed_callback := Callable()
var _transition_finished_callback := Callable()
@onready var visual_root: Node3D = $VisualRoot
@onready var ground_ring: MeshInstance3D = $VisualRoot/GroundRing
@onready var outer_ring: MeshInstance3D = $VisualRoot/OuterRing
@onready var inner_ring: MeshInstance3D = $VisualRoot/InnerRing
@onready var strand_layers: Array[MeshInstance3D] = [$VisualRoot/PortalStrandLayerDeepBack, $VisualRoot/PortalStrandLayerBack, $VisualRoot/PortalStrandLayerMiddle, $VisualRoot/PortalStrandLayerNearMiddle, $VisualRoot/PortalStrandLayerFront, $VisualRoot/PortalStrandLayerDeepFront]
@onready var back_veil: MeshInstance3D = $VisualRoot/BackVeil
@onready var interaction_area: Area3D = $InteractionArea
@onready var interaction_shape: CollisionShape3D = $InteractionArea/CollisionShape3D
@onready var orbit_motes: GPUParticles3D = $VisualRoot/OrbitMotes
@onready var light_sleeves: Node3D = $VisualRoot/PortalLightSleeve3D
@onready var portal_light: OmniLight3D = $VisualRoot/PortalLight
@onready var prompt: CanvasLayer = $WorldInteractionPrompt

func _exit_tree() -> void:
	_clear_transition_callbacks()

func _ready() -> void:
	add_to_group("player_interactable")
	_capture_strand_target_scales()
	_duplicate_runtime_materials()
	interaction_area.body_entered.connect(_on_body_entered)
	interaction_area.body_exited.connect(_on_body_exited)
	if prompt.has_method("set_target"):
		prompt.call("set_target", self)
	var prompt_label := prompt.get_node_or_null("Root/TrackingRoot/AnimationRoot/PromptRoot/PromptBox/ActionLabel")
	if prompt_label is Label:
		prompt_label.text = interaction_prompt_text
	_set_activation(0.0)
	_deactivate()

func activate() -> void:
	if _state == PortalState.ACTIVE or _state == PortalState.ACTIVATING or _state == PortalState.WAITING_FOR_CONFIRMATION or _state == PortalState.ENTERING:
		return
	_state = PortalState.ACTIVATING
	show()
	visual_root.show()
	set_process(true)
	activation_started.emit()
	_play_staged_activation()

func can_player_interact(player: Node) -> bool:
	return entry_mode == EntryMode.INTERACT and _state == PortalState.ACTIVE and _player_in_range and not _is_loading_scene and player == _current_player

func interact(player: Node) -> void:
	if not can_player_interact(player):
		return
	if require_entry_confirmation:
		_request_entry_confirmation(player)
	else:
		_begin_entry(player)

func continue_entry_after_confirmation(player: Node) -> void:
	if _state != PortalState.WAITING_FOR_CONFIRMATION or player != _confirmation_player:
		return
	_confirmation_player = null
	_begin_entry(player, true)

func cancel_entry_confirmation(player: Node) -> void:
	if _state != PortalState.WAITING_FOR_CONFIRMATION or (_confirmation_player != null and player != _confirmation_player):
		return
	_confirmation_player = null
	_is_loading_scene = false
	_state = PortalState.ACTIVE
	_set_interaction_enabled(true)
	_update_prompt()

func _process(delta: float) -> void:
	if _state == PortalState.INACTIVE:
		return
	ground_ring.rotate_y(0.34 * delta)
	orbit_motes.rotate_z(-0.78 * delta)

func _capture_strand_target_scales() -> void:
	if not _strand_target_scales.is_empty():
		return
	for layer in strand_layers:
		_strand_target_scales.append(layer.scale)
		_strand_target_transforms.append(layer.transform)

func _get_strand_target_scale(index: int) -> Vector3:
	if index >= 0 and index < _strand_target_scales.size():
		return _strand_target_scales[index]
	return Vector3.ONE

func _get_strand_target_transform(index: int) -> Transform3D:
	if index >= 0 and index < _strand_target_transforms.size():
		return _strand_target_transforms[index]
	return Transform3D.IDENTITY

func _scaled_transform(source: Transform3D, scale_multiplier: float) -> Transform3D:
	var result := source
	result.basis.x *= scale_multiplier
	result.basis.y *= scale_multiplier
	result.basis.z *= scale_multiplier
	return result

func _duplicate_runtime_materials() -> void:
	_strand_materials.clear()
	for index in range(strand_layers.size()):
		var layer := strand_layers[index]
		if layer.material_override is ShaderMaterial:
			layer.material_override = layer.material_override.duplicate()
			var material := layer.material_override as ShaderMaterial
			_strand_materials.append(material)
			material.set_shader_parameter("phase_offset", PORTAL_LAYER_PHASE_OFFSETS[index])
			material.set_shader_parameter("strand_density", 6.0)
			material.set_shader_parameter("radial_density", PORTAL_LAYER_RADIAL_DENSITIES[index])
			material.set_shader_parameter("rotation_speed", PORTAL_LAYER_ROTATION_SPEEDS[index])
			material.set_shader_parameter("layer_alpha", PORTAL_LAYER_ALPHAS[index])
	if back_veil.material_override is ShaderMaterial:
		back_veil.material_override = back_veil.material_override.duplicate()
		_back_veil_material = back_veil.material_override
	for index in range(2):
		var ring: MeshInstance3D = [outer_ring, inner_ring][index]
		if ring.material_override is ShaderMaterial:
			ring.material_override = ring.material_override.duplicate()
			var material := ring.material_override as ShaderMaterial
			_ring_materials.append(material)
			if index == 0:
				material.set_shader_parameter("ring_radius", 0.92)
				material.set_shader_parameter("ring_width", 0.115)
				material.set_shader_parameter("ring_alpha", 0.48)
				material.set_shader_parameter("emission_strength", 0.62)
			else:
				material.set_shader_parameter("ring_radius", 0.76)
				material.set_shader_parameter("ring_width", 0.070)
				material.set_shader_parameter("ring_alpha", 0.32)
				material.set_shader_parameter("emission_strength", 0.48)
			material.set_shader_parameter("edge_softness", 0.055)
	if ground_ring.material_override is ShaderMaterial:
		ground_ring.material_override = ground_ring.material_override.duplicate()
		_ground_material = ground_ring.material_override

func _play_staged_activation() -> void:
	if _activation_tween != null and _activation_tween.is_valid():
		_activation_tween.kill()
	_set_activation(0.0)
	visual_root.scale = Vector3.ONE
	ground_ring.scale = Vector3.ONE * 0.72
	outer_ring.scale = Vector3.ONE * 0.78
	inner_ring.scale = Vector3.ONE * 0.70
	for index in range(strand_layers.size()):
		var target_transform := _get_strand_target_transform(index)
		var start_multiplier := 0.90 + float(index) * 0.045
		strand_layers[index].transform = _scaled_transform(target_transform, start_multiplier)
	back_veil.scale = Vector3.ONE * 0.90
	portal_light.light_energy = 0.0
	orbit_motes.emitting = false
	_activation_tween = create_tween()
	_activation_tween.set_parallel(true)
	_activation_tween.tween_method(_set_ground_activation, 0.0, 1.0, 0.40).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	_activation_tween.tween_method(_set_ring_activation, 0.0, 1.0, 1.05).set_delay(0.15).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	_activation_tween.tween_property(outer_ring, "scale", Vector3.ONE, 1.05).set_delay(0.15).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	_activation_tween.tween_property(inner_ring, "scale", Vector3.ONE, 1.05).set_delay(0.15).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	_activation_tween.tween_method(_set_surface_activation, 0.0, 1.0, 1.20).set_delay(0.30).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	for index in range(strand_layers.size()):
		_activation_tween.tween_property(strand_layers[index], "transform", _get_strand_target_transform(index), 1.20).set_delay(0.30).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	_activation_tween.tween_method(_set_back_veil_activation, 0.0, 1.0, 1.10).set_delay(0.25).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	_activation_tween.tween_property(back_veil, "scale", Vector3.ONE, 1.10).set_delay(0.25).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	_activation_tween.tween_property(portal_light, "light_energy", 0.48, 0.75).set_delay(0.35).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	get_tree().create_timer(0.50).timeout.connect(func():
		if _state == PortalState.ACTIVATING:
			orbit_motes.emitting = true
	)
	_activation_tween.finished.connect(func():
		await get_tree().create_timer(maxf(0.0, activation_duration - 1.50)).timeout
		_finish_activation()
	)

func _set_activation(value: float) -> void:
	_set_ground_activation(value)
	_set_ring_activation(value)
	_set_surface_activation(value)
	_set_back_veil_activation(value)

func _set_ground_activation(value: float) -> void:
	if _ground_material != null:
		_ground_material.set_shader_parameter("activation", value)

func _set_ring_activation(value: float) -> void:
	for mat in _ring_materials:
		mat.set_shader_parameter("activation", value)

func _set_surface_activation(value: float) -> void:
	for mat in _strand_materials:
		mat.set_shader_parameter("activation", value)
	if light_sleeves != null and light_sleeves.has_method("set_activation"):
		light_sleeves.call("set_activation", value)

func _set_back_veil_activation(value: float) -> void:
	if _back_veil_material != null:
		_back_veil_material.set_shader_parameter("activation", value)

func _finish_activation() -> void:
	if _state != PortalState.ACTIVATING:
		return
	_set_activation(1.0)
	portal_light.light_energy = 0.48
	_state = PortalState.ACTIVE
	_set_interaction_enabled(true)
	_update_prompt()
	activation_completed.emit()

func _deactivate() -> void:
	_state = PortalState.INACTIVE
	hide()
	visual_root.hide()
	set_process(false)
	_set_interaction_enabled(false)
	orbit_motes.emitting = false
	if light_sleeves != null and light_sleeves.has_method("set_activation"):
		light_sleeves.call("set_activation", 0.0)
	portal_light.light_energy = 0.0
	if prompt.has_method("hide_prompt"):
		prompt.call("hide_prompt")

func _set_interaction_enabled(enabled: bool) -> void:
	interaction_area.set_deferred("monitoring", enabled)
	interaction_area.set_deferred("monitorable", enabled)
	interaction_shape.set_deferred("disabled", not enabled)

func _on_body_entered(body: Node3D) -> void:
	if not _is_player_body(body):
		return
	_player_in_range = true
	_current_player = body
	_update_prompt()
	if entry_mode == EntryMode.AUTO_ENTER and _state == PortalState.ACTIVE and not _is_loading_scene:
		_begin_entry(body)

func _on_body_exited(body: Node3D) -> void:
	if body != _current_player:
		return
	_player_in_range = false
	_current_player = null
	_update_prompt()

func _update_prompt() -> void:
	if prompt == null:
		return
	if can_player_interact(_current_player):
		prompt.call("show_prompt")
	elif prompt.has_method("hide_prompt"):
		prompt.call("hide_prompt")

func _request_entry_confirmation(player: Node) -> void:
	if _state != PortalState.ACTIVE or _is_loading_scene:
		return
	_state = PortalState.WAITING_FOR_CONFIRMATION
	_confirmation_player = player
	_set_interaction_enabled(false)
	if prompt.has_method("play_confirm_and_hide"):
		prompt.call("play_confirm_and_hide")
	elif prompt.has_method("hide_prompt"):
		prompt.call("hide_prompt")
	entry_confirmation_requested.emit(player)

func _begin_entry(player: Node, from_confirmation := false) -> void:
	if _is_loading_scene:
		return
	if (not from_confirmation and _state != PortalState.ACTIVE) or (from_confirmation and _state != PortalState.WAITING_FOR_CONFIRMATION):
		return
	_state = PortalState.ENTERING
	_is_loading_scene = true
	_confirmation_player = null
	if target_scene_path.is_empty():
		push_error("LevelPortal has no target_scene_path set.")
		_handle_transition_result(player, ERR_INVALID_PARAMETER)
		return
	_set_interaction_enabled(false)
	if prompt.has_method("play_confirm_and_hide") and not from_confirmation:
		prompt.call("play_confirm_and_hide")
	transition_started.emit()
	if not from_confirmation:
		_lock_player_controls_if_owned(player)
	_start_transition(player)

func _start_transition(player: Node) -> void:
	_clear_transition_callbacks()
	var transition := get_node_or_null("/root/SceneTransition")
	if transition == null or not transition.has_method("transition_to"):
		var error := get_tree().change_scene_to_file(target_scene_path)
		_handle_transition_result(player, error)
		return
	var failed_callback := _on_scene_transition_failed.bind(player)
	var finished_callback := _on_scene_transition_finished.bind(player)
	var result: int = transition.call("transition_to", target_scene_path, transition_duration, transition_fade_out_duration)
	if result != OK:
		_clear_transition_callbacks()
		_handle_transition_result(player, result)
		return
	_transition_service = transition
	_transition_failed_callback = failed_callback
	_transition_finished_callback = finished_callback
	if _transition_service.has_signal(&"transition_failed"):
		_transition_service.transition_failed.connect(_transition_failed_callback, CONNECT_ONE_SHOT)
	if _transition_service.has_signal(&"transition_finished"):
		_transition_service.transition_finished.connect(_transition_finished_callback, CONNECT_ONE_SHOT)

func _on_scene_transition_failed(scene_path: String, error_code: int, player: Node) -> void:
	if scene_path != target_scene_path:
		return
	_clear_transition_callbacks()
	_handle_transition_result(player, error_code)

func _on_scene_transition_finished(scene_path: String, player: Node) -> void:
	if scene_path != target_scene_path:
		return
	_clear_transition_callbacks()
	_controls_locked_by_portal = false
	transition_completed.emit()

func _handle_transition_result(player: Node, error: int) -> void:
	if error != OK:
		_clear_transition_callbacks()
	if error == OK:
		_controls_locked_by_portal = false
		transition_completed.emit()
		return
	push_error("Could not load portal target %s. Error code: %d" % [target_scene_path, error])
	_is_loading_scene = false
	_state = PortalState.ACTIVE
	_unlock_player_controls_if_owned(player)
	_set_interaction_enabled(true)
	_update_prompt()
	transition_failed.emit(player, error)

func _clear_transition_callbacks() -> void:
	if _transition_service != null:
		if _transition_failed_callback.is_valid() and _transition_service.has_signal(&"transition_failed") and _transition_service.transition_failed.is_connected(_transition_failed_callback):
			_transition_service.transition_failed.disconnect(_transition_failed_callback)
		if _transition_finished_callback.is_valid() and _transition_service.has_signal(&"transition_finished") and _transition_service.transition_finished.is_connected(_transition_finished_callback):
			_transition_service.transition_finished.disconnect(_transition_finished_callback)
	_transition_service = null
	_transition_failed_callback = Callable()
	_transition_finished_callback = Callable()

func _lock_player_controls_if_owned(player: Node) -> void:
	if _controls_locked_by_portal:
		return
	_set_player_controls(player, false)
	_controls_locked_by_portal = true

func _unlock_player_controls_if_owned(player: Node) -> void:
	if not _controls_locked_by_portal:
		return
	_set_player_controls(player, true)
	_controls_locked_by_portal = false

func _set_player_controls(player: Node, enabled: bool) -> void:
	if player != null and player.has_method("set_controls_enabled"):
		player.call("set_controls_enabled", enabled)

func _is_player_body(body: Node3D) -> bool:
	return body is CharacterBody3D and body.name == "Player"
