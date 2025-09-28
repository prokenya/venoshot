extends Node2D
class_name Player

@export var weapon:Weapon

@onready var player_hurt: AudioStreamPlayer = $player_hurt


var player_hp: int = 20:
	set(val):
		if val < player_hp:
			player_hurt.play()
		player_hp = val
		if player_max_hp < player_hp:
			player_hp = player_max_hp
		G.main.in_game_ui.set_hp_bar_value(player_max_hp, player_hp)
		G.main.shaker.start_shake()
		if player_hp <0:
			G.main.world.world_status.show_game_over()
var player_max_hp: int = 20
