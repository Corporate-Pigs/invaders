extends Area2D

class_name Decoy

@export var max_hp = 100

@onready var hp_bar: HPBar = $HpBar

func _ready() -> void:
	hp_bar.current_hp = max_hp
	hp_bar.max_hp = max_hp

func damage(damage: int):
	hp_bar.update_hp_with_delta(-damage as float)

func _on_area_entered(area: Area2D) -> void:
	if area is Zombie:
		area.attack(self)
