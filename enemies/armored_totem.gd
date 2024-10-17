extends BaseEnemy

func _ready() -> void:
	sprite = $AnimatedSprite
	animation = $AnimatedSprite
	ray_cast = $WallDetector
	floor_detector = $FloorDetector
	can_spawn = true
	spawn_instance = preload("res://enemies/totem.tscn")
	spawn_instance_position = $SpawnerMarker
	animation.animation_finished.connect(kill_flying)

func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	flip_sprite()
	
	if $PlayerDetector.is_colliding():
		move(delta)
