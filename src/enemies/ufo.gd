class_name UFO
extends Enemy

enum transported_objects {
	PowerUp,
	Medkit,
}

@export var transported_object: transported_objects = transported_objects.Medkit


func _ready() -> void:
	death.connect(spawn_object)
	transported_object = [0,1].pick_random()
	

func spawn_object():
	var wave = Wave.new()
	wave.not_required_to_clear = true
	wave.orbit = current_orbit
	wave.enemy_type = transported_object + 3
	wave.spawn_position = global_position
	G.main.world.spawn_wave(wave)
