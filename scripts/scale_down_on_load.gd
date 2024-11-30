extends Node
class_name ScaleOnLoad


@export_range(.1, 1.5) var scale_to := 1.0

func _ready() -> void:
	await SceneManager.transition_done
	print("Scaling ", get_parent().name, " to ", scale_to)
	var parent = get_parent()
	if parent.has_method("set_default_scale"):
		parent.set_default_scale(scale_to)
	var tween = get_tree().create_tween()
	tween.tween_property(get_parent(), "scale", Vector2(scale_to, scale_to), .5)
