extends Area2D

func _on_body_entered(body: Node2D) -> void:
	print("Entrou: ", body)
	if body.name == "Orange":
		body.velocity.y = body.JUMP_VELOCITY
		get_parent().animation.play("hurting")
