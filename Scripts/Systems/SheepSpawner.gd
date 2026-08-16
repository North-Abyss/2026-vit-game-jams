extends Node2D
class_name SheepSpawner

@export var sheep_scene: PackedScene
@export var num_sheeps: int = 20

func _ready() -> void:
	if not sheep_scene:
		print("SheepSpawner: No sheep_scene assigned!")
		return
	
	# TileMap Navigation is baked on a background thread in Godot 4!
	# We must wait a moment for the map to finish building before querying it.
	await get_tree().create_timer(1.0).timeout
	
	spawn_sheeps()

func spawn_sheeps() -> void:
	var map = get_world_2d().navigation_map
	
	for i in range(num_sheeps):
		# Get a random valid point on the navigation mesh (your painted grass!)
		var random_pos = NavigationServer2D.map_get_random_point(map, 1, false)
		
		var sheep = sheep_scene.instantiate()
		sheep.global_position = random_pos
		add_child(sheep)
		
	print("Spawned ", num_sheeps, " sheeps on the map!")
