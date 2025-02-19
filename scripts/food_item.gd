extends RigidBody3D


func _on_body_entered(body: Node) -> void:
	print(body.name)
	if body.is_in_group("Food Safe"): return
	queue_free()
