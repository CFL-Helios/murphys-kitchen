extends CanvasLayer
@onready var score_label : RichTextLabel = $ScoreLabel

func _ready() -> void:
	ScoreManager.score_changed.connect(_on_score_changed)
	_on_score_changed(0)
	
func _on_score_changed(score: int):
	score_label.text = "Score: " + str(score)
