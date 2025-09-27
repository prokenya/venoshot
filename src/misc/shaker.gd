extends Node
class_name Shaker
@onready var parent = get_parent()

# Public settings
var shake_magnitude: float = 16.0
var shake_duration: float = 0.5

# Internal
var _rng := RandomNumberGenerator.new()
var _shaking := false
var _time_left := 0.0
var _original_pos := Vector2.ZERO

func _ready():
	_rng.randomize()
	_original_pos = parent.position

func start_shake(magnitude: float = 16.0, duration: float = 0.5) -> void:
	# Start the shake effect
	shake_magnitude = magnitude
	shake_duration = duration
	_time_left = duration
	_shaking = true
	_original_pos = parent.position

func _process(delta: float) -> void:
	if _shaking:
		_time_left -= delta
		if _time_left <= 0.0:
			_shaking = false
			parent.position = _original_pos
		else:
			# linear falloff so shake weakens as time passes
			var t = _time_left / shake_duration
			var strength = shake_magnitude * t
			# random offset each frame
			parent.position = _original_pos + Vector2(
				_rng.randf_range(-1.0, 1.0),
				_rng.randf_range(-1.0, 1.0)
			) * strength
