class_name SrceenBorderBody
extends CharacterBody2D

signal bounced_off
signal rebound_threshold_reached

@export var speed: Vector2 = Vector2(350.0, 0.0)
@export var bounce: float = 1.0
@export var sprite: AnimatedSprite2D

@export var rebound_threshold: int = 3
@export var max_orbit: int = 4
@export var current_orbit: int = 1:
	set(val):
		current_orbit = val
		call_deferred("anim_orbit_move")
		z_index = current_orbit
		collision_priority = current_orbit
		sprite.modulate = Color.WHITE.lerp(Color(0.0, 0.0, 0.0, 1.0),float(max_orbit)/float(current_orbit) * 0.1)
@export var use_bottom:bool = false
@export var collider: Node2D

var rebound_count: int = 0

var orbit_tweeen: Tween

@onready var collider_base_scale: Vector2 = collider.scale


func _ready() -> void:
	velocity = speed
	bounced_off.connect(count_bounces)


func _physics_process(delta: float) -> void:
	move_and_slide()

	var view_rect: Rect2 = get_viewport().get_visible_rect()

	var frame_tex = sprite.sprite_frames.get_frame_texture(sprite.animation, sprite.frame)
	var half_width = (frame_tex.get_size().x * collider.scale.x) / 2.0
	var half_height = (frame_tex.get_size().y * collider.scale.y) / 2.0

	var left = view_rect.position.x + half_width
	var right = view_rect.position.x + view_rect.size.x - half_width
	#var top = view_rect.position.y + half_height
	#var bottom = view_rect.position.y + view_rect.size.y - half_height
	if orbit_tweeen.is_running():return
	if position.x < left:
		position.x = left
		velocity.x = abs(velocity.x) * bounce
		bounced_off.emit()
	elif position.x > right:
		position.x = right
		velocity.x = -abs(velocity.x) * bounce
		bounced_off.emit()

	#position.y = view_rect.size.y * 2 / 3 / max_orbit * current_orbit


func anim_orbit_move(duration: float = 1):
	var view_rect: Rect2 = get_viewport().get_visible_rect()

	var bottom = view_rect.size.y
	var top = 0.0
	var work_height = view_rect.size.y * 0.5
	
	if use_bottom:
		top = bottom - work_height
	else:
		top = 0.0
	
	var step = work_height / (max_orbit + 1)
	var target_y = top + step * current_orbit


	var target_scale:Vector2 = collider_base_scale + Vector2(current_orbit, current_orbit) * .1
	
	if orbit_tweeen:
		orbit_tweeen.kill()

	orbit_tweeen = create_tween().set_parallel(true)
	orbit_tweeen.tween_property(self, "position", Vector2(position.x + velocity.x, target_y), duration)
	orbit_tweeen.tween_property(collider, "scale", target_scale, 1)
	#print(target_scale)
	#print(current_orbit)

func count_bounces():
	rebound_count += 1
	if rebound_threshold <= rebound_count:
		rebound_count = 0
		rebound_threshold_reached.emit()
