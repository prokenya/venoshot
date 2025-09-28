extends StaticBody2D

@onready var shape_left: CollisionShape2D = $shape_left
@onready var shape_right: CollisionShape2D = $shape_right
@onready var shape_bottom: CollisionShape2D = $shape_bottom

func _physics_process(delta: float) -> void:
	var view_rect: Rect2 = get_viewport().get_visible_rect()

	shape_left.position.x = view_rect.position.x
	shape_right.position.x = view_rect.position.x + view_rect.size.x

	shape_bottom.position.y = view_rect.position.y + view_rect.size.y
