extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$SoundtrackPlayer.play()

func pause_soundratck():
	$SoundtrackPlayer.stream_paused = true
	
func play_soundtrack():
	$SoundtrackPlayer.stream_paused = false
