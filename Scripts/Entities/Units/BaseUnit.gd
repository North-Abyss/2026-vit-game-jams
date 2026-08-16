extends CharacterBody2D
class_name BaseUnit

# --- Signals ---
signal died()

# --- Magic Numbers & Variables ---
@export var is_enemy: bool = false
@export var move_speed: float = 150.0
@export var max_health: int = 100
@export var attack_damage: int = 20
@export var attack_range: float = 50.0
@export var attack_cooldown: float = 1.2

var current_health: int
var target: Node2D = null
var can_attack: bool = true

@onready var attack_timer: Timer = Timer.new()

# --- Functions ---

func _ready() -> void:
	current_health = max_health
	
	add_child(attack_timer)
	attack_timer.one_shot = true
	attack_timer.wait_time = attack_cooldown
	attack_timer.timeout.connect(func(): can_attack = true)

func _physics_process(delta: float) -> void:
	find_target()
	
	if target and is_instance_valid(target):
		var distance = global_position.distance_to(target.global_position)
		if distance > attack_range:
			# Move towards target
			var direction = (target.global_position - global_position).normalized()
			velocity = direction * move_speed
			move_and_slide()
		else:
			# Within range, stop moving and attack
			velocity = Vector2.ZERO
			if can_attack:
				perform_attack()
	else:
		velocity = Vector2.ZERO

func find_target() -> void:
	# Simplified targeting: just find the nearest node in a specific group
	# Enemies target "Allies" or "Base", Allies target "Enemies"
	var target_group = "Allies" if is_enemy else "Enemies"
	var potential_targets = get_tree().get_nodes_in_group(target_group)
	
	var closest_dist = INF
	target = null
	
	for p_target in potential_targets:
		var dist = global_position.distance_to(p_target.global_position)
		if dist < closest_dist:
			closest_dist = dist
			target = p_target
			
	# If enemy and no allies found, target the center/base (assume it's at Vector2.ZERO for now)
	if is_enemy and target == null:
		# Dummy target logic for base
		pass 

func perform_attack() -> void:
	if target and target.has_method("take_damage"):
		target.take_damage(attack_damage)
	
	can_attack = false
	attack_timer.start()

func take_damage(amount: int) -> void:
	current_health -= amount
	# Plays hurt animation.
	if current_health <= 0:
		die()

func die() -> void:
	died.emit()
	if is_enemy:
		# Give some gold reward
		GameManager.add_gold(10)
	queue_free()
