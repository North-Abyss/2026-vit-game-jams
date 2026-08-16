extends CanvasLayer
class_name PauseMenu

@onready var resume_button: Button = $VBoxContainer/ResumeButton
@onready var settings_button: Button = $VBoxContainer/SettingsButton
@onready var quit_button: Button = $VBoxContainer/QuitButton

func _ready() -> void:
	# Hide the pause menu by default
	hide()
	
	# Connect buttons
	if resume_button:
		resume_button.pressed.connect(_on_resume_pressed)
	if settings_button:
		settings_button.pressed.connect(_on_settings_pressed)
	if quit_button:
		quit_button.pressed.connect(_on_quit_pressed)

func _input(event: InputEvent) -> void:
	# Check if the player pressed the Esc key (mapped to 'ui_cancel' by default)
	if event.is_action_pressed("ui_cancel"):
		toggle_pause()

func toggle_pause() -> void:
	# Toggle the tree's pause state
	var new_pause_state = not get_tree().paused
	get_tree().paused = new_pause_state
	
	# Show or hide this menu
	visible = new_pause_state

func _on_resume_pressed() -> void:
	toggle_pause()

func _on_settings_pressed() -> void:
	print("Opening Settings Menu...")
	# For Phase 3, you would instantiate or show the SettingsMenu here

func _on_quit_pressed() -> void:
	# ALWAYS unpause before changing scenes, or the new scene will be frozen!
	get_tree().paused = false
	
	# Transition back to Start Menu using the Autoload
	if SceneTransition:
		SceneTransition.change_scene("res://Scenes/UI/StartMenu.tscn")
	else:
		get_tree().change_scene_to_file("res://Scenes/UI/StartMenu.tscn")
