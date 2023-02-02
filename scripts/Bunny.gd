extends PathFollow2D

export(int) var velocity = 150
export(int) var damage = 1
export(int) var max_life = 2
var life
var walk = true
var direction

func _ready():
	life = max_life

func _process(delta):
	var old_pos = position
	if walk:
		set_offset(get_offset() + velocity * delta)
	direction = (position - old_pos).normalized()
#	print(direction)

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

