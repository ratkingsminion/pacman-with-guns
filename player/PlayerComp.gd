class_name Player
extends Node

###

@export var bullet_scene:PackedScene
@export var shoot_seconds := 0.35

var creature:Character
var inputs:Array[Dictionary] = []
var shoot_timer:float

###

func _ready():
	creature = get_parent()

func _process(delta):
	if Input.is_action_pressed("shoot"):
		try_shoot()
	
	check_input("move_left", Vector2i(-1, 0))
	check_input("move_right", Vector2i(1, 0))
	check_input("move_up", Vector2i(0, -1))
	check_input("move_down", Vector2i(0, 1))
		
	if not inputs.is_empty(): # change direction according to current input
		var elem = inputs.front()
		if creature.try_move(creature.target_pos + elem.move):
			creature.cur_dir = elem.move
		#if not creature.try_move(creature.target_pos + creature.cur_dir):
		#	creature.cur_dir = Vector2i.ZERO

###

func try_shoot() -> bool:
	if shoot_timer > Time.get_ticks_msec() / 1000.0: return false
	shoot_timer = Time.get_ticks_msec() / 1000.0 + shoot_seconds
	print("shoot")
	Events.on_player_try_shoot.emit(self, bullet_scene, Vector2(creature.cur_dir), creature.position)
	return true

func check_input(input_name:String, move:Vector2i):
	var inside_inputs := ArrayEx.try_get_first(inputs, func(elem): return elem.name == input_name)
	if Input.is_action_just_pressed(input_name) and not inside_inputs.exists:
		inputs.push_front({ name = input_name, move = move, remove = false })
	elif Input.is_action_just_released(input_name) and inside_inputs.exists:
		inputs.erase(inside_inputs.elem)
