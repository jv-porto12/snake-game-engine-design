extends Node2D

@onready var snake = $Snake
@onready var move_timer: Timer = $MoveTimer
@onready var game_over_label: Label = $CanvasLayer/HUD/GameOverLabel


func _ready() -> void:
	move_timer.timeout.connect(_on_move_timer_timeout)
	snake.snake_died.connect(_on_snake_died)

	game_over_label.hide()
	move_timer.start()


func _on_move_timer_timeout() -> void:
	snake.move()


func _on_snake_died() -> void:
	move_timer.stop()
	game_over_label.show()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("restart"):
		restart_game()


func restart_game() -> void:
	snake.reset_snake()
	game_over_label.hide()
	move_timer.start()
