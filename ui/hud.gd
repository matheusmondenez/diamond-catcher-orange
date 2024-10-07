extends CanvasLayer

@onready var coins_counter: Label = $Control/MarginContainer/CoinsContainer/Counter
@onready var timer_counter: Label = $Control/MarginContainer/TimerContainer/Counter
@onready var score_counter: Label = $Control/MarginContainer/ScoreContainer/Counter
@onready var lives_counter: Label = $Control/MarginContainer/LivesContainer/Counter

@export_range(0,5) var default_minutes := 5
@export_range(0, 59) var defaul_seconds := 0

signal time_is_up()

var minutes: int = 0
var seconds: int = 0

func _ready() -> void:
	coins_counter.text = str("%02d" % Globals.coins)
	score_counter.text = str("%06d" % Globals.score)
	lives_counter.text = str("%01d" % Globals.lives)
	timer_counter.text = str("%02d" % default_minutes) + ":" + str("%02d" % defaul_seconds)
	
	reset_clock_timer()

func _process(delta: float) -> void:
	coins_counter.text = str("%02d" % Globals.coins)
	score_counter.text = str("%06d" % Globals.score)
	lives_counter.text = str("%01d" % Globals.lives)
	
	if minutes == 0 and seconds == 0:
		emit_signal("time_is_up")

func _on_timer_timeout() -> void:
	if seconds == 0:
		if minutes > 0:
			minutes -= 1
			seconds = 60
	seconds -= 1
	
	timer_counter.text = str("%02d" % minutes) + ":" + str("%02d" % seconds)

func reset_clock_timer():
	minutes = default_minutes
	seconds = defaul_seconds
