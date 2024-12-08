extends CanvasLayer

const NEXT_SCENE = "res://Scenes/game_scene.tscn"

func _on_play_button_pressed() -> void:
	if get_tree().change_scene_to_file(NEXT_SCENE) != OK:
		printerr("Scene '" + NEXT_SCENE + "' not found!")

func _on_quit_button_pressed() -> void:
	get_tree().quit()
