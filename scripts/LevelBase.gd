extends Node2D

const pre_bunny = preload("res://scennes/Bunny.tscn")

export(int) var max_bunnies = 15
var bunnies = []
var canAddNew = true

func _ready():
	GameController.connect("onAddBunny", self, "onAddBunny")
	pass

func addBunny():
	if canAddNew == true && max_bunnies > bunnies.size():
		GameController.addBunny()
	
func onAddBunny():
	if canAddNew == true && max_bunnies > bunnies.size(): 
		canAddNew = false
		if bunnies.size() > 0:
			for bunny in bunnies:
				bunny.walk = true
			yield(get_tree().create_timer(1), "timeout")
			for bunny in bunnies:
				bunny.walk = false
		var bunny = pre_bunny.instance()
		bunny.global_position = $CloneCenterPosition2D.global_position
		$Path2D.add_child(bunny)
		bunnies.append(bunny)
		bunny.walk = true
		yield(get_tree().create_timer(1), "timeout")
		bunny.walk = false
		canAddNew = true


func startWave():
	get_tree().change_scene("res://scennes/levels/Level1.tscn")
