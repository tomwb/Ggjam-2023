extends Node2D

const pre_bunny = preload("res://scennes/Bunny.tscn")

var bunnies = []
var finish = false

func _ready():
	yield($LevelSpawner/AnimationPlayer,"animation_finished")
	$LevelSpawner/AnimationPlayer.play("open")
	$LevelSpawner/OpenSound.pitch_scale = 10
	
	
func _process(delta):
	var first_bunny_position
	for bunny in bunnies:
		if is_instance_valid(bunny):
			if !first_bunny_position:
				first_bunny_position = bunny.global_position
			if first_bunny_position.x < bunny.global_position.x:
				first_bunny_position =  bunny.global_position
	if first_bunny_position:
		$Camera2D.global_position.x = first_bunny_position.x
		
		
	if finish == false && bunnies.size() > 0 && get_tree().get_nodes_in_group("BUNNY").size() <= 0:
		bunnies = []
		GameController.backToBase()
		
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


func _on_FastFoward_pressed():
	if Engine.time_scale == 3.0:
		Engine.time_scale = 1.0
	else:
		Engine.time_scale = 3.0


func _on_FinishGameBase_area_entered(area):
	if area.is_in_group("BUNNY"):
		area.queue_free()
		if finish == false:
			finish = true
			yield(get_tree().create_timer(0.5), "timeout")
			Engine.time_scale = 1.0
			GameController.changeToLevel("res://scennes/levels/LevelCredits.tscn")
