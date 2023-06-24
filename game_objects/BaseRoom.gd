extends Node

func _ready():
	add_child(preload("res://arenas/Arena_01.tscn").instantiate())
	add_child(preload("res://characters/Yokotuna.tscn").instantiate())
	add_child(preload("res://game_objects/TunaSpawner.tscn").instantiate())
