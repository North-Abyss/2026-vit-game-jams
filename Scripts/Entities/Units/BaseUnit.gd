extends CharacterBody2D
class_name BaseUnit

# --- Signals ---
signal died()

# --- Enums & State ---
enum UnitState { IDLE, RUN, ATTACK, FARM }
var current_state: UnitState = UnitState.IDLE

# --- Magic Numbers & Variables ---
@export var is_enemy: bool = false
@export var is_worker: bool = false # True for Pawns that can farm
@export var move_speed: float = 150.0
@export var max_health: int = 100
@export var attack_damage: int = 20
@export var attack_range: float = 60.0
@export var attack_cooldown: float = 1.2

var current_health: int
var target: Node2D = null
var can_attack: bool = true

# Node References
var attack_timer: Timer
var nav_agent: NavigationAgent2D
var detection_zone: Area2D
var sprite: AnimatedSprite2D

func _ready() -> void:
	current_health = max_health
	
	# Group Setup
	if is_enemy:
		add_to_group("Enemies")
	else:
		add_to_group("Allies")
		if is_worker:
			add_to_group("Workers")

	# 1. Attack Timer
	attack_timer = Timer.new()
	add_child(attack_timer)
	attack_timer.one_shot = true
	attack_timer.wait_time = attack_cooldown
	attack_timer.timeout.connect(func(): can_attack = true)
	
	# 2. Navigation Agent (For Pathfinding)
	nav_agent = NavigationAgent2D.new()
	add_child(nav_agent)
	nav_agent.path_desired_distance = 10.0
	nav_agent.target_desired_distance = attack_range - 10.0
	
	# 3. Detection Zone (Radar)
	detection_zone = Area2D.new()
	var shape = CollisionShape2D.new()
	var circle = CircleShape2D.new()
	circle.radius = 400.0 # Huge radar for Clash of Clans map awareness
	shape.shape = circle
	detection_zone.add_child(shape)
	add_child(detection_zone)
	
	# 4. Find Sprite for Animations
	sprite = get_node_or_null("AnimatedSprite2D")
	if not sprite:
		for child in get_children():
			if child is AnimatedSprite2D:
				sprite = child
				break

func _physics_process(_delta: float) -> void:
	find_target()
	
	if target and is_instance_valid(target):
		nav_agent.target_position = target.global_position
		
		if not nav_agent.is_navigation_finished():
			# Move towards target using pathfinding
			var next_path_pos = nav_agent.get_next_path_position()
			var direction = global_position.direction_to(next_path_pos)
			velocity = direction * move_speed
			move_and_slide()
			
			set_state(UnitState.RUN)
			
			# Flip Sprite based on movement
			if sprite and direction.x != 0:
				sprite.flip_h = direction.x < 0
		else:
			# Reached target (within attack range)
			velocity = Vector2.ZERO
			
			# Check if target is a resource or enemy
			if target.is_in_group("Resources") and is_worker:
				set_state(UnitState.FARM)
			else:
				set_state(UnitState.ATTACK)
				
			if can_attack:
				perform_action()
	else:
		velocity = Vector2.ZERO
		set_state(UnitState.IDLE)

func find_target() -> void:
	# Clash of Clans Prioritization
	var potential_targets = detection_zone.get_overlapping_bodies()
	var closest_dist = INF
	var best_target = null
	
	# We evaluate targets based on priority logic
	for p_target in potential_targets:
		if p_target == self: continue
		
		var dist = global_position.distance_to(p_target.global_position)
		var is_valid = false
		var _priority = 0
		
		if is_enemy:
			# Red Team Priorities: 1. Blue Troops, 2. Buildings
			if p_target.is_in_group("Allies"):
				is_valid = true; _priority = 1
			elif p_target.is_in_group("Buildings"):
				is_valid = true; _priority = 2
		else:
			# Blue Team Priorities: 1. Red Troops, 2. Resources (If worker)
			if p_target.is_in_group("Enemies"):
				is_valid = true; _priority = 1
			elif is_worker and p_target.is_in_group("Resources"):
				is_valid = true; _priority = 2
				
		# We want the highest priority (lowest number), and then closest distance
		if is_valid and dist < closest_dist: # In a full system, you'd weight priority heavily
			closest_dist = dist
			best_target = p_target
			
	target = best_target

func perform_action() -> void:
	if current_state == UnitState.ATTACK:
		if target.has_method("take_damage"):
			target.take_damage(attack_damage)
	elif current_state == UnitState.FARM:
		if target.has_method("harvest"):
			target.harvest(attack_damage) # E.g., mining gold
			
	can_attack = false
	attack_timer.start()

func set_state(new_state: UnitState) -> void:
	if current_state == new_state: return
	current_state = new_state
	
	if not sprite or not sprite.sprite_frames: return
	
	match current_state:
		UnitState.IDLE:
			if sprite.sprite_frames.has_animation("Idle"): sprite.play("Idle")
		UnitState.RUN:
			if sprite.sprite_frames.has_animation("walk-left"): sprite.play("walk-left")
			elif sprite.sprite_frames.has_animation("Run"): sprite.play("Run")
		UnitState.ATTACK:
			if sprite.sprite_frames.has_animation("attack-left"): sprite.play("attack-left")
			elif sprite.sprite_frames.has_animation("Attack1"): sprite.play("Attack1")
		UnitState.FARM:
			if sprite.sprite_frames.has_animation("Mine"): sprite.play("Mine")
			elif sprite.sprite_frames.has_animation("Chop"): sprite.play("Chop")
			elif sprite.sprite_frames.has_animation("attack-left"): sprite.play("attack-left")

func take_damage(amount: int) -> void:
	current_health -= amount
	if current_health <= 0:
		die()

func die() -> void:
	died.emit()
	if is_enemy:
		GameManager.add_gold(15) # Reward for killing enemy
	queue_free()
