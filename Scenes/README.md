# Scenes Directory

This folder contains all the `.tscn` (Godot Scene) files for the game, structured into logical subdirectories to keep the project scalable.

## Directory Structure & Scene Roles

### `Core/`
Contains global, foundational scenes that manage the overall game state.
- **`GameManager.tscn`**: An Autoload (Singleton) scene that manages global variables like `current_gold`, `current_wave`, and `base_health`. It persists across level changes.
- **`SceneTransition.tscn`**: An Autoload (Singleton) scene that overlays a `ColorRect` and an `AnimationPlayer` to smoothly fade the screen to black whenever the player changes menus or levels.

### `UI/`
Contains all user interface screens and menus.
- **`StartMenu.tscn`**: The main title screen. Features a background diorama and buttons to start the game, open settings, or quit.
- **`PauseMenu.tscn`**: An in-game overlay (CanvasLayer) that freezes the `SceneTree` when the player presses Escape. Contains resume, settings, and quit options.
- **`SettingsMenu.tscn`**: A shared UI component containing audio sliders and configuration options, accessible from both the Start Menu and Pause Menu.

### `Levels/`
Contains the actual playable game maps.
- **`MainLevel.tscn`**: The primary battlefield map where the wave defense takes place. Contains the TileMapLayers for the island, water, and cliffs.

### `Systems/`
Contains invisible or functional scenes that handle gameplay logic within a level.
- **`WaveSpawner.tscn`**: Manages a timer and spawns a calculated number of enemies in a circle around the base when a wave starts.
- **`DeploymentSystem.tscn`**: Listens to the Card UI and player mouse clicks to deduct resources and instantiate units onto the battlefield.

### `Entities/`
Contains the actual actors and objects in the game world.
- **`Units/AllySoldier.tscn`**: The base scene for deployed player characters (e.g., Knights) that attack enemies.
- **`Units/BuilderPawn.tscn`**: A non-combat unit spawned by a card that runs to a specific location to build a structure.
- **`Units/EnemyUnit.tscn`**: The base scene for wave enemies (e.g., Goblins).
- **`Buildings/GoldMine.tscn`**: A structure (either pre-placed or built by pawns) that uses a Timer to generate gold over time.
