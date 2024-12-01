extends Area2D

class_name Ball

@export var velocity: Vector2 = Vector2.RIGHT*50
@export var rotation_speed: float = 50

var recently_bounced_x: bool = false
var recently_bounced_y: bool = false

var rotating_right:= false

func _ready() -> void:
	if not $VisibleOnScreenNotifier2D.is_on_screen():
		Globals.error_counter_air_hocker += 1
		if Globals.error_counter_air_hocker > 1:
			SceneManager.next_level()
		else:
			SceneManager.reload_level()

func _physics_process(delta: float) -> void:
	rotation += pow(-1, int(rotating_right)) * rotation_speed*delta
	position += delta*velocity*100


func bounce_x():
	if(recently_bounced_x): return
	rotating_right = not rotating_right
	velocity = Vector2(-velocity.x,velocity.y)
	recently_bounced_x = true
	$XBounceDeltaTimer.start()
func bounce_y():
	if(recently_bounced_y): return
	rotating_right = not rotating_right
	velocity = Vector2(velocity.x,-velocity.y)
	recently_bounced_y = true
	$YBounceDeltaTimer.start()
	

func hit_with_paddle(paddle: Hockey_paddle):
	rotating_right = not rotating_right
	var velocity_length = velocity.length()
	var new_velocity = velocity + paddle.velocity
	velocity = paddle.velocity
	#velocity = new_velocity.normalized()*velocity_length
	return

func _on_x_bounce_delta_timer_timeout() -> void:
	recently_bounced_x = false

func _on_y_bounce_delta_timer_timeout() -> void:
	recently_bounced_y = false


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	if not get_parent().finished:
		SceneManager.reload_level()
