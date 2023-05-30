extends Node

var parent_node: Node = null # Initializing parent_node

# Called when the node enters the scene tree for the first time.
func _ready():
	parent_node = get_parent() # Setting the parent_node

	if parent_node is RigidBody2D:
		parent_node.gravity_scale = 0.0  # Not affected by gravity
		parent_node.lock_rotation = true # Rotation locked
	else:
		assert(false, "PhysicsComponent's parent isn't a RigidBody2D") # Basic error proofing
