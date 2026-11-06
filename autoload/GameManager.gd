extends Node

signal game_over
signal game_started

var is_game_over: bool = false
var is_playing: bool = false


func start_game() -> void:
	is_game_over = false
	is_playing = true
	game_started.emit()


func end_game() -> void:
	if is_game_over:
		return

	is_game_over = true
	is_playing = false
	game_over.emit()


func can_move() -> bool:
	return is_playing and not is_game_over
