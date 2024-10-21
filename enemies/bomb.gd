extends RigidBody2D

const EXPLOSION_SCENE = preload("res://enemies/explosion.tscn")

func _on_body_entered(body: Node) -> void:
	visible = false
	var explosion = EXPLOSION_SCENE.instantiate()
	get_parent().add_child(explosion) #add_sibling
	explosion.global_position = global_position
	explosion.scale = Vector2(2, 2)
	await explosion.animation_finished
	queue_free()
