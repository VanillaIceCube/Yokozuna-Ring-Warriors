extends RigidBody2D

class_name RigidBody2DBase

# Initializing movement related variables
var target_position: Vector2 = Vector2(0, 0)
var target_direction: Vector2 = Vector2.ZERO
var distance_to_target: float = 0.0
var linear_damp_var: float = 2.5 # Basically Friction

# Targetting variables
var target_is_enemy: bool = false
var tar_group: String = "Chest"

# Attributes
var dead: bool = false

# Verbosity for debugging
var verbosity: bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	linear_damp = linear_damp_var # This is two steps to setting friction, maybe it can be shortened
