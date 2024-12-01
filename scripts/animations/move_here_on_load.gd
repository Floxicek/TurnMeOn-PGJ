#@tool
extends Marker2D
class_name MoveFromHereOnLoad

@export var duration := 1.0

var child_pos: Vector2 = Vector2.ZERO

func _ready() -> void:
	if not Engine.is_editor_hint():
		if get_child(0):
			child_pos = get_child(0).global_position
			get_child(0).global_position = global_position
			await SceneManager.transition_done
			var child = get_child(0)
			if not child:
				return
			var tween = get_tree().create_tween()
			tween.tween_property(child, "global_position", child_pos, duration)
