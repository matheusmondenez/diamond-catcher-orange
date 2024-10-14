extends BaseEnemy

@onready var spawn_marker: Marker2D = $"../SpawnMarker"

func _ready() -> void:
	spawn_instance = preload("res://enemies/cherry.tscn")
	spawn_instance_position = spawn_marker
	can_spawn = true
	animation.animation_finished.connect(kill_flying)
