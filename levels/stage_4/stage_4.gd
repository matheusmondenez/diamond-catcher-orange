extends BaseStage

const DIAMOND_SCENE = preload("res://collectables/diamond.tscn")

@onready var transition = get_node("Transition/Fill")
@onready var transition_animation = get_node("Transition/Fill/Animation")
@onready var boss_area: Area2D = $BossArea
@onready var background_music: AudioStreamPlayer = $BackgroundMusic
@onready var tank_comrade: CharacterBody2D = $Enemies/TankComrade

@export_category("Transition")
@export_enum("Diamond", "Spot Player", "Spot Center", "Vertical Bar", "Horizontal Bar") var transition_type = 0
@export_range(0.0, 2.0) var duration = 1.0

func _on_boss_area_body_entered(body: Node2D) -> void:
	if body.name == "Orange":
		print("Entrou!")
		background_music.stop()
		tank_comrade.set_physics_process(true)
		tank_comrade.timer_bomb.start()
		tank_comrade.timer_missile.start()
