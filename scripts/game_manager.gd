extends Node3D

@export var input_exit : String = "exit"

var main_menu : PackedScene = preload("res://levels/start_menu.tscn")

func _input(event: InputEvent) -> void:
	if event.is_action(input_exit):
		get_tree().change_scene_to_packed(main_menu)

func _on_timer_timeout() -> void:
	pass
