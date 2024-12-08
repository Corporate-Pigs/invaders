extends Node2D

func _on_despawner_entered(body: Node2D) -> void:
	body.queue_free()
