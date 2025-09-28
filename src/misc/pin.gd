extends Node2D
class_name Pin

@export var target: Node2D


func _physics_process(delta: float) -> void:
	self.global_position = target.get_node("AttachPoint").global_position
