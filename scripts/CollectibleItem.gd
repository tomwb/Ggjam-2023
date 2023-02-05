tool
extends Area2D

const PRE_TEXTURE_BASIC =  preload("res://sprites/collectibles/pickup-Recovered.png")
const PRE_TEXTURE_STRONG =  preload("res://sprites/collectibles/pickup-forca.png")
const PRE_TEXTURE_FAST =  preload("res://sprites/collectibles/pickup-velocidade.png")
var collected = false

enum  bunniesTypes {
	Basic, Fast, Strong
}

export(bunniesTypes) var type = bunniesTypes.Basic setget set_bunny_type

func _ready():
	changeSprites()

func set_bunny_type(bunny_type):
	type = bunny_type
	changeSprites()
	
func changeSprites():
	if type == bunniesTypes.Basic:
		$Sprite.set_texture(PRE_TEXTURE_BASIC)
	if type == bunniesTypes.Strong:
		$Sprite.set_texture(PRE_TEXTURE_STRONG)
	if type == bunniesTypes.Fast:
		$Sprite.set_texture(PRE_TEXTURE_FAST)

func _on_CollectibleItem_area_entered(area):
	if area.is_in_group("BUNNY") and !collected:
		collected = true
		$CollectItemSound.play()
		visible = false
		yield($CollectItemSound, "finished")
		GameController.addCollectible(type)
		queue_free()
