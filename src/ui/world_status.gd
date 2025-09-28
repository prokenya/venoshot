extends CanvasLayer
class_name WorldStatus

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var wave_count: Label = %wave_count
@onready var game_over_sound: AudioStreamPlayer = $game_over/game_over_sound
@onready var win: AudioStreamPlayer = $win/WIN


func _ready() -> void:
	animation_player.animation_finished.connect(animation_finished)

func set_waves(idx:int):
	animation_player.play("show_wave_count")
	wave_count.text = str(idx)

func show_game_over():
	self.process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().paused = true
	game_over_sound.play()
	animation_player.play("game_over")


func animation_finished(anim_name:String):
	match anim_name:
		"game_over":
			get_tree().paused = false
			G.main.main_menu.exit_to_main_menu()
		_:return

func show_win():
	self.process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().paused = true
	animation_player.play("win",-1,2)
	await  get_tree().create_timer(1).timeout
	win.play()
	await animation_player.animation_finished
	animation_player.play("show_credits",-1,1)
	await animation_player.animation_finished
	G.main.main_menu.exit_to_main_menu()
	
