--- OOP ---
I used inheritance with FruitBase as the parent class and NormalFruit and BonusFruit as child classes. Polymorphism is shown through the get_points() function, which returns different values depending on the fruit type.

--- Singleton ---
A singleton allows scripts to access the same instance globally. I used two Autoloads:
- GameManager - Handles game state and game over.
- ScoreManager - Tracks the score and updates the UI.

This keeps shared information in one place instead of repeating it in different scripts.

--- Factory ---
FruitFactory handles creating the different fruit types. This makes it easier to add more fruit types later without changing the main game logic.

Resources
- Godot Documentation: https://docs.godotengine.org/
