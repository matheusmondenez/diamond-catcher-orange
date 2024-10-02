extends CharacterBody2D

const SPEED = 100.0
const JUMP_VELOCITY = -400.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		sprite.play("jumping")

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("left", "right")
	
	if direction:
		if Input.is_action_pressed("run"):
			velocity.x = direction * (SPEED * 2)
			sprite.play("walking", 2)
		else:
			velocity.x = direction * SPEED
			sprite.play("walking")

		set_face_direction(direction)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		sprite.play("idle")
		
	#if Input.is_action_just_pressed("run"):
		#print("is_action_just_pressed: RUN!")
	#if Input.is_action_pressed("run"):
		#print("is_action_pressed: RUN!")

	move_and_slide()

func set_face_direction(direction):
	if direction == -1:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
