class_name Cloud
extends Enemy

var dies:bool = false
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func damage(damage: int = 1) -> int:
	hp -= damage
	var t: float = clamp(float(hp) / float(max_hp), 0.0, 1.0)
	modulate = Color.WHITE.lerp(mask_color, 1.0 - t)
	procces_die()
	return damage

func procces_die():
	if hp<=0:
		velocity = Vector2.ZERO
		animation_player.play("rain")
		dies = true
		set_collision_layer_value(1,false)

		await animation_player.animation_finished
		sprite.play("die")
		await sprite.animation_finished
		
		queue_free()

func _on_dead_rain_body_entered(body: Node2D) -> void:
	if not (body is Enemy or body is RigidBody2D):return
	if dies:
		body.damage(enemy_damage)
