extends Node2D
class_name EnemySpawner

@export var enemy_scene: PackedScene
@export var spawn_interval: float = 20.0 # Time between waves
@export var enemies_per_wave: int = 3
@export var spawn_radius: float = 1500.0 # Distance from center of map

var wave_timer: Timer

func _ready() -> void:
	if not enemy_scene:
		print("EnemySpawner: No enemy scene assigned!")
		return
		
	wave_timer = Timer.new()
	add_child(wave_timer)
	wave_timer.wait_time = spawn_interval
	wave_timer.timeout.connect(_on_wave_timer_timeout)
	wave_timer.start()

func _on_wave_timer_timeout() -> void:
	# Spawn a wave of enemies at a random angle at the edge of the map
	var random_angle = randf() * TAU
	var spawn_center = Vector2(cos(random_angle), sin(random_angle)) * spawn_radius
	
	for i in range(enemies_per_wave):
		var enemy = enemy_scene.instantiate()
		
		# Scatter them slightly around the spawn center
		var scatter = Vector2(randf_range(-50, 50), randf_range(-50, 50))
		enemy.global_position = spawn_center + scatter
		
		get_parent().add_child(enemy)
		
	GameManager.current_wave += 1
	GameManager.wave_changed.emit(GameManager.current_wave)
	
	# Make the game harder over time!
	enemies_per_wave += 1
	print("Wave ", GameManager.current_wave, " spawned with ", enemies_per_wave, " enemies!")
