# Walkthrough: Wheels Go Round - "Cycles of War"

The initial implementation phase for the Wave Defense game has been successfully completed! All core architectural elements and scripts requested have been structured, commented, and integrated into the Godot project.

## What Was Accomplished

1. **Directory Structure Organization**: 
   Established clean folders (`Scenes/` and `Scripts/`) grouped by `Core`, `Entities`, `Levels`, `Systems`, and `UI` for scalability.

2. **Core Systems Implemented**:
   - `GameManager.gd`: Autoloaded global singleton created and registered in `project.godot`. It tracks `current_gold`, `current_wave`, and `base_health`, and emits signals when values change.
   - `WaveSpawner.gd`: Spawns enemies dynamically in a circle around the center of the map (`spawn_radius`). Scales enemy count exponentially per wave.
   - `DeploymentSystem.gd`: Handles mouse input to deduct `knight_cost` (50 Gold) and instantiate allied units dynamically based on user clicks.

3. **Entity Scripts Implemented**:
   - `BaseUnit.gd`: Handles character movement, basic target acquisition (switching between 'Allies' and 'Enemies' depending on the `is_enemy` export variable), and cooldown-based attacks.
   - `Windmill.gd`: Incorporates the "Wheels Go Round" theme! Handles continuous rotation using `rotation_speed_degrees` and a Timer to generate periodic gold.

> [!TIP]
> All scripts contain exported variables (magic numbers) at the top so you can easily tweak stats like `move_speed = 150`, `knight_cost = 50`, and `spawn_radius = 500` directly in the Godot Editor Inspector without touching code!

## Next Steps in the Editor

The code foundation is laid out, but now it requires the Godot Editor's visual interface to wire up the Scenes (`.tscn` files).

> [!IMPORTANT]
> **Your Next Tasks in Godot Editor:**
> 1. Create a `MainLevel.tscn` (Node2D).
> 2. Create the Node structures for the `WaveSpawner`, `DeploymentSystem`, and `Windmill` and attach the respective scripts we wrote.
> 3. Create the Unit Scenes (`AllyKnight.tscn` and `EnemyGoblin.tscn`), assign them to the "Allies" and "Enemies" Godot Groups, and assign the `BaseUnit.gd` script to them.
> 4. In the Inspector for the Spawner/Deployment system, assign the `AllyKnight` and `EnemyGoblin` PackedScenes to the exported script variables!

Have fun designing the visuals with the Tiny Swords assets, and let me know if you want to add any specific mechanics next!
