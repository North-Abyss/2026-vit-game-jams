extends Node2D
class_name Windmill

# --- Magic Numbers & Variables ---
@export var gold_per_cycle: int = 15
@export var cycle_duration: float = 3.0 # Takes 3 seconds to complete a rotation
@export var rotation_speed_degrees: float = 120.0 # Wheels Go Round!

@onready var blades_sprite: Sprite2D = Sprite2D.new() # In real scene this will be an existing node
@onready var cycle_timer: Timer = Timer.new()

# --- Functions ---

func _ready() -> void:
	# Add dummy sprite for script execution if none exists (helpful during dev)
	if not has_node("Blades"):
		blades_sprite.name = "Blades"
		add_child(blades_sprite)
	else:
		blades_sprite = $Blades
	
	add_child(cycle_timer)
	cycle_timer.wait_time = cycle_duration
	cycle_timer.timeout.connect(_on_cycle_timer_timeout)
	cycle_timer.start()

func _process(delta: float) -> void:
	# Rotates the blades_sprite continuously.
	if blades_sprite:
		blades_sprite.rotation_degrees += rotation_speed_degrees * delta

func _on_cycle_timer_timeout() -> void:
	# The wheel has completed a "cycle".
	GameManager.add_gold(gold_per_cycle)
	# Can spawn a floating text effect indicating "+15 Gold" here.
