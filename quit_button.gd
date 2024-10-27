extends TextureButton

var bounce_amplitude = 5
var bounce_speed = 3
var rotation_amplitude = 0.05
var rotation_speed = 2
var start_min_size

func _ready():
	# Store the button's initial minimum size
	start_min_size = rect_min_size

func _process(delta):
	# Simulate a vertical bounce by modifying rect_min_size
	rect_min_size.y = start_min_size.y + sin(Time.get_ticks_msec() / 1000.0 * bounce_speed + get_instance_id()) * bounce_amplitude
	
	# Apply rotation to the button
	rotation = sin(Time.get_ticks_msec() / 1000.0 * rotation_speed + get_instance_id()) * rotation_amplitude
