extends Node2D

@onready var player_scene = preload("res://player/player.tscn")

@onready var player: CharacterBody2D = $Orange
@onready var coins: Node = $Collectables/Coins
@onready var shards: Node = $Collectables/Shards
@onready var diamond: Area2D = $Collectables/Diamond
@onready var camera: Camera2D = $Camera
@onready var hud: CanvasLayer = $HUD

func _ready() -> void:
	Globals.player = player
	Globals.player.camera_follow(camera)
	Globals.player.has_died.connect(reload_level)
	hud.time_is_up.connect(reload_level)

func _process(delta: float) -> void:
	var shards_count = shards.get_child_count()
	
	if (shards_count == 0 and is_instance_valid(diamond)):
		diamond.show()

func reload_level():
	await get_tree().create_timer(1.0).timeout
	var player = player_scene.instantiate()
	add_child(player)
	Globals.player = player
	Globals.player.camera_follow(camera)
	Globals.player.has_died.connect(reload_level)
	Globals.coins = 0
	Globals.lives = 3
	Globals.respawn_player()
	#get_tree().reload_current_scene()
