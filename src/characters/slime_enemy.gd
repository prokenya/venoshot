class_name SlimeEnemy
extends Enemy

@onready var start_orbit

func _ready() -> void:
	super()
	start_orbit = current_orbit
	rebound_threshold_reached.connect(move_closer_to_attack)


func damage(damage: int = 1):
	super(damage)
	if hp <= 0:
		sprite.play("die")
		await sprite.animation_finished
		queue_free()


func move_closer_to_attack():
	current_orbit = 4
	await bounced_off
	attack()
	current_orbit = start_orbit


func attack():
	G.main.player.player_hp -= 1
