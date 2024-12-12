extends Node2D

class_name Spawners

@export var zombie_scene: PackedScene

@onready var l_collision_shape_2d: CollisionShape2D = $LeftSpawner/CollisionShape2D
@onready var r_collision_shape_2d: CollisionShape2D = $RightSpawner/CollisionShape2D
@onready var t_collision_shape_2d: CollisionShape2D = $TopSpawner/CollisionShape2D

@export var spawns_interval_in_seconds: float = 0.5
@export var number_of_zombies: int = 0
var time_since_last_spawn: float = 0.0
var spawner_areas = []

func _ready() -> void:
	spawner_areas = [l_collision_shape_2d, r_collision_shape_2d, t_collision_shape_2d]

func _can_spawn_zombie() -> bool:
	return number_of_zombies > 0 and time_since_last_spawn > spawns_interval_in_seconds

func _spawn_zombie() -> void:
	time_since_last_spawn = 0
	
	var collision_shape = spawner_areas.pick_random()

	var rect_shape = collision_shape.shape as RectangleShape2D
	var extents = rect_shape.extents  # Get the extents (half the width and height)

	# Generate a random point inside the rectangle
	var random_x = randf_range(-extents.x, extents.x)
	var random_y = randf_range(-extents.y, extents.y)
	
	var random_point = collision_shape.global_position + Vector2(random_x, random_y) 
	
	var zombie = zombie_scene.instantiate()
	zombie.global_position = random_point
	number_of_zombies -= 1
	get_tree().root.add_child(zombie)

func _process(delta: float) -> void:
	time_since_last_spawn += delta
	if not _can_spawn_zombie():
		return
	
	_spawn_zombie()
