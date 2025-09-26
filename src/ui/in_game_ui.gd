extends Control
class_name GameUI

var bullets_values:Dictionary = {
	0:0,1:11,2:22,3:33,
	4:44,5:57,6:68,
	7:78,8:94
}

@onready var bullets_clip: TextureProgressBar = $HBoxContainer/bullets_clip
@onready var hpbar: TextureProgressBar = $HBoxContainer/hpbar

func set_clip_status(bullets_left):
	bullets_clip.value = bullets_values[bullets_left]
