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
	var new_color = Color.white
	if type == GameController.bunniesTypes.Fast :
		new_color = Color.red
	$Foot/AnimatedSprite.material.set_shader_param("NEWCOLOR1", new_color)
	life = max_life

func _process(delta):
	if walk:
		z_index = 10 + position.y
		set_offset(get_offset() + velocity * delta)
		$Foot/AnimatedSprite.animation =  "walk"
		$Body/AnimatedSprite.animation =  "walk"
		$Head/AnimatedSprite.animation =  "walk"
	else :
		$Foot/AnimatedSprite.animation =  "idle"
		$Body/AnimatedSprite.animation =  "idle"
		$Head/AnimatedSprite.animation =  "idle"
	
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

