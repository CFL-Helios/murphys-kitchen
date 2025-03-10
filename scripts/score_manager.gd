extends Node

var score : int = 0
signal score_changed(score : int)
signal time_changed(time: float)

var interaction_manager : InteractionManager

func add_score(points : int):
	score += points
	score_changed.emit(score)

func set_time(time: float):
	time_changed.emit(time)

func get_all_children(node : Node):
	var nodes : Array = []

	for N in node.get_children():
		nodes.append(N)
		if N.get_child_count() > 0:
			nodes.append_array(get_all_children(N))
			
	return nodes
