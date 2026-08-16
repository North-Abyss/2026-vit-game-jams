# UI Styling Guide: Buttons & Cursors

Using the built-in Godot default UI looks out of place in a beautiful pixel art game. Thankfully, the *Tiny Swords* asset pack comes with excellent medieval Buttons and Cursors!

Here is how you apply them to your game.

---

## 1. Setting up a Custom Mouse Cursor

You can change the standard white arrow into a gauntlet or a sword pointer! The cursors are located in:
`Assets/Tiny Swords (Free Pack)/Tiny Swords (Free Pack)/UI Elements/UI Elements/Cursors/`

**How to set it globally:**
1. At the top of the Godot Editor, click **Project** -> **Project Settings**.
2. On the left side, scroll down to **Display** and click on **Mouse Cursor**.
3. You will see a setting called **Custom Image**.
4. Click the `<empty>` box and choose **Quick Load** (or drag the file from your FileSystem).
5. Select one of the `Cursor_01.png` to `Cursor_04.png` images.
6. (Optional) You can set the **Custom Image Hotspot**. If your cursor is a pointy sword, you might want to set the hotspot to `x: 0, y: 0` (the top left pixel) so the click happens exactly at the tip of the sword!

---

## 2. Styling the Buttons (Creating a Theme)

Instead of styling every single button one by one, it is highly recommended to create a **Theme** resource. This way, every button in your entire game will automatically use the Tiny Swords graphics!

The button assets are located in:
`Assets/Tiny Swords (Free Pack)/Tiny Swords (Free Pack)/UI Elements/UI Elements/Buttons/`

### Step A: Creating the Theme
1. In your `FileSystem` dock, right-click the `Docs` or `Scenes/UI` folder and select **Create New** -> **Resource**.
2. Search for **`Theme`** and create it. Name it `MainTheme.tres`.
3. Double-click `MainTheme.tres` to open the Theme Editor at the bottom of the screen.

### Step B: Adding the Button Type
1. In the Theme Editor at the bottom, look for the **+ (Add Type)** button on the right side.
2. Select **`Button`** from the list to add button styling to your theme.

### Step C: Setting the Textures
Godot buttons have different states: *Normal* (not doing anything), *Hover* (mouse over it), and *Pressed* (clicked). We need to set a texture for each.

1. In the Theme Editor, select the **Button** tab.
2. Under the **Styles** section, you will see `hover`, `normal`, and `pressed`.
3. Click the `+` icon next to **normal**. Choose **New StyleBoxTexture**.
4. Click on the new `StyleBoxTexture` to open its properties in the Inspector (on the right).
5. Under **Texture**, drag in the `Button_Disable.png` (or `Button_Blue.png`) from the Tiny Swords assets.
6. **CRUCIAL STEP (9-Slice Scaling):** Because buttons can be different sizes (some hold a lot of text, some are small), you must set the Margins so the corners don't stretch!
   - In the `StyleBoxTexture` properties, expand **Texture Margin**.
   - Set Left, Top, Right, and Bottom to **20 pixels** (or whatever fits the asset's border thickness). This tells Godot to stretch the middle of the button but keep the corners perfectly crisp!
7. Repeat this exact process for the **hover** state (maybe use `Button_Hover.png`) and the **pressed** state (maybe use `Button_Pressed.png`).

### Step D: Applying the Theme
Now that your theme is built, you can apply it!
1. Open your `StartMenu.tscn`.
2. Select your root `StartMenu` Node (or the `CanvasLayer`).
3. In the Inspector, find the **Theme** property (under Control or CanvasItem).
4. Drag your new `MainTheme.tres` into this slot.
5. Watch as every button in your menu instantly transforms into a beautiful medieval button!

---

## 3. Adding a Custom Font
To make your text match the pixel art, you should use the `BoldPixels.ttf` font provided in your `Assets/Fonts` folder. You can apply this globally so every button and label uses it!

1. Double-click your `MainTheme.tres` to open the Theme Editor.
2. In the Inspector (on the right), look for the **Default Font** property at the very top.
3. Drag `Assets/Fonts/BoldPixels.ttf` from your FileSystem into the `Default Font` slot.
4. You can also adjust the **Default Font Size** right below it to something that fits your buttons better (like 24 or 32).
5. Now, everything using this theme will automatically use the `BoldPixels` font!
