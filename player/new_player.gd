extends CharacterBody2D

enum STATE {
	IDLE,
	WALKING,
	RUNNING,
	JUMPING,
	FALLING,
	KICKING,
	ROLLING,
}

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		animation_player.play("jumping")
	else:
		animation_player.play("idle")

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		jump()

	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func set_state() -> void:
	pass

func walk() -> void:
	pass

func run() -> void:
	pass

func jump() -> void:
	velocity.y = JUMP_VELOCITY

func fall() -> void:
	pass

func kick() -> void:
	pass

func roll() -> void:
	pass
