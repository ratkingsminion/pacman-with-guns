class_name Pill
extends StaticBody2D

func collect():
	get_parent().collect(self)
