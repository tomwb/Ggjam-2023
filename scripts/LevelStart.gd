extends Node2D

const pre_bunny = preload("res://scennes/Bunny.tscn")

var bunnies = []

func _ready():
	yield($LevelSpawner/AnimationPlayer,"animation_finished")
	$LevelSpawner/AnimationPlayer.play("open")

func spawnBunny():
	if GameController.bunnies.size() > 0 && bunnies.size() < GameController.bunnies.size():
			var bunny = pre_bunny.instance()
			bunny.global_position = $StartPosition2D.global_position
			$Path2D.add_child(bunny)
			bunnies.append(bunny)
			bunny.onCreate(GameController.bunnies[bunnies.size() -1]["type"], GameController.bunnies[bunnies.size() - 1]["index"])
			bunny.walk = true
			yield($LevelSpawner/AnimationPlayer,"animation_finished")
			if bunnies.size() < GameController.bunnies.size():
				$LevelSpawner/AnimationPlayer.play("open")
