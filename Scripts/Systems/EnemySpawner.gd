extends Node2D
class_name EnemySpawner

@export var enemy_scene: PackedScene
@export var spawn_interval: float = 20.0 # Time between waves
@export var enemies_per_wave: int = 3
@export var spawn_radius: float = 1500.0 # Distance from center of map

var wave_timer: Timer
var warning_label: Label

func _ready() -> void:
	if not enemy_scene:
		print("EnemySpawner: No enemy scene assigned!")
		return
		
	# Create a giant warning label dynamically
	warning_label = Label.new()
	warning_label.text = "WAVE INCOMING!"
	warning_label.add_theme_font_size_override("font_size", 64)
	warning_label.add_theme_color_override("font_color", Color.RED)
	warning_label.visible = false
	
	# Create a CanvasLayer to ensure the label is drawn on top of everything
	var canvas = CanvasLayer.new()
	add_child(canvas)
	
	# Center the label
	var center_container = CenterContainer.new()
	center_container.set_anchors_preset(Control.PRESET_FULL_RECT)
	center_container.mouse_filter = Control.MOUSE_FILTER_IGNORE
	canvas.add_child(center_container)
	center_container.add_child(warning_label)
		
	wave_timer = Timer.new()
	add_child(wave_timer)
	wave_timer.wait_time = spawn_interval
	wave_timer.timeout.connect(_on_wave_timer_timeout)
	wave_timer.start()

func _on_wave_timer_timeout() -> void:
	# Show warning and play alarm!
	warning_label.visible = true
	if AudioManager and AudioManager.has_method("play_alarm"): 
		AudioManager.play_alarm()
	
	# Wait 3 seconds for dramatic effect
	await get_tree().create_timer(3.0).timeout
	warning_label.visible = false
	
	# Spawn a wave of enemies at a random angle at the edge of the map
	var random_angle = randf() * TAU
	var spawn_center = Vector2(cos(random_angle), sin(random_angle)) * spawn_radius
	
	for i in range(enemies_per_wave):
		var enemy = enemy_scene.instantiate()
		var scatter = Vector2(randf_range(-50, 50), randf_range(-50, 50))
		enemy.global_position = spawn_center + scatter
		get_parent().add_child(enemy)
		
	GameManager.current_wave += 1
	GameManager.wave_changed.emit(GameManager.current_wave)
	
	enemies_per_wave += 1
