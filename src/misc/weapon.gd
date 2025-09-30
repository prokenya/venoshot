class_name Weapon
extends Node2D

@export var weapon_body: AnimatedSprite2D
@export var scope: Sprite2D
@export var shape_cast: ShapeCast2D
@export var timer: Timer
@export var bullets_left: int = 8

@export var shot_sprite: Sprite2D
@export var animation_player: AnimationPlayer

@export var shot_audio: AudioStreamPlayer
@onready var reloading: AudioStreamPlayer = $reloading
@onready var shoot_critical: AudioStreamPlayer = $shoot_critical
@onready var empty_shot: AudioStreamPlayer = $empty_shot


var max_clip_size = 8
var x2_damage:bool = false
var reloadig:bool = false

func _input(event: InputEvent) -> void:
	var view_rect: Rect2 = get_viewport().get_visible_rect()
	weapon_body.global_position.y = view_rect.size.y - weapon_body.sprite_frames.get_frame_texture(weapon_body.animation, 0).get_size().y / 2

	var gmp = get_global_mouse_position()
	weapon_body.global_position.x = gmp.x
	scope.global_position = gmp

	if Input.is_action_just_pressed("shot"):
		if timer.is_stopped():
			shot()
		elif reloadig:
			empty_shot.play()
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
	shape_cast.global_position = scope.global_position
	shape_cast.force_shapecast_update()
	
	var count: int = shape_cast.get_collision_count()
	if count == 0:
		return
	
	var enemies: Array = []
	var weakpoints: Array[Weakpoint] = []
	
	#0 split
	for i in count:
		var collider = shape_cast.get_collider(i)
		if collider is Enemy or collider is RigidBody2D:
			enemies.append(collider)
		elif collider is Weakpoint:
			weakpoints.append(collider)
	
	if enemies.is_empty() and weakpoints.is_empty():
		return
	
	#1 sort enemies
	var nearest_enemy = null
	var nearest_enemy_index := -1
	for enemy in enemies:
		if nearest_enemy == null:
			nearest_enemy = enemy
			nearest_enemy_index = enemy.get_index()
		else:
			if enemy.z_index > nearest_enemy.z_index:
				nearest_enemy = enemy
				nearest_enemy_index = enemy.get_index()
			elif enemy.z_index == nearest_enemy.z_index and enemy.get_index() > nearest_enemy_index:
				nearest_enemy = enemy
				nearest_enemy_index = enemy.get_index()
	
	if nearest_enemy == null:
		return
	
	#2check weakpoint
	var chosen: Node2D = nearest_enemy
	for wp in weakpoints:
		if wp.body_to_damage == nearest_enemy:
			chosen = wp
			break
	
	#3 damage
	var damage_recived:int
	if x2_damage:
		damage_recived = chosen.damage(2)
		animation_player.play("shot_animation_critical")
	else:
		damage_recived = chosen.damage(1)
		animation_player.play("shot_animation_normal")
	match damage_recived:
		1:animation_player.play("shot_animation_normal")
		2, 1000:
			animation_player.play("shot_animation_critical")
			shoot_critical.play()
			
	shot_sprite.global_position = shape_cast.global_position


func set_x2damage(time:int = 10):
	x2_damage = true
	await get_tree().create_timer(time).timeout
	x2_damage = false


func reload():
	reloading.play()
	bullets_left = max_clip_size
	G.main.in_game_ui.set_clip_status(0)
	timer.wait_time = 2.5 # reloading time
	timer.start()
	reloadig = true
	await timer.timeout
	reloadig = false
	G.main.in_game_ui.set_clip_status(bullets_left)
	timer.wait_time = .25
	return


func show_shot_effect():
	weapon_body.play("shot")
	shot_audio.play()
	await get_tree().create_timer(0.3).timeout
	weapon_body.play("default")
