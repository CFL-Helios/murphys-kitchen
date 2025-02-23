extends Node3D

var pickup_packed : PackedScene = preload("res://entities/pickup/pickup.tscn")

@onready var timer : Timer = $Timer
@onready var plate_mesh : MeshInstance3D = $PlateMesh

func _ready() -> void:
	var time = randf_range(10, 15)
	timer.wait_time = time
	timer.start()
	plate_mesh.hide()

func _on_timer_timeout() -> void:
	var pickup = pickup_packed.instantiate()
	add_child(pickup)
