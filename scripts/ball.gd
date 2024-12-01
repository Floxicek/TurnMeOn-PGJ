extends CharacterBody2D

var direction: Vector2
@export var speed: float = 8
@export var platform: Node2D

var rng = RandomNumberGenerator.new()

func _ready() -> void:
	await SceneManager.transition_done
	direction = Vector2(rng.randf_range(-1, 1), -1)
	
func _process(delta: float) -> void:
	velocity = direction.normalized()*speed*100
	move_and_slide()

func on_brick_wall_bounced(vertical: bool):
	if vertical:
		direction.y *= -1
	else:
		direction.x *= -1


func _on_platform_bounce(vertical: bool) -> void:
	if vertical:
		direction.y *= -1
		direction.x += get_platform_bounce_dir()
	else:
		direction.x *= -1

func get_platform_bounce_dir() -> int:
	var output =0
	var difference = platform.position.x - position.x

	output -= difference/100
	
	return output
