class_name ObstacleManager extends Node2D

@export var zapper_datas: Array[ZapperData]
@export var coin_scenes: Array[PackedScene]

@onready var game: Game = get_tree().get_first_node_in_group("game")
@onready var initial_game_speed: float = game.game_speed

const zapper_scene: PackedScene = preload("uid://d0o5g2dq2syid")
const chunk_scene: PackedScene = preload("uid://e2w3n5bk75je")
var spacing: float


func _ready() -> void:
	spawn_chunk()


func spawn_zappers(count: int, chunk: Chunk) -> void:
	var spawn_point: Vector2
	generate_new_spacing()
	for i in count:
		var zapper := zapper_scene.instantiate() as Zapper
		chunk.add_child(zapper)
		zapper.zapper_data = zapper_datas.pick_random()
		zapper.apply_zapper_data()
		zapper.position.x += spawn_point.x
		spawn_point.x += zapper.zapper_data.x_offset * 2
		spawn_point.x += spacing * remap(zapper.zapper_data.x_offset, 60, 200, 0.75, 1)
	chunk.set_chunk_width(spawn_point.x)


func spawn_coins(count: int, chunk: Chunk) -> void:
	var spawn_point: Vector2
	generate_new_spacing()
	for i in count:
		var coin_scene: PackedScene = coin_scenes.pick_random()
		var coins := coin_scene.instantiate() as Node2D
		chunk.add_child(coins)
		var coins_size: Vector2 = (coins.get_node("VisibleOnScreenNotifier2D") as VisibleOnScreenNotifier2D).rect.size
		coins.position.x += spawn_point.x
		spawn_point.x += coins_size.x
		spawn_point.x += spacing * remap(coins_size.x, 560, 1400, 1, 1.5)
		coins.position.y = -(randf_range(0, 750 - coins_size.y) + 50)
	chunk.set_chunk_width(spawn_point.x)



func generate_new_spacing() -> void:
	spacing = (
		[1.5, 2, 2.5].pick_random()
		* 240
		* remap(game.game_speed, initial_game_speed, game.max_game_speed, 1, 3)
	)


func spawn_chunk() -> void:
	var chunk: Chunk = chunk_scene.instantiate()
	add_child(chunk)
	chunk.global_position.y = global_position.y
	# spawn_zappers(40, chunk)
	spawn_coins(40, chunk)
