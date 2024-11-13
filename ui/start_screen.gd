extends Node

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/stage_1/stage_1.tscn")
