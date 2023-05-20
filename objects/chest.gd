extends RigidBody2D

# Animation related
@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

# Initializing other variables
var dead = false
var distance_from_center = global_position.distance_to(Vector2(0, 0))

# Initilization tasks
func _ready():
	state_machine.travel("idle")

# Main physics loop
func _physics_process(_delta):
	handle_death()
	
# Handle death
func handle_death():
	if not dead:
		distance_from_center = global_position.distance_to(Vector2(0, 0))
		if distance_from_center > 240:
			dead = true
	else:
		state_machine.travel("open")
