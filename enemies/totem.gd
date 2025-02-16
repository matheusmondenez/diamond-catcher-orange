extends BaseEnemy

func _ready() -> void:
	ray_cast = $WallDetector
	floor_detector = $FloorDetector
	sprite = $AnimatedSprite
	animation = $AnimatedSprite
	damage_sfx = $DamageSFX
	animation.animation_finished.connect(kill_flying)

func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	move(delta)
	flip_sprite()
