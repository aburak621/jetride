class_name Laser extends Area2D

@export var length: float = 270
@export var width: float = 60
@export var initial_rotation: float = 90

@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var sprite: ColorRect = $ColorRect


func _ready() -> void:
	sprite.size = Vector2(width, length)
	sprite.set_anchors_preset(Control.LayoutPreset.PRESET_CENTER)

	var shape := collision.shape as CapsuleShape2D
	shape.radius = width / 2
	shape.height = length

	rotation = deg_to_rad(initial_rotation)

