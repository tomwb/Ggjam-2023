extends Node2D


func _ready():
	pass

func changeToGame():
	GameController.changeToLevel("res://scennes/levels/LevelBase.tscn")
