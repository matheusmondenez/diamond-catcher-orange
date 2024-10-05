extends Area2D

@onready var animated_sprite: AnimatedSprite2D = $Animation

func _on_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		animated_sprite.play("collected")

func _on_animation_animation_finished() -> void:
	if animated_sprite.animation == "appearing":
		animated_sprite.play("default")
	elif animated_sprite.animation == "collected":
		queue_free()

func _on_animation_visibility_changed() -> void:
	animated_sprite.play("appearing")
