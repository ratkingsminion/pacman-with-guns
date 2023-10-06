extends Area2D

@export var walls:Walls
@export var move_seconds := 0.2
@export var tile_size := 16

var cur_dir := Vector2i(0, 0)
var last_pos := Vector2i(2, 2)
var target_pos:Vector2i
var target_pos_next:Vector2i
var inputs:Array[Dictionary] = []

###

func _ready():
	position = tile_size * Vector2(0.5 + last_pos.x, 0.5 + last_pos.y)
	target_pos_next = last_pos
	target_pos = last_pos

func _process(delta):	
	check_input("move_left", Vector2i(-1, 0))
	check_input("move_right", Vector2i(1, 0))
	check_input("move_up", Vector2i(0, -1))
	check_input("move_down", Vector2i(0, 1))
		
	if not inputs.is_empty(): # change direction according to current input
		var elem = inputs.front()
		cur_dir = elem.move
		if not try_move(target_pos, target_pos + cur_dir):
			cur_dir = Vector2i.ZERO
		
	if target_pos_next == last_pos:
		target_pos = last_pos	
	if try_move(target_pos, target_pos + cur_dir):
		target_pos_next = target_pos + cur_dir
	
	var position_new := tile_size * Vector2(0.5 + target_pos.x, 0.5 + target_pos.y)
	position = VectorEx.move_toward(position, position_new, delta * tile_size / move_seconds)
	
	if position == tile_size * Vector2(0.5 + target_pos.x, 0.5 + target_pos.y):
		last_pos = target_pos
		target_pos = target_pos_next

	queue_redraw() # for debug drawing

func _draw():
	var l = tile_size * Vector2(last_pos.x , last_pos.y) - position
	draw_rect(Rect2(l.x, l.y, tile_size, tile_size), Color.GREEN, false, 1.0)
	var p = tile_size * Vector2(target_pos_next.x , target_pos_next.y) - position
	draw_rect(Rect2(p.x, p.y, tile_size, tile_size), Color.YELLOW, false, 1.0)
	var t = tile_size * Vector2(target_pos.x , target_pos.y) - position
	draw_rect(Rect2(t.x, t.y, tile_size, tile_size), Color.RED, false, 1.0)

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

func check_input(name:String, move:Vector2i):
	var inside_inputs := ArrayEx.try_get_first(inputs, func(elem): return elem.name == name)
	if Input.is_action_just_pressed(name) and not inside_inputs.exists:
		inputs.push_front({ name = name, move = move, remove = false })
		# print(str(Time.get_ticks_msec(), " ", name, " ", inputs.size()))
		#if move_timer < Time.get_ticks_msec():
		#	move_timer = Time.get_ticks_msec() + 1000 * move_seconds
	elif Input.is_action_just_released(name) and inside_inputs.exists:
		inputs.erase(inside_inputs.elem)

func _on_body_shape_entered(body_rid:RID, body:Node2D, body_shape_index:int, local_shape_index:int):
	if body is Pill:
		body.collect()
