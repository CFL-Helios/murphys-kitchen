class_name EndScreen extends CanvasLayer

@onready var scoreboard : RichTextLabel = $ColorRect/PanelContainer/MarginContainer/VBoxContainer/Score

var main_menu : PackedScene = preload("res://levels/start_menu.tscn")

func _ready() -> void:
	hide()

func set_score(score : int) -> void:
	scoreboard.text = "Score : " + str(score)

func _on_main_menu_pressed() -> void:
	print("return to main")
	get_tree().paused = false
	get_tree().change_scene_to_packed(main_menu)

func _on_play_again_pressed() -> void:
	print("play again")
	get_tree().paused = false
	ScoreManager.score = 0
	get_tree().reload_current_scene()
