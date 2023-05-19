extends RigidBody2D

# Movement related
@export var move_speed : float = 100
@export var stop_radius : float = 15
@export var linear_damp_export : float = 1.25

# Debugging related
@export var knock_force : float = 100

# Misc
@export var start_direction : Vector2 = Vector2(0, 1)

# Animation related
@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

# More misc variables
var target_position = get_viewport_rect().size / 2

# Initilization tasks
func _ready():
	update_animation_parameters(start_direction)
	linear_damp = linear_damp_export

# Main physics loop
func _physics_process(_delta):
	
	# Generates the target_direction based off of the target_position
	var target_direction = (target_position - global_position).normalized()
	var distance_to_target = global_position.distance_to(target_position)
	
	# If you're near your target_position then your target_direction stops (this will stop the movement forces applied on you)
	if distance_to_target <= stop_radius:
		target_direction = Vector2.ZERO
	
	# "Walk" towards your target position
	apply_central_force(target_direction*move_speed)
	
	# Handle animation
	handle_animation(target_direction)

# Whenever an input is pressed
func _input(event):
	
	# When I press F, knock the charcter in a random direction
	if event is InputEventKey:
		if event.is_action_released("character_knockback"):
			apply_knock_force()
	
	# When I click on the screen update the target_position
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		target_position = event.position
		print("Clicked position in world coordinates:", target_position)

# Knock the character in a random direction
func apply_knock_force():
	var knock_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	var knock_force_vector = knock_direction * knock_force
	apply_central_impulse(knock_force_vector)

# Handles all animation related code
func handle_animation(target_direction):
	update_animation_parameters(target_direction)
	pick_new_state()

# Changes the direction that character faces
func update_animation_parameters(move_input: Vector2):
	# Don't change animation parameters if there is no move input
	if move_input != Vector2.ZERO:
		animation_tree.set("parameters/walking/blend_position", move_input)
		animation_tree.set("parameters/idle/blend_position", move_input)

# Handles animation tree stuff
func pick_new_state():
	if linear_velocity.length() > 15:
		state_machine.travel("walking")
	else:
		state_machine.travel("idle")