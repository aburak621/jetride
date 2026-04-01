class_name Game extends Node

@export var game_start_speed: float = 1000
@export var max_game_speed: float = 2000

@onready var player: Player = get_tree().get_first_node_in_group("player")

var game_speed: float
var difficulty_scaling: float = 1
var distance_travelled: float
var max_scaling_distance: float = 400000


func _physics_process(delta: float) -> void:
	distance_travelled += game_speed * delta

	game_speed = clamp(
		remap(distance_travelled, 0, max_scaling_distance, game_start_speed, max_game_speed),
		game_start_speed,
		max_game_speed
	)

	difficulty_scaling = clamp(remap(distance_travelled, 0, max_scaling_distance, 1, 3), 1, 3)
