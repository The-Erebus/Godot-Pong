extends Node2D

func _ready():
	var _connect = ScoreManager.connect("score_changed", self, "set_score")

func set_score(p1, p2):
	$Score_p1.frame = p1
	$Score_p2.frame = p2
