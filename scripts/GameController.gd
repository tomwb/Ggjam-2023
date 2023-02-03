extends Node2D

enum  bunniesTypes {
	Basic, Fast, Strong
}

var total_bunnies = []
signal onAddBunny

func _ready():
	pass

func addBunny():
	total_bunnies.append(bunniesTypes.Basic)
	emit_signal("onAddBunny")
