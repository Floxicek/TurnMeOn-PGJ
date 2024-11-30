extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_area_entered(area):
	if area is Cursor_object:
		var tween = get_tree().create_tween()
		tween.tween_property(self, "scale", Vector2(1.2, 1.2), .05)
		tween.set_trans(Tween.TRANS_CUBIC)

func _on_area_2d_area_exited(area):
	if area is Cursor_object:
		var tween = get_tree().create_tween()
		tween.tween_property(self, "scale", Vector2(1, 1), .05)
		tween.set_trans(Tween.TRANS_CUBIC)
