extends Node

class_name Damageable

func hit(position):
	var hit_vector = (get_parent().global_position - position).normalized()
	get_parent().apply_central_impulse(1000*hit_vector)
