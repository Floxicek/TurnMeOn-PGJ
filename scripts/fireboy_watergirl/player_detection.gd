extends Area2D

var watergirl_in = false
var fireboy_in = false
@onready var red_rect = $RedRect
@onready var blue_rect = $BlueRect
var fireboy_color = Color("ff3259")
var water_color = Color("4c94df")

func _ready() -> void:
	update_rect()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Fireboy"):
		print("Fireboy finished")
		body.finished = true
		fireboy_in = true
	elif body.is_in_group("Watergirl"):
		print("Watergirl finished")
		body.finished = true
		watergirl_in = true
	update_rect()
	if watergirl_in and fireboy_in:
		SceneManager.next_level()


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Fireboy"):
		fireboy_in = false
		body.finished = false
	elif body.is_in_group("Watergirl"):
		watergirl_in = false
		body.finished = false
	update_rect()


func update_rect():
	if fireboy_in:
		update_color(red_rect, fireboy_color)
	else:
		update_color(red_rect, Color.TRANSPARENT)
	
	if watergirl_in:
		update_color(blue_rect, water_color)
	else:
		update_color(blue_rect, Color.TRANSPARENT)

func update_color(target, color:Color):
	var tween = get_tree().create_tween()
	tween.tween_property(target, "modulate", color, 1)
