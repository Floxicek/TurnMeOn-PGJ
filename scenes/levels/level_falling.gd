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

var spawn_timer = 0
@export var spawn_delay: float = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button_prefabs = [escape_button, settings_button, play_button, mute_button, language_button]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	spawn_timer += delta
	if spawn_timer >= spawn_delay:
		spawn_timer = 0
		spawn_button()
	
	for butt in get_children():
		if butt.is_in_group("SpawnedButtons"):
			butt.global_position.y += delta*velocity

		#b.position.y += delta*velocity

func spawn_button():
	var index = rng.randi_range(0, len(button_prefabs)-1)
	var tmp_button = button_prefabs[index].instantiate()
	add_child(tmp_button)
	tmp_button.set_global_position(Vector2(1280, 720))
	tmp_button.global_rotation_degrees = 90
	tmp_button.add_to_group("SpawnedButtons")
