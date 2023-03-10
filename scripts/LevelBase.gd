extends Node2D

const pre_bunny = preload("res://scennes/Bunny.tscn")
const pre_collectible_bunny_evolve = preload("res://scennes/CollectibleBunnyEvolve.tscn")

var velocity = 300
export(int) var max_bunnies = 15
var bunnies = []
var canAddNew = true
var walkBunnies = false
var mola_bunny
var startGame = false

func _ready():
	pass

func addBunny():
	if canAddNew == true && max_bunnies > bunnies.size() && GameController.collectibleCarrot > 0: 
		$CloneOMatic/CloningSound.play()
		GameController.removeCollectible(GameController.bunniesTypes.Basic)
		canAddNew = false
		if bunnies.size() > 0:
			walkBunnies = true
			yield(get_tree().create_timer(0.5), "timeout")
			walkBunnies = false
		
		var bunny_config = GameController.addBunny()
		var bunny = pre_bunny.instance()
		bunny.global_position = $CloneCenterPosition2D.global_position
		$Path2D.add_child(bunny)
		bunny.get_node("HpBar").visible = false
		bunny.onCreate(bunny_config["type"], bunny_config["index"])
		bunny.velocity = velocity
		bunnies.append(bunny)
		canAddNew = true
		
func _process(delta):
	if walkBunnies == true:
		for bunny in bunnies:
			bunny.walk = true
	else:
		for bunny in bunnies:
			bunny.walk = false
			
	if mola_bunny :
		mola_bunny.translate(Vector2(0,-1) * 1200 * delta)

func _on_CloneOMatic_mouse_entered():
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	$CloneOMatic/AnimatedSprite.material.set_shader_param("width", 5.0)

func _on_CloneOMatic_mouse_exited():
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	$CloneOMatic/AnimatedSprite.material.set_shader_param("width", 0.0)


func _on_CloneOMatic_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		addBunny()

func startWave():
	if canAddNew == true && bunnies.size() >= 1:
		$StartWaveButtonSound.play()
		$CanvasLayer/ButtonStartWave.visible = false
		canAddNew = false
		walkBunnies = true

func _on_Mola_area_entered(area):
	if area.is_in_group("BUNNY"):
		walkBunnies = false
		$Mola/AnimatedSprite.play("jump")
		$Mola/JumpSound.play()
		yield(get_tree().create_timer(0.2), "timeout")
		mola_bunny = area.get_parent()

func _on_MolaExitArea_area_entered(area):
	if area.is_in_group("BUNNY"):
		$Mola/AnimatedSprite.play("idle")
		var index = bunnies.find(area.get_parent())
		if index >= 0:
			bunnies.remove(index)
		mola_bunny = null
		walkBunnies = true
		area.get_parent().queue_free()
		if startGame == false :
			startGame = true
			yield(get_tree().create_timer(1), "timeout")
			GameController.startLevel()

func _on_CollectibleStrongButton_button_down():
	if canAddNew == true && bunnies.size() >= 1 && get_tree().get_nodes_in_group("COLLECTIBLE_BUNNY_EVOLVE").size() <= 0 && GameController.collectibleStrong > 0:
		$CollectibleSound.play()
		GameController.removeCollectible(GameController.bunniesTypes.Strong)
		var collectible_bunny_evolve = pre_collectible_bunny_evolve.instance()
		collectible_bunny_evolve.type = GameController.bunniesTypes.Strong
		get_parent().add_child(collectible_bunny_evolve)

func _on_CollectibleFastButton_button_down():
	if canAddNew == true && bunnies.size() >= 1 && get_tree().get_nodes_in_group("COLLECTIBLE_BUNNY_EVOLVE").size() <= 0 && GameController.collectibleFast > 0:
		$CollectibleSound.play()
		GameController.removeCollectible(GameController.bunniesTypes.Fast)
		var collectible_bunny_evolve = pre_collectible_bunny_evolve.instance()
		collectible_bunny_evolve.type = GameController.bunniesTypes.Fast
		get_parent().add_child(collectible_bunny_evolve)


func _on_CollectibleShooterButton_button_down():
	if canAddNew == true && bunnies.size() >= 1 && get_tree().get_nodes_in_group("COLLECTIBLE_BUNNY_EVOLVE").size() <= 0 && GameController.collectibleShooter > 0:
		$CollectibleSound.play()
		GameController.removeCollectible(GameController.bunniesTypes.Shooter)
		var collectible_bunny_evolve = pre_collectible_bunny_evolve.instance()
		collectible_bunny_evolve.type = GameController.bunniesTypes.Shooter
		get_parent().add_child(collectible_bunny_evolve)
