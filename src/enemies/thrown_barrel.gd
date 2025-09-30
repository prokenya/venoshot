extends RigidBody2D

@export var bdamage:int = 3
@export var explosion: GPUParticles2D
@export var sprite_2d: Sprite2D
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	z_index = 99

func _on_body_shape_entered(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int) -> void:
	if body_shape_index == 2:
		G.main.player.player_hp -= bdamage
		show_explosion()


func damage(d:int):
	show_explosion()
	return d

func show_explosion():
	audio_stream_player.play()
	explosion.emitting = true
	linear_velocity = Vector2.ZERO
	angular_velocity = 0
	sprite_2d.hide()
	set_collision_mask_value(2,false)
	set_collision_layer_value(1,false)
	await explosion.finished
	queue_free()
