extends Node

var parent_node: Node = null # Initializing parent_node

# Movement related
var move_speed: float = 10000
var stop_radius: float = 15

# Called when the node enters the scene tree for the first time.
func _ready():
	parent_node = get_parent() # Setting the parent_node

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not parent_node.dead:
		# Generates the target_direction based off of the target_position
		parent_node.target_direction = (parent_node.target_position - parent_node.global_position).normalized()
		parent_node.distance_to_target = parent_node.global_position.distance_to(parent_node.target_position)
		
		# This is how we stop
		if parent_node.distance_to_target <= stop_radius:
			parent_node.target_direction = Vector2.ZERO
		
		# "Walk" towards your target position
		parent_node.apply_central_force(delta*100*parent_node.target_direction * move_speed)

# This is a temporary way to choose the target position
func _input(event: InputEvent):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		parent_node.target_position = parent_node.get_global_mouse_position()
		print("Clicked position in world coordinates:", parent_node.target_position)
