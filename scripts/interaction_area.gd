class_name InteractionArea extends Area3D

var active : bool = true

func _on_body_entered(body: Node3D) -> void:
	if active and body.is_in_group("Player"):
		InteractionManager.reg_area(self)

func _on_body_exited(body: Node3D) -> void:
	if active and body.is_in_group("Player"):
		InteractionManager.unreg_area(self)

func highlight(_on: bool):
	pass
