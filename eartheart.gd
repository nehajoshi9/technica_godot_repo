extends Sprite2D

var bounce_amplitude = 5
var bounce_speed = 3       # Increased speed for faster bounce
var rotation_amplitude = 0.05
var rotation_speed = 2     # Increased speed for faster rotation
var start_position

func _ready():
	start_position = position

func _process(delta):
	# Combined vertical bounce and rotation effect with faster speed
	position.y = start_position.y + sin(Time.get_ticks_msec() / 1000.0 * bounce_speed) * bounce_amplitude
	rotation = sin(Time.get_ticks_msec() / 1000.0 * rotation_speed) * rotation_amplitude
