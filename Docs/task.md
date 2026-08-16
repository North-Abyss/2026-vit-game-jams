# Waves Defense Game Tasks

- `[x]` 1. **Directory Setup**
  - `[x]` Create `Scenes/UI`, `Scenes/Core`, `Scenes/Levels`, `Scenes/Systems`, `Scenes/Entities/Units`, `Scenes/Entities/Buildings`.
  - `[x]` Create `Scripts/UI`, `Scripts/Core`, `Scripts/Systems`, `Scripts/Entities/Units`, `Scripts/Entities/Buildings`.
- `[x]` 2. **Implement Core Scripts**
  - `[x]` Create `GameManager.gd` (Autoload skeleton).
  - `[x]` Create `WaveSpawner.gd`.
  - `[x]` Create `DeploymentSystem.gd`.
- `[/]` 3. **Implement Unit Scripts**
  - `[ ]` Create `BaseUnit.gd` for movement and combat.
  - `[ ]` Create `Windmill.gd` for resource generation.
- `[x]` 4. **Setup Godot Scenes (Editor Phase)**
  - `[x]` (Delegated to user) Create `MainLevel.tscn` and wire it up.
  - `[x]` (Delegated to user) Create `MainMenu.tscn`.
- `[x]` 5. **Testing & Verification**
  - `[x]` (Delegated to user) Ensure units spawn and attack.
  - `[x]` (Delegated to user) Ensure windmills generate gold over time.
