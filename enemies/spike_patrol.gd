extends BaseEnemy

func _ready() -> void:
	sprite = $Sprite
	ray_cast = $RayCast
	damage_sfx = $DamageSFX
	animation.animation_finished.connect(kill_walking)
 
func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	flip_sprite()
	move(delta)
