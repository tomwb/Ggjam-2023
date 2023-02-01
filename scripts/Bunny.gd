extends KinematicBody2D

var velocity = 150
var life = 50
var walk = true
var direction

var index = 0
var point_scale = 0
var points = []
var current_position = Vector2()
var next_position = Vector2()

func _ready():
	if get_parent().get_class() == 'Path2D':
		var curve = get_parent().get_curve()
		for i in range(curve.get_point_count()):
			points.push_back(curve.get_point_position(i))
		current_position = points[index]
		next_position = points[index + 1]
		#position = current_position
		# point_scale = 100.0 / points[index].distance_to(points[index + 1])
		direction = position.direction_to(next_position)

func _physics_process(delta):
#	print(position.y * 0.01)
#	$Foot/Sprite.z_index = 10 + (position.y/1000)
#	$Body/Sprite.z_index = 10 + (position.y/1000)
#	$Head/Sprite.z_index = 10 + (position.y/1000)
	point_scale = (100.0 * position.distance_to(next_position)) /  current_position.distance_to(next_position)
	if point_scale <= 1.5:
		position = next_position
		#print("trocou de index")
		index = index + 1
		if index >= points.size() - 1:
			direction = Vector2(0,0)
		else:
			current_position = points[index]
			next_position = points[index + 1]
			direction = current_position.direction_to(next_position)
		#print(direction)
	#set_position(current_position.linear_interpolate(next_position, offset))
	var collision = move_and_collide(direction * 150 * delta)
	
	
#	var old_pos = position
#	if walk:
#		set_offset(get_offset() + velocity * delta)
#	direction = (position - old_pos).normalized()
#	print(direction)


#func _on_Area2D_area_entered(area):
#	if area.is_in_group("BARRICADE") ||  area.is_in_group("BUNNY"):
#		walk = false
#
#
#func _on_Area2D_area_exited(area):
#	if area.is_in_group("BARRICADE") ||  area.is_in_group("BUNNY"):
#		walk = true
