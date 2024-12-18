extends CharacterBody2D

# TODO fix scene
@export_category("Movement")
@export var speed = 300.0
@export var coyote_time = 0.2
@export var jump_velocity = -1000.0
@export_category("Appearance")
@export var fireboy := true
@export var fireboy_color = Color(1, 0.19709, 0.350599, 1)
@export var watergirl_color = Color(0.299927, 0.579225, 0.875175, 1)
@export var inverted_gravity = false
var coyote_timer = 0.0
var finished = false

func _ready() -> void:
	if fireboy:
		add_to_group("Fireboy")
		get_node("AnimatedSprite2D").modulate = fireboy_color
	else:
		add_to_group("Watergirl")
		get_node("AnimatedSprite2D").modulate = watergirl_color
	set_physics_process(false)
	await SceneManager.transition_done
	await get_tree().create_timer(1).timeout
	set_physics_process(true)


func _physics_process(delta: float) -> void:
	if (is_on_floor() and not inverted_gravity) or (is_on_ceiling() and inverted_gravity):
		coyote_timer = coyote_time
	else:
		coyote_timer -= delta
	if not (is_on_floor() and not inverted_gravity) or (not (is_on_ceiling() and inverted_gravity)):
		if inverted_gravity:
			velocity -= get_gravity() * delta
		else:
			velocity += get_gravity() * delta

	var jumping = (Input.is_action_just_pressed("kb_up") and fireboy) or (Input.is_action_just_pressed("arrow_up") and not fireboy)
	if jumping and coyote_timer > 0:
		if inverted_gravity:
			velocity.y = -jump_velocity
		else:
			velocity.y = jump_velocity
			
		coyote_timer = 0
		
	var direction := 0.0
	if inverted_gravity:
		direction = Input.get_axis("kb_right", "kb_left") if fireboy else Input.get_axis("arrow_right", "arrow_left")
	else:
		direction = Input.get_axis("kb_left", "kb_right") if fireboy else Input.get_axis("arrow_left", "arrow_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	if not finished:
		$VisibleOnScreenNotifier2D/Timer.start()


func _on_visible_timeout() -> void:
	if not $VisibleOnScreenNotifier2D.is_on_screen():
		SceneManager.reload_level("Where are you going?")
