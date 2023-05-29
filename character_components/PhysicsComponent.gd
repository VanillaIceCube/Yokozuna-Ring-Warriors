extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	var parent_node = get_parent()

	if parent_node is RigidBody2D:
		var rigidbody = parent_node as RigidBody2D
		rigidbody.gravity_scale = 0.0
		rigidbody.lock_rotation = true
