extends Node2D

class_name Mute_Button

var is_on: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func push(callable: Callable):
	$AnimatedSprite2D.play("on_state") if is_on else $AnimatedSprite2D.play("off_state")


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Button"):
		scale = Vector2(1.2, 1.2)


func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("Button"):
		scale = Vector2(1, 1)
