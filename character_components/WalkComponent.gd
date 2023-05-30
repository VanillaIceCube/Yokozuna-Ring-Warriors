extends Node

var parent_node: Node = null # Initializing parent_node

# Movement related
@export var move_speed: float = 400
@export var stop_radius: float = 15
@export var linear_damp_export: float = 4 # Basically Friction

# Initializing movement related variables
var target_position: Vector2 = Vector2(0, 0)
var target_direction: Vector2 = Vector2.ZERO
var distance_to_target: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	parent_node = get_parent() # Setting the parent_node
	parent_node.linear_damp = linear_damp_export # This is two steps to setting friction, maybe it can be shortened

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	# Generates the target_direction based off of the target_position
	target_direction = (target_position - parent_node.global_position).normalized()
	distance_to_target = parent_node.global_position.distance_to(target_position)
	
	# This is how we stop
	if distance_to_target <= stop_radius:
		target_direction = Vector2.ZERO
	
	# "Walk" towards your target position
	parent_node.apply_central_force(target_direction * move_speed)

# This is a temporary way to choose the target position
func _input(event: InputEvent):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		target_position = parent_node.get_global_mouse_position()
		print("Clicked position in world coordinates:", target_position)
