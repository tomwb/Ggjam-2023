extends Area2D

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

func _on_EnemyBullet_area_entered(area):
	if area.is_in_group("BUNNY"):
		if area.get_parent().has_method("setDamage"):
			area.get_parent().setDamage(1)
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
