extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$SoundtrackPlayer.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func pause_soundratck():
	$SoundtrackPlayer.stream_paused = true
	
func play_soundtrack():
	$SoundtrackPlayer.stream_paused = false
