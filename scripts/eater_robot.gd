extends Area2D

class_name Eater_robot

signal full

var hunger: int = 4

var eating_loops: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("Idle")
	scale = Vector2(0.4, 0.4)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Pickupable"):
		$AnimatedSprite2D.play("Anticipating_food")


func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("Pickupable"):
		$AnimatedSprite2D.play("Idle")


func _on_pickupable_dropped(is_food: bool) -> void:
	if is_food:
		$AnimatedSprite2D.play("Eat")
		hunger -= 1
		if hunger > 0:
			grow()
		else:
			switch_to_play()
	else:
		SceneManager.reload_level("bleh!")

func grow():
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(scale.x + 0.15, scale.y + 0.15), 0.5).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

func switch_to_play():
	full.emit()
