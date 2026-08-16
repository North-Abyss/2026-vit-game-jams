extends Node2D

# --- Magic Numbers & Variables ---
@export var camera_speed: float = 800.0

# Optional: Limits for the camera so you can't scroll infinitely off-screen
@export var limit_left: int = -2000
@export var limit_right: int = 2000
@export var limit_top: int = -2000
@export var limit_bottom: int = 2000

@onready var pause_menu = $PauseMenu
@onready var pause_button = $UI/PauseButton

func _ready() -> void:
	if pause_button and pause_menu:
		# Connect the pause button to the PauseMenu's toggle function
		pause_button.pressed.connect(pause_menu.toggle_pause)
		
func _process(delta: float) -> void:
	var direction = Vector2.ZERO

	# Check for input using the built-in UI actions (Arrow keys / WASD if mapped)
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1

	# Normalize direction so moving diagonally isn't faster
	if direction != Vector2.ZERO:
		direction = direction.normalized()

	# Move the player node (which moves the attached Camera2D)
	global_position += direction * camera_speed * delta

	# Clamp the position so the camera doesn't fly off the map
	global_position.x = clamp(global_position.x, limit_left, limit_right)
	global_position.y = clamp(global_position.y, limit_top, limit_bottom)


func _on_pause_button_pressed() -> void:
	$UI/PauseButton.visible = false;
	
