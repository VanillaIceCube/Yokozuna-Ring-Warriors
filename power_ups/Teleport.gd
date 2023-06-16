extends Node

var parent_node: Node = null # Initializing parent_node

var teleport_distance:= 50

# Called when the node enters the scene tree for the first time.
func _ready():
	parent_node = get_parent() # Setting the parent_node

func _on_timer_timeout():
	if parent_node.verbosity:
		print("Ready to teleport")
	if not parent_node.target_is_enemy:
		teleport()
	elif parent_node.target_is_enemy and parent_node.get_node("Slash").slash_ready:
		teleport()

func teleport():
	if $Timer.is_stopped():
		if parent_node.verbosity:
			print("Ready to teleport")
		var maxTeleportDistance = min(teleport_distance, parent_node.distance_to_target)
		var teleportVector = parent_node.target_direction * maxTeleportDistance
		parent_node.global_position += teleportVector
		$Timer.start()
