extends Node
# Autoloaded as 'GameManager'

# --- Magic Numbers & Variables ---
var current_gold: int = 150
var current_wave: int = 1

const MAX_GOLD: int = 9999
const BASE_HEALTH: int = 100
var current_base_health: int = BASE_HEALTH

# --- Signals ---
signal gold_changed(new_amount: int)
signal base_health_changed(new_amount: int)
signal wave_changed(new_wave: int)
signal game_over()

# --- Functions ---

func _ready() -> void:
	# Initialize the UI with starting values
	gold_changed.emit(current_gold)
	base_health_changed.emit(current_base_health)
	wave_changed.emit(current_wave)

func add_gold(amount: int) -> void:
	# Adds gold to the player's pool (clamped to MAX_GOLD).
	current_gold = clampi(current_gold + amount, 0, MAX_GOLD)
	# Emits a signal to update the UI.
	gold_changed.emit(current_gold)

func spend_gold(amount: int) -> bool:
	# Deducts gold when deploying a soldier.
	if current_gold >= amount:
		current_gold -= amount
		gold_changed.emit(current_gold)
		return true
	# Returns true if successful, false if insufficient funds.
	return false

func take_base_damage(amount: int) -> void:
	# Deducts health from the central base.
	current_base_health -= amount
	base_health_changed.emit(current_base_health)
	
	# Triggers game over if current_base_health <= 0.
	if current_base_health <= 0:
		game_over.emit()
