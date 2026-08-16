# Start Menu Implementation Guide

Now that we have the `start_menu.gd` script, here is how you build the actual clickable buttons on top of your beautiful island diorama in the Godot Editor!

## 1. Setting up the CanvasLayer
We need a `CanvasLayer` so that the UI stays locked to the screen, even if you decide to move your camera around the island later.

1. Open your `StartMenu.tscn` scene.
2. Right-click the root `StartMenu` node -> **Add Child Node**.
3. Search for and add a **`CanvasLayer`**.

## 2. Adding the UI Layout
We use containers in Godot to keep buttons neatly aligned.

1. Right-click the `CanvasLayer` you just created -> **Add Child Node**.
2. Search for and add a **`VBoxContainer`** (this stacks buttons vertically).
3. Select the `VBoxContainer`. In the viewport, use the anchor tools (at the top toolbar) to position it on the left side, right side, or center of the screen.

## 3. Adding the Buttons
1. Right-click the `VBoxContainer` -> **Add Child Node**.
2. Add a **`Button`**.
3. Rename the button to `PlayButton`.
4. In the Inspector for the button, find the **Text** property and type `PLAY GAME`.
5. (Optional) You can duplicate this button (`Ctrl+D` or `Cmd+D`) to create a `SettingsButton` and `ExitButton`. The `VBoxContainer` will automatically stack them perfectly!

## 4. Connecting the Script
You already have the script `res://Scripts/Systems/start_menu.gd` written. Let's attach it!

1. Select the root node `StartMenu`.
2. At the bottom of the Inspector, drag and drop `start_menu.gd` into the **Script** property.
3. The script is designed to automatically find the `$CanvasLayer/VBoxContainer/PlayButton`. So as long as your tree looks exactly like this, it will work instantly:
```text
StartMenu (Node2D, attached start_menu.gd)
  L CanvasLayer
    L VBoxContainer
      L PlayButton
```

## 5. Testing it
1. Press **Play Scene** (F6).
2. Click the PLAY GAME button.
3. The script will automatically trigger `get_tree().change_scene_to_file(...)` and load your `MainLevel.tscn`!

> [!TIP]
> **Styling the Buttons**: Godot buttons look very basic by default. To make them look like Tiny Swords medieval buttons, select the `PlayButton`, go to the Inspector, scroll down to **Theme Overrides > Styles**, and you can replace the "Normal", "Hover", and "Pressed" styles with the wood/stone UI textures from the Tiny Swords pack!
