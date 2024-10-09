extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var is_idle := false
var is_walking := false
var is_jumping := false
var is_falling := false

func _physics_process(delta: float) -> void:
	print("is_idle: ", is_idle)
	print("is_walking: ", is_walking)
	print("is_jumping: ", is_jumping)
	print("is_falling: ", is_falling)
	
	if not is_on_floor():
		velocity += get_gravity() * delta
		is_idle = false
		is_walking = false
		
		if velocity.y < 0:
			print("Pulando")
			is_jumping = true
			is_falling = false
		else:
			print("Caindo")
			is_jumping = false
			is_falling = true

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("left", "right")
	
	if is_on_floor():
		if direction:
			animation_player.play("walking")
			velocity.x = direction * SPEED
			is_idle = false
			is_walking = true
			is_jumping = false
			is_falling = false
		else:
			animation_player.play("idle")
			velocity.x = move_toward(velocity.x, 0, SPEED)
			is_idle = true
			is_walking = false
			is_jumping = false
			is_falling = false

	move_and_slide()
	set_state()

func set_state() -> void:
	if is_idle:
		animation_player.play("idle")
	elif is_walking:
		animation_player.play("walking")
	elif is_jumping:
		animation_player.play("jumping")
	elif is_falling:
		animation_player.play("falling")
