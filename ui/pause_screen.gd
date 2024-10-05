extends Panel

@onready var pause_screen: Panel = $"."

func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("pause")):
		get_tree().paused = true
		pause_screen.show()

func _on_resume_button_pressed() -> void:
	get_tree().paused = false
	pause_screen.hide()

func _on_menu_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://ui/start_screen.tscn")
