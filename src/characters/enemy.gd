extends SrceenBorderBody
class_name Enemy

@export var hp:int = 5
var max_hp = hp
@export var mask_color:Color = Color(0.744, 0.0, 0.107, 1.0)

func damage(damage:int = 1):
	hp -= damage
	var t: float = clamp(float(hp) / float(max_hp), 0.0, 1.0)
	modulate = Color.WHITE.lerp(mask_color, 1.0 - t)
	if hp <= 0:
		queue_free()
