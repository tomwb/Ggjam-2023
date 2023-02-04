extends Area2D

var attack_array: Array


func _ready():
	$AnimationPlayer.play("Idle")


func _on_SensorArea2D_area_entered(area):
	if area.is_in_group("BUNNY"):
		$AnimationPlayer.play("Attack")
		attack_array.append(area)


func _on_SensorArea2D_area_exited(area):
	if area.is_in_group("BUNNY"):
		var index = attack_array.find(area)
		if index >= 0:
			attack_array.remove(index)

		if attack_array.size() <= 0 and !$AnimationPlayer.is_playing():
			$AnimationPlayer.play("Idle")



func _on_Atack_area_entered(area):
	if area.is_in_group("BUNNY"):
		if area.get_parent().has_method("setDamage"):
			area.get_parent().setDamage(1)


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Attack":
		$AnimationPlayer.play("Idle")

