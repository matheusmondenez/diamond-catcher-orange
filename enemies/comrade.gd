extends BaseEnemy

signal final_boss_defeated

func _ready() -> void:
	sprite = $AnimatedSprite
	animation = $AnimatedSprite
	ray_cast = $WallDetector
	damage_sfx = $DamageSFX
	animation.animation_finished.connect(kill_flying)
	SPEED = 5600.0

func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	move(delta)
	flip_sprite()

func _on_tree_exited() -> void:
	emit_signal("final_boss_defeated")
