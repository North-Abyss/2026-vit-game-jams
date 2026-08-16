extends Node2D
class_name DeploymentSystem

# --- "Imports" (Preloads) ---
# const KNIGHT_SCENE = preload("res://Scenes/Entities/Units/AllyKnight.tscn")
@export var ally_scene: PackedScene

# --- Magic Numbers & Variables ---
@export var knight_cost: int = 50
@export var deployment_cooldown: float = 1.0

var can_deploy: bool = true
@onready var cooldown_timer: Timer = Timer.new()

# --- Functions ---

func _ready() -> void:
	add_child(cooldown_timer)
	cooldown_timer.one_shot = true
	cooldown_timer.wait_time = deployment_cooldown
	cooldown_timer.timeout.connect(func(): can_deploy = true)

func _unhandled_input(event: InputEvent) -> void:
	# Detects mouse clicks on the map.
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if can_deploy:
			deploy_soldier(get_global_mouse_position(), "Knight")

func deploy_soldier(spawn_position: Vector2, type: String) -> void:
	if not ally_scene:
		push_warning("DeploymentSystem: ally_scene not assigned!")
		return
		
	# Checks with GameManager if the player has enough gold.
	if GameManager.spend_gold(knight_cost):
		# If yes, instantiates the KNIGHT_SCENE at spawn_position.
		var inst = ally_scene.instantiate()
		inst.global_position = spawn_position
		get_parent().add_child(inst)
		
		# Starts the deployment_cooldown timer.
		can_deploy = false
		cooldown_timer.start()
