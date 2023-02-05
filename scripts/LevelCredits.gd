extends Control


func _ready():
	pass

func _on_Button_pressed():
	GameController.changeToLevel("res://scennes/levels/LevelStart.tscn")
