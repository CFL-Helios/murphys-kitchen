class_name FoodItem extends RigidBody3D

@onready var splatter : Decal = $FoodSplatter
@onready var splat_sound : AudioStreamPlayer3D = $"../SplatSound"

var food_meshes : Array[MeshInstance3D]

func _ready() -> void:
	var children = get_children()
	for child in children:
		if child is MeshInstance3D:
			food_meshes.push_back(child)

func get_meshes() -> Array[MeshInstance3D]:
	return food_meshes

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Food Safe"): return
	elif body is Customer: body.splat()
	splat_sound.play()
	splatter.reparent(body)
	splatter.show()
	
	queue_free()
