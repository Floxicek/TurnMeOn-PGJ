extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$PlayButton.get_node("CollisionShape2D").disabled = true
	$PlayButton.hide()
	
	$PoofAnimation.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_poof_animation_animation_finished() -> void:
	var tween = create_tween()
	tween.tween_property($PoofAnimation, "modulate:a", 0, 1)


func _on_eater_robot_full() -> void:
	var tween = create_tween()
	await tween.tween_property($EaterRobot, "scale", Vector2(1, 1), 1.5).finished
	$EaterRobot.queue_free()
	$PoofAnimation.show()
	$PoofAnimation.play("default")
	$PlayButton.show()
	$PlayButton.modulate.a = 0
	var tween2 = create_tween()
	await tween2.tween_property($PlayButton, "modulate:a", 1, 1).finished
	$PlayButton.get_node("CollisionShape2D").disabled = false


func _on_play_button_pressed() -> void:
	SceneManager.next_level("", SceneManager.ANIMATIONS.HOCKEY)
