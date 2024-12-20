extends Node

class_name BaseStage

const PLAYER_SCENE = preload("res://player/player.tscn")
const TRANSITION_SCENE = preload("res://ui/transition.tscn")
const DIAMOND_SCENE = preload("res://collectables/diamond.tscn")

@export_category("Stage Elements")
@export var hud: CanvasLayer
@export var camera: Camera2D
@export var player: CharacterBody2D
@export var start_position: Marker2D
@export var diamond: Area2D
@export var next_stage: PackedScene

@onready var transition = get_node("Transition/Fill")
@onready var transition_animation = get_node("Transition/Fill/Animation")

@export_category("Transition")
@export_enum("Diamond", "Spot Player", "Spot Center", "Vertical Bar", "Horizontal Bar") var transition_type = 0
@export_range(0.0, 2.0) var duration = 1.0

var background_music: AudioStreamPlayer
var boss_music: AudioStreamPlayer
var emitted_all_shards_signal: bool = false
var final_platform

signal all_shards_collected

func _ready() -> void:
	Globals.player_start_position = start_position
	Globals.player = player
	Globals.player.has_died.connect(reload_level)
	hud.time_is_up.connect(game_over)
	diamond.get_node("Collision").disabled = true
	diamond.connect("stage_cleared", clear)
	self.connect("all_shards_collected", transit_camera)
	if self.name == "Stage4":
		$Enemies/TankComrade.set_physics_process(false)

func _physics_process(delta: float) -> void:
	var root_children = get_tree().root.get_children()
	for child in root_children:
		if child.name == "Comrade" and child.has_signal("final_boss_defeated"):
			child.final_boss_defeated.connect(show_final_platform)
	if Globals.shards < 5 and is_instance_valid(Globals.player):
		Globals.player.remote.remote_path = camera.get_path()
	elif Globals.shards == 5 and is_instance_valid(diamond):
		if not emitted_all_shards_signal:
			emit_signal("all_shards_collected")
			emitted_all_shards_signal = true

func reload_level():
	await get_tree().create_timer(1.0).timeout
	var player = PLAYER_SCENE.instantiate()
	add_child(player)
	Globals.player_start_position = start_position
	Globals.player = player
	Globals.player.has_died.connect(reload_level)
	Globals.coins = 0
	Globals.respawn_player()
	Globals.player.remote.remote_path = camera.get_path()

func game_over():
	Globals.score = 0
	Globals.lives = 3
	Globals.hearts = 3
	Globals.shards = 0
	get_tree().change_scene_to_file("res://ui/game_over.tscn")
	#get_tree().reload_current_scene()

func clear() -> void:
	var timer = $StageClear
	$StageClearMusic.play()
	get_tree().paused = true
	timer.start(7.15)
	await  timer.timeout
	get_tree().paused = false
	Globals.shards = 0

	var transition = TRANSITION_SCENE.instantiate()
	get_tree().root.add_child(transition)
	var transition_fill = transition.get_child(0)
	var transition_animation = transition_fill.get_child(0)
	transition_fill.material.set_shader_parameter("type", 0)
	transition_animation.current_animation = "in"
	transition_animation.speed_scale = 0.5
	await transition_animation.animation_finished
	await get_tree().create_timer(0.5).timeout

	transition.queue_free()

	if self.name == "Stage4":
		get_tree().change_scene_to_file("res://ui/win_screen.tscn")
	elif next_stage:
		get_tree().change_scene_to_packed(next_stage)

func spawn_diamond() -> void:
	if is_instance_valid(diamond):
		diamond.get_node("Collision").disabled = false
		diamond.show()

func transit_camera() -> void:
	get_tree().paused = true
	Globals.player.remote.remote_path = ""
	diamond.remote.remote_path = camera.get_path()
	await get_tree().create_timer(1.0).timeout
	spawn_diamond()
	await get_tree().create_timer(1.0).timeout
	Globals.player.remote.remote_path = camera.get_path()
	get_tree().paused = false
	
func show_final_platform():
	final_platform.visible = true
	final_platform.collision.disabled = false
	boss_music.stop()
	background_music.play()
