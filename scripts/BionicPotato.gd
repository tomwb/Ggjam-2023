extends Area2D

const pre_explosion = preload("res://scennes/Explosion.tscn")
var attack_array: Array

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

func _on_SensorArea2D_area_entered(area):
	if area.is_in_group("BUNNY"):
		attack_array.append(area)
		startAttack()
		
func startAttack():
	if attack_array.size() > 0 && attack_pause == false && $AnimationPlayer.current_animation != "attack":
		$AnimationPlayer.play("attack")
		yield(get_tree().create_timer(2), "timeout")
		$AnimationPlayer.play("idle")
		attack_pause = true
		yield(get_tree().create_timer(2), "timeout")
		attack_pause = false
		startAttack()

func _on_SensorArea2D_area_exited(area):
	if area.is_in_group("BUNNY"):
		var index = attack_array.find(area)
		if index >= 0:
			attack_array.remove(index)

		if attack_array.size() <= 0:
			yield($AnimationPlayer, "animation_finished")
			$AnimationPlayer.play("idle")

func _on_Atack_area_entered(area):
	if area.is_in_group("BUNNY"):
		if area.get_parent().has_method("setDamage"):
			area.get_parent().setDamage(1)
