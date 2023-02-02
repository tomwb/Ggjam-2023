extends Area2D

const pre_bullet = preload("res://scennes/EnemyBullet.tscn")
var bodies = []

export(int) var max_life = 4
var life = 0

func _ready():
	life = max_life
	
func _process(delta):
	pass

func setDamage(damage):
	life -= damage
	$HpBar.calcPercentage(max_life, life)
	if life <= 0:
		queue_free()


func _on_BulletTimer_timeout():
	if bodies.size() > 0:
		var bullet = pre_bullet.instance()
		bullet.global_position = $BulletPosition2D.global_position
		get_parent().add_child(bullet)
		bullet.setTarget(bodies[0])


func _on_SensorArea2D_area_entered(area):
	if area.is_in_group("BUNNY"):
		bodies.append(area)


func _on_SensorArea2D_area_exited(area):
	if area.is_in_group("BUNNY"):
		var index = bodies.find(area)
		if index >= 0:
			bodies.remove(index)
