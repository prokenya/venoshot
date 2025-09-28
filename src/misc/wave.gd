class_name Wave
extends Resource

enum enemy_types {
	Slime,
	Drill,
	Magnet_carrier,
	Medkit,
	PowerUp,
	Cloud,
	UFO,
	Barrel,
}

@export var time_before_wave:float
@export var enemy_type: enemy_types = enemy_types.Slime
@export var enemies_count:int = 1
@export_range(1,4,1) var orbit:int = 1
@export var hold_next_wave:bool = false
@export var not_required_to_clear:bool = false

@export var spawn_position:Vector2 = Vector2.ZERO
