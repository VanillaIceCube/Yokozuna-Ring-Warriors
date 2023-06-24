extends Node

func _ready():
	add_child(preload("res://arenas/Arena_01.tscn").instantiate())
	
	var Yoko = preload("res://characters/Yokotuna.tscn").instantiate()
	Yoko.add_to_group("Yoko")
	add_child(Yoko)
	
	add_child(preload("res://game_objects/TunaSpawner.tscn").instantiate())
