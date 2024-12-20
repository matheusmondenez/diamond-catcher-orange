extends BaseEnemy

@onready var timer: Timer = $SearchTimer

var has_detected_player: bool = false
var continue_searching: bool = false
var player_detection_atempts: int = 5

func _ready() -> void:
	sprite = $AnimatedSprite
	animation = $AnimatedSprite
	ray_cast = $WallDetector
	floor_detector = $FloorDetector
	player_detector = $PlayerDetector
	damage_sfx = $DamageSFX
	can_spawn = true
	spawn_instance = preload("res://enemies/totem.tscn")
	spawn_instance_position = $SpawnerMarker
	animation.animation_finished.connect(kill_flying)

func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	flip_sprite()
	
	if is_seeing_player():
		move(delta)
		sprite.play("walking")
		reset_search_for_player()
	elif not is_seeing_player() and has_detected_player and continue_searching and player_detection_atempts > 0:
		search_for_player()
	elif player_detection_atempts == 0:
		continue_searching = false

func is_seeing_player() -> bool:
	return $PlayerDetector.is_colliding()

func search_for_player() -> void:
	continue_searching = false
	sprite.play("standing")
	flip_sprite(true)
	player_detection_atempts -= 1
	timer.start()
	await timer.timeout
	continue_searching = true

func reset_search_for_player() -> void:
	has_detected_player = true
	continue_searching = true
	player_detection_atempts = 5
