extends Control
class_name GameOverUI

@onready var score_label: Label = $Panel/VBoxContainer/ScoreLabel
@onready var restart_button: Button = $Panel/VBoxContainer/RestartButton

func _ready() -> void:
	# Hide by default and ensure it still runs when the tree is paused!
	visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	GameManager.game_over.connect(_on_game_over)
	
	if restart_button:
		restart_button.pressed.connect(_on_restart_pressed)

func _on_game_over(final_score: int) -> void:
	visible = true
	if score_label:
		score_label.text = "Final Score: " + str(final_score) + "\n(Gold + Waves Survived)"
	
	# Pause the game so enemies stop moving
	get_tree().paused = true

func _on_restart_pressed() -> void:
	get_tree().paused = false
	GameManager.active_buildings = 0
	GameManager.current_gold = 150
	GameManager.current_meat = 50
	GameManager.current_wave = 1
	get_tree().reload_current_scene()
