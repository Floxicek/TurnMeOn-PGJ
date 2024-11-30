extends Node2D

func _on_play_button_pressed() -> void:
	SceneManager.next_level()


func _on_escape_button_pressed() -> void:
	$Text_displayer.show_rand_bad_button_dialog()

func _on_language_btn_korean_pressed() -> void:
	$Text_displayer.show_rand_bad_button_dialog()


func _on_settings_button_pressed() -> void:
	$Text_displayer.show_rand_bad_button_dialog()


func _on_mute_button_pressed() -> void:
	$Text_displayer.show_rand_bad_button_dialog()
