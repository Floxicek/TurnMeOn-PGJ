extends Node2D

signal bounce

var game_over: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Vertical.body_entered.connect(_on_vertical_area_entered)
	$Vertical.body_exited.connect(_on_vertical_area_exited)
	
	await SceneManager.transition_done


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x = get_global_mouse_position().x

func _on_vertical_area_entered(body: CharacterBody2D):
	if not game_over and body.is_in_group("ball"):
		bounce.emit(true)
	
func _on_vertical_area_exited(body: CharacterBody2D):
	pass
