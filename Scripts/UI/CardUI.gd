extends Control
class_name CardUI

# Define the resources
enum ResourceType { GOLD, MEAT }

@export var unit_name: String = "Knight"
@export var unit_scene: PackedScene
@export var cost_amount: int = 50
@export var cost_type: ResourceType = ResourceType.MEAT
@export var cooldown_time: float = 2.0

var is_on_cooldown: bool = false
var cooldown_timer: Timer

func _ready() -> void:
	cooldown_timer = Timer.new()
	add_child(cooldown_timer)
	cooldown_timer.one_shot = true
	cooldown_timer.wait_time = cooldown_time
	cooldown_timer.timeout.connect(func(): is_on_cooldown = false)

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if is_on_cooldown:
			print(unit_name, " is on cooldown!")
			return
		
		# Tell the global DeploymentSystem that this card was selected!
		var deployment_sys = get_tree().get_first_node_in_group("DeploymentSystem")
		if deployment_sys:
			deployment_sys.select_card(self)

func start_cooldown() -> void:
	is_on_cooldown = true
	cooldown_timer.start()
	# Optional: You can visually gray out the card here!
