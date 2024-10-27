extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label.text = "Congrats on collecting " + str(Global.gems_collected) + " trash! 
	Remember, picking up litter keeps the 
	earth healthy!"
