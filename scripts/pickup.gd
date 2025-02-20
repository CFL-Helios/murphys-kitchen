class_name Pickup extends InteractionArea

@export var dish: RigidBody3D
@export var food : Food

func highlight(_on: bool) -> void:
	food.highlight(_on)

func score() -> void:
	ScoreManager.score += food.get_score()
	InteractionManager.unreg_area(self)
	active = false
