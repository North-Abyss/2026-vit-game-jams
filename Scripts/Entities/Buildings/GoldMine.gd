extends Node2D
class_name GoldMine

@export var max_health: int = 500
@export var passive_gold_per_cycle: int = 25
@export var active_gold_per_hit: int = 5
@export var cycle_duration: float = 3.0

var current_health: int
var cycle_timer: Timer

func _ready() -> void:
	current_health = max_health
	add_to_group("Buildings") # So red troops can target it!
	GameManager.register_building()
	
	# Set up the internal timer
	cycle_timer = Timer.new()
	add_child(cycle_timer)
	cycle_timer.wait_time = cycle_duration
	cycle_timer.timeout.connect(_on_cycle_timer_timeout)
	cycle_timer.start()

func _on_cycle_timer_timeout() -> void:
	GameManager.add_gold(passive_gold_per_cycle)

func harvest(_damage: int) -> void:
	# Called by Pawns when they attack the mine
	GameManager.add_gold(active_gold_per_hit)

func take_damage(amount: int) -> void:
	# Called by Red Enemies when they attack the mine
	current_health -= amount
	if current_health <= 0:
		GameManager.building_destroyed()
		queue_free()
