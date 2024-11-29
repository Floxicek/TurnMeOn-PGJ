extends Control

signal clear_scene_done
signal show_scene_done


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "clear_scene":
		clear_scene_done.emit()
	elif anim_name == "show_scene":
		show_scene_done.emit()

func clear_scene():
	print("Transition started")
	$AnimationPlayer.play("clear_scene")

func show_scene():
	print("Transition stoped")
	$AnimationPlayer.play("show_scene")
