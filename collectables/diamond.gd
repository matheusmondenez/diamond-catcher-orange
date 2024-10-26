extends Area2D

const TRANSITION_SCENE = preload("res://ui/transition.tscn")

@onready var animated_sprite: AnimatedSprite2D = $Animation

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Orange":
		animated_sprite.play("collected")

func _on_animation_animation_finished() -> void:
	if animated_sprite.animation == "appearing":
		animated_sprite.play("default")
	elif animated_sprite.animation == "collected":
		queue_free()
		var transition = TRANSITION_SCENE.instantiate()
		get_tree().root.add_child(transition)
		var transition_fill = transition.get_child(0)
		var transition_animation = transition_fill.get_child(0)
		transition_fill.material.set_shader_parameter("type", 0)
		transition_animation.current_animation = "in"
		transition_animation.speed_scale = 0.5
		#await transition_animation.animation_finished
		#await get_tree().create_timer(0.5).timeout
		#get_tree().change_scene_to_file("res://ui/start_screen.tscn")

func _on_animation_visibility_changed() -> void:
	animated_sprite.play("appearing")
