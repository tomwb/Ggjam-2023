extends Area2D

const PRE_TEXTURE_STRONG =  preload("res://sprites/collectibles/pickup-forca.png")
const PRE_TEXTURE_FAST =  preload("res://sprites/collectibles/pickup-velocidade.png")
const PRE_TEXTURE_SHOOTER =  preload("res://sprites/collectibles/pickup-visao.png")


var bunny
var type = GameController.bunniesTypes.Strong

func _ready():
	if type == GameController.bunniesTypes.Strong:
		$Sprite.set_texture(PRE_TEXTURE_STRONG)
	if type == GameController.bunniesTypes.Fast:
		$Sprite.set_texture(PRE_TEXTURE_FAST)
	if type == GameController.bunniesTypes.Shooter:
		$Sprite.set_texture(PRE_TEXTURE_SHOOTER)

func _process(delta):
	global_position = get_viewport().get_mouse_position()

func _on_CollectibleBunnyEvolve_area_entered(area):
	if area.is_in_group("BUNNY"):
		if area.get_parent().type != type && area.get_parent().type != GameController.bunniesTypes.StrongFast || area.get_parent().type != GameController.bunniesTypes.StrongShooter || area.get_parent().type != GameController.bunniesTypes.FastShoter:
			if bunny :
				bunny.scale = Vector2(1,1)
			bunny = area.get_parent()
			area.get_parent().scale = Vector2(1.2,1.2)

func _on_CollectibleBunnyEvolve_area_exited(area):
	if area.is_in_group("BUNNY"):
		if area.get_parent().type != type && area.get_parent().type != GameController.bunniesTypes.StrongFast || area.get_parent().type != GameController.bunniesTypes.StrongShooter || area.get_parent().type != GameController.bunniesTypes.FastShoter:
			area.get_parent().scale = Vector2(1,1)
			if bunny == area.get_parent():
				bunny = null
	
func _on_CollectibleBunnyEvolve_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed) && bunny && bunny.has_method("onChangeType"):
		if bunny.type != type && bunny.type != GameController.bunniesTypes.StrongFast || bunny.type != GameController.bunniesTypes.StrongShooter || bunny.type != GameController.bunniesTypes.FastShoter:
			bunny.onChangeType(type)
			bunny.scale = Vector2(1,1)
			bunny.velocity = 300
			queue_free()
