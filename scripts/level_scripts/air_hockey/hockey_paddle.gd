extends Area2D

class_name Hockey_paddle

var velocity: Vector2 = Vector2.ZERO
@export var max_speed: float = 10
@export var agility: float = 4 #0-10
@export var slow_distance: float = 150
@export_category("Cursor specific")
@export var hide_os_cursor:= true
@export var bounce_dur: float = 0.12
@export var bounce_slow: float = 0.2

var buttons = []

var recently_bounced: bool = false

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN) 
	$BounceTimer.wait_time = bounce_dur
	$AnimatedSprite2D.play()
	#if(is_keyboard_mode):
		#position = Vector2(1280, 720)
	await SceneManager.transition_done

func _physics_process(delta: float) -> void:
	
	if(not recently_bounced):
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
	
func wall_collision(horizontal: bool, wall_pos:Vector2):
	if(recently_bounced): return
	#if horizontal:
		#if position.x > wall_pos.x:
			#position.x += 100
		#else:
			#position.x -= 100
		#velocity = Vector2(velocity.x, -velocity.y)
	#else:
		#if position.y > wall_pos.y:
			#position.y += 100
		#else:
			#position.y -= 100
		#velocity = Vector2(-velocity.x, velocity.y)
	
	var vel_len_slowed = velocity.length()*bounce_slow
	velocity = -velocity.normalized() * max(vel_len_slowed, 8)
	recently_bounced = true
	$BounceTimer.start()
	


func _on_area_entered(area: Area2D) -> void:
	if area is Ball:
		area.hit_with_paddle(self)
	pass # Replace with function body.


func _on_bounce_timer_timeout() -> void:
	recently_bounced = false
	pass # Replace with function body.
