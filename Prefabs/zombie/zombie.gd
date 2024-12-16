extends Area2D

class_name Zombie 

@export var speed = 50
@export var reward = 1000

var direction = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var target = get_tree().root.get_node("GameScene/Bunker")
	direction = (target.position - position).normalized()
	rotation = direction.angle()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += direction * speed * delta
