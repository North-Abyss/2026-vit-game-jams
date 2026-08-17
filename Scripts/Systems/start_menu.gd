extends Node2D
class_name StartMenu

# --- Magic Numbers & Variables ---
@export var next_scene_path: String = "res://Scenes/Levels/MainLevel.tscn"

# Grab all the buttons from the VBoxContainer
@onready var play_button: Button = $CanvasLayer/VBoxContainer/PlayButton
@onready var settings_button: Button = $CanvasLayer/VBoxContainer/Settings
@onready var credits_button: Button = $CanvasLayer/VBoxContainer/Credits
@onready var quit_button: Button = $CanvasLayer/VBoxContainer/Quit

# --- Functions ---

func _ready() -> void:
	# Connect all buttons to their respective functions
	if play_button:
		play_button.pressed.connect(_on_play_button_pressed)
	if settings_button:
		settings_button.pressed.connect(_on_settings_pressed)
	if credits_button:
		credits_button.pressed.connect(_on_credits_pressed)
	if quit_button:
		quit_button.pressed.connect(_on_quit_pressed)

func _on_play_button_pressed() -> void:
	print("Starting Game...")
	if SceneTransition:
		SceneTransition.change_scene(next_scene_path)
	else:
		get_tree().change_scene_to_file(next_scene_path)

func _on_settings_pressed() -> void:
	# Temp function for now
	print("Settings menu coming soon!")

func _on_credits_pressed() -> void:
	if SceneTransition:
		SceneTransition.change_scene("res://Scenes/Systems/Credits.tscn")
	else:
		get_tree().change_scene_to_file("res://Scenes/Systems/Credits.tscn")

func _on_quit_pressed() -> void:
	print("Quitting Game...")
	get_tree().quit()
