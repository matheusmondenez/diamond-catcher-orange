extends Node

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/stage_1/stage_1.tscn")

func _on_credits_button_pressed() -> void:
	get_tree().change_scene_to_file("res://ui/credits_screen.tscn")
