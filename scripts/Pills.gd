extends Node2D

@export var walls:Walls
@export var tile_size := 16
@export var pill_scene:PackedScene

func _ready():
	for y in 12:
		for x in 12:
			if walls.get_cell_atlas_coords(0, Vector2i(x, y)).y == 1: continue
			var pill = pill_scene.instantiate()
			pill.position = Vector2(0.5 + x, 0.5 + y) * tile_size
			add_child(pill)
