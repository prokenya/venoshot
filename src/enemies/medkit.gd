extends Enemy
class_name Medkit

func damage(dm:int = 2):
	G.main.player.player_hp += enemy_damage
	return super(dm)
	
