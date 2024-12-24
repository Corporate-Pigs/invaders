extends Node2D

@export var bullet_scene: PackedScene
@export var gun_shot: AudioStreamPlayer

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("shoot"):
		var bullet = bullet_scene.instantiate() as Bullet
		bullet.global_position = get_parent().global_position
		bullet.direction = get_parent().direction
		get_tree().root.add_child(bullet)
		gun_shot.play()
