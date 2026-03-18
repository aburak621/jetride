class_name Player extends CharacterBody2D

@export var gravity: float = 4411.7
@export var jump_acceleration: float = 3333.3 + gravity
@export var max_jump_speed: float = 1666.5
@export var max_fall_speed: float = 882.4


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

	velocity.y += gravity * delta

	if is_on_floor():
		velocity.y = 0

	if Input.is_action_pressed("jump"):
		if Input.is_action_just_pressed("jump") and velocity.y > 0:
			velocity.y = 0
		velocity.y -= jump_acceleration * delta
	
	if Input.is_action_just_released("jump"):
		if velocity.y < 0:
			velocity.y *= 0.75
	
	velocity.y = clampf(velocity.y, -max_jump_speed, max_fall_speed)

	velocity.x = 0
	move_and_slide()
