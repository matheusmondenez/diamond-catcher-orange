extends MarginContainer

@onready var text_label: Label = $TextContainer/TextLabel
@onready var timer: Timer = $Timer

const MAX_WIDTH = 256

var text = ""
var letter_index = 0
var letter_display_time := 0.07
var space_display_time := 0.05
var accentuation_display_time := 0.2

signal message_display_finished()

func display_message(text_to_display: String):
	text = text_to_display
	text_label.text = text_to_display

	await resized
	
	custom_minimum_size.x = min(size.x, MAX_WIDTH)
	
	if size.x > MAX_WIDTH:
		text_label.autowrap_mode = TextServer.AUTOWRAP_WORD
		
		# Aguarda uma vez para x e outra para y
		await resized
		await resized
		
		custom_minimum_size.y = size.y
	
	global_position.x -= size.x / 2
	global_position.y -= size.y + 24
	text_label.text = ""
	display_letter()

func display_letter():
	if letter_index < text.length():
		text_label.text += text[letter_index]

		match text[letter_index]:
			"!", "?", ",", ".":
				timer.start(accentuation_display_time)
			" ":
				timer.start(space_display_time)
			_:
				timer.start(letter_display_time)
		
		letter_index += 1
	else:
		message_display_finished.emit()

func _on_timer_timeout() -> void:
	display_letter()
