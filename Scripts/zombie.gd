extends CharacterBody2D

@export var max_health: int = 30
@export var speed: float = 120.0
@export var damage: int = 10
@export var attack_range: float = 28.0
@export var attack_cooldown: float = 1.0

var health: int = 30
var player: CharacterBody2D
var attack_timer: float = 0.0

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

func _physics_process(delta: float) -> void:
	if player == null:
		return

	attack_timer -= delta

	var distance_to_player: float = global_position.distance_to(player.global_position)

	if distance_to_player > attack_range:
		var direction: Vector2 = (player.global_position - global_position).normalized()
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO

	move_and_slide()

	if distance_to_player <= attack_range and attack_timer <= 0.0:
		player.take_damage(damage)
		attack_timer = attack_cooldown
		
func take_damage(amount: int) -> void:
	health -= amount

	print("Zombie HP: ", health)

	if health <= 0:
		print("Zombie died")
		queue_free()
