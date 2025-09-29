extends Node

var main:Main
var data:Data = Data.load_or_create()

@onready var main_scene:PackedScene = load("res://src/main.tscn")

var touch_available: bool = false
var touched_once: bool = false

signal toched

func _ready() -> void:
	# Check if touchscreen is available
	touch_available = DisplayServer.is_touchscreen_available()

	# Listen for input only if touchscreen is present
	if touch_available:
		set_process_input(true)


func _input(event: InputEvent) -> void:
	# Only run once and only if touchscreen exists
	if not touch_available or touched_once:
		return

	# Check for first touch (press on screen)
	if event is InputEventScreenTouch and event.pressed:
		touched_once = true
		toched.emit()
		# Stop listening after first activation
		set_process_input(false)
