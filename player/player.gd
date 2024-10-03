extends CharacterBody2D

const SPEED = 100.0
const JUMP_VELOCITY = -400.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var direction

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	direction = Input.get_axis("left", "right")
	
	if direction:
		if Input.is_action_pressed("run"):
			velocity.x = direction * (SPEED * 2)
		elif Input.is_action_pressed("roll"):
			velocity.x = direction * (SPEED * 4)
		else:
			velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	set_state()
	move_and_slide()

func set_face_direction():
	if direction < 0:
		sprite.flip_h = true
	elif direction > 0:
		sprite.flip_h = false

func set_state():
	set_face_direction()
	
	var state
	
	if is_on_floor():
		if Input.is_action_pressed("roll"):
			state = "rolling"
		elif velocity.x == 0:
			state = "idle"
		else:
			state = "walking"
	elif !is_on_floor():
		if velocity.y < 0:
			state = "jumping"
		else:
			state = "falling"

	sprite.play(state)
