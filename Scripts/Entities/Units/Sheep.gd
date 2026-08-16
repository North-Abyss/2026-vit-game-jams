extends Node2D
class_name Sheep

@export var max_health: int = 3
@export var meat_yield: int = 15
@export var move_speed: float = 20.0

var current_health: int
var sprite: AnimatedSprite2D
var state_timer: Timer
var nav_agent: NavigationAgent2D

enum State { IDLE, EAT, WANDER }
var current_state: State = State.IDLE

func _ready() -> void:
	add_to_group("Resources")
	current_health = max_health
	
	sprite = get_node_or_null("AnimatedSprite2D")
	
	nav_agent = NavigationAgent2D.new()
	add_child(nav_agent)
	
	state_timer = Timer.new()
	add_child(state_timer)
	state_timer.timeout.connect(_on_state_timer_timeout)
	
	_pick_new_state()

func _process(delta: float) -> void:
	if current_state == State.WANDER and not nav_agent.is_navigation_finished():
		var next_pos = nav_agent.get_next_path_position()
		var direction = global_position.direction_to(next_pos)
		
		global_position += direction * move_speed * delta
		
		if sprite:
			if sprite.sprite_frames.has_animation("move"): sprite.play("move")
			sprite.flip_h = direction.x < 0 # Flip if moving left
	else:
		if sprite:
			if current_state == State.EAT and sprite.sprite_frames.has_animation("grass"):
				sprite.play("grass")
			elif sprite.sprite_frames.has_animation("default"):
				sprite.play("default")

func _pick_new_state() -> void:
	current_state = randi() % 3 as State
	
	if current_state == State.WANDER:
		# Pick a random spot nearby
		var random_offset = Vector2(randf_range(-100, 100), randf_range(-100, 100))
		nav_agent.target_position = global_position + random_offset
		state_timer.wait_time = randf_range(2.0, 4.0)
	else:
		state_timer.wait_time = randf_range(3.0, 6.0)
		
	state_timer.start()

func _on_state_timer_timeout() -> void:
	_pick_new_state()

func harvest(_damage: int) -> void:
	# Called by Pawns when they attack the sheep
	current_health -= 1 # 1 hit per attack
	GameManager.add_meat(meat_yield)
	
	if current_health <= 0:
		queue_free()
