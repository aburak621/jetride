class_name Zapper extends Area2D

@export var zapper_data: ZapperData

@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var left_sprite: AnimatedSprite2D = $LeftSprite
@onready var right_sprite: AnimatedSprite2D = $RightSprite
@onready var beam: AnimatedSprite2D = $Beam

var length: float = 270
var width: float = 60
var rotation_speed: float = 0


func _physics_process(delta: float) -> void:
	rotation += deg_to_rad(rotation_speed) * delta


func apply_zapper_data() -> void:
	length = zapper_data.length
	rotation_speed = zapper_data.rotation_speed

	position.x += zapper_data.x_offset
	position.y = clamp([0, 0, 1, 2, 3, 4, 5].pick_random() * -138 - 80, -zapper_data.max_y, -zapper_data.min_y)

	left_sprite.position.y = length / 2 - 35
	right_sprite.position.y = -(length / 2 - 41)

	var tiling: float = (length - 118) / 152
	(beam.material as ShaderMaterial).set_shader_parameter("tiling", Vector2(tiling, 1))
	beam.scale.x = 2 * tiling

	var shape := collision.shape as CapsuleShape2D
	shape.radius = width / 2
	shape.height = length

	rotation = deg_to_rad(zapper_data.rotation) * [-1, 1].pick_random()
