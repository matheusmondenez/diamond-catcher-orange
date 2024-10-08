extends Node2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var area: Area2D = $Area2D

const LINES: Array[String] = [
	"Welcome!",
	"Collect all the five diamond shards to unlock the big one and finish the level",
	"...START!!!"
]

func _unhandled_input(event: InputEvent) -> void:
	if area.get_overlapping_bodies().size() > 0:
		sprite.show()
		
		if event.is_action_pressed("interact") && !Dialog.is_active_message:
			sprite.hide()
			Dialog.start_message(global_position, LINES)
		#else:
			#sprite.hide()
			
			#if Dialog.dialog_box != null:
				#Dialog.dialog_box.queue_free()
				#Dialog.is_active_message = false
