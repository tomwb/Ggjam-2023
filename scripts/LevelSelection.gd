extends Node2D


func _ready():
	$CanvasLayer/AnimationPlayer.play("Buttons")

func changeToGame():
	GameController.changeToLevel("res://scennes/levels/LevelLore.tscn")

func _on_QuitButton_pressed():
	get_tree().quit()

func _on_CreditsButton_pressed():
	pass
