extends Node2D

@export var horizontal: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var sprite = get_node_or_null("AnimatedSprite2D")
	if sprite != null:
		sprite.play("default")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_left_area_entered(area: Area2D) -> void:
	if (area is Ball):
		area.bounce_x() if horizontal else area.bounce_y()
	if area is Hockey_paddle:
		area.wall_collision(horizontal, position)

func _on_right_area_entered(area: Area2D) -> void:
	if (area is Ball):
		area.bounce_x() if horizontal else area.bounce_y()
	if area is Hockey_paddle:
		area.wall_collision(horizontal, position)

func _on_down_area_entered(area: Area2D) -> void:
	if (area is Ball):
		area.bounce_y() if horizontal else area.bounce_x()
	if area is Hockey_paddle:
		area.wall_collision(not horizontal, position)

func _on_up_area_entered(area: Area2D) -> void:
	if (area is Ball):
		area.bounce_y() if horizontal else area.bounce_x()
	if area is Hockey_paddle:
		area.wall_collision(not horizontal, position)
