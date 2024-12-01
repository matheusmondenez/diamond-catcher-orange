extends Node2D

@onready var label: Label = $Label
@onready var sprite: Sprite2D = $Sprite2D
@onready var area: Area2D = $Area2D

const LINES: Array[String] = [
	"Welcome!",
	"Collect all the five diamond shards to unlock the big one and finish the level",
	"To walk, just press the A or D keys. Or the arrow keys. But thinking about it... If you've already come here, it's because you already know this... Never mind!",
	"If you are in a hurry, try to hold Shift while walking!",
	"You can also double jump, you know? Just press Space to jump",
	"Okay, okay! I'm already finishing! To defeat enemies you have an extra trick besides jumping. You can roll towards them to catch them off guard! Just press Ctrl!",
	"Alright! I've already said too much! Now it's up to you! GO!",
]

func _unhandled_input(event: InputEvent) -> void:
	if area.get_overlapping_bodies().size() > 0:
		sprite.show()
		label.show()
		
		if event.is_action_pressed("interact") && !Dialog.is_active_message:
			Dialog.start_message(global_position, LINES)
		elif Dialog.is_active_message:
			sprite.hide()
			label.hide()
	else:
		sprite.hide()
		label.hide()
