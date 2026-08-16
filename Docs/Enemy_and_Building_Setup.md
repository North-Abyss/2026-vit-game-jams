# Enemies, Buildings, and Resources Setup Guide

## 1. Why Buildings & Resources CANNOT be TileMap Tiles
In your message, you mentioned you used the **Decoration TileSet** to paint Gold Mines and Trees onto your map. 

**For an Auto-Battler game, this will not work!** 
Why? Because Godot TileMaps are just static images merged into a single grid. The AI troops cannot target a tile, they cannot deal "damage" to a tile, and a tile cannot have a script attached to it to drop Gold or Meat. 

**The Solution:**
Instead of painting Gold Mines and Trees using the TileMap, you must create them as **Individual Scenes** (just like the Sheep!). 

### How to make a Gold Mine Scene:
1. Create a new Scene with a `StaticBody2D` root node. Name it `GoldMine`.
2. Attach the `res://Scripts/Entities/Buildings/GoldMine.gd` script to it.
3. Add a `Sprite2D` child. Look in `Assets/Tiny Swords/Terrain/Resources/` and drag the Gold Mine texture into the Sprite.
4. Add a `CollisionShape2D` so troops can bump into it.
5. **CRITICAL**: Go to the **Groups** tab and add this node to the `"Resources"` group!
6. Save it as `res://Scenes/Entities/Buildings/GoldMine.tscn`. 

Now, instead of painting gold mines on your TileMap, you just drag and drop this `GoldMine.tscn` scene directly onto your `MainLevel.tscn`. Your Blue Pawns will instantly be able to detect it, run to it, and harvest gold!

---

## 2. Setting up the Enemy Spawner
I wrote the `EnemySpawner.gd` script to automatically generate waves of red troops. Here is how to use it:

1. Open your `MainLevel.tscn`.
2. Right-click your root node and select **Add Child Node**. Add a basic `Node2D`.
3. Name it `EnemySpawner`.
4. Look at the Inspector on the right, scroll to the bottom, and attach the `res://Scripts/Systems/EnemySpawner.gd` script.
5. In the script properties in the Inspector, you will see a slot for **Enemy Scene**.
6. Drag your Red Goblin scene (or whatever red enemy troop you built) into that slot!
7. Adjust the `Spawn Radius` (e.g., 800) so they spawn far away at the edges of the map.

**How it works:** When you press play, every 20 seconds, the spawner will create 3 Goblins at the edge of the map. Because you attached the `BaseUnit.gd` script to the Goblins and checked `Is Enemy = true`, they will instantly use their radar to find your Blue troops or Gold Mines and run towards them to attack!
