extends RigidBody2DBase


func _on_body_entered(body: Node) -> void:
	print("I HAVE BEEN ENTERED")
	print(body)
