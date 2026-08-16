# Phase 3 UI Walkthrough: Transitions & Menus

I have written the underlying GDScript for your Scene Transitions, Pause Menu, and Settings Menu! Now we just need to hook them up in the Godot Editor.

## 1. Scene Transition (The Fade Effect)
This system uses a Singleton (Autoload) to keep it alive across all levels.

1. **Create the Scene**: Create a new Scene with a `CanvasLayer` root node. Name it `SceneTransition`. In the Inspector, set its **Layer** property to `100` (this ensures the fade effect draws *on top* of all your buttons!).
2. **Attach Script**: Attach `res://Scripts/Core/SceneTransition.gd` to the root.
3. **Add ColorRect**: Add a `ColorRect` child node. Set its color to Black (`#000000`). Make sure it covers the whole screen (set anchors to "Full Rect").
4. **Add AnimationPlayer**: Add an `AnimationPlayer` child node. Create two simple animations:
   - `fade_to_black`: Animates the `ColorRect`'s Modulate Alpha property from 0 (invisible) to 1 (solid black) over 0.5 seconds.
   - `fade_to_normal`: Animates the `ColorRect`'s Modulate Alpha property from 1 to 0 over 0.5 seconds.
5. **Save the Scene**: Save it as `res://Scenes/Core/SceneTransition.tscn`.
6. **Autoload It**: Go to **Project > Project Settings > Autoload**. Select your `SceneTransition.tscn` file, ensure the Node Name is `SceneTransition`, and click **Add**.

## 2. Pause Menu
1. **Create the Scene**: Create a new Scene with a `CanvasLayer` root node. Name it `PauseMenu`.
2. **Attach Script**: Attach `res://Scripts/UI/PauseMenu.gd` to the root.
3. **CRITICAL SETTING**: Select the `PauseMenu` root node. In the Inspector, go to **Node > Process > Mode** and set it to **Always**. *(If you leave it on Inherit, the pause menu won't be able to listen for your "unpause" click because the game is frozen!)*
4. **Build the UI**: Add a `ColorRect` (semi-transparent black for a background overlay), and a `VBoxContainer` with three `Button`s: `ResumeButton`, `SettingsButton`, `QuitButton`.
5. **Save and Instantiate**: Save it as `res://Scenes/UI/PauseMenu.tscn`. You can now drop this scene into your `MainLevel.tscn`! Pressing 'Escape' will pause the game.

## 3. Settings Menu
1. **Create the Scene**: Create a new Scene with a `CanvasLayer` root node. Name it `SettingsMenu`.
2. **Attach Script**: Attach `res://Scripts/UI/SettingsMenu.gd` to the root.
3. **Build the UI**: Add a `Panel` or `ColorRect` for the background, a `VBoxContainer`, some `HSlider`s for volume, and a `BackButton`.
4. **Save**: Save it as `res://Scenes/UI/SettingsMenu.tscn`. You can instantiate this inside both your `StartMenu.tscn` and your `PauseMenu.tscn`. When the user clicks the "Settings" button on either menu, simply call `settings_menu.show()`!
