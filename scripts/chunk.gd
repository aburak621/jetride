class_name Chunk extends Node2D

@onready var game: Game = get_tree().get_first_node_in_group("game")
@onready var visible_notifier: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D

var chunk_width: float


func _ready() -> void:
	visible_notifier.screen_exited.connect(_on_screen_exited)


func _physics_process(delta: float) -> void:
	position.x -= game.game_speed * delta


func set_chunk_width(width: float) -> void:
	chunk_width = width + 100
	visible_notifier.rect.size.x = chunk_width

	var rect := $ColorRect
	rect.position.x = chunk_width


func _on_screen_exited() -> void:
	queue_free()
