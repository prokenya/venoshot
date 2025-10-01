class_name GameUI
extends Control

var bullets_values: Dictionary = {
	0: 0, 1: 11, 2: 22, 3: 33,
	4: 44, 5: 57, 6: 68,
	7: 78, 8: 94
}

var hp_tween: Tween
var buff_ba_tween:Tween
var relodaing_tween: Tween

@export var bullets_clip: TextureProgressBar
@export var hpbar: TextureProgressBar
@export var buff_bar:TextureProgressBar
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func set_clip_status(bullets_left):
	bullets_clip.value = bullets_values[bullets_left]
	if bullets_left == 0:
		show_reloading_animations()


func set_hp_bar_value(max_hp, hp):
	var value = float(hp) / float(max_hp) * 100

	if hp_tween: hp_tween.kill()
	hp_tween = create_tween()
	hp_tween.tween_property(hpbar, "value", value, 0.5)


func show_reloading_animations(duration: float = 2.5):
	if relodaing_tween: relodaing_tween.kill()
	var offset := 35
	var start_pos := bullets_clip.position
	var up_pos := start_pos + Vector2(0, -offset)
	
	animation_player.play("show_reload")
	
	relodaing_tween = create_tween()
	relodaing_tween.tween_property(bullets_clip, "position", up_pos, duration / 2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	relodaing_tween.tween_property(bullets_clip, "position", start_pos, duration / 2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
