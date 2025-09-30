extends Enemy
class_name Boss

@onready var hp_bar: TextureProgressBar = $hp_barr
var hp_tween:Tween
var spawn_rate:int = 8.5
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D
@onready var gpu_particles_2d_2: GPUParticles2D = $GPUParticles2D2
const BOSS = preload("uid://db256btvnbd5s")



func _ready() -> void:
	super()
	for child:Node in G.main.world.enemies_parent.get_children():
		if child != self:
			child.queue_free()
	for child:Node in G.main.world.projectiles.get_children():
		child.queue_free()
	attack()
	set_hp_bar_value(max_hp,hp)
	G.main.world.music.stream = BOSS
	G.main.world.music.play()
	
func _physics_process(delta: float) -> void:
	z_index = -1
	pass

func anim_orbit_move(duration: float = 1):
	pass

func attack():
	var view_rect: Rect2 = get_viewport().get_visible_rect()


	var right = view_rect.size.x * 0.8
	var left = view_rect.position.x - view_rect.size.x * 0.2
	
	var spawn_pos = Vector2(randf_range(left,right),position.y)
	var wave = Wave.new()
	wave.enemy_type = wave.enemy_types.Thorn
	wave.not_required_to_clear = true
	wave.spawn_position = spawn_pos
	
	G.main.world.spawn_wave(wave)
	
	await get_tree().create_timer(spawn_rate).timeout
	attack()

func damage(damage: int = 1) -> int:
	hp -= damage
	if hp < max_hp/2:
		spawn_rate = 5
	set_hp_bar_value(max_hp,hp)
	var t: float = clamp(float(hp) / float(max_hp), 0.0, 1.0)
	modulate = Color.WHITE.lerp(mask_color, 1.0 - t)
	procces_die()
	return damage

func procces_die():
	if hp<=0:
		for child:Node in G.main.world.enemies_parent.get_children():
			if child != self:
				child.queue_free()
		for child:Node in G.main.world.projectiles.get_children():
			child.queue_free()
		hp_bar.hide()
		death.emit()
		set_collision_layer_value(1,false)
		velocity = Vector2.ZERO
		sprite.play("die")
		await sprite.animation_finished
		gpu_particles_2d.emitting = true
		gpu_particles_2d_2.emitting = true
		await gpu_particles_2d.finished
		queue_free()

func set_hp_bar_value(max_hp, hp):
	var value = float(hp) / float(max_hp) * 100

	if hp_tween: hp_tween.kill()
	hp_tween = create_tween()
	hp_tween.tween_property(hp_bar, "value", value, 0.5)
