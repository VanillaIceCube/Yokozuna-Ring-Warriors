extends RigidBody2D

# Initializing movement related variables
var target_position: Vector2 = Vector2(0, 0)
var target_direction: Vector2 = Vector2.ZERO
var distance_to_target: float = 0.0
var target_is_enemy: bool = false
var dead: bool = false
var tar_group: String = "Chest"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	# You die if you're too far from the center; this is a placeholder for now
	if not dead:
		var distance_from_center = global_position.distance_to(Vector2(0, 0))
		if distance_from_center > 240:
			dead = true
	else:
		queue_free()
