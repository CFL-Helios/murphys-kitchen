class_name Customer extends CharacterBody3D

@onready var nav_agent : NavigationAgent3D = $NavAgent
@onready var timer : Timer = $Timer

@export var speed : float = 5

var door : Node3D
var seat : Placement

func _physics_process(delta: float) -> void:
	velocity = (nav_agent.get_next_path_position() - global_position).normalized() * speed
	move_and_slide()

func update_seat(placement : Placement) -> void:
	seat = placement
	update_target_pos(seat.chair.global_position)

func update_target_pos(target_pos: Vector3) -> void:
	nav_agent.target_position = target_pos

func sit() -> void:
	global_position = seat.chair.global_position
	if seat.pickup: eat()
	else: seat.pickup_placed.connect(eat)

func _on_nav_agent_navigation_finished() -> void:
	sit()

func eat() -> void:
	seat.pickup_placed.disconnect(eat)
	timer.start()

func _on_timer_timeout() -> void:
	seat.free_seat()
	update_target_pos(door.global_position)
