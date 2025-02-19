class_name Food extends Node3D

@export var highlight_mat : Material

var food_items : Array[FoodItem]

func _ready() -> void:
	var children = get_children()
	for child in children:
		if child is FoodItem:
			food_items.push_back(child)

func highlight(_on: bool):
	var food_meshes : Array[MeshInstance3D]
	for item in food_items:
		if item:
			for mesh in item.get_meshes():
				mesh.material_overlay = highlight_mat if _on else null

	return food_meshes
