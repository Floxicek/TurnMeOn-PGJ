extends Node2D

var language_changed: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$PlayButton.process_mode = Node.PROCESS_MODE_DISABLED
	$PlayButton.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_button_pressed() -> void:
	SceneManager.next_level()
	

func _on_language_btn_korean_pressed() -> void:
	language_changed = !language_changed
	if language_changed:
		$PlayBtnKorean.process_mode = Node.PROCESS_MODE_DISABLED
		$PlayBtnKorean.hide()
		
		$PlayButton.process_mode = Node.PROCESS_MODE_PAUSABLE
		$PlayButton.show()
	else:
		$PlayButton.process_mode = Node.PROCESS_MODE_DISABLED
		$PlayButton.hide()
		
		$PlayBtnKorean.process_mode = Node.PROCESS_MODE_PAUSABLE
		$PlayBtnKorean.show()


func _on_esc_btn_pressed() -> void:
	$Text_displayer.show_rand_bad_button_dialog()
	pass # Replace with function body.


func _on_play_btn_korean_pressed() -> void:
	$Text_displayer.show_rand_bad_button_dialog()
	pass # Replace with function body.


func _on_settings_button_pressed() -> void:
	$Text_displayer.show_rand_bad_button_dialog()
	pass # Replace with function body.


func _on_mute_button_pressed() -> void:
	$Text_displayer.show_rand_bad_button_dialog()
	pass # Replace with function body.
