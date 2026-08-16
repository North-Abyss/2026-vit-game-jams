# Godot Editor Guide: Assembling "Cycles of War"

This guide outlines exactly how to organize your scenes, attach the scripts we created, and build the game inside the Godot Editor.

## 1. Project Organization Overview

When you open Godot, look at your **FileSystem dock** (bottom left). You will see the folders we created:
- `Scenes/` (Empty for now, you will save your `.tscn` files here)
- `Scripts/` (Contains the `.gd` files we already wrote)
- `Assets/` (Contains your Tiny Swords pack)

Always save your scenes into their matching folder under `Scenes/` (e.g., save the UI into `Scenes/UI/`).

---

## 2. Setting Up the Main Level (`MainLevel.tscn`) & Top-Down TileMaps

In newer Godot 4.x versions (Godot 4.3+), the old `TileMap` node is deprecated in favor of **`TileMapLayer`**. To get a proper top-down perspective where units can walk *behind* trees or walls, we use **Y-Sorting**.

1. Click **Scene > New Scene**.
2. Select **2D Scene** (creates a `Node2D` as the root). Rename it to `MainLevel`.
3. **Enable Y-Sorting on the Root:** Click `MainLevel`, go to the Inspector under **Ordering**, and check **Y Sort Enabled**.
4. Save the scene to `res://Scenes/Levels/MainLevel.tscn`.

### Creating the TileMapLayers
Instead of one node with internal layers, we create multiple `TileMapLayer` nodes for different depth heights:

1. Add a **`TileMapLayer`** node as a child of `MainLevel`. Rename it to `GroundLayer` (for grass/dirt).
   - In the Inspector, create a new `TileSet` resource and set up your Tiny Swords terrain tiles.
   - Make sure **Y Sort Enabled** is checked.
   - Set **Z Index** to 0.
2. Add another **`TileMapLayer`** as a child of `MainLevel`. Rename it to `ObjectsLayer` (for trees, walls, rocks).
   - In the Inspector, assign the *exact same* `TileSet` resource you created for the Ground.
   - Check **Y Sort Enabled**.
   - Set **Z Index** to 1.

> [!TIP]
> For the top-down Y-Sorting to work perfectly on your characters, you must also go into their scenes (`AllyKnight.tscn` and `EnemyGoblin.tscn`), select their `CharacterBody2D` root, and check **Y Sort Enabled** under the Ordering section! This ensures they appear correctly in front of or behind your TileMapLayer objects based on their vertical position.

---

## 3. Creating the Core Systems

We need to add our Spawner and Deployment systems into the `MainLevel`.

### The Wave Spawner
1. Right-click the `MainLevel` root node and select **Add Child Node**.
2. Add a `Node2D` and rename it `WaveSpawner`.
3. In the Inspector (right side), go to the **Script** property and drag `res://Scripts/Systems/WaveSpawner.gd` into it.
4. Move the `WaveSpawner` node to the very center of your map.

### The Deployment System
1. Right-click the `MainLevel` root node and select **Add Child Node**.
2. Add a `Node2D` and rename it `DeploymentSystem`.
3. Attach the script `res://Scripts/Systems/DeploymentSystem.gd` to it.

---

## 4. Creating the Units (`BaseUnit.gd`)

We need to create the actual visual characters that will fight. 

### Ally Knight (`AllyKnight.tscn`)
1. Create a **New Scene**.
2. Select **Other Node** -> choose `CharacterBody2D`.
3. Rename it to `AllyKnight`.
4. Add a `CollisionShape2D` as a child and give it a Circle shape.
5. Add an `AnimatedSprite2D` (or `Sprite2D`) and set up the Knight animation from Tiny Swords.
6. Attach the script `res://Scripts/Entities/Units/BaseUnit.gd`.
7. Go to the **Node tab** (next to Inspector) -> **Groups**. Type `Allies` and click **Add**.
8. Save as `res://Scenes/Entities/Units/AllyKnight.tscn`.

### Enemy Goblin (`EnemyGoblin.tscn`)
1. Create a **New Scene** using a `CharacterBody2D` root named `EnemyGoblin`.
2. Add `CollisionShape2D` and your Goblin `Sprite2D`.
3. Attach the *same script*: `res://Scripts/Entities/Units/BaseUnit.gd`.
4. In the Inspector for the script, **check the box for `Is Enemy`** (this is one of our "magic numbers").
5. Go to the **Node tab** -> **Groups**. Type `Enemies` and click **Add**.
6. Save as `res://Scenes/Entities/Units/EnemyGoblin.tscn`.

---

## 5. Wiring the Systems Together (The "Magic Numbers")

Now you need to tell the Spawner and Deployment system which units to use.

1. Open `MainLevel.tscn`.
2. Click on the `WaveSpawner` node. Look at the Inspector.
3. You will see an `Enemy Scene` property. Drag `EnemyGoblin.tscn` from the FileSystem into this slot.
4. You can also adjust the magic numbers here (e.g., change `Spawn Radius` from 500 to 300, or `Base Enemies Per Wave` from 5 to 10).
5. Click on the `DeploymentSystem` node.
6. In the Inspector, find the `Ally Scene` property and drag `AllyKnight.tscn` into it.

---

## 6. Creating the Windmill (`Windmill.tscn`)

1. Create a **New Scene** with a `Node2D` root. Rename it `Windmill`.
2. Attach `res://Scripts/Entities/Buildings/Windmill.gd`.
3. Add a `Sprite2D` child. Name it **exactly** `Blades`.
4. Assign the Tiny Swords windmill blades texture to the `Blades` sprite.
5. Add another `Sprite2D` for the Windmill base (make sure it's *behind* the blades).
6. Save as `res://Scenes/Entities/Buildings/Windmill.tscn`.
7. Go back to `MainLevel.tscn` and drag the `Windmill.tscn` file directly onto the map to place a few windmills around!

---

## 7. Testing Your Game

1. In the top right of the Godot Editor, click the **Play** button (or hit F5).
2. It will ask you to select a Main Scene. Choose `res://Scenes/Levels/MainLevel.tscn`.
3. Once the game runs:
   - Click anywhere on the map to spend 50 gold and spawn a Knight.
   - Wait 10 seconds, and the WaveSpawner will start creating Goblins in a circle around the center.
   - Knights and Goblins will automatically move towards each other and attack!
