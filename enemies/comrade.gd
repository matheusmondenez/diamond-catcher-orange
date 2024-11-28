extends BaseEnemy

func _ready() -> void:
	sprite = $AnimatedSprite
	animation = $AnimatedSprite
	ray_cast = $WallDetector
	damage_sfx = $DamageSFX
	animation.animation_finished.connect(kill_flying)

func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	move(delta)
	flip_sprite()
