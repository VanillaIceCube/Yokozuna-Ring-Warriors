extends Node

var parent_node: Node = null # Initializing parent_node

var dash_strength:= 50000
var dash_ready:= false

# Called when the node enters the scene tree for the first time.
func _ready():
	parent_node = get_parent() # Setting the parent_node

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if parent_node.target_is_enemy and parent_node.get_node("Slash").slash_ready:
		dash()
	

func _on_timer_timeout():
	dash_ready = true
	if parent_node.verbosity:
		print("Ready to dash")

func dash():
	if $Timer.is_stopped():
		parent_node.apply_central_impulse(dash_strength*parent_node.target_direction)
		dash_ready = false
		$Timer.start()
