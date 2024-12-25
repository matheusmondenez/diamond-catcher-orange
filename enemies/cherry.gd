extends BaseEnemy

func _ready() -> void:
	damage_sfx = $DamageSFX
	ray_cast = $WallDetector
	sprite = $SpriteAnimation

func _physics_process(delta: float) -> void:
	animation.animation_finished.connect(kill_flying)
	apply_gravity(delta)
	move(delta)
	flip_sprite()
