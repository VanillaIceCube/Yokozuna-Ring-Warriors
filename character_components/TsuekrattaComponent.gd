extends Node

var parent_node: Node = null # Initializing parent_node
var tsuerkeratta : float # more tsuerkeraata = more knockback

# Called when the node enters the scene tree for the first time.
func _ready():
	parent_node = get_parent() # Setting the parent_node
	tsuerkeratta = 0 # Start with 0 percent damage

# Handle getting hit
func get_hit(attack: Attack):
	tsuerkeratta += attack.attack_damage # Add more tsuerkeraata

	# Simple vector knockback for now
	var hit_vector = (parent_node.global_position - attack.attack_position).normalized()
	parent_node.apply_central_impulse(hit_vector*attack.knockback_force*(1+tsuerkeratta/100))
