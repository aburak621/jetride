class_name LaserArray extends Node2D

@export var laser_array_data: Array[LaserAnimation]

var animation_players: Array[AnimationPlayer]
var enter_animation_length: float


func _ready() -> void:
	for child in get_children():
		animation_players.append(child.get_node("AnimationPlayer") as AnimationPlayer)
	enter_animation_length = animation_players[0].get_animation("enter").length

	visible = true


func activate_lasers() -> float:
	var used_lasers: Dictionary[int, bool]
	var animation := laser_array_data.pick_random() as LaserAnimation
	for keyframe in animation.keyframes:
		var flag: int = animation.keyframes[keyframe].flags
		for i in range(7):
			if flag & (1 << i):
				used_lasers[i] = true
		get_tree().create_timer(keyframe + enter_animation_length).timeout.connect(
			func() -> void:
				for i in range(7):
					if flag & (1 << i):
						animation_players[i].play("activate")
		)

	for laser in used_lasers:
		animation_players[laser].play("enter")

	var last_keyframe: float = animation.keyframes.keys().max()
	get_tree().create_timer(last_keyframe + enter_animation_length + 3).timeout.connect(
		func() -> void:
			for laser in used_lasers:
				animation_players[laser].play("exit")
	)

	var exit_animation_length := 0.5
	return last_keyframe + enter_animation_length + 3 + exit_animation_length
