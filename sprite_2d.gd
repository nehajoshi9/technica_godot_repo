# NPC.gd (Attach this script to the NPC node, such as Sprite2D)
extends Sprite2D

var can_interact = false
var interaction_distance = 50.0
var popup_panel = null  # Holds the popup panel

func _process(delta):
	# Find the player node
	var player = get_parent().get_node_or_null("Player")
	
	if player:
		# Calculate the distance to the player
		var distance_to_player = global_position.distance_to(player.global_position)
		can_interact = distance_to_player <= interaction_distance

		# Show popup on 'E' press if player is within range
		if can_interact and Input.is_action_just_pressed("interact"):
			if popup_panel == null:
				create_popup()
			else:
				remove_popup()
	else:
		print("Player node not found in the parent scene.")

func create_popup():
	# Create a PopupPanel
	popup_panel = PopupPanel.new()
	popup_panel.set_size(Vector2(200, 200))  # Set the panel size

	# Create a VBoxContainer for vertical layout
	var vbox = VBoxContainer.new()
	vbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	vbox.size_flags_vertical = Control.SIZE_EXPAND_FILL
	vbox.anchor_left = 0.1
	vbox.anchor_right = 0.9
	vbox.anchor_top = 0.1
	vbox.anchor_bottom = 0.9
	popup_panel.add_child(vbox)

	# Add buttons to the VBoxContainer
	for i in range(4):
		var button = Button.new()
		button.text = "Option " + str(i + 1)
		button.custom_minimum_size = Vector2(180, 40)  # Set button size using custom_minimum_size
		button.pressed.connect(Callable(self, "_on_button_pressed").bind(i))  # Godot 4 style
		vbox.add_child(button)  # Add button to VBoxContainer for automatic layout

	# Add the popup to the root viewport and center it
	get_tree().root.add_child(popup_panel)
	popup_panel.popup_centered()
	print("Popup with buttons is now visible.")

func remove_popup():
	# Remove and delete the popup
	if popup_panel:
		popup_panel.queue_free()
		popup_panel = null
	print("Popup with buttons has been hidden.")

func _on_button_pressed(button_index):
	# Handle button press by index
	print("Button", button_index + 1, "was pressed!")
	remove_popup()  # Optionally hide the popup after a button is pressed
