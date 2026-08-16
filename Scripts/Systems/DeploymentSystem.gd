extends Node2D
class_name DeploymentSystem

var selected_card: CardUI = null

func _ready() -> void:
	# Add this node to a group so cards can find it easily
	add_to_group("DeploymentSystem")

func select_card(card: CardUI) -> void:
	selected_card = card
	print("Selected Card: ", card.unit_name)

func _input(event: InputEvent) -> void:
	# If player left-clicks on the map and has a card selected
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if selected_card and selected_card.unit_scene:
			attempt_deployment(get_global_mouse_position())

func attempt_deployment(spawn_pos: Vector2) -> void:
	var success = false
	
	# Check costs based on the card's required resource
	if selected_card.cost_type == CardUI.ResourceType.GOLD:
		success = GameManager.spend_gold(selected_card.cost_amount)
	else:
		success = GameManager.spend_meat(selected_card.cost_amount)
		
	if success:
		# Spawn the unit
		var new_unit = selected_card.unit_scene.instantiate()
		new_unit.global_position = spawn_pos
		
		# Add to the level (assuming DeploymentSystem is a child of MainLevel)
		get_parent().add_child(new_unit)
		
		# Trigger cooldown and deselect
		selected_card.start_cooldown()
		selected_card = null
		print("Deployed successfully!")
	else:
		print("Not enough resources to deploy ", selected_card.unit_name)
