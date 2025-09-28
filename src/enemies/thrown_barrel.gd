extends RigidBody2D

func _ready() -> void:
	z_index = 99

func _on_body_shape_entered(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int) -> void:
	if body_shape_index == 2:
		G.main.player.player_hp -= 3
		queue_free()

func damage(d:int):
	queue_free()
	return d
