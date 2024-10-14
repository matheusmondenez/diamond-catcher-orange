extends Node2D

@onready var sprite: AnimatedSprite2D = $Sprite
@onready var area: Area2D = $Area

func _on_area_body_entered(body: Node2D) -> void:
	if body.name == "Orange":
		area.queue_free()
		sprite.play("out")
		await sprite.animation_finished
		sprite.play("idle")
