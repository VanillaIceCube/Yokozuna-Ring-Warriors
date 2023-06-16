extends Node

var parent_node: Node = null # Initializing parent_node

# Called when the node enters the scene tree for the first time.
func _ready():
	parent_node = get_parent() # Setting the parent_node

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# You die if you're too far from the center; this is a placeholder for now
	if parent_node.dead:
		parent_node.get_node("AnimationParametersComponent").state_machine.travel("death")
		
		if $Timer.is_stopped():
			$Timer.start()

func _on_timer_timeout():
	parent_node.queue_free()
