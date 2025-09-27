extends Node2D
class_name Player

var player_hp: int = 10:
	set(val):
		player_hp = val
		G.main.in_game_ui.set_hp_bar_value(player_max_hp, player_hp)
		G.main.shaker.start_shake()
var player_max_hp: int = player_hp
