extends Enemy
class_name MagnetCarrier

@onready var timer: Timer = $Timer

@export var barrel_scene:PackedScene
@export var barrel_spawn_point:Node2D

func _ready() -> void:
	super()
	throw_barrel()

func throw_barrel():
	timer.start([7,8,9,10,11].pick_random())
	await timer.timeout
	var inst:RigidBody2D = barrel_scene.instantiate()
	var angle: float
	if randi() % 2 == 0:
		angle = randf_range(PI, PI + PI/4)
	else:
		angle = randf_range(PI + PI/2, 2 * PI)

	var direction = Vector2(cos(angle), sin(angle))
	
	G.main.world.projectiles.add_child(inst)
	inst.global_position = barrel_spawn_point.global_position
	inst.apply_impulse(direction * 150)
	inst.angular_velocity = randf_range(-45,45)
	throw_barrel()
