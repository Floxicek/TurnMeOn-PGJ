extends AnimationPlayer

signal finished

func start():
	current_animation = "walk_animation"

func _on_animation_finished(anim_name: StringName) -> void:
	finished.emit()
	queue_free()
