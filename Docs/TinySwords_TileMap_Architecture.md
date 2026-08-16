# Tiny Swords TileMap Architecture Plan

Thanks to the official Devlog guide by Pixel Frog, we have the exact layered architecture needed to recreate the beautiful multi-level maps!

## 1. The Official Layer Stack (Godot Scene Tree)

To achieve the overlapping cliffs and shadows exactly as intended by the artist, you need up to **9 layers** (depending on how high your cliffs go). In Godot 4, you achieve this by creating 9 `TileMapLayer` nodes as children of your `MainLevel`, ordered exactly like this (from top to bottom in the scene tree):

- **`Layer 0: BG Color`** (Z-Index 0) - A simple `ColorRect` or a `TileMapLayer` filled with the base sea color.
- **`Layer 1: Water Foam`** (Z-Index 1) - `TileMapLayer` for painting the animated foam edges where land meets water.
- **`Layer 2: Flat Ground`** (Z-Index 2) - `TileMapLayer` using the "Flat Ground" terrain (sea-level grass/beaches).
- **`Layer 3: Shadow`** (Z-Index 3) - `TileMapLayer` used to place the 128x128 drop-shadow sprite beneath the first cliff layer.
- **`Layer 4: Elevated Ground L1`** (Z-Index 4) - `TileMapLayer` for your first raised island.
- **`Layer 5: Shadow`** (Z-Index 5) - Shadows for the second cliff.
- **`Layer 6: Elevated Ground L2`** (Z-Index 6) - The second story of cliffs.
- **`Layer 7: Shadow`** (Z-Index 7) - Shadows for the third cliff.
- **`Layer 8: Elevated Ground L3`** (Z-Index 8) - The third story of cliffs.

*(Be sure to enable `Y Sort Enabled` on Layers 4, 6, and 8 so your units can walk behind the cliffs properly!)*

---

## 2. Setting up the Terrains (Auto-Tiling)

As shown in the devlog image, the `Flat Ground Tilemap` (and the Elevated Ground) uses a standard 16-tile configuration.

### How to set up the 16-Tile Bitmask:
When you create your Terrain in the `TileSet` panel and start painting the "bits", you need to match the 16 tiles shown in the devlog:
- **Tiles 1-9**: Paint the 3x3 block just like you did. The corners get corner bits, the edges get edge bits, and the center gets a full 3x3 bit.
- **Tiles 10-12**: Paint these as a horizontal path (left edge, center, right edge).
- **Tiles 13-15**: Paint these as a vertical path (top edge, center, bottom edge).
- **Tile 16**: Paint just the center bit (this acts as a single, isolated 1x1 island).

You should create **two** separate Terrains in Godot:
1. **Flat Ground Terrain**: Paint the bitmask over the "Flat Ground" block on the right side of the spritesheet.
2. **Elevated Ground Terrain**: Paint the exact same bitmask pattern over the "Elevated Ground" block on the left side of the spritesheet (the one with the cliff bottoms).

---

## 3. Shadows & Foam

**The Shadow System**:
The devlog reveals a clever trick for depth! There is a 128x128 `Shadow.png` sprite. 
Because your tiles are 64x64, the shadow sprite is exactly 2x2 tiles large. 
You place this shadow on your `Shadow` layers, directly underneath the corners and edges of your Elevated Ground, to cast a dark shadow onto the flat ground or the water below it.

**The Foam Animation (How to Animate a Tile in Godot 4)**:
The foam is painted manually on `Layer 1` along the edges where the ground meets the sea. Here is exactly how to set up the animated tile for `Water Foam.png`:
1. In the **TileSet** panel at the bottom of the editor, click the **Setup** tab and drag `Water Foam.png` into the sources. Ensure the Tile Size is correct (e.g., 64x64).
2. Switch to the **Select** tab (next to Setup/Paint).
3. Click on the very first frame of the foam animation in the image.
4. On the right side of the panel under "Selected Tile", expand the **Animation** dropdown.
5. Change **Columns** to the number of frames the animation has (count how many foam tiles are in the row, e.g., 4 or 8).
6. Adjust the **Speed** (fps) to make the foam wave naturally (e.g., `5.0`).
7. Switch to the **TileMap** panel, select your `FoamLayer`, and paint that first tile! Godot will automatically play the animation frames in the game.
