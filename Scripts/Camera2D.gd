extends Camera2D

#Camera shake parameters

export(float) var noise_shake_speed = 60.0
export(float) var noise_shake_strength = 5.0
export(float) var shake_decay_rate = 5.0

onready var noise = OpenSimplexNoise.new()

var noise_i = 0.0 
var shake_strength = 0.0

#Zoom parameters
export(float) var zoom_speed = 2.0
export(float) var zoom_target_value = 1.0

func _ready():
	randomize()
	noise.seed = randi()
	noise.period = 2
	GameManager.camera = self

func shake():
	shake_strength = noise_shake_strength

func _process(delta):
	shake_strength = lerp(shake_strength, 0, shake_decay_rate * delta)
	offset = get_noise_offset(delta)
	if(zoom.x != zoom_target_value):
		change_zoom(delta, zoom_target_value)

func set_zoom(zoom_value):
	zoom_target_value = zoom_value

func change_zoom(delta, zoom_value):
	zoom = zoom.linear_interpolate(Vector2(zoom_value, zoom_value), zoom_speed * delta)

func get_noise_offset(delta) -> Vector2:
	noise_i += delta * noise_shake_speed
	
	return Vector2(
		noise.get_noise_2d(1, noise_i) * shake_strength,
		noise.get_noise_2d(100, noise_i) * shake_strength
	)
