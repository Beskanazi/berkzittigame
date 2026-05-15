extends AnimatableBody2D

@export var is_left: bool = true
@export var rest_angle_deg: float = 30.0
@export var snap_angle_deg: float = 60.0
@export var flip_speed: float = 30.0

var _action: String = ""
var _rest_rad: float = 0.0
var _active_rad: float = 0.0


func _ready() -> void:
	_action = "flipper_left" if is_left else "flipper_right"
	if is_left:
		_rest_rad = deg_to_rad(rest_angle_deg)
		_active_rad = deg_to_rad(rest_angle_deg - snap_angle_deg)
	else:
		_rest_rad = deg_to_rad(180.0 - rest_angle_deg)
		_active_rad = deg_to_rad(180.0 - rest_angle_deg + snap_angle_deg)
	rotation = _rest_rad


func _physics_process(delta: float) -> void:
	var target: float = _active_rad if Input.is_action_pressed(_action) else _rest_rad
	rotation = lerp_angle(rotation, target, clampf(flip_speed * delta, 0.0, 1.0))
