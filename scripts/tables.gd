extends Node3D

var vacant : Array[Placement]
var occupied : Array[Placement]

func _ready() -> void:
	var children = get_children()
	for child in children:
		if child is Placement:
			vacant.push_back(child)
			child.freed.connect(free_seat)

func get_vacant() -> Placement:
	var idx = randi_range(0, vacant.size() - 1)
	var seat = vacant.get(idx)
	vacant.remove_at(idx)
	occupied.push_back(seat)
	return seat

func free_seat(placement: Placement):
	occupied.erase(placement)
	vacant.push_back(placement)
