extends Area2D

class_name Decoy

var hp = 1000

func damage(damage: int):
	hp -= damage
	print(hp)

func _on_area_entered(area: Area2D) -> void:
	if area is Zombie:
		area.attack(self)
