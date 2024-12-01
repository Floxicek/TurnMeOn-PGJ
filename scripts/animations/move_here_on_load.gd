extends Marker2D
class_name MoveHereOnLoad

@export var duration := 1.0

var last_parent_position: Vector2 = Vector2.ZERO

func _ready() -> void:
	if not Engine.is_editor_hint():
		await SceneManager.transition_done
		var parent = get_parent()
		if not parent:
			return
		var tween = get_tree().create_tween()
		tween.tween_property(parent, "global_position", global_position, duration)
		last_parent_position = parent.global_position
