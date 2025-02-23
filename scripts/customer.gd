class_name Customer extends CharacterBody3D

@onready var nav_agent : NavigationAgent3D = $NavAgent
@onready var timer : Timer = $Timer
@onready var flinch : Timer = $FlinchTimer
@onready var animation : AnimationPlayer = $CustomerMesh/AnimationPlayer

@export var speed : float = 5

var door : Node3D
var seat : Placement
var eaten : bool = false
var moving : bool = true
var flinching : bool = false


func _physics_process(delta: float) -> void:
	if flinching: 
		animation.play("gethit_001")
		return
	
	if not moving: 
		look_at_table()
		animation.play("waiting") 
		return
	
	var target_dir = (nav_agent.get_next_path_position() - global_position).normalized()
	var move_dir := Vector3(target_dir.x, 0, target_dir.z)
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if move_dir:
		move_dir *= speed
		velocity.x = move_toward(velocity.x, move_dir.x, 10)
		velocity.z = move_toward(velocity.z, move_dir.z, 10)
		
	var move_speed = move_dir.length()
	if move_speed < 0.5: 
		animation.speed_scale = 1
		animation.play("idle")
	else:
		animation.speed_scale = move_speed / 2
		animation.play("walk")
	
	var look_at_target = Vector3(global_position.x + velocity.x, global_position.y, global_position.z + velocity.z)
	if not look_at_target.is_equal_approx(global_position): look_at(look_at_target, up_direction, true)
	
	move_and_slide()

func update_seat(placement : Placement) -> void:
	seat = placement
	update_target_pos(seat.chair.global_position)

func update_target_pos(target_pos: Vector3) -> void:
	nav_agent.target_position = target_pos


func sit() -> void:
	if seat.pickup: eat()
	else:
		animation.play("waiting") 
		seat.pickup_placed.connect(eat)

func look_at_table() -> void:
	var look_at_target = seat.place_mesh.global_position
	look_at_target.y = seat.chair.global_position.y
	look_at_from_position(seat.chair.global_position, look_at_target, up_direction, true)

func _on_nav_agent_navigation_finished() -> void:
	moving = false
	animation.speed_scale = 1
	if not eaten: sit()
	else: queue_free()

func eat() -> void:
	animation.play("eating") 
	seat.pickup_placed.disconnect(eat)
	timer.start()

func _on_timer_timeout() -> void:
	animation.play("getup")
	seat.free_seat()
	eaten = true
	moving = true
	update_target_pos(door.global_position)

func splat() -> void:
	flinching = true
	animation.speed_scale = 1
	animation.play("gethit_001")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "gethit_001": flinching = false
