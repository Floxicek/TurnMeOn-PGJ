extends Node

const transition_scene = preload("res://autoload/transition/transition.tscn")


var _current_level_index := -1
var levels: Array = [
	"res://scenes/levels/level1.tscn",
	"res://scenes/levels/level_korean.tscn",
	"res://scenes/levels/Random_Buttons.tscn", # Starts cat
	"res://scenes/levels/Lights_out.tscn",
	"res://scenes/levels/inverted_mouse.tscn",
	"res://scenes/levels/level2.tscn",
	"res://scenes/levels/level_fireboy_and_watergirl.tscn",
	"res://scenes/levels/level_invert_wasd.tscn",
	"res://scenes/levels/level_falling.tscn",
	"res://scenes/levels/level_pong.tscn",
	"res://scenes/levels/level_periodic.tscn",
	"res://scenes/levels/level_fireboy_and_watergirl_again.tscn",
	"res://scenes/levels/air_hockey.tscn",
	"res://scenes/credits.tscn"
]


enum ANIMATIONS {
	NONE,
	CAT,
	FIREBOY,
	HOCKEY,
	EATING
}
var animation_names = {
	ANIMATIONS.CAT: "cat",
	ANIMATIONS.FIREBOY: "fireboy",
	ANIMATIONS.HOCKEY: "hockey",
	ANIMATIONS.EATING: "eating"
}


var _target_scene_path
var _transition

var _loading_status: int
var _progress: Array[float] = []

var _request_timer: SceneTreeTimer
@export var min_wait_time = 1
var _in_progress = false

signal transition_done

var transition_message = ""

func _ready() -> void:
	_transition = transition_scene.instantiate()
	add_child(_transition, true)
	_transition.clear_scene_done.connect(_clear_scene_done)
	_transition.show_scene_done.connect(_show_scene_done)
	await get_tree().create_timer(.5).timeout
	transition_done.emit()


func change_scene(target_scene_path, animation := ANIMATIONS.NONE) -> void:
	_in_progress = true
	_target_scene_path = target_scene_path
	_transition.clear_scene()
	if animation != ANIMATIONS.NONE:
		_transition.play_animation(animation_names[animation])


func _clear_scene_done() -> void:
	# Clear scene animation done
	ResourceLoader.load_threaded_request(_target_scene_path)
	_request_timer = get_tree().create_timer(min_wait_time)
	print("loading scene")

func _show_scene_done() -> void:
	# Show scene animation done
	_in_progress = false
	transition_done.emit()

	
func _process(_delta: float) -> void:
	if _target_scene_path:
		_loading_status = ResourceLoader.load_threaded_get_status(_target_scene_path, _progress)
		
		# Check the loading status:
		match _loading_status:
			ResourceLoader.THREAD_LOAD_IN_PROGRESS:
				#print("loading:", _progress[0] * 100)
				pass
			ResourceLoader.THREAD_LOAD_LOADED:
				# When done loading, change to the target scene:
				get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(_target_scene_path))
				await _request_timer.timeout
				_transition.show_scene()
				print("Scene changed to: ", _target_scene_path)
				_target_scene_path = ""
			ResourceLoader.THREAD_LOAD_FAILED:
				# Well some error happend:
				push_error("Error changing scenes")

func next_level(message: String = "", animation: ANIMATIONS = ANIMATIONS.NONE):
	if not _in_progress:
		#print(_in_progress, "in progress")
		transition_message = message
		_current_level_index = (_current_level_index + 1) % levels.size()
		print("Changing to level ", levels[_current_level_index])
		change_scene(levels[_current_level_index], animation)

func reload_level(message: String = ""):
	if _current_level_index == -1:
		push_error("RELOADING WILL NOT WORK WHEN TESTING LOCAL SCENES")
	transition_message = message
	print("Reloading the level ", levels[_current_level_index])
	change_scene(levels[_current_level_index])

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("restart"):
		reload_level()
	elif event.is_action_pressed("next_level"):
		next_level()
