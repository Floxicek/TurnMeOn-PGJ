extends Node2D

var buttons = [Node2D]
var rng = RandomNumberGenerator.new()

@export var velocity: float = 500
@export var escape_button: PackedScene
@export var settings_button: PackedScene
@export var play_button: PackedScene
@export var mute_button: PackedScene
@export var language_button: PackedScene
var button_prefabs = []
var play_spawning: bool = false

@export_category("Spawning")
@export var spawn_delay: float = 1
@export var randomized_spawn_delay:= true
@export var min_spawn_delay: float = 0.2
@export var max_spawn_delay: float = 1.2


@export var play_delay: float = 8

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await SceneManager.transition_done
	button_prefabs = [escape_button, settings_button, mute_button, language_button]
	$PlayTimer.wait_time = play_delay
	$PlayTimer.start()
	$SpawnTimer.wait_time = spawn_delay
	$SpawnTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for butt in get_children():
		if butt.is_in_group("SpawnedButtons"):
			butt.global_position.y += delta*velocity

		#b.position.y += delta*velocity

func spawn_button():
	var index = rng.randi_range(0, len(button_prefabs)-1)
	var tmp_button = button_prefabs[index].instantiate()
	
	
	if play_spawning:
		if index == len(button_prefabs)-1:
			tmp_button.pressed.connect(push_play_button)
		else:
			tmp_button.pressed.connect(push_wrong_button)
	else:
		tmp_button.pressed.connect(push_wrong_button)
	
	var spawn_pos = Vector2(rng.randi_range(tmp_button.get_node("CollisionShape2D").shape.size.y/2, 2560 - tmp_button.get_node("CollisionShape2D").shape.size.y/2), -tmp_button.get_node("CollisionShape2D").shape.size.x/2)
	add_child(tmp_button)
	
	tmp_button.set_global_position(spawn_pos)
	tmp_button.global_rotation_degrees = 90
	tmp_button.hover_scale = 1
	tmp_button.add_to_group("SpawnedButtons")
	

func push_play_button():
	velocity = 0
	SceneManager.next_level()
	$Hand/CollisionShape2D.disabled = true
	$Hand.level_done = true
	
func push_wrong_button():
	SceneManager.reload_level("Wrong")
	velocity = 0
	$Hand/CollisionShape2D.disabled = true
	$Hand.level_done = true

func _on_play_timer_timeout() -> void:
	button_prefabs.append(play_button)
	play_spawning = true


func _on_spawn_timer_timeout() -> void:
	spawn_button()
	#Randomized timer
	 
	if(randomized_spawn_delay):
		$SpawnTimer.stop()
		$SpawnTimer.wait_time = rng.randf_range(min_spawn_delay, max_spawn_delay)
		$SpawnTimer.start()
	
	
