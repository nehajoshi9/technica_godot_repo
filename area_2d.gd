# NPC.gd
extends Area2D

var can_interact = false  # Tracks if the player is close enough to interact
var question_ui_scene = preload("res://QuestionUI.tscn")  # Load the question UI scene

# Called when the script instance is loaded
func _ready():
	# Connect signals for detecting the player's presence within the interaction zone
	connect("body_entered", self, "_on_Area2D_body_entered")
	connect("body_exited", self, "_on_Area2D_body_exited")

# Detects when a player enters the interaction area
func _on_Area2D_body_entered(body):
	if body.name == "Player":
		can_interact = true  # Enable interaction when the player is in range

# Detects when a player leaves the interaction area
func _on_Area2D_body_exited(body):
	if body.name == "Player":
		can_interact = false  # Disable interaction when the player moves out of range

# Called every frame to check for input
func _process(delta):
	if can_interact and Input.is_action_just_pressed("interact"):
		show_question()  # Display the question when 'E' is pressed

# Instantiates and displays the question UI
func show_question():
	var question_ui = question_ui_scene.instance()
	get_tree().get_root().add_child(question_ui)
