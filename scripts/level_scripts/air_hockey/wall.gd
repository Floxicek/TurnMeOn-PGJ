extends Node2D

@export var horizontal: bool = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("default")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_left_area_entered(area: Area2D) -> void:
	if (area is Ball):
		area.bounce_x() if horizontal else area.bounce_y()

func _on_right_area_entered(area: Area2D) -> void:
	if (area is Ball):
		area.bounce_x() if horizontal else area.bounce_y()


func _on_down_area_entered(area: Area2D) -> void:
	if (area is Ball):
		area.bounce_y() if horizontal else area.bounce_x()


func _on_up_area_entered(area: Area2D) -> void:
	if (area is Ball):
		area.bounce_y() if horizontal else area.bounce_x()
