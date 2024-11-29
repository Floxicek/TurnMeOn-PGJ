extends Node

const transition_scene = preload("res://autoload/transition/transition.tscn")

var _target_scene_path
var _transition

var _loading_status: int
var _progress: Array[float] = []

func _ready() -> void:
	_transition = transition_scene.instantiate()
	add_child(_transition, true)
	_transition.clear_scene_done.connect(_clear_scene_done)
	_transition.show_scene_done.connect(_show_scene_done)


func change_scene(target_scene_path) -> void:
	_target_scene_path = target_scene_path
	_transition.clear_scene()


func _clear_scene_done() -> void:
	# Clear scene animation done
	ResourceLoader.load_threaded_request(_target_scene_path)
	print("loading scene")

func _show_scene_done() -> void:
	# Show scene animation done
	pass

	
func _process(_delta: float) -> void:
	if _target_scene_path:
		_loading_status = ResourceLoader.load_threaded_get_status(_target_scene_path, _progress)
		
		# Check the loading status:
		match _loading_status:
			ResourceLoader.THREAD_LOAD_IN_PROGRESS:
				print(_progress[0] * 100)
			ResourceLoader.THREAD_LOAD_LOADED:
				# When done loading, change to the target scene:
				get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(_target_scene_path))
				_transition.show_scene()
				print("Scene changed to: ", _target_scene_path)
				_target_scene_path = ""
			ResourceLoader.THREAD_LOAD_FAILED:
				# Well some error happend:
				push_error("Error changing scenes")
