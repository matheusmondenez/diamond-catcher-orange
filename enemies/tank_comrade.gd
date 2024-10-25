extends BaseEnemy

const BOMB_SCENE := preload("res://enemies/bomb.tscn")
const MISSILE_SCENE := preload("res://enemies/missile.tscn")

@onready var missile_spawner: Marker2D = %MissileSpawner
@onready var bomb_spawner: Marker2D = %BombSpawner
@onready var timer_missile: Timer = $TimerMissile
@onready var timer_bomb: Timer = $TimerBomb

func _ready() -> void:
	sprite = $Sprite
	animation = $AnimationPlayer
	ray_cast = $WallDetector
	can_spawn = true
	spawn_instance = preload("res://enemies/comrade.tscn")
	spawn_instance_position = $Spawner
	animation.animation_finished.connect(kill_walking)

func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	move(delta)
	flip_sprite()
	
	#if sprite.flip_h:
		#missile_spawner.position.x *= -1
		#bomb_spawner.position.x *= -1
	#else:
		#missile_spawner.position.x *= -1
		#bomb_spawner.position.x *= -1

func throw_bomb() -> void:
	var bomb = BOMB_SCENE.instantiate()
	add_sibling(bomb)
	bomb.global_position = bomb_spawner.global_position
	bomb.scale = Vector2(2, 2)
	bomb.apply_impulse(Vector2(randi_range(direction * 30, direction * 200), randi_range(-20, -400)))

func launch_missile() -> void:
	var missile = MISSILE_SCENE.instantiate()
	add_sibling(missile)
	missile.global_position = missile_spawner.global_position
	missile.scale = Vector2(2, 2)
	missile.set_direction(direction)

func _on_timer_bomb_timeout() -> void:
	throw_bomb()

func _on_timer_missile_timeout() -> void:
	launch_missile()
