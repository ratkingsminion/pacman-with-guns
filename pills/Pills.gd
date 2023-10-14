extends Node2D

@export var pill_scene:PackedScene

@onready var walls:Walls = $/root/Main/GAME/Walls

var max_count := 0
var collected := 0
var all_pills:Dictionary # [Vector2i, Pill]

###

func _ready():
	create_all()

###

func create_all():
	max_count = 0
	for y in 12:
		for x in 12:
			if walls.get_cell_atlas_coords(0, Vector2i(x, y)).y == 1: continue
			var coords := Vector2i(x, y)
			if all_pills.has(coords): continue # .any(func(p): return p.x == x and p.y == y): continue
			var pill = pill_scene.instantiate()
			pill.init(x, y, Walls.TILE_SIZE)
			add_child(pill)
			max_count += 1
			all_pills[coords] = pill
	Events.on_pill_count_changed.emit(all_pills.size(), 0)

func collect(pill:Pill):
	all_pills.erase(pill.coords)
	pill.queue_free()
	collected += 1
	Events.on_pill_count_changed.emit(all_pills.size(), collected)
	if all_pills.is_empty(): # or randf() < 0.05:
		call_deferred("create_all")
