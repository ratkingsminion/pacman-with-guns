class_name Enemy
extends Node

@export var weapon:WeaponComp

@onready var creature:Character = get_parent()

var shoot_dir:Vector2

###

func _ready():
	creature.cur_dir = Vector2i.RIGHT
	Events.add_signal(creature, Events.SIGNAL_DIE, on_die)
	shoot_dir = Vector2(randf() - 0.5, randf() - 0.5).normalized()

func _process(delta:float):
	if creature.last_pos == creature.target_pos and not creature.try_move(creature.target_pos + creature.cur_dir):
		match randi_range(0, 3):
			0: creature.cur_dir = Vector2i.RIGHT
			1: creature.cur_dir = Vector2i.UP
			2: creature.cur_dir = Vector2i.DOWN
			3: creature.cur_dir = Vector2i.LEFT
	
	if weapon != null:
		if weapon.try_shoot(shoot_dir):
			shoot_dir = shoot_dir.rotated(deg_to_rad(30.0))

### events:

func on_die():
	creature.cur_dir = Vector2i.ZERO
	queue_free() # only remove this component
