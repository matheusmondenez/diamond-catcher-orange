extends AnimatableBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = $Timer
@onready var respawn_position := global_position

@export var reset_time := 3.0

var velocity := Vector2.ZERO
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_triggered := false

func _ready() -> void:
	set_physics_process(false)

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	position += velocity * delta

func has_collided_with(collision: KinematicCollision2D, collider: CharacterBody2D) -> void:
	if not is_triggered:
		is_triggered = true
		animation_player.play("shake")
		velocity = Vector2.ZERO

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	set_physics_process(true)
	timer.start(reset_time)

func _on_timer_timeout() -> void:
	set_physics_process(false)
	global_position = respawn_position
	
	if is_triggered:
		var tween = create_tween().set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_IN_OUT)
		tween.tween_property($Sprite2D, "scale", Vector2(1, 1), 0.2).from(Vector2(0, 0))
 
	is_triggered = false
