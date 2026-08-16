# Game Plan: Wheels Go Round - "Cycles of War" (Wave Defense)

This document outlines the architectural plan for your Godot 4.6 game. Based on your feedback, we've shifted from base-building to a **Wave Defense & Soldier Deployment** game, integrating the "Wheels Go Round" theme and your *Tiny Swords* assets.

## Game Concept & Theme Integration
**Concept:** A wave-based defense game where you deploy medieval soldiers (from the *Tiny Swords* pack) to fend off endless cycles (waves) of enemies.
**Theme ("Wheels Go Round"):**
- **Cycles of War:** The game is driven by endless "cycles" or waves of enemies that grow stronger each rotation.
- **Rotational Economy:** You rely on spinning Windmills/Waterwheels to generate the Meat/Gold needed to deploy your soldiers.
- **Circular Defense:** Enemies spawn around the edges of a circular map and march towards your central keep/flag.

## Assets Info
As noted in `Assets/Info.md`, we are utilizing the **Tiny Swords (Free Pack)**. Heavy assets are ignored in git (`.gitignore`) to prevent repo bloat.

---

## User Review Required
> [!IMPORTANT]
> Please review this updated wave-defense architecture and GDScript templates. If this matches your vision for deploying soldiers against enemy waves, approve this plan so we can create a `task.md` and start coding!

---

## Proposed Scene Architecture

1. **`res://Scenes/UI/MainMenu.tscn`**
   - The main hub for starting the game and viewing high scores.
2. **`res://Scenes/Core/GameManager.tscn`** (Autoload / Singleton)
   - Handles global economy, wave counters, and game-over states.
3. **`res://Scenes/Levels/MainLevel.tscn`**
   - The main battlefield map.
4. **`res://Scenes/Systems/WaveSpawner.tscn`**
   - Handles the timing and spawning of enemy waves.
5. **`res://Scenes/Systems/DeploymentSystem.tscn`**
   - Handles the player clicking on the map to deploy soldiers (costs resources).
6. **`res://Scenes/Entities/Units/AllySoldier.tscn`**
   - Parent scene for deployed player units (e.g., Knights, Archers).
7. **`res://Scenes/Entities/Units/EnemyUnit.tscn`**
   - Parent scene for wave enemies (e.g., Goblins, Sheep).
8. **`res://Scenes/Entities/Buildings/Windmill.tscn`**
   - A resource generator whose rotating wheel provides passive income.

---

## GDScript Skeletons

Below are the initial GDScript structures, including "imports" (preloads/class names), "magic numbers" (exports/constants), and commented function signatures.

### 1. Game Manager (Singleton) (`res://Scripts/Core/GameManager.gd`)

```gdscript
extends Node
# Autoloaded as 'GameManager'

# --- Magic Numbers & Variables ---
var current_gold: int = 150
var current_wave: int = 1

const MAX_GOLD: int = 9999
const BASE_HEALTH: int = 100
var current_base_health: int = BASE_HEALTH

# --- Functions ---

func add_gold(amount: int) -> void:
    # Adds gold to the player's pool (clamped to MAX_GOLD).
    # Emits a signal to update the UI.
    pass

func spend_gold(amount: int) -> bool:
    # Deducts gold when deploying a soldier.
    # Returns true if successful, false if insufficient funds.
    return false

func take_base_damage(amount: int) -> void:
    # Deducts health from the central base.
    # Triggers game over if current_base_health <= 0.
    pass
```

### 2. Wave Spawner (`res://Scripts/Systems/WaveSpawner.gd`)

```gdscript
extends Node2D
class_name WaveSpawner

# --- "Imports" (Preloads) ---
const GOBLIN_SCENE = preload("res://Scenes/Entities/Units/EnemyGoblin.tscn")

# --- Magic Numbers & Variables ---
@export var spawn_radius: float = 500.0 # Enemies spawn in a circle around the center
@export var base_enemies_per_wave: int = 5
@export var wave_multiplier: float = 1.5
@export var time_between_waves: float = 10.0

@onready var wave_timer: Timer = $WaveTimer

var enemies_alive: int = 0

# --- Functions ---

func _ready() -> void:
    # Start the first wave countdown.
    pass

func start_wave() -> void:
    # Calculates how many enemies to spawn based on GameManager.current_wave.
    # Spawns enemies along the circumference of the spawn_radius.
    pass

func _on_enemy_died() -> void:
    # Decrements enemies_alive.
    # If enemies_alive == 0, starts the timer for the next wave.
    pass
```

### 3. Deployment System (`res://Scripts/Systems/DeploymentSystem.gd`)

```gdscript
extends Node2D
class_name DeploymentSystem

# --- "Imports" (Preloads) ---
const KNIGHT_SCENE = preload("res://Scenes/Entities/Units/AllyKnight.tscn")

# --- Magic Numbers & Variables ---
@export var knight_cost: int = 50
@export var deployment_cooldown: float = 1.0

var can_deploy: bool = true

# --- Functions ---

func _input(event: InputEvent) -> void:
    # Detects mouse clicks on the map.
    # If clicked and can_deploy, attempts to deploy a soldier.
    pass

func deploy_soldier(spawn_position: Vector2, type: String) -> void:
    # Checks with GameManager if the player has enough gold.
    # If yes, instantiates the KNIGHT_SCENE at spawn_position.
    # Starts the deployment_cooldown timer.
    pass
```

### 4. Base Soldier / Unit (`res://Scripts/Entities/Units/BaseUnit.gd`)

```gdscript
extends CharacterBody2D
class_name BaseUnit

# --- Magic Numbers & Variables ---
@export var is_enemy: bool = false
@export var move_speed: float = 150.0
@export var max_health: int = 100
@export var attack_damage: int = 20
@export var attack_range: float = 50.0
@export var attack_cooldown: float = 1.2

var current_health: int
var target: Node2D = null

@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var attack_timer: Timer = $AttackTimer

# --- Functions ---

func _ready() -> void:
    current_health = max_health

func _physics_process(delta: float) -> void:
    # Finds the nearest valid target (enemies find allies/base, allies find enemies).
    # Moves towards target using move_speed.
    # If within attack_range, stops moving and triggers attack sequence.
    pass

func take_damage(amount: int) -> void:
    # Reduces current_health.
    # Plays hurt animation.
    # Calls die() if health <= 0.
    pass

func die() -> void:
    # If is_enemy, gives gold to GameManager.
    # Plays death animation and queues_free().
    pass
```

### 5. Windmill (Resource Generator) (`res://Scripts/Entities/Buildings/Windmill.gd`)

```gdscript
extends Node2D
class_name Windmill

# --- Magic Numbers & Variables ---
@export var gold_per_cycle: int = 15
@export var cycle_duration: float = 3.0 # Takes 3 seconds to complete a rotation
@export var rotation_speed_degrees: float = 120.0 # Wheels Go Round!

@onready var blades_sprite: Sprite2D = $Blades
@onready var cycle_timer: Timer = $CycleTimer

# --- Functions ---

func _ready() -> void:
    # Starts the cycle_timer based on cycle_duration
    pass

func _process(delta: float) -> void:
    # Rotates the blades_sprite continuously.
    # blades_sprite.rotation_degrees += rotation_speed_degrees * delta
    pass

func _on_cycle_timer_timeout() -> void:
    # The wheel has completed a "cycle".
    # Calls GameManager.add_gold(gold_per_cycle).
    # Spawns a floating text effect indicating "+15 Gold".
    pass
```

## Verification Plan
1. **Directory Setup**: Create folders for Scripts, Scenes, and organize the Tiny Swords assets appropriately.
2. **Implement Core Systems**: Write the `GameManager`, `WaveSpawner`, and `DeploymentSystem` scripts based on the skeletons.
3. **Unit Logic**: Implement the shared `BaseUnit` logic for movement and combat.
4. **Testing**: Run the MainLevel, ensure windmills generate gold via rotation, deploying knights costs gold, and waves of enemies spawn and attack deployed knights or the central base.
