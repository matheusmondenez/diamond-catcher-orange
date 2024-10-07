extends CanvasLayer

@onready var resume_button: TextureButton = $ButtonsContainer/ResumeButton
@onready var menu_button: TextureButton = $ButtonsContainer/MenuButton
@onready var credits_button: TextureButton = $ButtonsContainer/CreditsButton
@onready var quit_button: TextureButton = $ButtonsContainer/QuitButton

func _ready():
	visible = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		get_tree().paused = true
		visible = true
		resume_button.grab_focus()

func _on_resume_button_pressed() -> void:
	get_tree().paused = false
	visible = false

func _on_menu_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://ui/start_screen.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()
