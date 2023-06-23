extends Node

var parent_node: Node = null # Initializing parent_node

var rock_speed:= 50

var rock_scene = preload("res://objects/Rock.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	parent_node = get_parent() # Setting the parent_node

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if parent_node.target_is_enemy and parent_node.distance_to_target > 25 and not parent_node.get_node("Slash").slash_ready:
		throw_rock()

func _on_timer_timeout():
	if parent_node.verbosity:
		print("Ready to throw rocks")

func throw_rock():
	if $Timer.is_stopped():

		var spawnPosition = parent_node.global_position + (parent_node.target_direction * 25)

		var rock_instance = rock_scene.instantiate()

		# Set the position of the object
		rock_instance.global_position = spawnPosition
		rock_instance.apply_central_impulse(1200*parent_node.target_direction)
		rock_instance.apply_torque_impulse(5000000 * sign(randf_range(-1, 1)))

		# Add the object to the scene
		parent_node.get_parent().add_child(rock_instance)

		$Timer.start()



