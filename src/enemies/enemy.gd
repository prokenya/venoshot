class_name Enemy
extends SrceenBorderBody

signal death

@export var hp: int = 5
@export var max_hp: int = hp
@export var enemy_damage:int = 1
@export var mask_color: Color = Color(1.0, 0.0, 0.0, 1.0)



func damage(damage: int = 1) -> int:
	hp -= damage
	var t: float = clamp(float(hp) / float(max_hp), 0.0, 1.0)
	modulate = Color.WHITE.lerp(mask_color, 1.0 - t)
	procces_die()
	return damage

func procces_die():
	if hp<=0:
		death.emit()
		set_collision_layer_value(1,false)
		velocity = Vector2.ZERO
		sprite.play("die")
		await sprite.animation_finished
		queue_free()
