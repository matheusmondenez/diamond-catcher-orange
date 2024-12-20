extends BaseEnemy

const BOMB_SCENE := preload("res://enemies/bomb.tscn")
const MISSILE_SCENE := preload("res://enemies/missile.tscn")

@onready var missile_spawner: Marker2D = %MissileSpawner
@onready var bomb_spawner: Marker2D = %BombSpawner
@onready var timer_missile: Timer = $TimerMissile
@onready var timer_bomb: Timer = $TimerBomb
@onready var timer_invunerability: Timer = $TimerInvunerability

func _ready() -> void:
	sprite = $Sprite
	animation = $AnimationPlayer
	ray_cast = $WallDetector
	can_spawn = true
	spawn_instance = preload("res://enemies/comrade.tscn")
	spawn_instance_position = $Spawner
	damage_sfx = $DamageSFX
	boss_lives = 3
	animation.animation_finished.connect(kill_walking)

func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	move(delta)
	flip_sprite()

func throw_bomb(distance) -> void:
	var bomb = BOMB_SCENE.instantiate()
	add_sibling(bomb)
	bomb.global_position = bomb_spawner.global_position
	bomb.apply_impulse(Vector2(randi_range(direction * (100 + distance), direction * (200 + distance)), randi_range(-20, -400)))

func launch_missile(velocity) -> void:
	var missile = MISSILE_SCENE.instantiate()
	add_sibling(missile)
	missile.global_position = missile_spawner.global_position
	missile.set_direction(direction)
	missile.SPEED = velocity

func _on_timer_bomb_timeout() -> void:
	var distance = 0

	if boss_lives == 2:
		distance += 100
	if boss_lives == 1:
		distance += 100

	throw_bomb(distance)

func _on_timer_missile_timeout() -> void:
	var velocity = 100.0
	
	if boss_lives == 2:
		velocity += 50.0
	if boss_lives == 1:
		velocity += 50.0

	launch_missile(velocity)

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "hurting" and boss_lives > 0:
		SPEED += 1500.0
		animation.play("invunerable")
		timer_invunerability.start()

func _on_timer_invunerability_timeout() -> void:
	animation.play("moving")
