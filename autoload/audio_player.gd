extends Node2D

enum SFX_Type {CLICK = 0, WRONG_CLICK = 1}

signal soundtrack_player_state_updated(updated_stated)

@export var click: Array[AudioStream] = []
@export var wrong_click: Array[AudioStream] = []
var rng = RandomNumberGenerator.new()

@onready var soundtrack_player = $SoundtrackPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rng.randomize()
	soundtrack_player.play()
	soundtrack_player_state_updated.emit(soundtrack_player.stream_paused)
	

func pause_soundratck():
	soundtrack_player.stream_paused = true
	soundtrack_player_state_updated.emit(soundtrack_player.stream_paused)
	
func play_soundtrack():
	soundtrack_player.stream_paused = false
	soundtrack_player_state_updated.emit(soundtrack_player.stream_paused)

func toggle_soundtrack():
	soundtrack_player.stream_paused = !soundtrack_player.stream_paused
	soundtrack_player_state_updated.emit(soundtrack_player.stream_paused)
	

func play_sound_effect(type: SFX_Type):
	var sound_effects = []
	if type == SFX_Type.CLICK:
		sound_effects = click
	elif type == SFX_Type.WRONG_CLICK:
		sound_effects = wrong_click
		
	if sound_effects:
		var index = rng.randi_range(0, len(sound_effects) - 1)
		$SoundEffectPlayer.stream = sound_effects[index]
		$SoundEffectPlayer.play(1)
	else:
		push_error("No sound effects added")
