extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Orange":
		$Animation.play("collected")
		await $Collision.call_deferred("queue_free")
		Globals.shards += 1

func _on_animation_animation_finished() -> void:
	if $Animation.animation == "collected":
		queue_free()
