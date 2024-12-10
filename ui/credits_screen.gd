extends Node

@onready var back_button: TextureButton = $BackButton

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://ui/start_screen.tscn")
