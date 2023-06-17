extends Area2D

var parent_node: Node = null # Initializing parent_node

var attack_damage := 10
var knockback_force := 40000
var attack_range:= 30
var attack_time:= 1
var slash_ready:= false

# Called when the node enters the scene tree for the first time.
func _ready():
	parent_node = get_parent() # Setting the parent_node
	$Timer.wait_time = attack_time

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if parent_node.distance_to_target < attack_range and parent_node.target_is_enemy:
		slash()

func _on_body_entered(body):
	for child in body.get_children():
		if child.has_method("get_hit"):
			var attack = Attack.new()
			attack.attack_damage = attack_damage
			attack.knockback_force = knockback_force*(1+parent_node.linear_velocity.length()*.01)
			attack.attack_position = parent_node.global_position
			child.get_hit(attack)

func _on_timer_timeout():
	slash_ready = true
	if parent_node.verbosity:
		print("YokoTuna can attack again!")

func slash():
	if $Timer.is_stopped():
		get_node("../AnimationParametersComponent").state_machine.travel("slash")
		if get_node("../AnimationParametersComponent").state_machine.get_current_node() == "slash":
			$Timer.start()
