extends Node

var parent_node: Node = null # Initializing parent_node

# Animation related
@onready var animation_tree: AnimationTree
@onready var state_machine

# Called when the node enters the scene tree for the first time.
func _ready():
	parent_node = get_parent() # Setting the parent_node
	animation_tree = get_node("../AnimationTree")
	state_machine = animation_tree.get("parameters/playback")
	print(animation_tree)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	# Don't change animation parameters if there is no move input
	if parent_node.target_direction != Vector2.ZERO:
		animation_tree.set("parameters/walking/blend_position", parent_node.target_direction)
		animation_tree.set("parameters/idle/blend_position", parent_node.target_direction)
		animation_tree.set("parameters/slash/blend_position", parent_node.target_direction)
		animation_tree.set("parameters/death/blend_position", parent_node.target_direction)
	pass
	
	# Changes animation between walking and idle
	if parent_node.linear_velocity.length() > 5:
		state_machine.travel("walking")
	else:
		state_machine.travel("idle")
