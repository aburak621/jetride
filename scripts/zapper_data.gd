@tool
class_name ZapperData extends Resource

@export var length: float = 270:
	set(value):
		length = value
		update_properties()
@export var rotation: float = 90:
	set(value):
		rotation = value
		update_properties()
@export var rotation_speed: float = 0:
	set(value):
		rotation_speed = value
		update_properties()

var x_offset: float = 135
var min_y: float = 80
var max_y: float = 760


func update_properties() -> void:
	x_offset = max(length * (abs(sin(deg_to_rad(rotation))) if rotation_speed == 0 else 1) / 2, 30)
	var half_height: float = length * (abs(cos(deg_to_rad(rotation))) if rotation_speed == 0 else 1) / 2
	min_y = half_height + 30
	max_y = 850 - half_height - 30
