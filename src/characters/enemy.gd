class_name Enemy
extends SrceenBorderBody

@export var hp: int = 5
@export var max_hp: int = hp
@export var mask_color: Color = Color(1.0, 0.0, 0.0, 1.0)


func damage(damage: int = 1):
	hp -= damage
	var t: float = clamp(float(hp) / float(max_hp), 0.0, 1.0)
	modulate = Color.WHITE.lerp(mask_color, 1.0 - t)
	if hp<=0:
		velocity = Vector2.ZERO
