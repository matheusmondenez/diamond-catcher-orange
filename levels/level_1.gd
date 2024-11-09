extends Node2D

@onready var player_scene = preload("res://player/player.tscn")
@onready var start_position: Marker2D = $StartPosition
@onready var player: CharacterBody2D = $Orange
@onready var coins: Node = $Collectables/Coins
@onready var shards: Node = $Collectables/Shards
@onready var diamond: Area2D = $Collectables/Diamond
@onready var camera: Camera2D = $Camera
@onready var hud: CanvasLayer = $HUD
@onready var transition = get_node("Transition/Fill")
@onready var transition_animation = get_node("Transition/Fill/Animation")

@export_category("Transition")
@export_enum("Diamond", "Spot Player", "Spot Center", "Vertical Bar", "Horizontal Bar") var transition_type = 0
@export_range(0.0, 2.0) var duration = 1.0

func _ready() -> void:
	Globals.player_start_position = start_position
	Globals.player = player
	Globals.player.camera_follow(camera)
	Globals.player.has_died.connect(reload_level)
	hud.time_is_up.connect(game_over)
	transition.material.set_shader_parameter("type", transition_type)
	transition_animation.speed_scale = duration

func _process(delta: float) -> void:
	var shards_count = shards.get_child_count()
	
	if (shards_count == 0 and is_instance_valid(diamond)):
		#var tween = create_tween()
		#var initial_camera_position = camera.global_position
		#await tween.tween_property(camera, "position", Vector2(1136, 216), 2.0)

		diamond.appear()

		#tween.tween_property(camera, "position", initial_camera_position, 2.0)
		#Globals.player.camera_follow(camera)

func reload_level():
	await get_tree().create_timer(1.0).timeout
	var player = player_scene.instantiate()
	add_child(player)
	Globals.player = player
	Globals.player.camera_follow(camera)
	Globals.player.has_died.connect(reload_level)
	Globals.coins = 0
	#Globals.lives = 3 # Rever regra
	Globals.respawn_player()

func game_over():
	get_tree().reload_current_scene()
