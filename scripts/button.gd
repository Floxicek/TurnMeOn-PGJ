extends Node2D

signal hover_start
signal hover_stopped
signal pressed

@export var react_on_cursor = true


func _ready():
	$AnimatedSprite2D.play()

var default_scale = 1.0
@export_range(.8,1.4) var hover_scale = 1.1

func set_default_scale(_scale):
	default_scale = _scale

func _on_area_entered(area):
	if area.is_in_group("Cursor"):
		if react_on_cursor:
			hover_start.emit(area)
			var tween = get_tree().create_tween()
			tween.tween_property(self, "scale", Vector2(hover_scale * default_scale, hover_scale * default_scale), .05)
			tween.set_trans(Tween.TRANS_CUBIC)
		else:
			_on_area_exited(area)
	

func _on_area_exited(area) -> void:
	if area.is_in_group("Cursor"):
		hover_stopped.emit(area)
		var tween = get_tree().create_tween()
		tween.tween_property(self, "scale", Vector2(default_scale, default_scale), .05)
		tween.set_trans(Tween.TRANS_CUBIC)
