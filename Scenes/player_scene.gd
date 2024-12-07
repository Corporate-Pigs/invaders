extends Area2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

@export var speed = 500

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

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
	var rotation_angle = (mouse_position - center).angle()
	rotation = rotation_angle + PI * 0.5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var movementDirection = _getMovementDirectionFromInput()
	_moveInDirection(movementDirection * delta)
	_rotateToMousePoint()
