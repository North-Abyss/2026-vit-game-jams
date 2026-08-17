extends Control

@export var scroll_speed: float = 120.0 # Adjust horizontal text scroll speed
@export var character_speed: float = 120.0 # Adjust character path movement speed
@export var character_spacing: float = 0.12 # Increase this number to make the gap between them larger!

@onready var credits_text: RichTextLabel = $RichTextLabel
@onready var path_node: Path2D = $Path2D
@onready var team_node: AnimatedSprite2D = $team # Updated to match your exact node name

var can_scroll: bool = false
var characters_moving: bool = true # Controls if the whole group is allowed to walk

func _ready() -> void:
	# Start the title logo animation immediately using the "team" animation
	if team_node:
		team_node.play("team")
		
	# Position credits text off-screen to the right using screen viewport width
	if credits_text:
		credits_text.position.x = get_viewport_rect().size.x
	
	# Find all character sprites inside PathFollow2D nodes and start their walk animation
	if path_node:
		var current_spacing: float = 0.0 # Start the first character at the beginning
		
		for follower in path_node.get_children():
			if follower is PathFollow2D:
				# Disable loop so they stay at the end position when finished
				follower.loop = false
				
				# Assign starting position gap
				follower.progress_ratio = current_spacing
				current_spacing += character_spacing
				
				# Play initial walk animation
				for child in follower.get_children():
					if child is AnimatedSprite2D:
						child.play("walk")
	
	# Wait 3 seconds for character intro before text scrolling begins
	await get_tree().create_timer(3.0).timeout
	can_scroll = true

func _process(delta: float) -> void:
	# 1. Move characters along the Path2D line until the leader reaches the end
	if path_node and characters_moving:
		var leader_finished: bool = false
		
		# Move everyone forward
		for follower in path_node.get_children():
			if follower is PathFollow2D:
				follower.progress += character_speed * delta
				
				# Check if ANY character has hit the very end of the line
				if follower.progress_ratio >= 1.0:
					leader_finished = true
		
		# If the front character reached the end, stop EVERYONE to keep the gap
		if leader_finished:
			characters_moving = false # Stops the movement code above from running next frame
			
			for follower in path_node.get_children():
				if follower is PathFollow2D:
					for child in follower.get_children():
						if child is AnimatedSprite2D and child.animation != "animation1":
							child.play("animation1")

	# 2. Scroll the RichTextLabel horizontally from right to left
	if can_scroll and credits_text:
		credits_text.position.x -= scroll_speed * delta
		
		# Return to main menu when credits finish scrolling past the left side
		if credits_text.position.x < -credits_text.size.x:
			go_back_to_menu()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"): # Press ESC to skip back
		go_back_to_menu()

func _on_back_button_pressed() -> void:
	go_back_to_menu()

func go_back_to_menu() -> void:
	if SceneTransition:
		SceneTransition.change_scene("res://Scenes/Systems/StartMenu.tscn")
	else:
		get_tree().change_scene_to_file("res://Scenes/Systems/StartMenu.tscn")
