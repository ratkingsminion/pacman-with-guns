class_name Characters
extends Node2D

var all_characters:Array[Character]

###

func _ready():
	for c in find_children("*", "Character", true, false):
		all_characters.push_back(c)
		c.tree_exited.connect(func(): all_characters.erase(c)) # TODO - respawning

###

func can_move_to(char:Character, target:Vector2i) -> bool:
	for c in all_characters:
		if c == char: continue
		if char != null and c.last_pos == target and c.target_pos == char.last_pos: return false
		if c.target_pos == target: return false
		if c.target_pos_next == target: return false
	return true

func unregister(char:Character):
	all_characters.erase(char)
