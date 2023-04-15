extends Node

signal score_changed(p1, p2)
signal game_over

var p1_score : int = 0
var p2_score : int = 0

func add_score(add_p1, add_p2):
	p1_score += add_p1
	p2_score += add_p2
	
	if(p1_score > 9 or p2_score > 9):
		emit_signal("game_over")
		return
	emit_signal("score_changed", p1_score, p2_score)

func set_score(set_p1, set_p2):
	p1_score = set_p1
	p2_score = set_p2
	emit_signal("score_changed", p1_score, p2_score)
