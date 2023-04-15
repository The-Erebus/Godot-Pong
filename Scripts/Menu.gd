extends Node2D

func _ready():
	$VBoxContainer/start_1p.grab_focus()


func _on_start_1p_pressed():
	GameManager.start_single_player()

func _on_start_2p_pressed():
	GameManager.start_multiplayer()

func _on_quit_pressed():
	GameManager.quit_game()
