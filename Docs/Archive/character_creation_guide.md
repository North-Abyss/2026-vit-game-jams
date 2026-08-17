# 🛡️ Character & Pathfinding Creation Guide

Welcome to the Clash of Clans troop manager! I have completely updated your `BaseUnit.gd` AI script. It now handles **Auto-Animations**, **Smart Pathfinding**, and **Target Prioritization** (e.g., Enemies will attack your troops before they attack your buildings).

Follow these steps to set up your troops and your game map!

---

## Part 1: Setting up the Map for Pathfinding
For your troops to know how to walk around water and cliffs, you need to "paint" the walkable grass on your `MainLevel`.

1. Open your `MainLevel.tscn`.
2. Select your `TileMapLayer` (or `TileMap`).
3. On the right side, in the **Inspector**, go to **Tile Set**.
4. Expand **Navigation Layers** and click **Add Element**.
5. At the bottom of the Godot Editor, click the **TileSet** panel.
6. Go to the **Paint** tab, select **Navigation Layer 0**, and click on all your Grass tiles to paint them red.
   > [!TIP]
   > Godot's `NavigationAgent2D` will now automatically route your troops across these red-painted tiles, totally avoiding the water and cliffs!

---

## Part 2: Creating a New Troop
You have already imported your characters (like the `gobline.tscn`). Here is how you turn them into smart, autonomous fighters:

1. **Open the Scene:** Open `Scenes/Entities/Enemies/goblin/gobline.tscn`.
2. **Attach the Brain:** Select the top root node (`gobline`). Drag and drop `Scripts/Entities/Units/BaseUnit.gd` onto it.
3. **Configure the Stats:** Look at the Inspector on the right. You will see new variables:
   - **`Move Speed`**: Set how fast they run.
   - **`Max Health` & `Attack Damage`**: Adjust their strength.
4. **Set the Role:**
   - If this is an **Enemy** (like a Goblin), check the `Is Enemy` box!
   - If this is a **Worker** (like a Blue Pawn), check the `Is Worker` box!
5. **Animation Names:**
   - The script will automatically play animations, but they must be named correctly in your `AnimatedSprite2D` node!
   - Make sure your animations are exactly named: `"Idle"`, `"Run"`, `"Attack1"`, and `"Mine"` (if it's a worker).

---

## Part 3: Deploying Troops
Now that your troops have brains, how do you spawn them?

1. Open your `CardUI.tscn` (or select the card in your `StartMenu` if you built the Deployment Slider there).
2. Look at the Inspector for the Card script.
3. Drag your smart `gobline.tscn` (or Blue Knight scene) into the **Unit Scene** slot.
4. Set the **Cost Amount** and whether it costs **Gold** or **Meat**.

> [!NOTE]
> That's it! When you play the game, click the card, and click the grass. The troop will spawn, immediately scan its surroundings using its massive 400-pixel radar, find the nearest enemy or gold mine, and run straight there!
