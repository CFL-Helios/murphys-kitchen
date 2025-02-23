class_name StartMenu extends CanvasLayer

var main_scene : PackedScene = preload("res://levels/kitchen.tscn")

func _on_start_pressed() -> void:
	ScoreManager.score = 0
	get_tree().change_scene_to_packed(main_scene)


func _on_quit_pressed() -> void:
	get_tree().quit()
