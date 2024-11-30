extends Control

signal clear_scene_done
signal show_scene_done

func _ready() -> void:
	$AnimatedSprite2D.hide()


var _started = false
func _on_animated_sprite_2d_animation_finished() -> void:
	mouse_filter = MouseFilter.MOUSE_FILTER_IGNORE
	#print("Finished")
	#$AnimatedSprite2D.hide()
	if _started:
		clear_scene_done.emit()
	else:
		show_scene_done.emit()

func clear_scene():
	#print("Transition started")
	_started = true
	$AnimatedSprite2D.show()
	mouse_filter = MouseFilter.MOUSE_FILTER_STOP
	$AnimatedSprite2D.play("transition")

func show_scene():
	#print("Transition stoped")
	_started = false
	$AnimatedSprite2D.show()
	mouse_filter = MouseFilter.MOUSE_FILTER_STOP
	$AnimatedSprite2D.play_backwards("transition")
