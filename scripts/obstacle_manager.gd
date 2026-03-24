class_name ObstacleManager extends Node2D

const zapper_scene: PackedScene = preload("uid://d0o5g2dq2syid")


func spawn_zappers(count: int) -> void:
	pass


func spawn_chunk() -> void:
	var chunk: Chunk = Chunk.new()
	spawn_zappers()
	chunk.set_chunk_width(2000) # TODO: Placeholder
	add_child(chunk)
