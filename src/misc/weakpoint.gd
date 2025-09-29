#@tool
extends Area2D
class_name Weakpoint
@onready var sprite: AnimatedSprite2D = %Sprite2D

enum point_types{
	sign,
	heart
}
@export var body_to_damage:Node
@export var point_type:point_types = point_types.sign:
	set(val):
		point_type = val
		if not Engine.is_editor_hint(): return
		_ready()
				

func _ready() -> void:
	match point_type:
		point_types.sign:
			sprite.animation = "default"
		point_types.heart:
			sprite.animation = "heart"

#func _physics_process(delta: float) -> void:
	#self.z_index = body_to_damage.z_index


func damage(damage:int) -> int:
	print("Weakpoint")
	if point_type == point_types.heart:
		process_anim()
	else:
		self.hide()
	body_to_damage.damage(1000)
	return 1000

func process_anim():
	sprite.play("heart_breaking")
	await sprite.animation_finished
	self.hide()
	
