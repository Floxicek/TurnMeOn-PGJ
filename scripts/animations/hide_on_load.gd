extends Node
class_name HideOnLoad

@export var duration := 1.0
@export var visible := false

func _ready() -> void:
	if not visible:
		await SceneManager.transition_done
		print("Hiding ", get_parent().name)
		animate_hide()


func animate_hide():
	var parent = get_parent()
	var tween = get_tree().create_tween()
	tween.tween_property(parent, "modulate:a", 0, 1)
	await tween.finished
	return tween

func animate_show():
	var parent = get_parent()
	var tween = get_tree().create_tween()
	tween.tween_property(parent, "modulate:a", 1, 1)
	return tween
