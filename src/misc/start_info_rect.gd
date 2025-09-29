class_name OnStartRect
extends TextureRect

@export_range(1, 15, 0.5) var duration: float = 3


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().paused = true
	
	show()
	modulate = Color(0.0, 0.0, 0.0, 1.0)
	var tween = create_tween()

	tween.tween_property(self, "modulate", Color(1.0, 1.0, 1.0, 1.0), duration / 2)
	await tween.finished
	tween = create_tween()
	tween.tween_property(self, "modulate", Color(0.0, 0.0, 0.0, 0.0), duration / 2)
	await tween.finished
	get_tree().paused = false
	queue_free()

func _input(event: InputEvent) -> void:
	if Input.is_anything_pressed():
		var tween = create_tween() 
		tween.tween_property(self, "modulate", Color(0.0, 0.0, 0.0, 0.0), 0.5)
		await tween.finished
		get_tree().paused = false
		queue_free()
