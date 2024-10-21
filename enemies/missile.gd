extends AnimatableBody2D

const SPEED := 100.0
const EXPLOSION_SCENE = preload("res://enemies/explosion.tscn")

var velocity := Vector2.ZERO
var direction := -1 

func _process(delta: float) -> void:
	velocity.x = SPEED * direction * delta
	move_and_collide(velocity)

func _on_area_body_entered(body: Node2D) -> void:
	visible = false
	var explosion = EXPLOSION_SCENE.instantiate()
	get_parent().add_child(explosion) #add_sibling
	explosion.global_position = global_position
	explosion.scale = Vector2(2, 2)
	await explosion.animation_finished
	queue_free()
