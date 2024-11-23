extends RigidBody2D

const EXPLOSION_SCENE = preload("res://enemies/explosion.tscn")

@onready var collision: CollisionShape2D = $Collision

func _on_body_entered(body: Node) -> void:
	visible = false
	var explosion = EXPLOSION_SCENE.instantiate()
	get_parent().add_child(explosion) #add_sibling
	explosion.global_position = global_position
	collision.set_deferred("disabled", true)
	await explosion.animation_finished
	queue_free()
