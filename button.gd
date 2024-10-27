# NPC.gd (Attach this to the NPC node)
extends Sprite2D

var can_interact = false              # Tracks if the player is close enough to interact
var interaction_distance = 50.0        # Maximum distance for interaction
var buttons_visible = false            # Tracks if buttons are currently visible
var buttons = []                       # Stores the buttons created in code

func _process(delta):
	# Find the player node
	var player = get_parent().get_node_or_null("Player")
	
	if player:
		# Calculate the distance to the player
		var distance_to_player = global_position.distance_to(player.global_position)
		can_interact = distance_to_player <= interaction_distance

		# Check if 'E' is pressed and the player is within range
		if can_interact and Input.is_action_just_pressed("interact"):
			if buttons_visible:
				hide_buttons()
			else:
				show_buttons()
	else:
		print("Player node not found in the parent scene.")

func show_buttons():
	# Create 4 buttons dynamically
	for i in range(4):
		var button = Button.new()
		button.text = "Option " + str(i + 1)
		button.position = Vector2(100, 100 + i * 50)  # Adjust position as needed
		button.callable("pressed", self, "_on_button_pressed", [i])
		add_child(button)  # Add the button as a direct child of NPC
		buttons.append(button)  # Keep track of buttons
	buttons_visible = true
	print("Buttons are now visible.")

func hide_buttons():
	# Remove and delete all dynamically created buttons
	for button in buttons:
		button.queue_free()  # Remove the button from the scene
	buttons.clear()  # Clear the list of buttons
	buttons_visible = false
	print("Buttons are now hidden.")

func _on_button_pressed(button_index):
	# Handle button press with the index
	print("Button", button_index + 1, "was pressed!")
	# Optionally, add functionality based on the button index
