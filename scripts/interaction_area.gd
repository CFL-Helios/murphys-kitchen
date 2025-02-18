class_name InteractionArea extends Area3D

@export var action_name: String = "interact"
@export var is_pickup: bool

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		InteractionManager.reg_area(self)

func _on_body_exited(body: Node3D) -> void:
	if body.is_in_group("Player"):
		InteractionManager.unreg_area(self)
