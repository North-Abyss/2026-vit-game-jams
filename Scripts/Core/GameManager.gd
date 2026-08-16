extends Node
# Autoloaded as 'GameManager'

# --- Magic Numbers & Variables ---
var current_gold: int = 150
var current_meat: int = 50
var current_wave: int = 1

const MAX_GOLD: int = 9999
const MAX_MEAT: int = 9999
const BASE_HEALTH: int = 100
var current_base_health: int = BASE_HEALTH

var active_buildings: int = 0
var total_score: int = 0

# --- Signals ---
signal gold_changed(new_amount: int)
signal meat_changed(new_amount: int)
signal base_health_changed(new_amount: int)
signal wave_changed(new_wave: int)
signal game_over(final_score: int)

# --- Functions ---

func _ready() -> void:
	# Initialize the UI with starting values
	gold_changed.emit(current_gold)
	meat_changed.emit(current_meat)
	base_health_changed.emit(current_base_health)
	wave_changed.emit(current_wave)

func register_building() -> void:
	active_buildings += 1

func building_destroyed() -> void:
	active_buildings -= 1
	if active_buildings <= 0:
		total_score = current_gold + (current_wave * 100)
		game_over.emit(total_score)

func add_gold(amount: int) -> void:
	# Adds gold to the player's pool (clamped to MAX_GOLD).
	current_gold = clampi(current_gold + amount, 0, MAX_GOLD)
	# Emits a signal to update the UI.
	gold_changed.emit(current_gold)

func spend_gold(amount: int) -> bool:
	if current_gold >= amount:
		current_gold -= amount
		gold_changed.emit(current_gold)
		return true
	return false

func add_meat(amount: int) -> void:
	current_meat = clampi(current_meat + amount, 0, MAX_MEAT)
	meat_changed.emit(current_meat)

func spend_meat(amount: int) -> bool:
	if current_meat >= amount:
		current_meat -= amount
		meat_changed.emit(current_meat)
		return true
	return false
