extends Area2D

enum LiquidType {LAVA, WATER, ACID}
@export var type: LiquidType = LiquidType.WATER
@export_color_no_alpha var lava_color = Color("c24545")
@export_color_no_alpha var water_color = Color("4771cc")
@export_color_no_alpha var acid_color = Color("5f841d")


func _ready() -> void:
	if type == LiquidType.LAVA:
		$Ground1.modulate = lava_color
	elif type == LiquidType.WATER:
		$Ground1.modulate = water_color
	elif type == LiquidType.ACID:
		$Ground1.modulate = acid_color

func _on_body_entered(body: Node2D) -> void:
	if (type == LiquidType.WATER and body.is_in_group("Fireboy")) or (type == LiquidType.LAVA and body.is_in_group("Watergirl")) or (type == LiquidType.ACID and (body.is_in_group("Fireboy") or body.is_in_group("Watergirl"))):
		SceneManager.reload_level("You died")
