extends Node2D


func _ready():
	$CanvasLayer/AnimationPlayer.play("Buttons")

func changeToGame():
	GameController.changeToLevel("res://scennes/levels/Lore.tscn")


func _on_QuitButton_pressed():
	get_tree().quit()
