extends Node

var parent_node: Node = null

# Called when the node enters the scene tree for the first time.
func _ready():
	parent_node = get_parent()

	if parent_node is RigidBody2D:
		parent_node.gravity_scale = 0.0
		parent_node.lock_rotation = true
	else:
		assert(false, "PhysicsComponent's parent isn't a RigidBody2D")
