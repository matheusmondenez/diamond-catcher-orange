extends BaseEnemy

func _ready() -> void:
	sprite = $Sprite
	animation = $AnimationPlayer
	ray_cast = $WallDetector
	can_spawn = true
	spawn_instance = preload("res://enemies/comrade.tscn")
	spawn_instance_position = $ComradeSpawner
	animation.animation_finished.connect(kill_flying)

func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	move(delta)
	flip_sprite()
