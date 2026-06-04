extends Node2D

@export var spawn_interval: float = 3.0

var timer: float = 0.0

@onready var zombie_scene = preload("res://Scenes/zombie.tscn")

func _process(delta: float) -> void:
	timer -= delta

	if timer <= 0.0:
		spawn_zombie()
		timer = spawn_interval

func spawn_zombie() -> void:
	var zombie = zombie_scene.instantiate()

	get_parent().add_child(zombie)

	zombie.global_position = Vector2(
		randi_range(150, 750),
		randi_range(150, 500)
	)
