extends Enemy
class_name PowerUp

@export var effect:GPUParticles2D

func damage(dm:int = 1):
	G.main.player.weapon.set_x2damage(10)
	return super(dm)

func procces_die():
	if hp<=0:
		death.emit()
		set_collision_layer_value(1,false)
		velocity = Vector2.ZERO
		sprite.play("die")
		await sprite.animation_finished
		sprite.hide()
		effect.emitting = true
		await effect.finished
		queue_free()
