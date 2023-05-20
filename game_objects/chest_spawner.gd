extends Node

var objectScene = preload("res://objects/chest.tscn")  # Replace with the path to your object scene

func _on_timer_timeout():
	print("Spawn Chest")

	var spawnArea = Rect2(Vector2(-200, -200), Vector2(200, 200))  # Replace with the desired spawn area
	var spawnX = randf_range(spawnArea.position.x, spawnArea.position.x + spawnArea.size.x)
	var spawnY = randf_range(spawnArea.position.y, spawnArea.position.y + spawnArea.size.y)
	var spawnPosition = Vector2(spawnX, spawnY)

	var objectInstance = objectScene.instantiate()

	# Set the position of the object
	objectInstance.position = spawnPosition
	
	# Set Group
	objectInstance.add_to_group("Chest")

	# Add the object to the scene
	get_parent().add_child(objectInstance)
