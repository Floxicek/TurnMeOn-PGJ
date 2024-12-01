extends Node2D

signal bounce_brick

var resolved: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("Brick")
	$AnimatedSprite2D.play("default")
	$Horizontal.body_entered.connect(_on_horizontal_area_entered)
	$Horizontal.body_exited.connect(_on_horizontal_area_exited)
	
	$Vertical.body_entered.connect(_on_vertical_area_entered)
	$Vertical.body_exited.connect(_on_vertical_area_exited)

func die():
	var tween = create_tween()
	await tween.tween_property(self, "modulate:a", 0, 0.2).finished
	queue_free()

func _on_vertical_area_entered(body: CharacterBody2D):
	if not resolved and body.is_in_group("ball"):
		resolved = true
		bounce_brick.emit(true)
		die()
	
func _on_vertical_area_exited(body: CharacterBody2D):
	pass

func _on_horizontal_area_entered(body: CharacterBody2D):
	if not resolved and body.is_in_group("ball"):
		resolved = true
		bounce_brick.emit(false)
		die()
	
func _on_horizontal_area_exited(body: CharacterBody2D):
	pass
