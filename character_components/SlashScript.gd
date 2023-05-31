extends Area2D

var parent_node: Node = null # Initializing parent_node

# Called when the node enters the scene tree for the first time.
func _ready():
	parent_node = get_parent() # Setting the parent_node
	
var attack_damage := 10
var knockback_force := 1000
var attack_range:= 36

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if parent_node.distance_to_target < attack_range:
		slash()

func _on_body_entered(body):
	for child in body.get_children():
		if child.has_method("get_hit"):
			var attack = Attack.new()
			attack.attack_damage = attack_damage
			attack.knockback_force = knockback_force
			attack.attack_position = parent_node.global_position
			child.get_hit(attack)

func _on_timer_timeout():
	print("YokoTuna can attack again!")

# Whenever an input is pressed
func _input(event):
	# Pressing R swings sword
	if event.is_action_pressed("swing_sword"):
		slash()

func slash():
	if $Timer.is_stopped():
		get_node("../AnimationParametersComponent").state_machine.travel("slash")
		$Timer.start()
