extends Area2D

signal hover_start
signal hover_stopped
signal pressed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area) -> void:
	$AnimatedSprite2D.show()
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
