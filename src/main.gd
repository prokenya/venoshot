extends Node
class_name Main

@export var worlds:Array[PackedScene]
@export var world:Node

@export var main_menu:MainMenu
func  _ready() -> void:
	G.main = self

func load_world(index:int = 0):
	var instace = worlds[index].instantiate()
	if world:
		world.queue_free()
		await get_tree().process_frame
	world = instace
	add_child(world)
