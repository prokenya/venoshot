class_name Main
extends Node2D

@export var worlds: Array[PackedScene]
@export var world: World

@export var main_menu: MainMenu
@export var in_game_ui: GameUI
@export var player:Player
@export var shaker:Shaker

func _ready() -> void:
	G.main = self


func load_world(index: int = 0):
	get_tree().paused = true
	var instace = worlds[index].instantiate()
	if world:
		world.queue_free()
		await get_tree().process_frame
	world = instace
	get_tree().paused = false
	add_child(world)
