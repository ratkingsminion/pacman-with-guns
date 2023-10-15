class_name Characters
extends Node2D

@export var enemy_scene:PackedScene

@onready var player:Character = $/root/Main/GAME/CHARACTERS/Player
var all_characters:Array[Character]

###

func _ready():
	for c in find_children("*", "Character", true, false):
		all_characters.push_back(c)
		c.tree_exited.connect(func(): unregister(c))
	spawn_enemy()

###

func spawn_enemy() -> Character:
	if all_characters.size() >= 20: return # not too many!
	var c := enemy_scene.instantiate() as Character
	var player_pos := player.target_pos if player != null else Vector2i(randi_range(1, 10), randi_range(1, 10))
	c.start_pos = player_pos
	while c.start_pos == player_pos: c.start_pos = Vector2i(randi_range(1, 10), randi_range(1, 10))
	add_child(c)
	all_characters.push_back(c)
	c.tree_exited.connect(func(): unregister(c))
	return c

func can_move_to(char:Character, target:Vector2i) -> bool:
	for c in all_characters:
		if c == char: continue
		if char != null and c.last_pos == target and c.target_pos == char.last_pos: return false
		if c.target_pos == target: return false
		if c.target_pos_next == target: return false
	return true

func unregister(char:Character):
	if not all_characters.has(char): return
	all_characters.erase(char)
	if char != player: spawn_enemy() # respawn!
