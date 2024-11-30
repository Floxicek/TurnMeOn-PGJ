extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	var sprite:Sprite2D = $rectangle
	get_parent().get_node("Text_displayer").write_wrong_button()
	get_parent().get_node("Text_displayer2").start_printing()
	sprite.self_modulate = Color.RED

func _on_area_exited(area: Area2D) -> void:
	var sprite:Sprite2D = $rectangle
	get_parent().get_node("Text_displayer").hide_text()
	sprite.self_modulate = Color.BLUE
