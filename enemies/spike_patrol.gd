extends CharacterBody2D

const SPEED = 700.0

@onready var sprite: Sprite2D = $Sprite
@onready var animation: AnimationPlayer = $Animation
@onready var ray_cast: RayCast2D = $RayCast

var direction: int = -1

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if ray_cast.is_colliding():
		direction *= -1
		ray_cast.scale.x *= -1
	
	if direction == 1:
		sprite.flip_h = true
	else:
		sprite.flip_h = false

	velocity.x = direction * SPEED * delta

	move_and_slide()

func _on_animation_animation_finished(anim_name: StringName) -> void:
	if anim_name == "hurting":
		Globals.score += 100
		queue_free()
