class_name Player
extends Node

###

@export var weapon:WeaponComp

@onready var creature:Creature = get_parent()

var inputs:Array[Dictionary] = []

###

func _process(delta:float):
	if Input.is_action_pressed("shoot"):
		weapon.try_shoot(creature.cur_dir)
	
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

func check_input(input_name:String, move:Vector2i):
	var inside_inputs := ArrayEx.try_get_first(inputs, func(elem): return elem.name == input_name)
	if Input.is_action_just_pressed(input_name) and not inside_inputs.exists:
		inputs.push_front({ name = input_name, move = move, remove = false })
	elif Input.is_action_just_released(input_name) and inside_inputs.exists:
		inputs.erase(inside_inputs.elem)
