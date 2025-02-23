class_name InteractionManager extends Node3D

@onready var player : TopDownPlayer = get_tree().get_first_node_in_group("Player")

var active_pickups : Array[InteractionArea] = []
var active_placements : Array[InteractionArea] = []

var closest_pickup : InteractionArea
var closest_placement : InteractionArea
var holding_object : bool = false

func _init() -> void:
	ScoreManager.interaction_manager = self

func reg_area(area: InteractionArea):
	if area is Pickup: active_pickups.push_back(area)
	else: active_placements.push_back(area)
	
func unreg_area(area: InteractionArea):
	area.highlight(false)
	if area is Pickup: active_pickups.erase(area)
	else: active_placements.erase(area)
	
func _process(_delta: float) -> void:
	if not player or not player.has_moved(): return
	elif holding_object and not active_placements.is_empty():
		closest_placement = _get_closest(active_placements)
	elif not holding_object and not active_pickups.is_empty():
		closest_pickup = _get_closest(active_pickups)

func _get_closest(areas: Array[InteractionArea]):
	var closest = areas.reduce(_reduce_by_dist)
	
	for area in areas: area.highlight(false)
	if closest: closest.highlight(true)
	return closest
		
func _reduce_by_dist(area1: InteractionArea, area2: InteractionArea):
	if not area1: return area2
	if not area2: return area1
	
	var a1_dist = player.global_position.distance_to(area1.global_position)
	var a2_dist = player.global_position.distance_to(area2.global_position)
	
	return area1 if a1_dist < a2_dist else area2

func _input(event: InputEvent) -> void:
	if not event.is_action_pressed("interact"): return
		
	if holding_object: 
		if active_placements.is_empty(): player.drop_pickup()
		else: 
			closest_placement.place_pickup(player.pickup)
			closest_placement.highlight(false)
			player.pickup.active = false
			player.place_pickup(closest_placement.global_position)
		
		holding_object = false
		closest_pickup = _get_closest(active_pickups)
		
	elif not active_pickups.is_empty():
		player.take_pickup(closest_pickup)
		closest_pickup.highlight(false)
		
		holding_object = true
		closest_placement = _get_closest(active_placements)
