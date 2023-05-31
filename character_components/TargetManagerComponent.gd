extends Node

var parent_node: Node = null # Initializing parent_node

# Called when the node enters the scene tree for the first time.
func _ready():
	parent_node = get_parent() # Setting the parent_node

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	choose_target(find_group("Chest"))

# Choose the closest target based on the given list
func choose_target(list):
	var closestNode = null
	var closestDistance = INF
	
	if not list.is_empty():
	# Find the node with the minimum distance
		
		for node in list:
			if node.distance < closestDistance:
				closestNode = node.node
				closestDistance = node.distance

		# Check if a closest node was found
		if closestNode:
			var _closestPosition = closestNode.global_position
			
		parent_node.target_position = closestNode.position
		return closestNode.global_position
	else:
		parent_node.target_position = Vector2(0,0)
		return(Vector2(0,0)) 

# Create a list of a certain group
func find_group(group):
	var group_list = []

	# Iterate over all nodes in the scene
	for node in get_tree().get_nodes_in_group(group):
		if not node.dead:
			var node_entry = {
				"node": node,
				"position": node.global_position,
				"distance": parent_node.global_position.distance_to(node.global_position)
			}
			group_list.append(node_entry)
	
	return group_list
