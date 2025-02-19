class_name Placement extends InteractionArea

@onready var place_mesh : MeshInstance3D = $InteractionMesh

func _ready() -> void:
	place_mesh.hide()

func highlight(_on: bool):
	place_mesh.show() if _on else place_mesh.hide()
