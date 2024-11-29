extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play()
	connect("Area2D", _on_area_2d_area_entered)
	connect("Area2D", _on_area_2d_area_exited)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_area_entered(area):
	if area is Cursor_object:
		scale = Vector2(1.2, 1.2)


func _on_area_2d_area_exited(area):
	if area is Cursor_object:
		scale = Vector2(1, 1)
