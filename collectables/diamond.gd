extends Area2D

const TRANSITION_SCENE = preload("res://ui/transition.tscn")

@onready var animated_sprite: AnimatedSprite2D = $Animation
@onready var remote: RemoteTransform2D = $RemoteTransform2D
@onready var collect_sfx: AudioStreamPlayer = $CollectSFX

@export var camera: Camera2D

signal stage_cleared

func _ready() -> void:
	animated_sprite.play("appearing")

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Orange":
		animated_sprite.play("collected")

func _on_animation_animation_finished() -> void:
	if animated_sprite.animation == "appearing":
		animated_sprite.play("default")
	elif animated_sprite.animation == "collected":
		queue_free()
		emit_signal("stage_cleared")

func _on_animation_visibility_changed() -> void:
	animated_sprite.play("appearing")
	collect_sfx.play()

func appear():
	self.show()
