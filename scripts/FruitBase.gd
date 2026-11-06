class_name FruitBase
extends Node2D

const CELL_SIZE: int = 32

var grid_position: Vector2i = Vector2i.ZERO
var fruit_color: Color = Color.RED


func get_points() -> int:
	return 0


func setup(position_on_grid: Vector2i) -> void:
	grid_position = position_on_grid
	position = Vector2(grid_position * CELL_SIZE)
	queue_redraw()


func _draw() -> void:
	draw_rect(
		Rect2(2, 2, CELL_SIZE - 4, CELL_SIZE - 4),
		fruit_color
	)
