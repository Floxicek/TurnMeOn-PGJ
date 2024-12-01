extends Area2D

class_name Ball

@export var velocity: Vector2 = Vector2.RIGHT*50

var recently_bounced_x: bool = false
var recently_bounced_y: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	position += delta*velocity

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func bounce_x():
	if(recently_bounced_x): return
	velocity = Vector2(-velocity.x,velocity.y)
	recently_bounced_x = true
	$XBounceDeltaTimer.start()
func bounce_y():
	if(recently_bounced_y): return
	velocity = Vector2(velocity.x,-velocity.y)
	recently_bounced_y = true
	$YBounceDeltaTimer.start()
	


func _on_x_bounce_delta_timer_timeout() -> void:
	recently_bounced_x = false

func _on_y_bounce_delta_timer_timeout() -> void:
	recently_bounced_y = false
