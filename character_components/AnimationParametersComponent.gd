extends Node

var parent_node: Node = null # Initializing parent_node

# Animation related
@onready var animation_tree: AnimationTree
@onready var state_machine
@export var animation_list = "idle"

# Called when the node enters the scene tree for the first time.
func _ready():
	parent_node = get_parent() # Setting the parent_node
	animation_tree = get_node("../AnimationTree")
	state_machine = animation_tree.get("parameters/playback")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	# Don't change animation parameters if there is no move input
	if parent_node.target_direction != Vector2.ZERO:
		for animation in animation_list.split(", "):
			animation_tree.set("parameters/" + animation + "/blend_position", parent_node.target_direction)

	# Changes animation between walking and idle
	if parent_node.linear_velocity.length() > 5:
		state_machine.travel("walking")
	else:
		state_machine.travel("idle")
