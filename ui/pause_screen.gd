extends CanvasLayer

@onready var resume_button: TextureButton = $ButtonsContainer/ResumeButton
@onready var menu_button: TextureButton = $ButtonsContainer/MenuButton
@onready var quit_button: TextureButton = $ButtonsContainer/QuitButton
@onready var pause_sfx: AudioStreamPlayer = $PauseSFX
@onready var unpause_sfx: AudioStreamPlayer = $UnpauseSFX

func _ready():
	visible = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		pause_sfx.play()
		get_tree().paused = true
		visible = true
		resume_button.grab_focus()

func _on_resume_button_pressed() -> void:
	unpause_sfx.play()
	get_tree().paused = false
	visible = false

func _on_menu_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://ui/start_screen.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()
