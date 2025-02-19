extends RigidBody3D

@onready var splatter : Decal = $FoodSplatter

func _on_body_entered(body: Node) -> void:
	print(body.name)
	if body.is_in_group("Food Safe"): return
	
	splatter.reparent(body)
	splatter.show()
	
	queue_free()
