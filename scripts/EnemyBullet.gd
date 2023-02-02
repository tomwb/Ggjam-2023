extends Area2D

var velocity = 500
var direction = Vector2()

func _ready():
	pass

func _process(delta):
	translate(direction * velocity * delta)

func setTarget(area):
	direction = global_position.direction_to(area.global_position)


func _on_EnemyBullet_area_entered(area):
	if area.is_in_group("BUNNY"):
		if area.get_parent().has_method("setDamage"):
			area.get_parent().setDamage(1)
		queue_free()
