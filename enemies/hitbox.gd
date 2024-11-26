extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Orange":
		body.velocity.y = body.JUMP_VELOCITY
		get_parent().animation.play("hurting")
		get_parent().damage_sfx.play()
