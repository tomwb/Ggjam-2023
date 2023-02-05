extends Control


func _ready():
	$AnimationPlayer.play("TextScrolling")
	yield($AnimationPlayer, "animation_finished")
	Engine.time_scale = 1
	yield(get_tree().create_timer(0.5), "timeout")
	GameController.changeToLevel("res://scennes/levels/LevelBase.tscn")
	


func _on_FastFoward_pressed():
	Engine.time_scale = 15

