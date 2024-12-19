extends BaseStage

@onready var boss_area: Area2D = $BossArea
@onready var tank_comrade: CharacterBody2D = $Enemies/TankComrade

func _ready() -> void:
	super()
	background_music = $BackgroundMusic
	boss_music = $BossMusic
	final_platform = $Platforms/MovingPlatformFinal

func _on_boss_area_body_entered(body: Node2D) -> void:
	if body.name == "Orange":
		# TODO: Verify AudioStreamPlayerInterative usage possibility
		final_platform.collision.disabled = true
		background_music.stop()
		boss_music.play()
		tank_comrade.set_physics_process(true)
		tank_comrade.timer_bomb.start()
		tank_comrade.timer_missile.start()
