extends KinematicBody2D

export(float) var speed = 80.0
var velocity = Vector2(0.5, 0.5) * speed

signal ball_ready

var beep_sfx = preload("res://Assets/SFX/beep.wav")
var explosion_sfx = preload("res://Assets/SFX/explosion.wav")

var explosion_particles = preload("res://Scenes/Explosion.tscn")

func _ready():
	GameManager.ball = self

func _physics_process(delta):
	var collision_info = move_and_collide(velocity * delta)
	if(collision_info):
		velocity = velocity.bounce(collision_info.normal)
		play_sfx(beep_sfx, 0.02)
	if(global_position.x < 0):
		ScoreManager.add_score(0, 1)
		explode()
		global_position = Vector2(80.0, 45.0)
		play_sfx(explosion_sfx, 0.05)
	if(global_position.x > 160):
		ScoreManager.add_score(1, 0)
		explode()
		global_position = Vector2(80.0, 45.0)
		play_sfx(explosion_sfx, 0.05)

func frame_freeze(time_scale, duration):
	Engine.time_scale = time_scale
	yield(get_tree().create_timer(duration * time_scale), "timeout")
	Engine.time_scale = 1.0
	emit_signal("ball_ready")

func play_sfx(sfx, pitch_range):
	$AudioStreamPlayer.stop()
	$AudioStreamPlayer.stream = sfx
	$AudioStreamPlayer.pitch_scale = rand_range(1.0 - pitch_range, 1.0 + pitch_range)
	$AudioStreamPlayer.play()


func explode():
	var particles = explosion_particles.instance()
	GameManager.camera.shake()
	GameManager.camera.set_zoom(0.7)
	get_parent().add_child(particles)
	particles.global_position = global_position
	frame_freeze(0.1, 0.4)
	play_sfx(explosion_sfx, 0.05)

func _on_ball_ball_ready():
	GameManager.camera.set_zoom(1.0)
