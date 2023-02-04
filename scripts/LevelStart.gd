extends Node2D

const pre_bunny = preload("res://scennes/Bunny.tscn")

func _ready():
	invoqueBunnies()

func invoqueBunnies():
	if GameController.bunnies.size() > 0:
		for i in range(GameController.bunnies.size()):
			var bunny = pre_bunny.instance()
			bunny.global_position = $StartPosition2D.global_position
			$Path2D.add_child(bunny)
			bunny.onCreate(GameController.bunnies[i]["type"], GameController.bunnies[i]["index"])
			bunny.set_offset(150 * i)
			bunny.walk = true
