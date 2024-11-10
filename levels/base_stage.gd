extends Node

class_name BaseStage

const PLAYER_SCENE = preload("res://player/player.tscn")

@export_category("Stage Elements")
@export var hud: CanvasLayer
@export var camera: Camera2D
@export var player: CharacterBody2D
@export var start_position: Marker2D

func _ready() -> void:
	Globals.player_start_position = start_position
	Globals.player = player
	Globals.player.camera_follow(camera)
	Globals.player.has_died.connect(reload_level)
	hud.time_is_up.connect(game_over)

func reload_level():
	await get_tree().create_timer(1.0).timeout
	var player = PLAYER_SCENE.instantiate()
	add_child(player)
	Globals.player_start_position = start_position
	Globals.player = player
	Globals.player.camera_follow(camera)
	Globals.player.has_died.connect(reload_level)
	Globals.coins = 0
	#Globals.lives = 3 # Rever regra
	Globals.respawn_player()

func game_over():
	get_tree().reload_current_scene()

func clear() -> void:
	var timer = $StageClear
	get_tree().paused = true
	timer.start(2.0)
	await  timer.timeout
	get_tree().paused = false
