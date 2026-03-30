class_name Rocket extends Area2D

signal exploded

var speed: float = 2886


func _ready() -> void:
	area_entered.connect(
		func() -> void:
			exploded.emit()
			queue_free()
	)


func _physics_process(delta: float) -> void:
	global_position.x -= speed * delta

	if global_position.x < -960:
		queue_free()
