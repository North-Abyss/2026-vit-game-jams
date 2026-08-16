# 2026 VIT Game Jam - "Cycles of War"

A 2D Wave Defense game created with the Godot Engine 4.x for the 2026 VIT Game Jam. 

## Theme Integration: "Wheels Go Round"
- **Cycles of War:** The game is driven by endless "cycles" or waves of enemies that grow stronger each rotation.
- **Rotational Economy:** You rely on spinning resource generators (like the Gold Mine) to generate the currency needed to deploy your army cards.

## Credits & Assets
This project utilizes the wonderful open-source assets created by Pixel Frog:
- **Art Assets**: [Tiny Swords by Pixel Frog](https://pixelfrog-assets.itch.io/tiny-swords)
- **UI & Cursors**: The medieval UI, buttons, and custom mouse cursor are natively integrated using Godot's Theme system.
- **Custom Font**: The game UI uses `BoldPixels.ttf`.

## Technical Project Details
- **Engine**: Godot Engine 4.x (Compatibility Renderer recommended for pixel art).
- **Screen & Display Settings**:
  - The project is configured for pixel-perfect scaling.
  - **Stretch Mode**: `viewport` (renders the game at native resolution and scales it up to prevent pixel distortion).
  - **Stretch Aspect**: `expand` (allows the camera view to expand on wider monitors without creating empty black pillar-box bars).

## Project Documentation
Detailed implementation guides and design plans are located in the `Docs/` folder:
- **[Docs/StartMenu_Ideas.md](Docs/StartMenu_Ideas.md)**: Conceptual ideas for the start menu.
- **[Docs/StartMenu_Implementation.md](Docs/StartMenu_Implementation.md)**: How to structure Godot UI containers.
- **[Docs/UI_Styling_Guide.md](Docs/UI_Styling_Guide.md)**: Explains 9-slice scaling, button themes, custom cursors, and custom fonts.
- **[Docs/UI_Flow_Walkthrough.md](Docs/UI_Flow_Walkthrough.md)**: Setup instructions for Scene Transitions, Pause Menu, and Settings overlay.
- **[Docs/TinySwords_TileMap_Architecture.md](Docs/TinySwords_TileMap_Architecture.md)**: A complete breakdown of how to recreate Pixel Frog's advanced 8-layer multi-elevation maps using TileMapLayers.

## Setup and Running
1. Make sure you have [Godot Engine 4+ (or compatible version)](https://godotengine.org/) installed.
2. Clone this repository.
3. Open Godot, click on "Import" and select the `project.godot` file.
4. Press the **Play** button (or F5) to run the game.

## Scripts & Tools
- `gitsync.sh`: A simple automation script to quickly pull, add, commit, and push your changes to the git repository.
