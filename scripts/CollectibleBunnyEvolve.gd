extends Area2D

var bunny
var type = GameController.bunniesTypes.Strong

func _ready():
	pass

func _process(delta):
	global_position = get_viewport().get_mouse_position()

func _on_CollectibleBunnyEvolve_area_entered(area):
	if area.is_in_group("BUNNY"):
		if bunny :
			bunny.scale = Vector2(1,1)
		bunny = area.get_parent()
		area.get_parent().scale = Vector2(1.2,1.2)


func _on_CollectibleBunnyEvolve_area_exited(area):
	if area.is_in_group("BUNNY"):
		area.get_parent().scale = Vector2(1,1)
		if bunny == area.get_parent():
			bunny = null
		


func _on_CollectibleBunnyEvolve_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed) && bunny && bunny.has_method("onChangeType"):
		bunny.onChangeType(type)
		queue_free()
