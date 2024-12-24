extends Area2D

class_name Player

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

@export var speed = 400 

var direction = Vector2.UP
func _enter_tree():
	set_multiplayer_authority(name.to_int())

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rotation = direction.angle()

func _getMovementDirectionFromInput() -> Vector2:
	var verticalInput = Input.get_axis("up", "down")
	var horizontalInput = Input.get_axis("left", "right")
	return Vector2(horizontalInput, verticalInput)

func _moveInDirection(direction: Vector2) -> void:
	position += direction * speed

func _rotateToMousePoint() -> void:
	var mouse_position = get_viewport().get_mouse_position()
	var rectangle_shape = collision_shape_2d.shape.get_rect()
	var center = position
	direction = (mouse_position - center).normalized()
	rotation = direction.angle()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var movementDirection = _getMovementDirectionFromInput()
	_moveInDirection(movementDirection * delta)
	_rotateToMousePoint()
