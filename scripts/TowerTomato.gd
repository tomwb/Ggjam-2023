extends Area2D

const pre_explosion = preload("res://scennes/Explosion.tscn")
const pre_bullet = preload("res://scennes/EnemyBullet.tscn")
var bodies = []

export(int) var max_life = 3
var life = 0
var attack_pause = false

func _ready():
	life = max_life
	
func _process(delta):
	pass

func setDamage(damage):
	life -= damage
	$HpBar.calcPercentage(max_life, life)
	if life <= 0:
		var explosion = pre_explosion.instance()
		explosion.position = position
		get_parent().add_child(explosion)
		queue_free()

func atack():
	if bodies.size() > 0:
		var bullet = pre_bullet.instance()
		bullet.global_position = $BulletPosition2D.global_position
		get_parent().add_child(bullet)
		bullet.setTarget(bodies[0])

func _on_SensorArea2D_area_entered(area):
	if area.is_in_group("BUNNY"):
		bodies.append(area)
		startAttack()
		
func startAttack():
	if bodies.size() > 0 && attack_pause == false && $AnimationPlayer.current_animation != "atack":
		$AnimationPlayer.play("atack")
		yield(get_tree().create_timer(3.6), "timeout")
		$AnimationPlayer.play("idle")
		attack_pause = true
		yield(get_tree().create_timer(0.8), "timeout")
		attack_pause = false
		startAttack()	


func _on_SensorArea2D_area_exited(area):
	if area.is_in_group("BUNNY"):
		var index = bodies.find(area)
		if index >= 0:
			bodies.remove(index)
		
		if bodies.size() <= 0 :
			$AnimationPlayer.play("idle")
