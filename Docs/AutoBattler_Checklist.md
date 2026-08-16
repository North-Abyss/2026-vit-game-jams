# Auto-Battler Setup Checklist

We have written all the scripts for the Clash of Clans mechanics! Now we need to create the actual UI screens in the Godot Editor so the player can click them.

Here is exactly what is missing and how to build it:

## 1. Create `CardUI.tscn`
This is the clickable button that allows the player to spawn a troop.

1. **Create Scene**: Create a new Scene with a `Button` (or `TextureButton`) as the root node. Name it `CardUI`.
2. **Attach Script**: Attach the `res://Scripts/UI/CardUI.gd` script to it.
3. **Build the UI**: 
   - Add a `TextureRect` child to display the icon of the troop (e.g., a Sword icon).
   - Add a `Label` child at the bottom to display the cost (e.g., "50 Meat").
4. **Configure Script Stats**: Select the `CardUI` root node, go to the Inspector, and set:
   - **Unit Name**: (e.g., "Goblin")
   - **Cost Amount**: (e.g., 50)
   - **Cost Type**: (Gold or Meat)
   - **Unit Scene**: Drag and drop your `gobline.tscn` into this slot!
5. **Save**: Save the scene in `res://Scenes/UI/CardUI.tscn`.

## 2. Create the `DeploymentBar`
This is the scrollable slider at the bottom of the screen that holds all your Cards.

1. **Create Scene**: Open your `player.tscn` (or `MainLevel.tscn`).
2. **Add ScrollContainer**: Inside your `UI` CanvasLayer, add a `ScrollContainer` node. Place it at the very bottom of the screen.
3. **Add HBoxContainer**: Add an `HBoxContainer` as a child of the `ScrollContainer`.
4. **Add Cards**: Drag and drop your new `CardUI.tscn` into the `HBoxContainer` multiple times! (One for each troop you have).
5. **Save**: Save your main scene.

## 3. Attach the Deployment System
The global system that handles deducting money and spawning the troops on the map.

1. **Add Node**: In your `MainLevel.tscn`, create an empty `Node2D` and name it `DeploymentSystem`.
2. **Attach Script**: Attach the `res://Scripts/Systems/DeploymentSystem.gd` script to it.

## 4. Play the Game!
- Run the game.
- Click a Card in your bottom Deployment Bar.
- Click anywhere on the grass.
- Watch your troop spawn, deduct resources, and automatically run to fight enemies or farm sheep!

## 5. Create the Top HUD (Resources)
This will display your current Gold, Meat, and Wave number at the top of the screen.

1. **Create Scene**: Create a new Scene with a `Control` (or `CanvasLayer`) as the root node. Name it `TopHUD`.
2. **Attach Script**: Attach the `res://Scripts/UI/TopHUD.gd` script to it.
3. **Build the UI**:
   - Add a `HBoxContainer` at the top of the screen.
   - Inside it, add two `HBoxContainer`s (name them `GoldContainer` and `MeatContainer`).
   - Inside each, add a `TextureRect` (for the Gold/Meat icon) and a `Label` (name them `GoldLabel` and `MeatLabel`).
   - Add a separate `Label` for the wave (name it `WaveLabel`).
4. **Save and Instantiate**: Save it as `res://Scenes/UI/TopHUD.tscn`. Drop this scene into your `player.tscn`'s UI CanvasLayer! It will automatically connect to the `GameManager` and update your money whenever a Gold Mine or Sheep generates resources!

## 6. Auto-Spawn Sheep on Grass
You can automatically scatter 20 sheep randomly across the playable, painted grass terrain when the game starts!

1. **Create Node**: In your `MainLevel.tscn`, create an empty `Node2D` and name it `SheepSpawner`.
2. **Attach Script**: Attach the new `res://Scripts/Systems/SheepSpawner.gd` script I just wrote for you!
3. **Configure**: Select the `SheepSpawner` node. In the Inspector, drag and drop your `Sheep.tscn` into the **Sheep Scene** slot. You can also adjust the number of sheep you want (default is 20).
4. **Play**: When you start the game, Godot will look at your navigation map and instantly teleport the 20 sheep randomly across all valid grass tiles!
