extends Area2D
class_name Weakpoint
func damage(damage:int):
	print("Weakpoint")
	get_parent().damage(1000)
