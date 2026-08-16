# Resolution and Auto-Tiling Guide for 64px Tiles

## 1. Optimal Canvas Size (Resolution) for 64px Tiles

When working with exactly 64x64 pixel tiles, you want a window resolution that is perfectly divisible by 64 while maintaining a standard **16:9** aspect ratio. 

The perfect base resolution for this is **1024 x 576**.
- **Width:** 1024 / 64 = exactly **16 tiles** wide.
- **Height:** 576 / 64 = exactly **9 tiles** high.

*(I have updated your `project.godot` to use this window size automatically!)*

### How scaling works in Godot:
Because 1024x576 is a perfect 16:9 ratio, if the player plays the game in Fullscreen on a 1920x1080 monitor, the game will scale up cleanly without black bars, and your 64px tiles will still look perfectly crisp. The project settings have been set to `stretch/mode = "canvas_items"` and `stretch/aspect = "keep"`.

---

## 2. Setting Up Auto-Tiling (Godot 4 "Terrains")

In Godot 4, "Auto-Tiling" is now called **Terrains**. Here is exactly how to set it up for your Tiny Swords tilesets:

### Step A: Configure the TileSet
1. Select your `TileMapLayer` node (e.g., `GroundLayer`).
2. In the Inspector, click on your `TileSet` resource to expand its properties.
3. Under **Tile Size**, set it to `x: 64, y: 64`.
4. Scroll down and find **Terrain Sets**. Click **Add Element**.
5. Inside the new Terrain Set 0, find **Terrains** and click **Add Element**. 
6. Name this terrain "Grass". Set a color for it (e.g., green).

### Step B: "Paint" the Tile Bitmasks
1. Look at the bottom of your Godot Editor to find the **TileSet** panel.
2. Go to the **TileSet** tab at the bottom, and select your imported Tiny Swords texture atlas.
3. Click on the **Paint** tab (the brush icon) in the middle toolbar of the TileSet panel.
4. In the "Paint Properties" dropdown, select **Terrains > Terrain Set 0**.
5. Choose your "Grass" terrain from the list.
6. Now, click and drag over the tiles in your tilesheet to assign the "bits". 
   - *Example:* For a central grass tile, paint the middle and all sides. For a top-edge tile, paint the bottom half. Godot will visually show connecting lines!

### Step C: Drawing the Auto-Tiles
1. Switch to the **TileMap** panel at the very bottom of the editor.
2. Select the **Terrains** tab (instead of the default Tiles tab).
3. Select your "Grass" terrain.
4. Click and drag in the actual level viewport. Godot will automatically pick the correct corners, edges, and center tiles from the bitmask you painted!

---

## 3. Tiny Swords Specific Layout Breakdown

The *Tiny Swords* terrain tilesets (like `Tilemap_color4.png` and the water assets) are designed to be layered on top of each other. Here is how the assets "break down" and how you should organize them:

### Layer 1: The Sea Background (Lowest Layer)
- **Asset**: `Water Background color.png`
- **How to use**: This is just a solid block of color. You don't even need to auto-tile this! You can either fill a `TileMapLayer` entirely with this single tile, or just create a `ColorRect` node at the back of your scene, stretch it across the whole screen, and set its color to match the water.

### Layer 2: Animated Water Foam
- **Asset**: `Water Foam.png`
- **How to use**: This is an animated spritesheet. In your `TileSet` setup at the bottom, when you add this image, you can tell Godot it is animated! 
- Go to the **TileSet** tab -> Select the Foam image.
- Look at the "Setup" properties for that tile, go to **Animation**, and set the columns/frames to create a looping animation.
- *Where to paint it*: You manually paint this animated tile around the edges of your islands to make the water look alive!

### Layer 3: Grass Islands & Cliffs (The "Walls")
- **Asset**: `Tilemap_color1.png` through `5`
- **How to use**: The spritesheet is split into two main sections:
  - **The Left 3x3 Block**: This is the "elevated" island. The bottom row of this 3x3 block includes the cliff "walls" dropping down into the sea. This is the main block you should use for your **Terrains** bitmask (exactly as you started doing in your screenshot!).
  - **The Tiles below the left 3x3**: These are extra-long cliff walls. You usually place these *manually* underneath your auto-tiled islands if you want a taller cliff.
  - **The Right 3x3 Block**: This is flat ground (no cliffs). It represents ground that transitions smoothly into water or sand without a drop-off. You can create a *second* Terrain called "Flat Grass" and paint this right block if you want beaches!

**The Plan for your Islands**:
1. Have your `Sea Background` layer at the bottom.
2. Use your `Grass` Terrain (the left 3x3 block you painted) to draw floating islands. Because of how the tiles are drawn, the bottom edges will automatically look like cliffs/walls!
3. Add a `TileMapLayer` on top for `Foam`, and manually paint the animated foam tiles around the edges of the islands where the grass meets the water.
