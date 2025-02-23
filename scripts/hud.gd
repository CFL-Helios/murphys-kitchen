extends CanvasLayer
@onready var score_label : RichTextLabel = $ScoreLabel
@onready var timer_label : RichTextLabel = $TimerLabel

func _ready() -> void:
	ScoreManager.score_changed.connect(_on_score_changed)
	_on_score_changed(0)
	
	ScoreManager.time_changed.connect(_on_time_changed)
	
func _on_score_changed(score: int):
	score_label.text = "Score: " + str(score)

func _on_time_changed(time: float):
	var minutes = int(time/60)
	var seconds = int(time) % 60
	timer_label.text = "%02d:%02d" % [minutes, seconds]
