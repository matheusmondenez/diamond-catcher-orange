extends Node

@onready var trophy: AnimatedSprite2D = $Trophy
@onready var particles: GPUParticles2D = $GPUParticles
@onready var score_points: Label = $VerticalContainer/ScorePoints

func _ready() -> void:
	print(get_children())
	score_points.text = str("%06d" % Globals.score)
	await get_tree().create_timer(1).timeout
	trophy.play("default")
	particles.emitting = true
