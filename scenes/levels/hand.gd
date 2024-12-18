extends Area2D

var level_done:= false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(not level_done):
		position.x = get_global_mouse_position().x


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("SpawnedButtons"):
		area.pressed.emit()
