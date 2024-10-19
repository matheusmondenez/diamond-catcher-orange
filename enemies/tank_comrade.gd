extends BaseEnemy

@onready var missile_spawner_1: Marker2D = $MissileSpawner1
@onready var missile_spawner_2: Marker2D = $MissileSpawner2
@onready var missile_spawner_3: Marker2D = $MissileSpawner3
@onready var missile_spawner_4: Marker2D = $MissileSpawner4

func _ready() -> void:
	sprite = $AnimatedSprite
	animation = $AnimatedSprite
	ray_cast = $WallDetector
	can_spawn = true
	spawn_instance = preload("res://enemies/comrade.tscn")
	spawn_instance_position = $ComradeSpawner
	animation.animation_finished.connect(kill_flying)

func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	move(delta)
	flip_sprite()
