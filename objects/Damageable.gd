extends Node

class_name Damageable

func hit():
	get_parent().dead = true
