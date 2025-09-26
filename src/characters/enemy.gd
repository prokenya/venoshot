extends SrceenBorderBody
class_name Enemy

@export var hp:int = 5
@export var max_hp:int = hp
@export var mask_color:Color = Color(1.0, 0.0, 0.0, 1.0)
@export var enemy_collider:Variant

@export var rebound_threshold:int = 3
@export var max_bounces:int = 5

func damage(damage:int = 1):
	hp -= damage
	var t: float = clamp(float(hp) / float(max_hp), 0.0, 1.0)
	modulate = Color.WHITE.lerp(mask_color, 1.0 - t)

func move_closer():
	enemy_collider.scale += 0.3
	
