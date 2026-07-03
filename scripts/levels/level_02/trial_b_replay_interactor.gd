extends Node
class_name TrialBReplayInteractor
signal replay_requested
func interact(_player: Node3D=null) -> void: replay_requested.emit()
