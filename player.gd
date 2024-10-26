extends CharacterBody2D

const SPEED = 250.0
const JUMP_VELOCITY = -400.0
const VOID_THRESHOLD_Y = 400.0  # Adjust this value to define where the void starts

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var spawn_point = Vector2(355, 100)  # Replace with your actual spawn position

func _ready():
	# Initialize character position at spawn point
	position = spawn_point

func _physics_process(delta):
	# Respawn if character falls into the void
	if position.y > VOID_THRESHOLD_Y:
		respawn()

	# Apply gravity if not on the floor
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump with 'jump' action
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$JumpSfx.play()

	# Horizontal movement with 'move_left' and 'move_right'
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
		$AnimatedSprite2D.play("run")
		$AnimatedSprite2D.flip_h = direction == -1
	else:
		$AnimatedSprite2D.play("idle")
		velocity.x = move_toward(velocity.x, 0, SPEED / 2)

	# Update animations for jumping
	if not is_on_floor():
		$AnimatedSprite2D.play("jump")

	# Apply movement
	move_and_slide()

func respawn():
	# Reset position to spawn point and stop any movement
	position = spawn_point
	velocity = Vector2.ZERO
