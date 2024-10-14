extends BaseEnemy

func _physics_process(delta: float) -> void:
	animation.animation_finished.connect(kill_flying)
	apply_gravity(delta)
	move(delta)
