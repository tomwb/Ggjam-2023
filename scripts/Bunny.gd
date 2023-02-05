extends PathFollow2D

const pre_explosion = preload("res://scennes/Explosion.tscn")

export(int) var velocity = 200
export(int) var max_life = 2
var life
var walk = false

var type = GameController.bunniesTypes.Basic
var positionIndex = 0

func _ready():
	pass
	
func onCreate(new_type, index) :
	type = new_type
	positionIndex = index
	
	if type == GameController.bunniesTypes.Strong :
		max_life = 4
		$AnimationPlayer.play("bunny_strong")
	if type == GameController.bunniesTypes.Fast :
		velocity = 400
		$AnimationPlayer.play("bunny_fast")
	if type == GameController.bunniesTypes.Shooter :
		$AnimationPlayer.play("bunny_shooter")
	if type == GameController.bunniesTypes.StrongFast :
		max_life = 4
		velocity = 400
		$AnimationPlayer.play("bunny_strong_fast")
	if type == GameController.bunniesTypes.StrongShooter :
		max_life = 4
		$AnimationPlayer.play("bunny_strong_shooter")
	if type == GameController.bunniesTypes.FastShooter :
		velocity = 400
		$AnimationPlayer.play("bunny_fast_shooter")
	life = max_life

func onChangeType(new_type):
	if (type == GameController.bunniesTypes.Strong && new_type == GameController.bunniesTypes.Fast) || (type == GameController.bunniesTypes.Fast && new_type == GameController.bunniesTypes.Strong):
		new_type = GameController.bunniesTypes.StrongFast
	if (type == GameController.bunniesTypes.Strong && new_type == GameController.bunniesTypes.Shooter) || (type == GameController.bunniesTypes.Shooter && new_type == GameController.bunniesTypes.Strong):
		new_type = GameController.bunniesTypes.StrongShooter
	if (type == GameController.bunniesTypes.Fast && new_type == GameController.bunniesTypes.Shooter) || (type == GameController.bunniesTypes.Shooter && new_type == GameController.bunniesTypes.Fast):
		new_type = GameController.bunniesTypes.FastShooter
	GameController.changeBunny(positionIndex, new_type)
	$EvoSound.play()
	onCreate(new_type, positionIndex)

func _process(delta):
	if walk:
		z_index = 10 + position.y
		set_offset(get_offset() + velocity * delta)
		$Foot/AnimatedSprite.animation =  "foot_walk"
		$Body/AnimatedSprite.animation =  "body_walk"
		$Head/AnimatedSprite.animation =  "head_walk"
	else :
		$Foot/AnimatedSprite.animation =  "foot_idle"
		$Body/AnimatedSprite.animation =  "body_idle"
		$Head/AnimatedSprite.animation =  "head_idle"
	
func explode():
	walk = false
	var explosion = pre_explosion.instance()
	explosion.position = position
	get_parent().add_child(explosion)
	queue_free()
	
func setDamage(damage):
	$DamageSound.play()
	life -= damage
	$HpBar.calcPercentage(max_life, life)
	if life <= 0:
		GameController.removeBunny(positionIndex)
		explode()

func _on_Area2D_area_entered(area):
	if area.is_in_group("ENEMY"):
		if area.has_method("setDamage"):
			area.setDamage(life)
		GameController.removeBunny(positionIndex)
		explode()

