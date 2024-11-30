extends Node2D

var shown_text = ""
@export var text = "Sample text"
@export var time_between_letters = 0.2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Next_letter_timer.wait_time = time_between_letters
	$Next_letter_timer.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Label.text = shown_text
	pass


func _on_next_letter_timer_timeout() -> void:
	var len_text = len(text)
	for i in range(len(text)+1):
		if i >= len(shown_text) and i<len(text):
			shown_text+=text[i]
			return
	return
	
