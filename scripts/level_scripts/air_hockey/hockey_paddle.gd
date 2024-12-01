extends Node2D

var velocity: Vector2 = Vector2.ZERO
@export var max_speed: float = 10
@export var agility: float = 4 #0-10
@export var slow_distance: float = 150
@export_category("Cursor specific")
@export var hide_os_cursor := true

var buttons = []

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN) 
		
	position = Vector2(206, 1214)
	
	$AnimatedSprite2D.play()
	#if(is_keyboard_mode):
		#position = Vector2(1280, 720)
	await SceneManager.transition_done

func _physics_process(delta: float) -> void:
	
	steering_beh_arrive()
	position += 100*delta*velocity


func steering_beh_arrive():
	var target: Vector2 = get_global_mouse_position()
	var to_target:Vector2 = target - position
	var distance: float = to_target.length()
	#var desired_velocity = distance/slow_distance * to_target.normalized()
	var desired_velocity = to_target.normalized() * max(max_speed, distance)
	desired_velocity *= distance/slow_distance
	desired_velocity = min(desired_velocity.length(), max_speed) * desired_velocity.normalized()
	var p:float = agility/10
	velocity = (((1-p)*velocity) + p*desired_velocity)/2
	
	
