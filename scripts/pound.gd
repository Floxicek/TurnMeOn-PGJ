extends Area2D

signal player_entered
@export var water = false
@export_color_no_alpha var lava_color
@export_color_no_alpha var water_color


func _ready() -> void:
	modulate = water_color if water else lava_color

func _on_body_entered(body: Node2D) -> void:
	if (water and body.is_in_group("Fireboy")) or (not water and body.is_in_group("Watergirl")):
		body.die()
