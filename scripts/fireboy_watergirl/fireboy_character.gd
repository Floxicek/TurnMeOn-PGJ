extends CharacterBody2D


@export var fireboy := true
const SPEED = 300.0
@export var jump_velocity = -1000.0

func _ready() -> void:
	if fireboy:
		add_to_group("Fireboy")
	else:
		add_to_group("Watergirl")
	set_physics_process(false)
	await SceneManager.transition_done
	await get_tree().create_timer(1).timeout
	set_physics_process(true)
	

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	var jumping = (Input.is_action_just_pressed("UP") and fireboy) or (Input.is_action_just_pressed("arrow_up") and not fireboy)
	if (jumping) and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	var direction := Input.get_axis("LEFT", "RIGHT") if fireboy else Input.get_axis("arrow_left", "arrow_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
