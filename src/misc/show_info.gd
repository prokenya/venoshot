extends CanvasLayer

var tween:Tween

func show_splash(idx:int,duration:int = 2) -> void:
	var current_window:Control = get_child(idx)
	current_window.show()
	
	if tween:
		tween.kill()
	tween = create_tween()
	
	tween.tween_property(current_window,"modulate",Color(1.0, 1.0, 1.0, 1.0),duration)
	await tween.finished
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(current_window,"modulate",Color(0.0, 0.0, 0.0, 0.0),duration)
	await tween.finished
	hide()
	return
