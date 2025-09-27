class_name World
extends Node2D
@export var enemies_parent:Node2D
@export var enemies:Array[PackedScene]
@export var waves:Array[Wave]
var wave_index:int = -1
@onready var last_wave_index = waves.size() -1

func _ready() -> void:
	next_wave()
	enemies_parent.child_exiting_tree.connect(func(n:Node):if enemies_parent.get_child_count() == 1:next_wave())

func spawn_wave(wave:Wave):
	var inst:Enemy = enemies[wave.enemy_type].instantiate()
	inst.current_orbit = wave.orbit
	inst.position.x = get_viewport().get_visible_rect().size.x * randf_range(0.2,0.8)
	enemies_parent.add_child(inst)

func next_wave():
	wave_index += 1 
	if wave_index > last_wave_index:
		return
	var current_wave = waves[wave_index]
	await get_tree().create_timer(current_wave.time_before_wave).timeout
	for i in range(current_wave.enemies_count):
		spawn_wave(current_wave)
	if not current_wave.hold_next_wave:
		next_wave()
	
