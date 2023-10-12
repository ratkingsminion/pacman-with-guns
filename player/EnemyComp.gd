class_name Enemy
extends Node

@onready var creature:Character = get_parent()

###

func _ready():
	creature.cur_dir = Vector2i.RIGHT
	Events.add_signal(creature, Events.SIGNAL_DIE, on_die)

func _process(delta:float):
	if creature.last_pos == creature.target_pos and not creature.try_move(creature.target_pos + creature.cur_dir):
		match randi_range(0, 3):
			0: creature.cur_dir = Vector2i.RIGHT
			1: creature.cur_dir = Vector2i.UP
			2: creature.cur_dir = Vector2i.DOWN
			3: creature.cur_dir = Vector2i.LEFT

### events:

func on_die():
	creature.cur_dir = Vector2i.ZERO
	queue_free() # only remove this component
