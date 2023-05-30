extends Node

var parent_node: Node = null # Initializing parent_node

# Called when the node enters the scene tree for the first time.
func _ready():
	parent_node = get_parent() # Setting the parent_node
	assert(parent_node is RigidBody2D, "PhysicsComponent's parent isn't a RigidBody2D") # Basic error proofing
	
	parent_node.gravity_scale = 0.0  # Not affected by gravity
	parent_node.lock_rotation = true # Rotation locked
