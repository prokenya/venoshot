extends Sprite2D
class_name Weapon

@export var scope:Sprite2D
@export var ray:RayCast2D
@export var timer:Timer

@onready var shot_sprite: Sprite2D = $"../Shot"
@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"


func _input(event: InputEvent) -> void:
	var view_rect: Rect2 = get_viewport().get_visible_rect()
	global_position.y = view_rect.size.y - get_rect().size.y
	
	var gmp = get_global_mouse_position()
	global_position.x = gmp.x
	scope.global_position = gmp
	
	if Input.is_action_just_pressed("shot") and timer.is_stopped():
		shot()

func _physics_process(delta: float) -> void:
	$Label.text = "reloading " +  str(timer.time_left)

func shot():
	timer.start()
	ray.target_position = scope.position
	ray.force_raycast_update()
	if ray.is_colliding():
		var collider = ray.get_collider()
		if collider is Enemy:
			collider.damage(1)
			shot_sprite.global_position = ray.get_collision_point()
			animation_player.play("shot_animation_normal")
			
