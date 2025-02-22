class_name FoodItem extends RigidBody3D

@onready var splatter : Decal = $FoodSplatter
var food_meshes : Array[MeshInstance3D]

func _ready() -> void:
	var children = get_children()
	for child in children:
		if child is MeshInstance3D:
			food_meshes.push_back(child)

func get_meshes() -> Array[MeshInstance3D]:
	return food_meshes

func _on_body_entered(body: Node) -> void:
	print(body.name)
	if body.is_in_group("Food Safe"): return
	
	splatter.reparent(body)
	splatter.show()
	
	queue_free()
