extends Node

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN) 


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("fullscreen_toggle"):
		print(DisplayServer.window_get_mode())
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	if event.is_action_pressed("mute"):
		AudioPlayer.toggle_soundtrack()
