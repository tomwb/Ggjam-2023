extends Node2D

enum  bunniesTypes {
	Basic, Fast, Strong, StrongFast
}

var bunnies = []

func _ready():
	pass

func addBunny():
	var type = bunniesTypes.Basic
	if bunnies.size() == 1:
		type = bunniesTypes.Strong
	if bunnies.size() == 2:
		type = bunniesTypes.Fast
	if bunnies.size() == 3:
		type = bunniesTypes.StrongFast
	bunnies.append({
		"type": type,
		"index": bunnies.size()
	})
	return bunnies[bunnies.size() - 1]

func changeToLevel(level_name):
	$AnimationPlayer.play("fade_in")
	yield(get_tree().create_timer(1), "timeout")
	get_tree().change_scene(level_name)
	yield(get_tree().create_timer(0.2), "timeout")
	$AnimationPlayer.play("fade_out")

	
