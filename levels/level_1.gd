extends Node2D

@onready var player: CharacterBody2D = $Orange
@onready var coins: Node = $Collectables/Coins
@onready var shards: Node = $Collectables/Shards
@onready var diamond: Area2D = $Collectables/Diamond
@onready var camera: Camera2D = $Camera
@onready var control: Control = $HUD/Control

func _ready() -> void:
	player.camera_follow(camera)
	player.has_died.connect(reload_level)
	control.time_is_up.connect(reload_level) 

func _process(delta: float) -> void:
	var shards_count = shards.get_child_count()
	
	if (shards_count == 0 and is_instance_valid(diamond)):
		diamond.show()

func reload_level():
	await get_tree().create_timer(1.0).timeout
	get_tree().reload_current_scene()
	Globals.coins = 0
	Globals.lives = 3
