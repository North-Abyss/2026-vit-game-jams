extends Control
class_name GameOverUI

var score_label: Label
var restart_button: Button
var quit_button: Button

func _ready() -> void:
	# Hide by default and ensure it still runs when the tree is paused!
	visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	score_label = find_child("ScoreLabel", true, false) as Label
	restart_button = find_child("RestartButton", true, false) as Button
	quit_button = find_child("Quit", true, false) as Button
	
	GameManager.game_over.connect(_on_game_over)
	
	if restart_button:
		restart_button.pressed.connect(_on_restart_pressed)
	if quit_button:
		quit_button.pressed.connect(func(): get_tree().quit())

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
