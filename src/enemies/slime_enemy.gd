class_name SlimeEnemy
extends Enemy

@onready var start_orbit

@onready var hit_slime: AudioStreamPlayer = $hit_slime
@onready var death_slime: AudioStreamPlayer = $death_slime


func _ready() -> void:
	super()
	start_orbit = current_orbit
	rebound_threshold_reached.connect(move_closer_to_attack)
	death.connect(func():death_slime.play())

func damage(dm:int = 1):
	hit_slime.play()
	return super(dm)

func move_closer_to_attack():
	current_orbit = 4
	await bounced_off
	attack()
	current_orbit = start_orbit


func attack():
	G.main.player.player_hp -= enemy_damage
