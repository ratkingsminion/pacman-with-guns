class_name Characters
extends Node2D

var allCharacters:Array[Character]

###

func _ready():
	for c in find_children("*", "Character", true, false):
		allCharacters.push_back(c)
		c.tree_exited.connect(func(): allCharacters.erase(c)) # TODO - respawning

###

func can_move_to(char:Character, target:Vector2i) -> bool:
	for c in allCharacters:
		if c == char: continue
		if char != null and c.last_pos == target and c.target_pos == char.last_pos: return false
		if c.target_pos == target: return false
		if c.target_pos_next == target: return false
	return true
