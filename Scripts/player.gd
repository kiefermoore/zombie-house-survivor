extends CharacterBody2D

@export var speed: float = 220.0
@export var max_health: int = 100
@export var melee_damage: int = 15
@export var melee_range: float = 50.0
@export var attack_cooldown: float = 0.4

var health: int = 100
var attack_timer : float = 0.0


func _physics_process(_delta: float) -> void:
	attack_timer -= _delta
	var direction: Vector2 = Vector2.ZERO

	direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")

	direction = direction.normalized()

	velocity = direction * speed

	move_and_slide()
	
	if Input.is_action_just_pressed("attack") and attack_timer <= 0.0:
		attack()
		attack_timer = attack_cooldown

func take_damage(amount: int) -> void:
	health -= amount

	print("Player HP: ", health)

	if health <= 0:
		print("Player died")
		queue_free()
		
func attack() -> void:
	print("Attack!")

	var zombies: Array = get_tree().get_nodes_in_group("zombies")

	for zombie in zombies:
		if global_position.distance_to(zombie.global_position) <= melee_range:
			zombie.take_damage(melee_damage)
