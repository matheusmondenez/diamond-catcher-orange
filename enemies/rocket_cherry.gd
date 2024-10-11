extends CharacterBody2D

@onready var animation: AnimatedSprite2D = $AnimatedSprite

func _on_hitbox_body_entered(body: Node2D) -> void:
	animation.play("hurting")

func _on_animated_sprite_animation_finished() -> void:
	if animation.animation == "hurting":
		queue_free()
		Globals.score += 300
