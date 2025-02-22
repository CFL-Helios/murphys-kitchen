class_name Pickup extends InteractionArea

@export var dish: RigidBody3D
@export var food : Food

@onready var top_node : Node3D = $"../.."

func highlight(_on: bool) -> void:
	food.highlight(_on)

func score() -> void:
	ScoreManager.score += food.get_score()
	ScoreManager.interaction_manager.unreg_area(self)
	active = false

func eat() -> void:
	top_node.queue_free()
