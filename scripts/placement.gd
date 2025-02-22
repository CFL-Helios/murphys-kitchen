class_name Placement extends InteractionArea

@onready var place_mesh : MeshInstance3D = $InteractionMesh
@export var chair : RigidBody3D

var pickup : InteractionArea
signal pickup_placed(pickup: Pickup)
signal freed(placement: Placement)

func _ready() -> void:
	place_mesh.hide()

func highlight(_on: bool):
	place_mesh.show() if _on else place_mesh.hide()

func place_pickup(newPickup):
	pickup = newPickup
	pickup_placed.emit(pickup)
	active = false

func free_seat() -> void:
	freed.emit(self)
	active = true
