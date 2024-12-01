extends Control

signal clear_scene_done
signal show_scene_done

@export var clear_sounds: Array[AudioStream] = []

@onready var audio = $AudioStreamPlayer2D

@onready var rng = RandomNumberGenerator.new()
@onready var text_displayer = $TextDisplayer
@onready var animation_player = $Animations


func _ready() -> void:
	$AnimatedSprite2D.hide()

func play_animation(animation_name):
	
	animation_player.play(animation_name)

var _started = false
func _on_animated_sprite_2d_animation_finished() -> void:
	mouse_filter = MouseFilter.MOUSE_FILTER_IGNORE
	audio.stop()
	#print("Finished")
	#$AnimatedSprite2D.hide()
	if _started:
		clear_scene_done.emit()
		if SceneManager.transition_message:
			print(SceneManager.transition_message)
			text_displayer.write(SceneManager.transition_message)
		else:
			text_displayer.finished.emit()
	else:
		show_scene_done.emit()

func clear_scene():
	#print("Transition started")
	_started = true
	$AnimatedSprite2D.show()
	mouse_filter = MouseFilter.MOUSE_FILTER_STOP
	$AnimatedSprite2D.play("transition")
	start_random_sound()

func show_scene():
	#print("Transition stoped")
	if not text_displayer.is_done:
		await text_displayer.finished
	
	if animation_player.is_playing():
		await animation_player.finished
	
	_started = false
	$AnimatedSprite2D.show()
	mouse_filter = MouseFilter.MOUSE_FILTER_STOP
	$AnimatedSprite2D.play_backwards("transition")
	start_random_sound()


func start_random_sound():
	var index = rng.randi_range(0, clear_sounds.size() - 1)
	audio.stream = clear_sounds[index]
	audio.play()
