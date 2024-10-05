extends CharacterBody2D

const WALK_SPEED = 100.0/2
const RUN_SPEED = 200.0/2
const ROLL_SPEED = 400.0/2
const JUMP_VELOCITY = -400.0
const JUMP_MAX = 2

@onready var animatied_sprite: AnimatedSprite2D = $Animation

var direction: int = 0
var can_kick: bool = false
var is_kicking: bool = false
var can_roll: bool = true
var is_preparing_to_roll: bool = false
var is_rolling: bool = false
var is_stoping_to_roll: bool = false
var can_double_jump: bool = true
var is_double_jumping: bool = false
var jump_count: int = 0

func _physics_process(delta: float) -> void:
	direction = Input.get_axis("left", "right")
	
	fall(delta)

	if check_action("jump"):
		jump()
		
	if check_action("kick"):
		kick()
	
	if direction:
		if Input.is_action_pressed("run"):
			run()
		else:
			walk()
	else:
		idle()
		
		if check_action("roll"):
			roll()

	set_face_direction()
	set_state()
	move_and_slide()

func check_action(action) -> bool:
	if Input.is_action_just_pressed(action):
		return true
	else:
		return false

func idle() -> void:
	velocity.x = move_toward(velocity.x, 0, WALK_SPEED)

func walk() -> void:
	velocity.x = direction * WALK_SPEED

func run() -> void:
	velocity.x = direction * RUN_SPEED

func jump() -> void:
	if is_on_floor():
		jump_count = 0
		velocity.y = JUMP_VELOCITY
		jump_count += 1
	elif can_double_jump and jump_count < JUMP_MAX:
		velocity.y = JUMP_VELOCITY
		jump_count += 1

func fall(delta) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

func kick() -> void:
	is_kicking = true

func roll() -> void:
	if is_on_floor() and not is_rolling:
		is_preparing_to_roll = true
		await get_tree().create_timer(.45).timeout
		velocity = Vector2(1, 0).normalized() * 1000

func set_face_direction() -> void:
	if direction < 0:
		animatied_sprite.flip_h = true
	elif direction > 0:
		animatied_sprite.flip_h = false

func set_state() -> void:
	var state
	
	if is_on_floor():
		if is_preparing_to_roll:
			animatied_sprite.animation = "rolling_start"
		elif is_rolling:
			animatied_sprite.play("rolling")
		elif is_stoping_to_roll:
			animatied_sprite.play("rolling_stop")
		elif is_kicking:
			animatied_sprite.play("kicking")
		elif velocity.x == 0:
			animatied_sprite.play("idle")
		else:
			if velocity.x < WALK_SPEED * -1 or velocity.x > WALK_SPEED:
				animatied_sprite.play("running")
			else:
				animatied_sprite.play("walking")
	elif !is_on_floor():
		if velocity.y < 0:
			animatied_sprite.play("jumping")
		else:
			animatied_sprite.play("falling")

func _on_animated_sprite_2d_animation_finished() -> void:
	if animatied_sprite.animation == "rolling_start":
		is_preparing_to_roll = false
		is_rolling = true
	elif animatied_sprite.animation == "rolling":
		is_rolling = false
		is_stoping_to_roll = true
		await get_tree().create_timer(1).timeout
		is_stoping_to_roll = false
	elif animatied_sprite.animation == "kicking":
		is_kicking = false
