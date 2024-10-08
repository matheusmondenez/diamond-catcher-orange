extends Node

@onready var dialog_scene = preload("res://ui/dialog.tscn")

var message_lines: Array[String] = []
var current_line = 0
var dialog_box
var dialog_box_position := Vector2.ZERO
var is_active_message := false
var can_forward_message := false

func start_message(position: Vector2, lines: Array[String]):
	if is_active_message:
		return
	
	message_lines = lines
	dialog_box_position = position
	show_text()
	is_active_message = true

func show_text():
	dialog_box = dialog_scene.instantiate()
	dialog_box.message_display_finished.connect(_on_all_text_displayed)
	get_tree().root.add_child(dialog_box)
	dialog_box.global_position = dialog_box_position
	dialog_box.display_message(message_lines[current_line])
	can_forward_message = false

func _on_all_text_displayed():
	can_forward_message = true

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("forward") && is_active_message && can_forward_message:
		dialog_box.queue_free()
		current_line += 1
		
		if current_line >= message_lines.size():
			is_active_message = false
			current_line = 0
			return

		show_text()
