extends Node2D
class_name GoldMine

@export var gold_per_cycle: int = 25
@export var cycle_duration: float = 3.0

var cycle_timer: Timer

func _ready() -> void:
	# Set up the internal timer
	cycle_timer = Timer.new()
	add_child(cycle_timer)
	cycle_timer.wait_time = cycle_duration
	cycle_timer.timeout.connect(_on_cycle_timer_timeout)
	cycle_timer.start()

func _on_cycle_timer_timeout() -> void:
	GameManager.add_gold(gold_per_cycle)
	# You can add a floating text effect here later!

func harvest(damage: int) -> void:
	# Called by Pawns when they attack the mine
	GameManager.add_gold(gold_per_cycle)
	# Gold Mines don't die, they just give gold when hit!
