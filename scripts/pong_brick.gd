extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("Brick")
	$AnimatedSprite2D.play("default")

func die():
	var tween = create_tween()
	await tween.tween_property(self, "modulate:a", 0, 0.2).finished
	queue_free()
