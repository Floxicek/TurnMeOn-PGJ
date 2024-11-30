extends Node2D

var original_background_color

var play_button_on = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HiddenLightbulb.process_mode = Node.PROCESS_MODE_DISABLED
	original_background_color = RenderingServer.get_default_clear_color()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func turn_the_lights_out():
	for child in get_children():
		if(child.is_in_group("Button")):
			child.find_child("AnimatedSprite2D").hide()
	RenderingServer.set_default_clear_color(Color.BLACK)
	
func turn_the_lights_on():
	for child in get_children():
		if(child.is_in_group("Button")):
			child.find_child("AnimatedSprite2D").show()
	RenderingServer.set_default_clear_color(original_background_color)
	play_button_on = true


func _on_light_string_pulled_signal() -> void:
	turn_the_lights_out()
	$LightString.hide()
	$HiddenLightbulb.process_mode = Node.PROCESS_MODE_PAUSABLE

func _on_hidden_lightbulb_pressed() -> void:
	turn_the_lights_on()
	pass # Replace with function body.


func _on_play_button_pressed() -> void:
	if play_button_on:
		SceneManager.next_level()	
	pass # Replace with function body.
