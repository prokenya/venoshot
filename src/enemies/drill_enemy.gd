class_name Drill
extends Enemy

@onready var start_position = self.position

func _physics_process(delta: float) -> void:
	super(delta)
	var view_rect: Rect2 = get_viewport().get_visible_rect()
	var frame_tex = sprite.sprite_frames.get_frame_texture(sprite.animation, sprite.frame)
	
	var half_height = (frame_tex.get_size().y * collider.scale.y) / 2.0
	var bottom = view_rect.position.y + view_rect.size.y - half_height
	
	if position.y >= bottom:
		G.main.player.player_hp -= enemy_damage
		current_orbit = 1
	collider.scale = collider_base_scale + Vector2(current_orbit, current_orbit) * (position.y - target_orbit_y) * 0.001
