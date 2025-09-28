extends Enemy
class_name PowerUp

func damage(dm:int = 1):
	G.main.player.weapon.set_x2damage(10)
	return super(dm)
