extends Node2D

@onready var sprite: AnimatedSprite2D = $Sprite
@onready var area: Area2D = $Area
@onready var respawn_marker: Marker2D = $RespawnMarker
@onready var passing_sfx: AudioStreamPlayer = $PassingSFX

var is_active = false

func _on_area_body_entered(body: Node2D) -> void:
	if body.name == "Orange":
		area.queue_free()
		sprite.play("out")
		passing_sfx.play()
		await sprite.animation_finished
		sprite.play("idle")
		activate()

func activate():
	is_active = true
	Globals.current_checkpoint = respawn_marker
