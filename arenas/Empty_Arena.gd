extends Node

func _ready():
	var node = preload("res://arenas/Arena_01.tscn").instantiate()
	add_child(node)
