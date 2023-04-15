extends KinematicBody2D

enum PLAYER_TYPE {P1, P2, CPU}
export(PLAYER_TYPE) var player_type

export(float) var speed = 30.0

onready var sprite_height = $Sprite.get_texture().get_height()

func _ready():
	if(player_type != PLAYER_TYPE.P1):
		player_type = GameManager.game_mode + 1

func _physics_process(delta):
	var direction = 0.0
	match player_type:
		PLAYER_TYPE.P1:
			direction = Input.get_axis("player1_down", "player1_up")
		PLAYER_TYPE.P2:
			direction = Input.get_axis("player2_down", "player2_up")
		PLAYER_TYPE.CPU:
			if(GameManager.ball != null):
				direction = sign(round(global_position.y - GameManager.ball.global_position.y))
	var velocity = speed * direction * Vector2.UP * delta
	if global_position.y + ((sprite_height/2)*sign(velocity.y)) < 90 and global_position.y + ((sprite_height/2)*sign(velocity.y)) > 0:
		global_translate(velocity)
