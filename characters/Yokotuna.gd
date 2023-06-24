extends RigidBody2DBase

func _on_area_2d_body_exited(body):
	body.dead = true
	if has_node("Teleport"):
		var teleport = get_node("Teleport")
		if teleport.teleport_ready:
			teleport.teleport_away()
			body.dead = false
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _input(event):
	if event is InputEventKey:
		if event.is_action_pressed("character_knockback"):
			var knock_direction = Vector2(-1, 0)  # Set the knockback direction to left
			var knock_force_vector = knock_direction * 100000
			apply_central_impulse(knock_force_vector)
