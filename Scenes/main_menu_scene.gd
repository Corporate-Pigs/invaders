extends CanvasLayer

const NEXT_SCENE = "res://Scenes/game_scene.tscn"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_play_button_pressed() -> void:
	if get_tree().change_scene_to_file(NEXT_SCENE) != OK:
		printerr("Scene '" + NEXT_SCENE + "' not found!")

func _on_quit_button_pressed() -> void:
	get_tree().quit()
