class_name Pickup extends InteractionArea

@export var dish: RigidBody3D
@export var food : Food
@onready var cash_sound : AudioStreamPlayer3D = $"../../CashSound"

@onready var top_node : Node3D = $"../.."

func highlight(_on: bool) -> void:
	food.highlight(_on)

func score() -> void:
	cash_sound.play()
	print("cashing")
	ScoreManager.add_score(food.get_score())
	ScoreManager.interaction_manager.unreg_area(self)

func eat() -> void:
	score()



func _on_cash_sound_finished() -> void:
	top_node.queue_free()
