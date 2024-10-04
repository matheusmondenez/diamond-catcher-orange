extends CharacterBody2D

const WALK_SPEED = 100.0
const RUN_SPEED = 200.0
const ROLL_SPEED = 400.0
const JUMP_VELOCITY = -400.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var direction: int = 0
var can_kick: bool = false
var is_kicking: bool = false
var can_roll: bool = true
var is_preparing_to_roll: bool = false
var is_rolling: bool = false
var is_stoping_to_roll: bool = false
var can_double_jump: bool = false
var is_double_jumping: bool = false

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	direction = Input.get_axis("left", "right")
	
	if direction:
		if Input.is_action_pressed("run"):
			velocity.x = direction * (RUN_SPEED)
		else:
			velocity.x = direction * WALK_SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, WALK_SPEED)
		
		if check_action("roll"):
			roll()

	set_state()
	move_and_slide()

func set_face_direction() -> void:
	if direction < 0:
		sprite.flip_h = true
	elif direction > 0:
		sprite.flip_h = false

func set_state() -> void:
	set_face_direction()
	
	var state
	
	if is_on_floor():
		if is_preparing_to_roll:
			sprite.animation = "rolling_start"
		elif is_rolling:
			sprite.play("rolling")
		elif is_stoping_to_roll:
			sprite.play("rolling_stop")
		elif velocity.x == 0:
			sprite.play("idle")
		else:
			if velocity.x < WALK_SPEED * -1 or velocity.x > WALK_SPEED:
				sprite.play("running")
			else:
				sprite.play("walking")
	elif !is_on_floor():
		if velocity.y < 0:
			sprite.play("jumping")
		else:
			sprite.play("falling")

func check_action(action) -> bool:
	if Input.is_action_just_pressed(action):
		return true
	else:
		return false

func roll() -> void:
	if is_on_floor() and not is_rolling:
		is_preparing_to_roll = true
		await get_tree().create_timer(.4).timeout
		velocity = Vector2(1, 0).normalized() * 1000

func kick() -> void:
	pass

func jump() -> void:
	pass

func _on_animated_sprite_2d_animation_finished() -> void:
	if sprite.animation == "rolling_start":
		print("finished rolling_start")
		is_preparing_to_roll = false
		is_rolling = true
	elif sprite.animation == "rolling":
		is_rolling = false
		is_stoping_to_roll = true
		await get_tree().create_timer(1).timeout
		is_stoping_to_roll = false
