class_name Weapon
extends Node2D

@export var weapon_body: AnimatedSprite2D
@export var scope: Sprite2D
@export var ray: RayCast2D
@export var timer: Timer
@export var bullets_left: int = 8

@export var shot_sprite: Sprite2D
@export var animation_player: AnimationPlayer
@export var shot_audio: AudioStreamPlayer

var max_clip_size = 8


func _input(event: InputEvent) -> void:
	var view_rect: Rect2 = get_viewport().get_visible_rect()
	weapon_body.global_position.y = view_rect.size.y - weapon_body.sprite_frames.get_frame_texture(weapon_body.animation, 0).get_size().y / 2

	var gmp = get_global_mouse_position()
	weapon_body.global_position.x = gmp.x
	scope.global_position = gmp

	if Input.is_action_just_pressed("shot") and timer.is_stopped():
		shot()
	if Input.is_action_just_pressed("reload") and bullets_left < max_clip_size:
		reload()


func shot():
	bullets_left -= 1

	G.main.in_game_ui.set_clip_status(bullets_left)

	show_shot_effect()

	timer.start()
	check_collision()
	if bullets_left == 0:
		reload()


func check_collision():
	ray.position = scope.position
	ray.target_position = Vector2.UP
	ray.force_raycast_update()
	if ray.is_colliding():
		var collider = ray.get_collider()
		if collider is Enemy or Weakpoint:
			collider.damage(1)
			shot_sprite.global_position = ray.get_collision_point()
			animation_player.play("shot_animation_normal")



func reload():
	bullets_left = max_clip_size
	G.main.in_game_ui.set_clip_status(0)
	timer.wait_time = 2.5 # reloading time
	timer.start()
	await timer.timeout
	G.main.in_game_ui.set_clip_status(bullets_left)
	timer.wait_time = .25
	return


func show_shot_effect():
	weapon_body.play("shot")
	shot_audio.play()
	await get_tree().create_timer(0.3).timeout
	weapon_body.play("default")
