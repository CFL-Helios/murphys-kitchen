class_name Pickup extends InteractionArea

@export var dish: RigidBody3D
@export var food : Food

func highlight(_on: bool):
	food.highlight(_on)
