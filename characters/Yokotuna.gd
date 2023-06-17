extends RigidBody2DBase


func _on_area_2d_body_exited(body):
	body.dead = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
