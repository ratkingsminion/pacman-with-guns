class_name Enemy
extends Node

var creature:Character

###

func _ready():
	creature = get_parent() as Character
	creature.cur_dir = Vector2i.RIGHT

func _process(delta):
	if not creature.try_move(creature.target_pos + creature.cur_dir):
		match randi_range(0, 3):
			0: creature.cur_dir = Vector2i.RIGHT
			1: creature.cur_dir = Vector2i.UP
			2: creature.cur_dir = Vector2i.DOWN
			3: creature.cur_dir = Vector2i.LEFT
