extends Node2D

var velocity:Vector2

func _process(delta:float):
	position += velocity * delta * Walls.TILE_SIZE * 10
	if position.x < 0 or position.x > 320 or position.y < 0 or position.y > 200:
		queue_free()
