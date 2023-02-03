extends Node2D


func _ready():
	pass

func changeToGame():
	get_tree().change_scene("res://scennes/levels/LevelBase.tscn")
