class_name MainMenu
extends Control

@export var ui_animations: AnimationPlayer

@export var sfx_spin_box: SpinBox
@export var music_spin_box: SpinBox

@export var start_button: Button
@export var exit_button: Button

@export var resume_button:Button

@onready var main_menu_music: AudioStreamPlayer = $main_menu_music

var in_ui: bool = false


func _ready() -> void:
	set_audio()

	start_button.pressed.connect(start_game)
	resume_button.pressed.connect(switch_ui)
	exit_button.pressed.connect(exit_to_main_menu)

	music_spin_box.value_changed.connect(_on_music_spin_box_value_changed)
	sfx_spin_box.value_changed.connect(_on_sfx_spin_box_value_changed)

	switch_ui()


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Menu"):
		switch_ui()


func switch_ui() -> void:
	if in_ui:
		ui_animations.play_backwards("show_menu")
	else:
		ui_animations.play("show_menu")
	in_ui = !in_ui

	get_tree().paused = in_ui
	await ui_animations.animation_finished
	return


func start_game():
	main_menu_music.stop()
	await switch_ui()
	G.main.load_world(0)
	start_button.visible = !start_button.visible
	exit_button.show()
	G.main.in_game_ui.show()
	resume_button.show()


func exit_to_main_menu():
	get_tree().change_scene_to_packed(G.main_scene)


func set_audio(data: Data = G.data):

	var bus_index = AudioServer.get_bus_index("sfx")
	var bus_index1 = AudioServer.get_bus_index("music")
	AudioServer.set_bus_volume_db(
		bus_index,
		linear_to_db(data.sfx)
	)
	AudioServer.set_bus_volume_db(
		bus_index1,
		linear_to_db(data.music)
	)
	sfx_spin_box.value = data.sfx * 100
	music_spin_box.value = data.music * 100


func _on_music_spin_box_value_changed(value: float) -> void:
	G.data.music = value / 100
	G.data.save()
	set_audio()


func _on_sfx_spin_box_value_changed(value: float) -> void:
	G.data.sfx = value / 100
	G.data.save()
	set_audio()
