extends Area2D

class_name Zombie 

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var hp_bar: HPBar = $HpBar

enum State {
	uninitialized,
	walking,
	attacking,
	dead
}

@export var speed: int = 150
@export var reward: int = 1000
@export var attack_damage: int = 1
@export var attacks_per_second: int = 1
@export var max_hp = 100

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
	sprite_2d.rotation = direction.angle()
	current_state = State.walking
	hp_bar.max_hp = max_hp
	hp_bar.current_hp = max_hp

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
			current_decoy.damage(attack_damage)

func damage(damage: float) -> void:
	if current_state == State.dead:
		return
	
	hp_bar.update_hp_with_delta(-damage)
	if hp_bar.current_hp <= 0:
		current_state = State.dead
		sprite_2d.modulate.a = 0.25
	
func attack(decoy: Decoy) -> void:
	current_decoy = decoy
	current_state = State.attacking
