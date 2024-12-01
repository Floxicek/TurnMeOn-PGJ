extends Node2D

signal hover_start
signal hover_stopped
signal pressed

var is_on: bool = true
var default_scale = 1.0
@export_range(.8,1.4) var hover_scale = 1.2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioPlayer.soundtrack_player_state_updated.connect(update_icon)

	$AnimatedSprite2D.play()
	if AudioPlayer.soundtrack_player.stream_paused:
		_on_pressed()

func set_default_scale(_scale):
	default_scale = _scale

func update_icon(state):
	print(state)
	print("MUTEE")
	if state == is_on:
		_on_pressed()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Cursor"):
		hover_start.emit(area)
		var tween = get_tree().create_tween()
		tween.tween_property(self, "scale", Vector2(hover_scale * default_scale, hover_scale * default_scale), .05)
		tween.set_trans(Tween.TRANS_CUBIC)


func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("Cursor"):
		hover_stopped.emit(area)
		var tween = get_tree().create_tween()
		tween.tween_property(self, "scale", Vector2(default_scale, default_scale), .05)
		tween.set_trans(Tween.TRANS_CUBIC)


func _on_pressed() -> void:
	if is_on:
		$AnimatedSprite2D.play("off_state")
		AudioPlayer.pause_soundratck()
	else:
		$AnimatedSprite2D.play("on_state")
		AudioPlayer.play_soundtrack()
	is_on = !is_on
