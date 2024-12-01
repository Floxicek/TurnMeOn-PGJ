#@tool
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

func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		var parent = get_parent()
		if not parent:
			return
		if parent.global_position != last_parent_position or global_position != position:
			last_parent_position = parent.global_position
			queue_redraw()

func _draw() -> void:
	if Engine.is_editor_hint():
		var parent = get_parent()
		if parent:
			var start_pos = parent.global_position - global_position
			var end_pos = Vector2.ZERO
			draw_line(start_pos, end_pos, Color(1, 0, 0), 2)
			var arrow_size = 10
			var direction = (end_pos - start_pos).normalized()
			var arrow_tip = start_pos + direction * arrow_size
