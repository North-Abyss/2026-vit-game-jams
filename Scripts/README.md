# Scripts Directory

This folder contains all the `.gd` (GDScript) files for the game. Like the Scenes directory, scripts are organized by their architectural role.

## Directory Structure & Script Roles

### `Core/`
Scripts that handle global logic and foundational systems.
- **`GameManager.gd`**: Autoloaded script attached to `GameManager.tscn`. Stores the player's current gold, tracks the wave number, handles deducting/adding resources, and manages the Game Over state.
- **`SceneTransition.gd`**: Autoloaded script attached to `SceneTransition.tscn`. Provides a global `change_scene(target)` function that smoothly fades the screen to black, switches the active Godot scene, and fades back in.
- **`player.gd`**: A simple camera control script. Attached to a `Node2D` with a `Camera2D` child, it listens for `ui_left/right/up/down` arrow keys to pan the camera across the battlefield.

### `UI/`
Scripts specifically attached to Control nodes and CanvasLayers to handle user interface logic.
- **`start_menu.gd`**: Attached to `StartMenu.tscn`. Connects button signals (Play, Settings, Credits, Quit) and transitions the game to the Main Level when "Play" is pressed.
- **`PauseMenu.gd`**: Attached to `PauseMenu.tscn`. Listens for the `ui_cancel` (Escape) key. When pressed, it toggles `get_tree().paused = true`, making the overlay visible and freezing the game behind it.
- **`SettingsMenu.gd`**: Attached to `SettingsMenu.tscn`. Manages the logic for the back button and handles the sliders for adjusting the game's audio buses (Master, SFX, Music).
- **`CardUI.gd`**: Manages the logic for a clickable deployment card, including displaying the resource cost and handling the visual cooldown timer after spawning a unit.

### `Systems/`
Scripts that act as "Managers" for specific gameplay mechanics within a level.
- **`WaveSpawner.gd`**: Attached to `WaveSpawner.tscn`. Uses a `Timer` to trigger waves. It calculates how many enemies to spawn based on the current wave number and uses trigonometry (`sin`/`cos`) to spawn them in a circle around the base.
- **`DeploymentSystem.gd`**: Attached to `DeploymentSystem.tscn`. Listens for left mouse clicks on the map. If the player has enough gold and a Card is selected, it instantiates the corresponding unit at the mouse position.

### `Entities/`
Scripts attached to physical game objects (KinematicBodies, CharacterBodies, Node2Ds).
- **`Units/BaseUnit.gd`**: The foundational combat script. Handles moving towards a target (`CharacterBody2D` physics) and basic attack cooldowns. Both Ally Knights and Enemy Goblins inherit this logic.
- **`Units/BuilderPawn.gd`**: A specialized unit script for non-combat pawns. They move to a target coordinate and trigger a build timer to spawn a structure.
- **`Buildings/GoldMine.gd`**: Attached to `GoldMine.tscn`. Uses a `Timer` to periodically call `GameManager.add_gold()`, feeding the player's economy.
