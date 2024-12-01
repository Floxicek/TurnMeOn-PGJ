extends Node2D

#@onready var brick_script = preload("res://scripts/pong_brick.gd")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#for child in $bricks.get_children():
		#child.set_script(brick_script)
	await SceneManager.transition_done
	
	$PlayButton.get_node("AnimatedSprite2D").play("default")
	$Platform.get_node("AnimatedSprite2D").play("default")
	for child in $bricks.get_children():
		child.bounce_brick.connect($Ball.on_brick_wall_bounced)




func _on_death_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("ball"):
		$Platform.game_over = true
		SceneManager.reload_level()


func _on_walls_body_entered(body: Node2D) -> void:
	if body.is_in_group("ball"):
		$Ball.direction.x *= -1


func _on_ceiling_body_entered(body: Node2D) -> void:
	if body.is_in_group("ball"):
		$Ball.direction.y *= -1


func _on_play_button_body_entered(body: Node2D) -> void:
	if body.is_in_group("ball"):
		$Ball.direction = Vector2(0, 0)
		SceneManager.next_level()
