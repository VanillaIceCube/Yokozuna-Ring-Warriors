extends RigidBody2D

# Movement related
@export var move_speed : float = 400
@export var stop_radius : float = 15
@export var linear_damp_export : float = 4

# Knockback related
@export var tsukareta : float = 0
@export var knock_force : float = 400

# Misc
@export var start_direction : Vector2 = Vector2(0, 1)

# Animation related
@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

# Initializing position related variables
var target_position = get_viewport_rect().size / 2
var target_direction = (target_position - global_position).normalized()
var distance_to_target = global_position.distance_to(target_position)

# Initializing other variables
var dead = false

# Initilization tasks
func _ready():
	update_animation_parameters(start_direction)
	linear_damp = linear_damp_export

# Main physics loop
func _physics_process(_delta):
		
	if not dead:
		handle_walk() # Handle walking
		handle_animation(target_direction) # Handle animation
	
	handle_death() # Handle death related stuff

# Whenever an input is pressed
func _input(event):
	
	# Pressing R swings sword
	if event.is_action_pressed("swing_sword"):
		print("I have pressed the button")
		state_machine.travel("slash")
	
	# When I press F, knock the charcter in a random direction
	if event is InputEventKey:
		if event.is_action_pressed("character_knockback"):
			apply_knock_force()
	
	# When I click on the screen update the target_position
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		target_position = get_global_mouse_position()
		print("Clicked position in world coordinates:", target_position)

# Handles walking for now
func handle_walk():
	
	# Generates the target_direction based off of the target_position
	target_direction = (target_position - global_position).normalized()
	distance_to_target = global_position.distance_to(target_position)
	
	# This is how we stop
	if distance_to_target <= stop_radius:
		target_direction = Vector2.ZERO
	
	# "Walk" towards your target position
	apply_central_force(target_direction*move_speed)

# Handles all animation related code
func handle_animation(direction: Vector2):
	update_animation_parameters(direction)
	idle_or_walk()

# Changes the direction that character faces
func update_animation_parameters(move_input: Vector2):
	# Don't change animation parameters if there is no move input
	if move_input != Vector2.ZERO:
		animation_tree.set("parameters/walking/blend_position", move_input)
		animation_tree.set("parameters/idle/blend_position", move_input)
		animation_tree.set("parameters/slash/blend_position", move_input)
		animation_tree.set("parameters/death/blend_position", move_input)

# Handles animation tree stuff
func idle_or_walk():
	if linear_velocity.length() > 5:
		state_machine.travel("walking")
	else:
		state_machine.travel("idle")

# Handle death
func handle_death():
	# You die if you're too far from the center; this is a placeholder for now
	if not dead:
		var distance_from_center = global_position.distance_to(Vector2(0, 0))
		if distance_from_center > 240:
			dead = true
	else:
		state_machine.travel("death")


# Knock the character in a random direction
func apply_knock_force():
	tsukareta += 25 # Simulates damage taken
	var knock_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	var knock_force_vector = knock_direction * knock_force * (1 + tsukareta/100) # multiples knockback by damage taken
	apply_central_impulse(knock_force_vector)
