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
@onready var marker_2d: Marker2D = $Marker2D

@export_category("Transition")
@export_enum("Diamond", "Spot Player", "Spot Center", "Vertical Bar", "Horizontal Bar") var transition_type = 0
@export_range(0.0, 2.0) var duration = 1.0

signal voltar_camera
var emited: bool = false

func _ready() -> void:
	Globals.player_start_position = start_position
	Globals.player = player
	#Globals.player.camera_follow(camera)
	Globals.player.has_died.connect(reload_level)
	hud.time_is_up.connect(game_over)
	transition.material.set_shader_parameter("type", transition_type)
	transition_animation.speed_scale = duration
	diamond.connect("stage_cleared", clear)
	#self.connect("voltar_camera", voltar_camera_para_jogador)

func _process(delta: float) -> void:
	#var shards_count = shards.get_child_count()
	if Globals.shards < 5:
		Globals.player.remote.remote_path = camera.get_path()
	elif (Globals.shards == 5 and is_instance_valid(diamond)):
		Globals.player.remote.remote_path = ""
		diamond.remote.remote_path = camera.get_path()
		#Globals.player.camera_follow("")
		#var tween = create_tween()
		#tween.tween_property(camera, "position", marker_2d.position, 2.0)
		#await tween.finished
#
		await get_tree().create_timer(1.0).timeout
		diamond.appear()
		await get_tree().create_timer(1.0).timeout

		#diamond.remote.remote_path = ""
		Globals.player.remote.remote_path = camera.get_path()
		#await get_tree().create_timer(2.0).timeout
		
		#if not emited:
			#emited = true
			#emit_signal("voltar_camera")
		#Globals.player.camera_follow(camera)

func reload_level():
	await get_tree().create_timer(1.0).timeout
	var player = player_scene.instantiate()
	add_child(player)
	Globals.player = player
	#Globals.player.camera_follow(camera)
	Globals.player.has_died.connect(reload_level)
	Globals.coins = 0
	#Globals.lives = 3 # Rever regra
	Globals.respawn_player()

func game_over():
	get_tree().reload_current_scene()

func clear() -> void:
	#var timer = $StageClear
	#get_tree().paused = true
	#timer.start(2.0)
	#await  timer.timeout
	#get_tree().paused = false
	Globals.shards = 0

func voltar_camera_para_jogador():
	print("voltar_camera_para_jogador")
	Globals.player.camera_follow(camera)
