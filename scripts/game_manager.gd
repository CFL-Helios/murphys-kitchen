extends Node3D

@export var input_exit : String = "exit"

@onready var end_screen : EndScreen = $EndScreen
@onready var end_sound : AudioStreamPlayer = $EndSound
@onready var bgm : AudioStreamPlayer = $BGM

@onready var game_timer : Timer = $Timer


func _process(_delta: float) -> void:
	ScoreManager.set_time(game_timer.time_left)

func _input(event: InputEvent) -> void:
	if event.is_action(input_exit):
		_on_timer_timeout()


func _on_timer_timeout() -> void:
	get_tree().paused = true
	bgm.stop()
	end_sound.play()
	end_screen.set_score(ScoreManager.score)
	end_screen.show()
