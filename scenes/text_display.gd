extends Node2D

var shown_text = ""
@export var text = "Sample text"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Next_letter_timer.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Label.text = shown_text
	pass


func _on_next_letter_timer_timeout() -> void:
	for i in range(len(text)):
		if text[i] != shown_text[i] and i<len(text)-1:
			shown_text+=text[i+1]
	return
	
