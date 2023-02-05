extends Area2D

const pre_explosion = preload("res://scennes/Explosion.tscn")

var velocity = 600
var target
var direction = Vector2()


func _ready():
	pass

func _process(delta):
	if target && is_instance_valid(target):
		direction = global_position.direction_to(target.global_position)
	translate(direction * velocity * delta)

func setTarget(area):
	target = area

func _on_BunnyBullet_area_entered(area):
	if area.is_in_group("BULLET"):
		var explosion = pre_explosion.instance()
		explosion.position = position
		get_parent().add_child(explosion)
		area.queue_free()
		queue_free()
	
	if area.is_in_group("ENEMY"):
		if area.has_method("setDamage"):
			area.setDamage(1)
		queue_free()
		
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
