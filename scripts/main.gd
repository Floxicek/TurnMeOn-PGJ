extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Text_displayer.start_printing()
	$Text_displayer2.write_wrong_button()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
