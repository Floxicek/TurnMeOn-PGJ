extends Node2D

enum SFX_Type {CLICK = 0, WRONG_CLICK = 1}

@export var sound_effects := [[]]
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$SoundtrackPlayer.play()

func pause_soundratck():
	$SoundtrackPlayer.stream_paused = true
	
func play_soundtrack():
	$SoundtrackPlayer.stream_paused = false

func play_sound_effect(type: SFX_Type):
	if sound_effects.size() > 0:
		var index = rng.randi_range(0, len(sound_effects[type]) - 1)
		$SoundEffectPlayer.stream = sound_effects[index]
		$SoundEffectPlayer.play()
	else:
		push_error("No sound effects loaded")
