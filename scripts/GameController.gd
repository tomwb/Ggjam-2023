extends Node2D

enum  bunniesTypes {
	Basic, Fast, Strong, Shooter, StrongFast, StrongShooter, FastShooter
}

signal updateHud

var bunnies = []
var wave = 0
var collectibleCarrot = 0
var collectibleStrong = 0
var collectibleFast = 0
var collectibleShooter = 0

func _ready():
	resetCollectible()
	
func resetCollectible() :
	collectibleCarrot = 3
	collectibleStrong = 0
	collectibleFast = 0
	collectibleShooter = 0

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
	
func removeBunny(index):
	var new_bunnies = []
	for bunny in bunnies:
		if bunny["index"] != index:
			new_bunnies.append(bunny)
	bunnies = new_bunnies
	if bunnies.size() == 0:
		backToBase()

func backToBase():
	yield(get_tree().create_timer(1), "timeout")
	Engine.time_scale = 1.0
	changeToLevel("res://scennes/levels/LevelBase.tscn")

func changeToLevel(level_name):
	$AnimationPlayer.play("fade_in")
	yield(get_tree().create_timer(1), "timeout")
	get_tree().change_scene(level_name)
	yield(get_tree().create_timer(0.2), "timeout")
	$AnimationPlayer.play("fade_out")

	

func startLevel():
	changeToLevel("res://scennes/levels/Level1.tscn")
	wave += 1
	emit_signal("updateHud")

func addCollectible(type):
	if type == bunniesTypes.Basic:
		collectibleCarrot += 1
	if type == bunniesTypes.Strong:
		collectibleStrong += 1
	if type == bunniesTypes.Fast:
		collectibleFast += 1
	if type == bunniesTypes.Shooter:
		collectibleShooter += 1
	emit_signal("updateHud")
	
func removeCollectible(type):
	if type == bunniesTypes.Basic:
		collectibleCarrot -= 1
	if type == bunniesTypes.Strong:
		collectibleStrong -= 1
	if type == bunniesTypes.Fast:
		collectibleFast -= 1
	if type == bunniesTypes.Shooter:
		collectibleShooter -= 1
	emit_signal("updateHud")
