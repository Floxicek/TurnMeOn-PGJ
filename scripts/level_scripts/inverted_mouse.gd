extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CursorObject.inverted_mouse = true
	await SceneManager.transition_done
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_play_button_pressed() -> void:
	SceneManager.next_level()
	await SceneManager._clear_scene_done
	$CursorObject.inverted_mouse = false


func _on_escape_button_pressed() -> void:
	$Text_displayer.write_wrong_button()

func _on_language_btn_korean_pressed() -> void:
	$Text_displayer.write_wrong_button()


func _on_settings_button_pressed() -> void:
	$Text_displayer.write_wrong_button()


func _on_mute_button_pressed() -> void:
	$Text_displayer.write_wrong_button()
