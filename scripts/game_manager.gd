extends Node3D

@export var input_exit : String = "exit"

@onready var end_screen : EndScreen = $EndScreen
@onready var end_sound : AudioStreamPlayer3D = $EndSound
@onready var game_timer : Timer = $Timer
var main_menu : PackedScene = preload("res://levels/start_menu.tscn")

func _process(delta: float) -> void:
	ScoreManager.set_time(game_timer.time_left)

func _input(event: InputEvent) -> void:
	if event.is_action(input_exit):
		get_tree().change_scene_to_packed(main_menu)

func _on_timer_timeout() -> void:
	get_tree().paused = true
	end_sound.play()
	end_screen.set_score(ScoreManager.score)
	end_screen.show()
