extends Area2D

signal dropped
signal pressed #redundant, needed for button-like functionality

@export var is_food: bool = false
var is_over_robot: bool = false
var mouse_button_held: bool = false
var is_under_mouse: bool = false
var is_picked_up: bool = false

var bot_mouth_position: Vector2 = Vector2(1259, 744)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("default")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_picked_up:
		position = get_global_mouse_position()


func _on_area_entered(area: Area2D) -> void:
	if area is Eater_robot:
		is_over_robot = true
	elif area.is_in_group("Cursor"):
		is_under_mouse = true


func _on_area_exited(area: Area2D) -> void:
	if area is Eater_robot:
		is_over_robot = false
	elif area.is_in_group("Cursor"):
		is_under_mouse = false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.is_pressed() and is_under_mouse:
			pick_up()
		elif event.button_index == 1 and not event.is_pressed():
			drop()

func pick_up():
	is_picked_up = true
	
func drop():
	is_picked_up = false
	if is_over_robot:
		dropped.emit(is_food)
		var tween = create_tween()
		tween.tween_property(self, "scale", Vector2(0.1, 0.1), 0.5)
		var tween2 = create_tween()
		await tween2.tween_property(self, "position", bot_mouth_position, 0.5).set_trans(Tween.TRANS_QUART).finished
		queue_free()
