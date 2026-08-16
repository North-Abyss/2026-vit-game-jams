extends CanvasLayer
class_name SettingsMenu

@onready var back_button: Button = $Panel/VBoxContainer/BackButton
@onready var master_slider: HSlider = $Panel/VBoxContainer/MasterSlider
@onready var sfx_slider: HSlider = $Panel/VBoxContainer/SFXSlider

func _ready() -> void:
	if back_button:
		back_button.pressed.connect(_on_back_pressed)

func _on_back_pressed() -> void:
	# Hide the settings menu to return to the previous screen (Pause Menu or Start Menu)
	hide()
