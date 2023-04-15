extends Node

enum GAME_MODE {
	MULTIPLAYER,
	SINGLE_PLAYER	
}

var game_mode = GAME_MODE.SINGLE_PLAYER

#References
var camera = null
var ball = null

func start_single_player():
	game_mode = GAME_MODE.SINGLE_PLAYER
	start_game()

func start_multiplayer():
	game_mode = GAME_MODE.MULTIPLAYER
	start_game()

func start_game():
	var _scene = get_tree().change_scene("res://Scenes/Game.tscn")

func quit_game():
	get_tree().quit()
