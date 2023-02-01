extends Node2D	

onready var initial_rect_size = $ColorRect.rect_size
export(Color) var border_color = Color(1,1,1)
export(Color) var background_color = Color(0,0,0)
export(int) var value = 100

func _ready():
	setValue(value)
	$ColorRect.color = background_color

func _draw():
	draw_rect(Rect2($ColorRect.rect_position - Vector2(1,1), initial_rect_size + Vector2(2,2)), border_color, true)
	
func setValue(new_value):
	if new_value > 100:
		new_value = 100
	value = new_value
	$ColorRect.rect_size.x = (initial_rect_size.x * value) / 100
	
