extends Node

var parent_node: Node = null # Initializing parent_node

var teleport_distance:= 50

# Called when the node enters the scene tree for the first time.
func _ready():
	parent_node = get_parent() # Setting the parent_node

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if parent_node.target_is_enemy and parent_node.get_node("Slash").slash_ready:
		teleport()

func _on_timer_timeout():
	if parent_node.verbosity:
		print("Ready to teleport")

func teleport():
	if $Timer.is_stopped():
		create_particle($StartParticles)
		
		if parent_node.verbosity:
			print("Ready to teleport")
		var maxTeleportDistance = min(teleport_distance, parent_node.distance_to_target)
		var teleportVector = parent_node.target_direction * maxTeleportDistance
		parent_node.global_position += teleportVector
		parent_node.apply_central_impulse(25000*parent_node.target_direction)
	
		create_particle($EndParticles)
		
		$Timer.start()

func create_particle(particle):
	particle.global_position = parent_node.global_position
	particle.emitting = true
