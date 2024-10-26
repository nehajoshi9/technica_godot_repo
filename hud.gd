extends CanvasLayer

func level(num):
	$CurrentLevel.text = "Level: " + str(num)
	
func gems(num):
	$GemsLabel.text = "Trash: " + str(num)
