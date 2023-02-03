extends Node2D

const pre_bunny = preload("res://scennes/Bunny.tscn")

func _ready():
	invoqueBunnies()

func invoqueBunnies():
	if GameController.total_bunnies.size() > 0:
		for i in range(GameController.total_bunnies.size()):
			var bunny = pre_bunny.instance()
			bunny.global_position = $StartPosition2D.global_position
			$YSort/Path2D.add_child(bunny)
			bunny.set_offset(150 * i)
			bunny.walk = true
