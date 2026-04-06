class_name RocketWarning extends CharacterBody2D

signal timeout(y_position: float)

@export var speed: float = 200
@export var sprites: Array[AnimatedSprite2D]

@onready var player: Player = get_tree().get_first_node_in_group("player")

var countdown: float = 2  # TODO: Add scaling by distance
var timer: float = countdown


func _ready() -> void:
	global_position.x = 1770

	get_tree().create_timer(countdown - 0.5).timeout.connect(
		func() -> void:
			for sprite in sprites:
				sprite.play("flash")
	)


func _physics_process(delta: float) -> void:
	timer -= delta
	if timer <= 0:
		timeout.emit(global_position.y)
		queue_free()
	elif timer <= 0.5:
		return

	var y_delta := player.global_position.y - global_position.y
	if abs(y_delta) > 10:
		velocity.y = sign(y_delta) * speed
		move_and_slide()
		global_position.x = 1770
		global_position.y = clamp(global_position.y, 200, 950)
