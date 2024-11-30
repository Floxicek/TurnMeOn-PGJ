extends Node2D

class_name Cursor_object

@export_category("Keyboard movement")
@export var is_keyboard_mode: bool = false
var velocity: Vector2 = Vector2.ZERO
@export var keyboard_max_speed: float = 10
@export var keyboard_acceleration: float = 4
@export var keyboard_decceleration: float = 10
@export_category("Cursor specific")
@export var hide_os_cursor := true


var buttons = []

func _ready() -> void:
	if hide_os_cursor: 
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN) 
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	if is_keyboard_mode:
		position = Vector2(206, 1214)
	
	$AnimatedSprite2D.play()
	#if(is_keyboard_mode):
		#position = Vector2(1280, 720)
	await SceneManager.transition_done

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

func _input(event: InputEvent) -> void:
	if event.is_action("START_KEYBOARD_CONTROL"):
		is_keyboard_mode = not is_keyboard_mode
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
