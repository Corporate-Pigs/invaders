extends Area2D

class_name Player

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var weapon_labels: Node2D = $WeaponLabels
@onready var magazine_count_lbl: Label = $WeaponLabels/MagazineCountLbl

@export var speed = 500 

var direction = Vector2.UP
var current_weapon: Weapon = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rotation = direction.angle()
	var weapon_1911_scene = load("res://Prefabs/weapons/1911.tscn")
	var weaponp_1911 = weapon_1911_scene.instantiate()
	add_child(weaponp_1911)
	
	current_weapon = weaponp_1911 as Weapon
	

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
	
	var new_rotation = direction.angle()
	rotation = new_rotation
	weapon_labels.rotation = -new_rotation

func _update_weapon_labels() -> void:	
	if current_weapon.is_reloading:
		magazine_count_lbl.text = str(round_to_dec(current_weapon.reload_speed - current_weapon.time_between_reloading_acc, 2))
	else:
		magazine_count_lbl.text = str(current_weapon.bullets_in_magazine)

func round_to_dec(num, digit):
	return round(num * pow(10.0, digit)) / pow(10.0, digit)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var movementDirection = _getMovementDirectionFromInput()
	_moveInDirection(movementDirection * delta)
	_rotateToMousePoint()
	
	_update_weapon_labels()
