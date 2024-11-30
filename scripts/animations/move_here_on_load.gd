extends Marker2D
class_name MoveHereOnLoad


@export var duration := 1.0


func _ready() -> void:
	await SceneManager.transition_done
	#print("Hiding ", get_parent().name)
	
	var parent = get_parent()
	var tween = get_tree().create_tween()
	tween.tween_property(parent, "global_position", global_position, duration)
