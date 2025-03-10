class_name TableManager extends Node3D

var vacant : Array[Placement]
var occupied : Array[Placement]

func _ready() -> void:
	var children = ScoreManager.get_all_children(self)
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

func has_vacant() -> bool:
	return not vacant.is_empty()

func free_seat(placement: Placement):
	occupied.erase(placement)
	vacant.push_back(placement)
