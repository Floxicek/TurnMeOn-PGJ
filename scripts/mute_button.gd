extends Node2D

var is_on: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_area_entered(area):
	if area is Cursor_object:
		scale = Vector2(1.2, 1.2)


func _on_area_2d_area_exited(area):
	if area is Cursor_object:
		scale = Vector2(1, 1)


func push(callable: Callable):
	$AnimatedSprite2D.play("on_state") if is_on else $AnimatedSprite2D.play("off_state")
