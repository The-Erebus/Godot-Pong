extends Node2D

var isGameOver = false

func _ready():
	ScoreManager.set_score(0,0)
	var _connect = ScoreManager.connect("game_over", self, "game_over")

func _input(event):
	if(event is InputEventKey and event.is_pressed() and isGameOver):
		var _scene = get_tree().change_scene("res://Scenes/Menu.tscn")
	
func game_over():
	GameManager.ball.velocity = Vector2.ZERO
	$main.visible = false
	$win_screen.visible = true
	if(ScoreManager.p1_score > ScoreManager.p2_score):
		$win_screen/Player_wins.text = "Player 1 wins"
	else:
		$win_screen/Player_wins.text = "Player 2 wins"
	
	#Give time for the slow motion effect to finish
	yield(get_tree().create_timer(0.25), "timeout")
	isGameOver = true
