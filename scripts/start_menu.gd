extends Control

var main_scene : PackedScene = preload("res://levels/player_test.tscn")

func _on_start_pressed() -> void:
	get_tree().change_scene_to_packed(main_scene)


func _on_quit_pressed() -> void:
	get_tree().quit()
