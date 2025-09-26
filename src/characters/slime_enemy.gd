extends Enemy
class_name SlimeEnemy

@onready var scale_tween:Tween

func damage(damage:int = 1):
	super()
	if hp <=0:
		sprite.play("die")
		await sprite.animation_finished
		queue_free()
