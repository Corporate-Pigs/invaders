extends Area2D

class_name Bullet

@export var speed = 600
@export var direction = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rotation = direction.angle()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += direction * speed * delta

func _on_area_entered(area: Area2D) -> void:
	if area is Zombie:
		var zombie = area as Zombie
		zombie.damage(33)
		EventBus.zombie_killed(zombie)
