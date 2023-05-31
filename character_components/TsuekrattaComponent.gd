extends Node

var tsuerkeratta : float # more tsuerkeraata = more knockback

# Called when the node enters the scene tree for the first time.
func _ready():
	tsuerkeratta = 0


# Handle getting hit
func get_hit(attack: Attack):
	tsuerkeratta += attack.attack_damage # Add more tsuerkeraata

	# Simple vector knockback for now
	var hit_vector = (get_parent().global_position - attack.attack_position).normalized()
	get_parent().apply_central_impulse(hit_vector*attack.knockback_force*(1+tsuerkeratta/100))
