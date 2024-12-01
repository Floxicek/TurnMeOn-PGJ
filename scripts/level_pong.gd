@tool
extends Node2D

@onready var brick_script = preload("res://scripts/pong_brick.gd")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in $bricks.get_children():
		child.set_script(brick_script)
		
	#$Platform.get_node("AnimatedSprite2D").play("default")
