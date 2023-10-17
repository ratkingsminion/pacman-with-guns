class_name Creatures
extends Node2D

@export var enemy_scene:PackedScene

@onready var player:Creature = $/root/Main/GAME/CREATURES/Player
var all_creatures:Array[Creature]

###

func _ready():
	for c in find_children("*", "Creature", true, false):
		all_creatures.push_back(c)
		c.tree_exited.connect(func(): unregister(c))
	spawn_enemy()

###

func spawn_enemy() -> Creature:
	if all_creatures.size() >= 20: return # not too many!
	var c := enemy_scene.instantiate() as Creature
	var player_pos := player.target_pos if player != null else Vector2i(randi_range(1, 10), randi_range(1, 10))
	c.start_pos = player_pos
	while c.start_pos == player_pos: c.start_pos = Vector2i(randi_range(1, 10), randi_range(1, 10))
	add_child(c)
	all_creatures.push_back(c)
	c.tree_exited.connect(func(): unregister(c))
	return c

func can_move_to(creature:Creature, target:Vector2i) -> bool:
	for c in all_creatures:
		if c == creature: continue
		if creature != null and c.last_pos == target and c.target_pos == creature.last_pos: return false
		if c.target_pos == target: return false
		if c.target_pos_next == target: return false
	return true

func unregister(creature:Creature):
	if not all_creatures.has(creature): return
	all_creatures.erase(creature)
	if creature != player:
		spawn_enemy() # respawn!
		spawn_enemy() # respawn!
