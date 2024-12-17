extends Node2D

class_name Weapon

enum FIRE_MODE {SINGLE, FULL_AUTO}

const shoot_action = "shoot"
const reload_action = "reload"

@export var gun_name: String
@export var damage: float
@export var magazine_size: int
@export var fire_rate: float			# Rounds per minute
@export var reload_speed: float			# Seconds
@export var fire_mode: FIRE_MODE
@export var bullet_scene: PackedScene

var bullets_in_magazine: int
var is_reloading = false
var time_between_reloading_acc: float = 0

var is_firing = false
var time_between_firing_s: float
var time_between_firing_acc: float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bullets_in_magazine = magazine_size
	time_between_firing_s = 60 / fire_rate

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if _is_still_reloading(delta) || _is_still_firing(delta):
		return
	
	if Input.is_action_pressed(shoot_action):
		if fire_mode == FIRE_MODE.SINGLE:
			_shoot_single_fire()
		else:
			_shoot_full_auto()
	elif Input.is_action_pressed(reload_action):
		bullets_in_magazine = magazine_size
		is_reloading = true
		#await get_tree().create_timer(reload_speed).timeout.connect(_stop_reloading)

func _shoot_single_fire() -> void:
	if Input.is_action_just_pressed(shoot_action):
		_fire()

func _shoot_full_auto() -> void:
	if Input.is_action_pressed(shoot_action):
		_fire()

func _fire() -> void:
	if bullets_in_magazine <= 0 || is_firing:
		return
	
	bullets_in_magazine -= 1
	is_firing = true
	
	# Spawn bullet
	var bullet = bullet_scene.instantiate() as Bullet
	var parent = get_parent()
	bullet.global_position = parent.global_position
	bullet.direction = parent.direction
	bullet.damage = damage
	get_tree().root.add_child(bullet)

func _is_still_reloading(delta: float) -> bool:
	if !is_reloading:
		return is_reloading	
	
	time_between_reloading_acc += delta
	if time_between_reloading_acc >= reload_speed:
		is_reloading = false
		time_between_reloading_acc = 0
	
	return is_reloading

func _is_still_firing(delta: float) -> bool:
	if !is_firing:
		return is_firing
	
	time_between_firing_acc += delta
	if time_between_firing_acc >= time_between_firing_s:
		is_firing = false
		time_between_firing_acc = 0
	
	return is_firing
