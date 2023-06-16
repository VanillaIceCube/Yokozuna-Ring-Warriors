extends Node

var parent_node: Node = null # Initializing parent_node

# Called when the node enters the scene tree for the first time.
func _ready():
	parent_node = get_parent() # Setting the parent_node

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# You die if you're too far from the center; this is a placeholder for now
	if not parent_node.dead:
		var distance_from_center = parent_node.global_position.distance_to(Vector2(0, 0))
		if distance_from_center > 240:
			parent_node.dead = true
	else:
		parent_node.get_node("AnimationParametersComponent").state_machine.travel("death")
