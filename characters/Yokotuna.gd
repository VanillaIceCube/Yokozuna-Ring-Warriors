extends RigidBody2DBase


func _on_area_2d_body_exited(body):
	body.dead = true
