extends CharacterBody2D
class_name BaseEnemy

@export var SPEED = 2800.0

@onready var animation = $SpriteAnimation

var sprite
var ray_cast
var floor_detector: RayCast2D
var player_detector: RayCast2D
var direction: int = -1
var can_spawn = false
var spawn_instance: PackedScene = null
var spawn_instance_position
var damage_sfx
var boss_lives: int

func apply_gravity(delta) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

func move(delta) -> void:
	velocity.x = direction * SPEED * delta
	move_and_slide()

func flip_sprite(force: bool = false) -> void:
	if ray_cast.is_colliding() or force:
		direction *= -1
		ray_cast.scale.x *= -1
		if floor_detector:
			floor_detector.scale.x *= -1
		if player_detector:
			player_detector.scale.x *= -1
	
	if floor_detector:
		if not floor_detector.is_colliding():
			direction *= -1
			ray_cast.scale.x *= -1
			floor_detector.scale.x *= -1
			if player_detector:
				player_detector.scale.x *= -1
			
	if direction == 1:
		sprite.flip_h = true
	else:
		sprite.flip_h = false

func kill_flying():
	kill_and_score()

func kill_walking(anim_name: StringName):
	if self.name == "TankComrade":
		boss_lives -= 1
		if boss_lives == 0:
			kill_and_score()
	else:
		kill_and_score()

func kill_and_score():
	Globals.score += 100
	
	if can_spawn:
		spawn_new_enemy()
		if get_class() == "CharacterBody2D":
			queue_free()
		else:
			get_parent().queue_free()
	else:
		queue_free()

func spawn_new_enemy():
	var instance_scene = spawn_instance.instantiate()
	get_tree().root.add_child(instance_scene)
	instance_scene.global_position = spawn_instance_position.global_position
	# TODO: Verify spawn direction
