class_name Game extends Node

@export var game_speed: float = 800
@export var max_game_speed: float = 1000
@export var game_speed_increase_rate: float = (max_game_speed - game_speed) / 120


func _physics_process(delta: float) -> void:
	game_speed += game_speed_increase_rate * delta
	game_speed = clamp(game_speed, 0, max_game_speed)
