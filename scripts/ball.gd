extends RigidBody2D

@export var radius: float = 12.0
@export var max_speed: float = 1600.0


func _draw() -> void:
	draw_circle(Vector2.ZERO, radius, Color(0.95, 0.95, 1.0))
	draw_circle(Vector2.ZERO, radius, Color(0.2, 0.2, 0.25), false, 1.5)
	draw_circle(Vector2(-radius * 0.35, -radius * 0.35), radius * 0.32, Color(1, 1, 1, 0.65))


func _physics_process(_delta: float) -> void:
	var speed := linear_velocity.length()
	if speed > max_speed:
		linear_velocity = linear_velocity / speed * max_speed
