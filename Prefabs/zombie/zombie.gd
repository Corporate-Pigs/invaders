extends Area2D

class_name Zombie 

enum State {
	uninitialized,
	walking,
	attacking
}

@export var speed: int = 150
@export var reward: int = 1000
@export var damage: int = 1
@export var attacks_per_second: int = 1

var direction = Vector2.ZERO
var current_state : State = State.uninitialized
var current_decoy : Decoy = null
var seconds_since_last_attack = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var root_scene = get_tree().root.get_child(1)
	var decoys_node = root_scene.get_node("Decoys")
	current_decoy = _select_decoy_from(decoys_node)
	direction = (current_decoy.position - position).normalized()
	rotation = direction.angle()
	current_state = State.walking

func _select_decoy_from(decoys: Node2D) -> Node2D:
	var distance = 999999
	var target: Node2D = decoys.get_child(0)
	# find closest decoy
	for child in decoys.get_children():
		var distance_to_child = child.position.distance_to(position)
		if distance_to_child < distance:
			distance = distance_to_child
			target = child
			break
			
	return target

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if current_state == State.walking:
		position += direction * speed * delta
	elif current_state == State.attacking:
		seconds_since_last_attack += delta
		if seconds_since_last_attack > attacks_per_second:
			seconds_since_last_attack = 0
			current_decoy.damage(damage)

func attack(decoy: Decoy) -> void:
	current_decoy = decoy
	current_state = State.attacking
