extends Node

class_name BaseStage

const PLAYER_SCENE = preload("res://player/player.tscn")

@export_category("Stage Elements")
@export var hud: CanvasLayer
@export var camera: Camera2D
@export var player: CharacterBody2D
@export var start_position: Marker2D
@export var diamond: Area2D
@export var next_stage: PackedScene

var emitted: bool = false
signal all_shards_collected

func _ready() -> void:
	Globals.player_start_position = start_position
	Globals.player = player
	Globals.player.has_died.connect(reload_level)
	hud.time_is_up.connect(game_over)
	diamond.get_node("Collision").disabled = true
	diamond.connect("stage_cleared", clear)
	self.connect("all_shards_collected", test)

func _physics_process(delta: float) -> void:
	if Globals.shards < 5 and is_instance_valid(Globals.player):
		Globals.player.remote.remote_path = camera.get_path()
	elif Globals.shards == 5 and is_instance_valid(diamond):
		if not emitted:
			emit_signal("all_shards_collected")
			emitted = true

func reload_level():
	await get_tree().create_timer(1.0).timeout
	var player = PLAYER_SCENE.instantiate()
	add_child(player)
	Globals.player_start_position = start_position
	Globals.player = player
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
	Globals.shards = 0

	if next_stage:
		get_tree().change_scene_to_packed(next_stage)

func spawn_diamond() -> void:
	if is_instance_valid(diamond):
		diamond.get_node("Collision").disabled = false
		diamond.show()

func test() -> void:
	print("ALL SHARDS")
	get_tree().paused = true
	Globals.player.remote.remote_path = ""
	diamond.remote.remote_path = camera.get_path()
	await get_tree().create_timer(1.0).timeout
	spawn_diamond()
	await get_tree().create_timer(1.0).timeout
	Globals.player.remote.remote_path = camera.get_path()
	get_tree().paused = false
