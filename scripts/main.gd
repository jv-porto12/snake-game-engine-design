extends Node2D

@onready var snake = $Snake
@onready var fruit_container: Node2D = $FruitContainer
@onready var score_label: Label = $CanvasLayer/HUD/ScoreLabel
@onready var move_timer: Timer = $MoveTimer
@onready var game_over_label: Label = $CanvasLayer/HUD/GameOverLabel

var current_fruit: FruitBase
var score: int = 0

func _ready() -> void:
	randomize()

	move_timer.timeout.connect(_on_move_timer_timeout)
	snake.snake_died.connect(_on_snake_died)
	snake.food_eaten.connect(_on_food_eaten)

	game_over_label.hide()
	score_label.text = "Score: 0"

	spawn_fruit()
	move_timer.start()

func _on_move_timer_timeout() -> void:
	snake.move()


func _on_snake_died() -> void:
	move_timer.stop()
	game_over_label.text = "GAME OVER - Press R to Restart"
	game_over_label.show()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("restart"):
		restart_game()


func restart_game() -> void:
	move_timer.stop()

	if is_instance_valid(current_fruit):
		current_fruit.queue_free()
		current_fruit = null

	score = 0
	score_label.text = "Score: 0"

	snake.reset_snake()
	game_over_label.hide()

	spawn_fruit()

	if not game_over_label.visible:
		move_timer.start()
	
func _on_food_eaten() -> void:
	score += current_fruit.get_points()
	score_label.text = "Score: " + str(score)
	spawn_fruit()
	
func spawn_fruit() -> void:
	if is_instance_valid(current_fruit):
		current_fruit.queue_free()

	var empty_cells: Array[Vector2i] = []

	for x in range(snake.GRID_WIDTH):
		for y in range(snake.GRID_HEIGHT):
			var cell := Vector2i(x, y)

			if cell not in snake.body:
				empty_cells.append(cell)

	if empty_cells.is_empty():
		move_timer.stop()
		game_over_label.text = "YOU WIN!"
		game_over_label.show()
		return

	var spawn_position: Vector2i = empty_cells.pick_random()

	var fruit_type: FruitFactory.FruitType = FruitFactory.FruitType.NORMAL

	# Approximately 20% chance of bonus fruit.
	if randf() < 0.2:
		fruit_type = FruitFactory.FruitType.BONUS

	current_fruit = FruitFactory.create_fruit(
		fruit_type,
		spawn_position
	)

	fruit_container.add_child(current_fruit)
	snake.set_food_position(spawn_position)
