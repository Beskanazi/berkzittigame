extends Node2D

const BALL_SCENE := preload("res://scenes/ball.tscn")
const STARTING_BALLS := 3

@onready var ball_spawn: Marker2D = $BallSpawn
@onready var score_label: Label = $HUD/Margin/VBox/ScoreLabel
@onready var info_label: Label = $HUD/Margin/VBox/InfoLabel

var score: int = 0
var balls_remaining: int = STARTING_BALLS
var current_ball: RigidBody2D = null
var ball_ready_for_launch: bool = false
var game_over: bool = false


func _ready() -> void:
	add_to_group("main")
	_refresh_hud()
	_spawn_ball()


func _process(_delta: float) -> void:
	if current_ball and current_ball.global_position.y > 1360:
		_drain_ball()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("launch"):
		_try_launch()
	elif event.is_action_pressed("restart"):
		_restart()


func add_score(points: int) -> void:
	if game_over:
		return
	score += points
	_refresh_hud()


func _spawn_ball() -> void:
	if balls_remaining <= 0:
		game_over = true
		_refresh_hud()
		return
	current_ball = BALL_SCENE.instantiate()
	current_ball.global_position = ball_spawn.global_position
	current_ball.freeze = true
	add_child(current_ball)
	ball_ready_for_launch = true
	_refresh_hud()


func _try_launch() -> void:
	if game_over or current_ball == null or not ball_ready_for_launch:
		return
	current_ball.freeze = false
	current_ball.apply_central_impulse(Vector2(0, -900))
	ball_ready_for_launch = false
	_refresh_hud()


func _drain_ball() -> void:
	if current_ball:
		current_ball.queue_free()
		current_ball = null
	balls_remaining -= 1
	_refresh_hud()
	if balls_remaining > 0:
		await get_tree().create_timer(0.8).timeout
		_spawn_ball()
	else:
		game_over = true
		_refresh_hud()


func _restart() -> void:
	get_tree().reload_current_scene()


func _refresh_hud() -> void:
	score_label.text = "SCORE  %07d" % score
	if game_over:
		info_label.text = "GAME OVER  -  Press R to restart"
	elif ball_ready_for_launch:
		info_label.text = "Balls: %d  -  SPACE to launch  -  A / D flippers" % balls_remaining
	else:
		info_label.text = "Balls: %d  -  A / D flippers  -  R restart" % balls_remaining
