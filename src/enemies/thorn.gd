class_name Thorn
extends Enemy

@onready var start_position = self.position

func _ready() -> void:
	super()
	velocity.x *= [1,-1].pick_random()

func _physics_process(delta: float) -> void:
	super(delta)
	var view_rect: Rect2 = get_viewport().get_visible_rect()
	var frame_tex = sprite.sprite_frames.get_frame_texture(sprite.animation, sprite.frame)

	var half_height = (frame_tex.get_size().y * collider.scale.y) / 4.0
	var bottom = view_rect.position.y + view_rect.size.y - half_height
	
	if position.y >= bottom:
		G.main.player.player_hp -= enemy_damage
		queue_free()
	collider.scale = collider_base_scale + Vector2(current_orbit, current_orbit) * (position.y - target_orbit_y) * 0.001
	sprite.rotation += delta
	z_index = 99

func procces_die():
	if hp <= 0:
		for i in range(2):
			var wave = Wave.new()
			wave.enemy_type = [0,1,2,6].pick_random()
			wave.spawn_position = global_position
			wave.orbit = [1,2,3].pick_random()
			G.main.world.spawn_wave(wave)
		queue_free()
