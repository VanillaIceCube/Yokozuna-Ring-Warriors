extends Node

var objectScene = preload("res://objects/chest.tscn")  # Replace with the path to your object scene

func _on_timer_timeout():
	print("Spawn Chest")
	var spawnPosition = Vector2(randf_range(-240,240), randf_range(-240,240))

	var objectInstance = objectScene.instantiate()

	# Set the position of the object
	objectInstance.position = spawnPosition
	
	# Set Group
	objectInstance.add_to_group("Chest")

	# Add the object to the scene
	get_parent().add_child(objectInstance)
