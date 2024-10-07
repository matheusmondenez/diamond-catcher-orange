extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Orange":
		$Animation.play("collected")
		# Evita coletar duplamente enquanto a animação não acaba
		await $Collision.call_deferred("queue_free")
		Globals.coins += 1

func _on_animation_animation_finished() -> void:
	queue_free()
