extends Node

var objectScene = preload("res://characters/Yokotuna.tscn") 
var tunas = 1
var current_round = 1
var in_current_round = false

# General Plan
# For now make a UI that follows the player around with tsuk, and each power up's cooldown
# Start of every 5 rounds show a UI that says pick a powerup
# Make sure every opponent dies between rounds, 3 seconds at round start to allow resetting

func _on_timer_timeout():
	for i in range(round(tunas)):
		spawn_tuna()
	tunas += 0.25

# This needs to be cleaned up
func spawn_tuna():
	print("Spawn Tuna")
	var spawnPosition = Vector2(randf_range(-180,180), randf_range(-180,180))
	var objectInstance = objectScene.instantiate()
	objectInstance.global_position = spawnPosition
	objectInstance.tar_group = "Yoko"
	objectInstance.get_node("Slash").attack_damage = 5
	objectInstance.get_node("Slash").knockback_force = 10000
	objectInstance.get_node("Slash").attack_time = 5
	objectInstance.verbosity = false
	var nodesToFree = ["Teleport", "RockThrow", "Dash"]
	for nodeName in nodesToFree:
		if objectInstance.has_node(nodeName):
			var node = objectInstance.get_node(nodeName)
			node.queue_free()
	objectInstance.modulate = Color(1, 0, 0)
	objectInstance.add_to_group("Chest")
	get_parent().add_child(objectInstance)
