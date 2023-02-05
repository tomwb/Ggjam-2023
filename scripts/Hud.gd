extends Node2D


func _ready():
	GameController.connect("updateHud", self, "onUpdateHud")
	onUpdateHud()
	
func onUpdateHud():
	$CanvasLayer/CollectibleCarrotText.set_text(str(GameController.collectibleCarrot).pad_zeros(3))
	$CanvasLayer/CollectibleStrongText.set_text(str(GameController.collectibleStrong).pad_zeros(3))
	$CanvasLayer/CollectibleFastText.set_text(str(GameController.collectibleFast).pad_zeros(3))
	$CanvasLayer/CollectibleShooterText.set_text(str(GameController.collectibleShooter).pad_zeros(3))
	$CanvasLayer/WaveText.set_text("Wave: " + str(GameController.wave).pad_zeros(3))

