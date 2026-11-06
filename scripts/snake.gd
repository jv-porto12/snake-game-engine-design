
extends Node2D

signal snake_died
signal food_eaten

const CELL_SIZE: int = 32
const GRID_WIDTH: int = 25
const GRID_HEIGHT: int = 20

var body: Array[Vector2i] = []
var direction: Vector2i = Vector2i.RIGHT
var next_direction: Vector2i = Vector2i.RIGHT

var food_position: Vector2i = Vector2i(-1, -1)
var alive: bool = true


func _ready() -> void:
	reset_snake()


func reset_snake() -> void:
	body = [
		Vector2i(5, 10),
		Vector2i(4, 10),
		Vector2i(3, 10)
	]

	direction = Vector2i.RIGHT
	next_direction = Vector2i.RIGHT
	alive = true
	queue_redraw()


func _process(_delta: float) -> void:
	if not alive:
		return

	if Input.is_action_just_pressed("move_up"):
		change_direction(Vector2i.UP)
	elif Input.is_action_just_pressed("move_down"):
		change_direction(Vector2i.DOWN)
	elif Input.is_action_just_pressed("move_left"):
		change_direction(Vector2i.LEFT)
	elif Input.is_action_just_pressed("move_right"):
		change_direction(Vector2i.RIGHT)


func change_direction(new_direction: Vector2i) -> void:
	if new_direction != -direction:
		next_direction = new_direction


func move() -> void:
	if not alive:
		return

	direction = next_direction
	var new_head: Vector2i = body[0] + direction

	# Check wall collisions.
	if new_head.x < 0 or new_head.x >= GRID_WIDTH:
		die()
		return

	if new_head.y < 0 or new_head.y >= GRID_HEIGHT:
		die()
		return

	var eating: bool = new_head == food_position

	# Moving into the tail's previous cell is legal
	# when the tail is about to move away.
	var collision_length: int = body.size()
	if not eating:
		collision_length -= 1

	for i in range(collision_length):
		if new_head == body[i]:
			die()
			return

	body.push_front(new_head)

	if eating:
		food_eaten.emit()
	else:
		body.pop_back()

	queue_redraw()


func die() -> void:
	alive = false
	snake_died.emit()


func set_food_position(pos: Vector2i) -> void:
	food_position = pos


func _draw() -> void:
	for i in range(body.size()):
		var segment: Vector2i = body[i]
		var rect := Rect2(
			Vector2(segment * CELL_SIZE),
			Vector2(CELL_SIZE - 2, CELL_SIZE - 2)
		)

		var color: Color = Color(0.2, 0.9, 0.3)

		if i == 0:
			color = Color(0.1, 0.6, 0.2)

		draw_rect(rect, color)
