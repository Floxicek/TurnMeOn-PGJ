extends Node2D

enum SFX_Type {CLICK = 0, WRONG_CLICK = 1 }

@export var sound_effects: Array[Array]
var rng = RandomNumberGenerator.new()

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

func play_sound_effect(type: SFX_Type):
	var index = rng.randi_range(0, len(sound_effects[type]) - 1)
	$SoundEffectPlayer.stream = sound_effects[index]
	$SoundEffectPlayer.play()
	
