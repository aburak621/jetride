class_name ObstacleManager extends Node2D

@export var zapper_datas: Array[ZapperData]

const zapper_scene: PackedScene = preload("uid://d0o5g2dq2syid")
const chunk_scene: PackedScene = preload("uid://e2w3n5bk75je")


func _ready() -> void:
	spawn_chunk()


func spawn_zappers(count: int, chunk: Chunk) -> void:
	var spawn_point: Vector2
	for i in count:
		var zapper := zapper_scene.instantiate() as Zapper
		chunk.add_child(zapper)
		zapper.zapper_data = zapper_datas.pick_random()
		zapper.apply_zapper_data()
		zapper.position.x += spawn_point.x
		spawn_point.x += zapper.zapper_data.x_offset * 2
		spawn_point.x += 000 # TODO: Add a maybe scaling space between zappers (Maybe make all zappers prefabs)


func spawn_chunk() -> void:
	var chunk: Chunk = chunk_scene.instantiate()
	add_child(chunk)
	spawn_zappers(40, chunk)
	chunk.set_chunk_width(20000) # TODO: Placeholder
