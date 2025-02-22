class_name TopDownPlayer extends CharacterBody3D

## Can we move around?
@export var can_move : bool = true
## Are we affected by gravity?
@export var has_gravity : bool = true
## Can we press to jump?
@export var can_jump : bool = true
## Can we hold to run?
@export var can_sprint : bool = false

## Normal speed.
@export var base_speed : float = 7.0
## Speed of jump.
@export var jump_velocity : float = 4.5
## How fast do we run?
@export var sprint_speed : float = 10.0
@export var accel : float = 0.5
@export var deccel : float = 0.5

@export_group("Input Actions")
## Name of Input Action to move Left.
@export var input_left : String = "ui_left"
## Name of Input Action to move Right.
@export var input_right : String = "ui_right"
## Name of Input Action to move Forward.
@export var input_forward : String = "ui_up"
## Name of Input Action to move Backward.
@export var input_back : String = "ui_down"
## Name of Input Action to Jump.
@export var input_jump : String = "ui_accept"
## Name of Input Action to Sprint.
@export var input_sprint : String = "sprint"

var move_speed : float = 0.0

var pickup : Pickup

## IMPORTANT REFERENCES
@onready var collider: CollisionShape3D = $PlayerCollider
@onready var pickup_socket: Marker3D = $PickupSocket
@onready var drop_socket : Marker3D = $DropSocket

func _ready() -> void:
	check_input_mappings()

func _physics_process(delta: float) -> void:
	# Apply gravity to velocity
	if has_gravity:
		if not is_on_floor():
			velocity += get_gravity() * delta

	# Apply jumping
	if can_jump:
		if Input.is_action_just_pressed(input_jump) and is_on_floor():
			velocity.y = jump_velocity

	# Modify speed based on sprinting
	if can_sprint and Input.is_action_pressed(input_sprint):
			move_speed = sprint_speed
	else:
		move_speed = base_speed

	# Apply desired movement to velocity
	if can_move:
		calculate_velocity()
	else:
		velocity.x = 0
		velocity.z = 0
	
	# Use velocity to actually move
	move_and_slide()
	
	if pickup: 
		var move_v = velocity * delta
		move_v.y = 0
		pickup.dish.global_position += move_v
	
func calculate_velocity():
	var input_dir := Input.get_vector(input_left, input_right, input_forward, input_back)
	var move_dir := Vector3(input_dir.x, 0, input_dir.y)
	
	if move_dir:
		move_dir *= move_speed
		velocity.x = move_toward(velocity.x, move_dir.x, accel)
		velocity.z = move_toward(velocity.z, move_dir.z, accel)

	else:
		velocity.x = move_toward(velocity.x, 0, deccel)
		velocity.z = move_toward(velocity.z, 0, deccel)
	
	var look_at_target = Vector3(global_position.x + velocity.x, global_position.y, global_position.z + velocity.z)
	if not look_at_target.is_equal_approx(global_position): look_at(look_at_target, up_direction, true)
	
	velocity.x = clamp(velocity.x, -1 * move_speed, move_speed)
	velocity.z = clamp(velocity.z, -1 * move_speed, move_speed)

func has_moved() -> bool:
	return velocity.length() > 0
	
func take_pickup(new_pickup: Pickup):
	pickup = new_pickup
	
	var pos_diff = pickup_socket.global_position - pickup.dish.global_position 
	pickup.dish.global_position += pos_diff
	pickup.food.global_position += pos_diff 

func drop_pickup():
	place_pickup(drop_socket.global_position)
	
func place_pickup(place_pos : Vector3):
	var pos_diff = pickup.dish.global_position - place_pos
	pickup.dish.global_position = place_pos
	pickup.food.global_position -= pos_diff
	pickup = null

## Checks if some Input Actions haven't been created.
## Disables functionality accordingly.
func check_input_mappings():
	if can_move and not InputMap.has_action(input_left):
		push_error("Movement disabled. No InputAction found for input_left: " + input_left)
		can_move = false
	if can_move and not InputMap.has_action(input_right):
		push_error("Movement disabled. No InputAction found for input_right: " + input_right)
		can_move = false
	if can_move and not InputMap.has_action(input_forward):
		push_error("Movement disabled. No InputAction found for input_forward: " + input_forward)
		can_move = false
	if can_move and not InputMap.has_action(input_back):
		push_error("Movement disabled. No InputAction found for input_back: " + input_back)
		can_move = false
	if can_jump and not InputMap.has_action(input_jump):
		push_error("Jumping disabled. No InputAction found for input_jump: " + input_jump)
		can_jump = false
	if can_sprint and not InputMap.has_action(input_sprint):
		push_error("Sprinting disabled. No InputAction found for input_sprint: " + input_sprint)
		can_sprint = false
