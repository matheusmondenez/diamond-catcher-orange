extends CharacterBody2D
class_name BaseEnemy

const SPEED = 700.0

@onready var animation = $SpriteAnimation

var sprite
var ray_cast
var direction: int = -1
var can_spawn = false
var spawn_instance: PackedScene = null
var spawn_instance_position

func apply_gravity(delta) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

func move(delta) -> void:
	velocity.x = direction * SPEED * delta
	move_and_slide()

func flip_sprite() -> void:
	if ray_cast.is_colliding():
		direction *= -1
		ray_cast.scale.x *= -1
	
	if direction == 1:
		sprite.flip_h = true
	else:
		sprite.flip_h = false

func kill_flying():
	kill_and_score()

func kill_walking(anim_name: StringName):
	kill_and_score()

func kill_and_score():
	Globals.score += 100
	
	if can_spawn:
		spawn_new_enemy()
		get_parent().queue_free()
	else:
		queue_free()

func spawn_new_enemy():
	var instance_scene = spawn_instance.instantiate()
	get_tree().root.add_child(instance_scene)
	instance_scene.global_position = spawn_instance_position.global_position
	instance_scene.scale = Vector2(2, 2)
