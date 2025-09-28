class_name World
extends Node2D
@export var enemies_parent:Node2D
@export var projectiles:Node2D
@export var enemies:Array[PackedScene]
@export var waves:Array[Wave]
@export var world_status:WorldStatus
var wave_index:int = -1
var wave_index_for_player:int = 0
@onready var last_wave_index = waves.size() -1

func _ready() -> void:
	next_wave()
	@warning_ignore("unused_parameter")
	enemies_parent.child_exiting_tree.connect(func(n:Node):if enemies_parent.get_child_count() == 1:next_wave())

func spawn_wave(wave:Wave):
	await get_tree().create_timer(wave.time_before_wave).timeout
	var inst:Enemy = enemies[wave.enemy_type].instantiate()
	inst.current_orbit = wave.orbit
	if wave.spawn_position == Vector2.ZERO:
		inst.position.x = get_viewport().get_visible_rect().size.x * randf_range(0.2,0.8)
	else:
		inst.position = wave.spawn_position
	if wave.not_required_to_clear:
		projectiles.add_child(inst)
	else:
		enemies_parent.add_child(inst)

func next_wave():
	wave_index += 1 
	if wave_index > last_wave_index:
		world_status.show_win()
		return
	var current_wave = waves[wave_index]
	if current_wave.hold_next_wave:
		wave_index_for_player += 1
		world_status.set_waves(wave_index_for_player)
	for i in range(current_wave.enemies_count):
		spawn_wave(current_wave)
	if not current_wave.hold_next_wave:
		next_wave()
