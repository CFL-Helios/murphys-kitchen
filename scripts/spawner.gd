extends Node3D

var customer_file = preload("res://entities/customer/customer.tscn")
@export var tables : TableManager

@onready var timer : Timer = $Timer
@onready var reference_cust : MeshInstance3D = $CustomerMesh

func _ready() -> void:
	reference_cust.hide()

func spawn():
	if not tables.has_vacant(): return
	var customer : Customer = customer_file.instantiate()
	add_child(customer)
	customer.door = self
	customer.update_seat(tables.get_vacant())

func _on_timer_timeout() -> void:
	spawn()
