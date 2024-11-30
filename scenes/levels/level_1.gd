extends Node2D


func _on_play_button_pressed() -> void:
	print("first scene button pressed")
	SceneManager.change_scene("res://scenes/levels/level2.tscn")
