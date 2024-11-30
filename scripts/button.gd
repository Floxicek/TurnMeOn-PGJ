extends Node2D

signal hover_start
signal hover_stopped
signal pressed


func _ready():
	$AnimatedSprite2D.play()


func _on_area_entered(area):
	if area is Cursor_object:
		hover_start.emit(area)
		var tween = get_tree().create_tween()
		tween.tween_property(self, "scale", Vector2(1.2, 1.2), .05)
		tween.set_trans(Tween.TRANS_CUBIC)

func _on_area_exited(area) -> void:
	if area is Cursor_object:
		hover_stopped.emit(area)
		var tween = get_tree().create_tween()
		tween.tween_property(self, "scale", Vector2(1, 1), .05)
		tween.set_trans(Tween.TRANS_CUBIC)
