class_name Wave
extends Resource

enum enemy_types {
	Slime,
	Plate,
	Barrel
}

@export var time_before_wave:float
@export var enemy_type: enemy_types = enemy_types.Slime
@export var enemies_count:int = 1
@export_range(1,4,1) var orbit:int = 1
@export var hold_next_wave:bool = false
