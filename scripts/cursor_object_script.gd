extends Node2D

class_name Cursor_object

@export var is_keyboard_mode: bool = false
var velocity: Vector2 = Vector2.ZERO
@export var keyboard_max_speed: float = 10
@export var keyboard_acceleration: float = 4
@export var keyboard_decceleration: float = 10


var buttons = []

func _ready() -> void:
	$AnimatedSprite2D.play()
	if(is_keyboard_mode):
		position = Vector2(1280, 720)

func _physics_process(delta: float) -> void:
	if(not is_keyboard_mode):
		velocity = Vector2.ZERO
		position = get_global_mouse_position()
	else:
		if Input.is_action_pressed("UP"):
			velocity += keyboard_acceleration*Vector2.UP
		if Input.is_action_pressed("LEFT"):
			velocity += keyboard_acceleration*Vector2.LEFT
		if Input.is_action_pressed("DOWN"):
			velocity += keyboard_acceleration*Vector2.DOWN
		if Input.is_action_pressed("RIGHT"):
			velocity += keyboard_acceleration*Vector2.RIGHT
		
		velocity -= velocity*(keyboard_decceleration)*delta

		if velocity.length() > keyboard_max_speed:
			velocity = velocity.normalized()*keyboard_max_speed
		
		position += velocity

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("START_KEYBOARD_CONTROL"):
		stop_controlling_mouse_with_keyboard() if is_keyboard_mode else start_controlling_mouse_with_keyboard()

func start_controlling_mouse_with_keyboard():
	is_keyboard_mode = true

func stop_controlling_mouse_with_keyboard():
	is_keyboard_mode = false


func _input(event: InputEvent) -> void:
	if event.is_action("START_KEYBOARD_CONTROL"):
		stop_controlling_mouse_with_keyboard() if is_keyboard_mode else start_controlling_mouse_with_keyboard()
	elif event.is_action_pressed("click"):
		for b in buttons:
				b.pressed.emit()
				#current_button.push(test_func)

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Button"):
		buttons.append(area)


func _on_area_exited(area: Area2D) -> void:
	if area in buttons:
		buttons.erase(area)
