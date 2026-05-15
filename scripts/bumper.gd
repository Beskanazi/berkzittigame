extends Area2D

@export var points: int = 100
@export var force: float = 900.0
@export var radius: float = 30.0
@export var bumper_color: Color = Color(0.95, 0.3, 0.45)

var _flash_t: float = 0.0


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	set_process(false)


func _draw() -> void:
	var pulse := clamp(_flash_t / 0.12, 0.0, 1.0)
	var outer := bumper_color.lerp(Color(1, 1, 1), pulse)
	draw_circle(Vector2.ZERO, radius + pulse * 4.0, outer)
	draw_circle(Vector2.ZERO, radius, Color(0, 0, 0, 0.35), false, 2.0)
	draw_circle(Vector2.ZERO, radius * 0.55, outer.lightened(0.4))


func _process(delta: float) -> void:
	_flash_t = max(0.0, _flash_t - delta)
	queue_redraw()
	if _flash_t == 0.0:
		set_process(false)


func _on_body_entered(body: Node) -> void:
	if not (body is RigidBody2D):
		return
	var offset := body.global_position - global_position
	var dir := offset.normalized() if offset.length() > 0.01 else Vector2.UP
	body.linear_velocity = dir * force
	var main := get_tree().get_first_node_in_group("main")
	if main and main.has_method("add_score"):
		main.add_score(points)
	_flash_t = 0.12
	set_process(true)
