extends Node3D

var pickup_packed : PackedScene = preload("res://entities/pickup/pickup.tscn")

@onready var timer : Timer = $Timer
@onready var start_timer : Timer = $StartTimer
@onready var plate_mesh : MeshInstance3D = $PlateMesh
@onready var chef_sound : AudioStreamPlayer3D = $ChefSound
@onready var bell_sound : AudioStreamPlayer3D = $BellSound

func _ready() -> void:
	var start_time = randf_range(10, 50)
	start_timer.wait_time = start_time
	start_timer.start()
	plate_mesh.hide()

func _on_timer_timeout() -> void:
	var pickup = pickup_packed.instantiate()
	add_child(pickup)
	chef_sound.play()
	bell_sound.play()

func _on_start_timer_timeout() -> void:
	_on_timer_timeout()
	var time = randf_range(40, 60)
	timer.wait_time = time
	timer.start()
