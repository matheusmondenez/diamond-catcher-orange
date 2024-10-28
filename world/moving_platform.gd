extends Node2D

const WAIT_DURATION := 1.0

@onready var platform: AnimatableBody2D = $AnimatableBody

@export_category("Platform")
@export var speed := 3.0
@export var distance := 192
@export var move_horizontal := true

var follow := Vector2.ZERO
var platform_center := 16

func _ready() -> void:
	move()

func _physics_process(delta: float) -> void:
	platform.position = platform.position.lerp(follow, 0.5)

func move() -> void:
	var move_direction = Vector2.RIGHT * distance if move_horizontal else Vector2.UP * distance
	var duration = move_direction.length() / float(speed * platform_center)
	var tween = create_tween().set_loops().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	
	tween.tween_property(self, "follow", move_direction, duration).set_delay(WAIT_DURATION)
	tween.tween_property(self, "follow", Vector2.ZERO, duration).set_delay(WAIT_DURATION)
