extends Node
class_name tochscreen_item

func _ready() -> void:
	G.toched.connect(show_element)
	show_element()

func show_element():
	if G.touched_once:
		get_parent().show()
