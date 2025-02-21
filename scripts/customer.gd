extends CharacterBody3D

@onready var nav_agent : NavigationAgent3D = $NavAgent

@export var speed : float
@export var arrival_dist : float

func _physics_process(delta: float) -> void:
	if nav_agent.target_position.distance_to(global_position) < arrival_dist:
		print("arrived")
		
	velocity = (nav_agent.get_next_path_position() - global_position).normalized() * speed
	move_and_slide()

func update_target_pos(target_pos: Vector3):
	nav_agent.target_position = target_pos
