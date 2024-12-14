extends BaseStage

@onready var boss_area: Area2D = $BossArea
@onready var background_music: AudioStreamPlayer = $BackgroundMusic
@onready var boss_music: AudioStreamPlayer = $BossMusic
@onready var tank_comrade: CharacterBody2D = $Enemies/TankComrade

func _on_boss_area_body_entered(body: Node2D) -> void:
	if body.name == "Orange":
		# TODO: Verify AudioStreamPlayerInterative usage possibility
		background_music.stop()
		boss_music.play()
		tank_comrade.set_physics_process(true)
		tank_comrade.timer_bomb.start()
		tank_comrade.timer_missile.start()

# TODO: Implements platform appearance after defeat boss
