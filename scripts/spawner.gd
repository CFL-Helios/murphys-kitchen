extends Node3D

@export var customer_file : PackedScene
@export var tables : TableManager

@onready var timer : Timer = $Timer

func spawn():
	if not tables.has_vacant(): return
	var customer : Customer = customer_file.instantiate()
	add_child(customer)
	customer.update_target_pos(tables.get_vacant().chair.global_position)


func _on_timer_timeout() -> void:
	spawn()
