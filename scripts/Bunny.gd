extends PathFollow2D

export(int) var velocity = 150
export(int) var damage = 1
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
	
	var new_color = Color(0.83,0.83,0.47)
	if type == GameController.bunniesTypes.Strong :
		new_color = Color(0.42, 0.65, 0.94)
		$AnimationPlayer.play("bunny_strong")
	if type == GameController.bunniesTypes.Fast :
		new_color = Color(0.98, 0.29, 0.29)
		$AnimationPlayer.play("bunny_fast")
	if type == GameController.bunniesTypes.StrongFast :
		new_color = Color(0.72, 0.29, 0.98)
		$AnimationPlayer.play("bunny_strong_fast")
	
	$Foot/AnimatedSprite.material.set_shader_param("NEWCOLOR1", new_color)
	life = max_life

func onChangeType(new_type):
	GameController.changeBunny(positionIndex, new_type)
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
	queue_free()
	
func setDamage(damage):
	life -= damage
	$HpBar.calcPercentage(max_life, life)
	if life <= 0:
		queue_free()

func _on_Area2D_area_entered(area):
	if area.is_in_group("ENEMY"):
		if area.has_method("setDamage"):
			area.setDamage(damage)
		explode()

