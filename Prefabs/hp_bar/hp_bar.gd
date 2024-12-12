extends Node2D

class_name HPBar

@onready var green_bar: Polygon2D = $GreenBar

@export var current_hp = 50.0
@export var max_hp = 100.0
@export var fade_after_seconds = 1

var visible_for_seconds = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_update_green_bar_scale()

func _process(delta: float) -> void:
	visible_for_seconds += delta
	if visible and visible_for_seconds >= fade_after_seconds:
		modulate.a = 0
		
func set_hp(new_current_hp: float) -> void:
	current_hp = max(0, new_current_hp)
	_update_green_bar_scale()
	
func update_hp_with_delta(delta: float) -> void:
	current_hp += delta
	current_hp = max(current_hp, 0)
	_update_green_bar_scale()

func _update_green_bar_scale() -> void:
	var scale = current_hp / max_hp
	green_bar.scale.x = scale
	visible_for_seconds = 0
	modulate.a = 1
