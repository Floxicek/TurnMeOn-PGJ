extends Node2D


var finished = false



func _on_play_button_area_entered(area: Area2D) -> void:
	if(area is Ball):
		finished = true
		SceneManager.next_level()
