extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	var sprite:Sprite2D = $rectangle
	sprite.self_modulate = Color.RED

func _on_area_exited(area: Area2D) -> void:
	var sprite:Sprite2D = $rectangle
	sprite.self_modulate = Color.BLUE
