extends Area2D

var attack_damage := 10
var knockback_force := 400

# Whenever an input is pressed
func _input(event):
	# Pressing R swings sword
	if event.is_action_pressed("swing_sword"):
		if $Timer.is_stopped():
			print("TUNA TIMER IS STOPPED")
			get_node("../AnimationParametersComponent").state_machine.travel("slash")
			$Timer.start()
		else:
			print("TUNA TIMER IS NOT STOPPED")

func _on_timer_timeout():
	print("TUNA TIMER DONE")


func _on_body_entered(body):
	for child in body.get_children():
		if child.has_method("get_hit"):
			var attack = Attack.new()
			attack.attack_damage = attack_damage
			attack.knockback_force = knockback_force
			attack.attack_position = global_position
			child.get_hit(attack)
