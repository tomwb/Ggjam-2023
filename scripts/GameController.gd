extends Node2D

enum  bunniesTypes {
	Basic, Fast, Strong, StrongFast
}

var bunnies = []

func _ready():
	pass

func addBunny():
	var type = bunniesTypes.Basic
	bunnies.append({
		"type": type,
		"index": bunnies.size()
	})
	return bunnies[bunnies.size() - 1]
	
func changeBunny(index, type):
	var new_bunnies = []
	for bunny in bunnies:
		if bunny["index"] == index:
			bunny["type"] = type
		new_bunnies.append(bunny)
	bunnies = new_bunnies

func changeToLevel(level_name):
	$AnimationPlayer.play("fade_in")
	yield(get_tree().create_timer(1), "timeout")
	get_tree().change_scene(level_name)
	yield(get_tree().create_timer(0.2), "timeout")
	$AnimationPlayer.play("fade_out")

	
