class_name Customer extends CharacterBody3D

@onready var nav_agent : NavigationAgent3D = $NavAgent
@onready var timer : Timer = $Timer

@export var speed : float = 5

var door : Node3D
var seat : Placement
var eaten : bool = false

func _physics_process(delta: float) -> void:
	var target_dir = (nav_agent.get_next_path_position() - global_position).normalized()
	var move_dir := Vector3(target_dir.x, 0, target_dir.z)
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if move_dir:
		move_dir *= speed
		velocity.x = move_toward(velocity.x, move_dir.x, 10)
		velocity.z = move_toward(velocity.z, move_dir.z, 10)
	
	var look_at_target = Vector3(global_position.x + velocity.x, global_position.y, global_position.z + velocity.z)
	if not look_at_target.is_equal_approx(global_position): look_at(look_at_target, up_direction, true)
	
	move_and_slide()

func update_seat(placement : Placement) -> void:
	seat = placement
	update_target_pos(seat.chair.global_position)

func update_target_pos(target_pos: Vector3) -> void:
	nav_agent.target_position = target_pos

func sit() -> void:
	look_at_from_position(seat.chair.global_position, seat.global_position - seat.chair.global_position)
	if seat.pickup: eat()
	else: seat.pickup_placed.connect(eat)

func _on_nav_agent_navigation_finished() -> void:
	if not eaten: sit()
	else: queue_free()

func eat() -> void:
	seat.pickup_placed.disconnect(eat)
	timer.start()

func _on_timer_timeout() -> void:
	seat.free_seat()
	eaten = true
	update_target_pos(door.global_position)
