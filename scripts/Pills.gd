extends Node2D

@export var walls:Walls
@export var tile_size := 16
@export var pill_scene:PackedScene

var max_count := 0
var collected := 0
var pills:Array[Pill]

###

func _ready():
	await get_tree().create_timer(0.25).timeout
	create_all()

###

func create_all():
	max_count = 0
	for y in 12:
		for x in 12:
			if walls.get_cell_atlas_coords(0, Vector2i(x, y)).y == 1: continue
			if pills.any(func(p): return p.x == x and p.y == y): continue
			var pill = pill_scene.instantiate()
			pill.init(x, y, tile_size)
			add_child(pill)
			max_count += 1
			pills.push_back(pill)
	Events.on_pill_count_changed.emit(pills.size())

func collect(pill:Pill):
	pills.erase(pill)
	pill.queue_free()
	collected += 1
	Events.on_pill_count_changed.emit(pills.size(), collected)
	if pills.is_empty() or randf() < 0.05:
		create_all()
