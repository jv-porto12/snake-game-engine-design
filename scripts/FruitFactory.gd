class_name FruitFactory
extends RefCounted

enum FruitType {
	NORMAL,
	BONUS
}

static func create_fruit(
	type: FruitType,
	grid_pos: Vector2i
) -> FruitBase:

	var fruit: FruitBase

	match type:
		FruitType.BONUS:
			fruit = BonusFruit.new()
		_:
			fruit = NormalFruit.new()

	fruit.setup(grid_pos)

	return fruit
