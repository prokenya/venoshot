extends CharacterBody2D
class_name SrceenBorderBody
@export var speed: Vector2 = Vector2(350.0,0.0)
@export var bounce: float = 1.0
@export var sprite: AnimatedSprite2D

signal bounced_off


func _ready() -> void:
	velocity = speed

func _physics_process(delta: float) -> void:
	move_and_slide()

	var view_rect: Rect2 = get_viewport().get_visible_rect()

	var half_width = (sprite.sprite_frames.get_frame_texture(sprite.animation,0).get_size().x * sprite.scale.x) / 2.0
	var left = view_rect.position.x + half_width
	var right = view_rect.position.x + view_rect.size.x - half_width

	if position.x < left:
		position.x = left
		velocity.x = abs(velocity.x) * bounce
		bounced_off.emit()
	elif position.x > right:
		position.x = right
		velocity.x = -abs(velocity.x) * bounce
		bounced_off.emit()

		
