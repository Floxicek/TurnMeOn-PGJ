extends Node2D

var rng = RandomNumberGenerator.new()


@export var all_buttons: Array[Area2D]
@export var play_button: Area2D
var button_with_play_func: Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assign_play_func()
	pass # Replace with function body.

func assign_play_func():
	if(len(all_buttons)<=0):
		return
	while true:
		var random_button:Area2D = all_buttons[rng.randi_range(0,len(all_buttons)-1)]
		if random_button!=play_button:
			button_with_play_func = random_button
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_escape_button_pressed() -> void:
	pass # Replace with function body.


func _on_language_btn_korean_pressed() -> void:
	pass # Replace with function body.


func _on_play_button_pressed() -> void:
	pass # Replace with function body.


func _on_settings_button_pressed() -> void:
	pass # Replace with function body.
