extends HBoxContainer

var bounce_amplitude = 5        # Controls how much the container bounces up and down
var bounce_speed = 3            # Speed of the bounce
var rotation_amplitude = 0.05   # Amount of rotation
var rotation_speed = 2          # Speed of rotation
var start_position

func _ready():
	# Store the initial position of the container
	start_position = position

func _process(delta):
	# Apply vertical bounce to the container
	position.y = start_position.y + sin(Time.get_ticks_msec() / 1000.0 * bounce_speed) * bounce_amplitude
	
	# Apply rotation to the container
	rotation = sin(Time.get_ticks_msec() / 1000.0 * rotation_speed) * rotation_amplitude
