extends AnimatableBody2D

const SPEED := 100.0
const EXPLOSION_SCENE = preload("res://enemies/explosion.tscn")

@onready var sprite: Sprite2D = $Sprite
@onready var collision_sprite: CollisionShape2D = $Collision
@onready var collision_area: CollisionShape2D = $Area/Collision

var velocity := Vector2.ZERO
var direction

func _process(delta: float) -> void:
	velocity.x = SPEED * direction * delta
	move_and_collide(velocity)

func set_direction(dir) -> void:
	direction = dir

	if direction == 1:
		sprite.flip_h = true
	else:
		sprite.flip_h = false

func _on_area_body_entered(body: Node2D) -> void:
	visible = false
	var explosion = EXPLOSION_SCENE.instantiate()
	get_parent().add_child(explosion) #add_sibling
	explosion.global_position = global_position
	explosion.scale = Vector2(2, 2)
	collision_sprite.set_deferred("disabled", true)
	collision_area.set_deferred("disabled", true)
	await explosion.animation_finished
	queue_free()
