class_name Character
extends Node2D

@export var walls:Walls
@export var move_seconds := 0.2
@export var show_debug := false

var cur_dir := Vector2i(0, 0)
var last_pos := Vector2i(2, 2)
var target_pos:Vector2i
var target_pos_next:Vector2i

###

func _ready():
	position = Walls.TILE_SIZE * Vector2(0.5 + last_pos.x, 0.5 + last_pos.y)
	target_pos_next = last_pos
	target_pos = last_pos

func _process(delta):
	if target_pos_next == last_pos:
		target_pos = last_pos	
	if try_move(target_pos, target_pos + cur_dir):
		target_pos_next = target_pos + cur_dir
	
	var position_new := Walls.TILE_SIZE * Vector2(0.5 + target_pos.x, 0.5 + target_pos.y)
	position = MathEx.vec2_move_toward(position, position_new, delta * Walls.TILE_SIZE / move_seconds)
	
	if position == Walls.TILE_SIZE * Vector2(0.5 + target_pos.x, 0.5 + target_pos.y):
		last_pos = target_pos
		target_pos = target_pos_next

	if show_debug: queue_redraw() # for debug drawing

func _draw():
	if not show_debug: return
	var l = Walls.TILE_SIZE * Vector2(last_pos.x , last_pos.y) - position
	draw_rect(Rect2(l.x, l.y, Walls.TILE_SIZE, Walls.TILE_SIZE), Color.GREEN, false, 1.0)
	var p = Walls.TILE_SIZE * Vector2(target_pos_next.x , target_pos_next.y) - position
	draw_rect(Rect2(p.x, p.y, Walls.TILE_SIZE, Walls.TILE_SIZE), Color.YELLOW, false, 1.0)
	var t = Walls.TILE_SIZE * Vector2(target_pos.x , target_pos.y) - position
	draw_rect(Rect2(t.x, t.y, Walls.TILE_SIZE, Walls.TILE_SIZE), Color.RED, false, 1.0)

###

func try_move(from:Vector2i, to:Vector2i) -> bool:
	var move = to - from
	if walls == null: return true # test mode
	var c = walls.get_cell_atlas_coords(0, from)
	if c.y == 0:
		if (c.x == 1 or c.x == 3) and move.y > 0: return false
		if (c.x == 2 or c.x == 3) and move.x > 0: return false
	var nc = walls.get_cell_atlas_coords(0, to)
	if nc.y == 0:
		if (nc.x == 1 or nc.x == 3) and move.y < 0: return false
		if (nc.x == 2 or nc.x == 3) and move.x < 0: return false
	if nc.y == 1: return false
	return true
