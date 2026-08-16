extends Node2D
class_name WaveSpawner

# --- "Imports" (Preloads) ---
# const GOBLIN_SCENE = preload("res://Scenes/Entities/Units/EnemyGoblin.tscn")
# Keeping it dynamic via export so we can configure in inspector later
@export var enemy_scene: PackedScene

# --- Magic Numbers & Variables ---
@export var spawn_radius: float = 500.0 # Enemies spawn in a circle around the center
@export var base_enemies_per_wave: int = 5
@export var wave_multiplier: float = 1.5
@export var time_between_waves: float = 10.0

@onready var wave_timer: Timer = Timer.new()

var enemies_alive: int = 0

# --- Functions ---

func _ready() -> void:
	# Setup Wave Timer
	add_child(wave_timer)
	wave_timer.wait_time = time_between_waves
	wave_timer.one_shot = true
	wave_timer.timeout.connect(start_wave)
	
	# Start the first wave countdown.
	wave_timer.start()

func start_wave() -> void:
	var wave: int = GameManager.current_wave
	# Calculates how many enemies to spawn based on GameManager.current_wave.
	var num_enemies: int = int(base_enemies_per_wave * pow(wave_multiplier, wave - 1))
	enemies_alive += num_enemies
	
	# Spawns enemies along the circumference of the spawn_radius.
	for i in range(num_enemies):
		var angle: float = (float(i) / num_enemies) * TAU
		var spawn_pos: Vector2 = Vector2(cos(angle), sin(angle)) * spawn_radius
		
		# Instantiate if the scene is set
		if enemy_scene:
			var enemy_inst = enemy_scene.instantiate()
			enemy_inst.global_position = global_position + spawn_pos
			get_parent().add_child(enemy_inst)
			
			# We assume enemy has a signal "died"
			if enemy_inst.has_signal("died"):
				enemy_inst.died.connect(_on_enemy_died)
				
	GameManager.current_wave += 1
	GameManager.wave_changed.emit(GameManager.current_wave)

func _on_enemy_died() -> void:
	# Decrements enemies_alive.
	enemies_alive -= 1
	
	# If enemies_alive <= 0, starts the timer for the next wave.
	if enemies_alive <= 0:
		wave_timer.start()
