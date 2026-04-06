class_name Coin extends Area2D

signal coin_collected()

@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D


func collect() -> void:
	coin_collected.emit()
	queue_free()
