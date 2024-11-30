extends Node2D

signal pressed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Sprite2D.modulate = Color.TRANSPARENT

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func flash(color: Color):
	$Sprite2D.modulate = color
	$Sprite2D.modulate.a = 0
	var tween = create_tween()
	await tween.tween_property($Sprite2D, "modulate:a", 0.5, 0.2).set_trans(Tween.TRANS_CUBIC)
	await get_tree().create_timer(0.2).timeout
	var tween2 = create_tween()
	tween2.tween_property($Sprite2D, "modulate:a", 0, 0.2).set_trans(Tween.TRANS_CUBIC)
