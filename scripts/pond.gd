extends Area2D

enum LiquidType {LAVA, WATER, ACID}
@export var type: LiquidType = LiquidType.WATER
@export_color_no_alpha var lava_color
@export_color_no_alpha var water_color
@export_color_no_alpha var acid_color


func _ready() -> void:
	if type == LiquidType.LAVA:
		$AnimatedSprite2D.play("lava")
		$AnimatedSprite2D.modulate = lava_color
	elif type == LiquidType.WATER:
		$AnimatedSprite2D.play("water")
		$AnimatedSprite2D.modulate = water_color
	elif type == LiquidType.ACID:
		$AnimatedSprite2D.play("acid")
		$AnimatedSprite2D.modulate = acid_color

func _on_body_entered(body: Node2D) -> void:
	if (type == LiquidType.WATER and body.is_in_group("Fireboy")) or (type == LiquidType.LAVA and body.is_in_group("Watergirl")) or (type == LiquidType.ACID and (body.is_in_group("Fireboy") or body.is_in_group("Watergirl"))):
		SceneManager.reload_level("You died")
