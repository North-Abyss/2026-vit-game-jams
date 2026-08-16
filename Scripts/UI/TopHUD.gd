extends Control
class_name TopHUD

@onready var gold_label: Label = $HBoxContainer/GoldContainer/GoldLabel
@onready var meat_label: Label = $HBoxContainer/MeatContainer/MeatLabel
@onready var wave_label: Label = $HBoxContainer/WaveLabel

func _ready() -> void:
	# Connect to GameManager signals so the UI updates automatically!
	GameManager.gold_changed.connect(_on_gold_changed)
	GameManager.meat_changed.connect(_on_meat_changed)
	GameManager.wave_changed.connect(_on_wave_changed)
	
	# Fetch initial values so the HUD isn't blank on startup
	_on_gold_changed(GameManager.current_gold)
	_on_meat_changed(GameManager.current_meat)
	_on_wave_changed(GameManager.current_wave)

func _on_gold_changed(new_amount: int) -> void:
	if gold_label:
		gold_label.text = str(new_amount)

func _on_meat_changed(new_amount: int) -> void:
	if meat_label:
		meat_label.text = str(new_amount)

func _on_wave_changed(new_wave: int) -> void:
	if wave_label:
		wave_label.text = "Wave: " + str(new_wave)
