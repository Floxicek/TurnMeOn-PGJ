extends Node

const transition_scene = preload("res://autoload/transition/transition.tscn")

var _target_scene_path
var _transition

var _loading_status: int
var _progress: Array[float] = []

var _request_timer: SceneTreeTimer
@export var min_wait_time = 1
var _in_progress = false

signal transition_done


func _ready() -> void:
	_transition = transition_scene.instantiate()
	add_child(_transition, true)
	_transition.clear_scene_done.connect(_clear_scene_done)
	_transition.show_scene_done.connect(_show_scene_done)
	await get_tree().create_timer(.5).timeout
	transition_done.emit()


func change_scene(target_scene_path) -> void:
	_target_scene_path = target_scene_path
	_transition.clear_scene()


func _clear_scene_done() -> void:
	# Clear scene animation done
	ResourceLoader.load_threaded_request(_target_scene_path)
	_request_timer = get_tree().create_timer(min_wait_time)
	_in_progress = true
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
				print("loading:", _progress[0] * 100)
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


var _current_level_index := 0
@export var levels : Array = ["res://scenes/levels/level1.tscn", "res://scenes/levels/level_falling.tscn", "res://scenes/levels/level_fireboy_and_watergirl.tscn", "res://scenes/levels/Lights_out.tscn"]

func next_level(message: String = ""):
	if not _in_progress:
		#print(_in_progress, "in progress")
		_current_level_index = (_current_level_index + 1) % levels.size()
		print("Changing to level ", levels[_current_level_index])
		change_scene(levels[_current_level_index])
# TODO display message


func reload_level(message:String = ""):
	print("Reloading the level ", levels[_current_level_index])
	change_scene(levels[_current_level_index])
