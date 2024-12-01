extends Node2D

var original_background_color

var play_button_on = false


func _ready() -> void:
	$HiddenLightbulb.process_mode = Node.PROCESS_MODE_DISABLED
	original_background_color = RenderingServer.get_default_clear_color()
	await SceneManager.transition_done
	$Text_displayer.write_dialogue(["Money is tight", "Turn off the lights!"])

func turn_the_lights_out():
	for child in get_children():
		if (child.is_in_group("Button")):
			child.find_child("AnimatedSprite2D").hide()
			child.process_mode = Node.PROCESS_MODE_DISABLED
	$Text_displayer._reset_label()
	RenderingServer.set_default_clear_color(Color.BLACK)
	
func turn_the_lights_on():
	for child in get_children():
		if (child.is_in_group("Button")):
			child.find_child("AnimatedSprite2D").show()
			child.process_mode = Node.PROCESS_MODE_PAUSABLE

	RenderingServer.set_default_clear_color(original_background_color)
	play_button_on = true

func _on_light_string_pulled_signal() -> void:
	turn_the_lights_out()
	$LightString.hide()
	$HiddenLightbulb.process_mode = Node.PROCESS_MODE_PAUSABLE


func _on_hidden_lightbulb_pressed() -> void:
	turn_the_lights_on()


func _on_play_button_pressed() -> void:
	if play_button_on:
		SceneManager.next_level()
	# THID CHANGES THE TEXT BEFORE LIGHTS GO OUT
	# else:
	# 	$Text_displayer.write_wrong_button()


func _on_escape_button_pressed() -> void:
	if play_button_on:
		$Text_displayer.write_wrong_button()


func _on_language_btn_korean_pressed() -> void:
	if play_button_on:
		$Text_displayer.write_wrong_button()


func _on_settings_button_pressed() -> void:
	if play_button_on:
		$Text_displayer.write_wrong_button()


func _on_mute_button_pressed() -> void:
	if play_button_on:
		$Text_displayer.write_wrong_button()
