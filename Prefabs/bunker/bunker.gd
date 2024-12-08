extends Area2D

func _on_bunker_entered(body: Node2D) -> void:
	body.queue_free()
