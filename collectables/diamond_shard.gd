extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		$Animation.play("collected")

func _on_animation_animation_finished() -> void:
	if $Animation.animation == "collected":
		queue_free()
