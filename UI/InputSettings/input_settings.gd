extends Control

@onready var input_button_scene = preload("res://UI/InputSettings/input_button.tscn")
@onready var action_list_container = $PanelContainer/MarginContainer/VBoxContainer/ScrollContainer/ActionList

var is_remaping: bool = false
var action_to_remap
var button_to_remap: Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_create_action_list()

func _create_action_list() -> void:
	InputMap.load_from_project_settings()
	for item in action_list_container.get_children():
		item.queue_free()
	
	for action in InputMap.get_actions():
		if action.begins_with("ui_"):
			continue
		
		var button = input_button_scene.instantiate() as Button
		var button_action_label = button.find_child("LabelAction") as Label
		var button_key_label = button.find_child("LabelKey") as Label
		
		button_action_label.text = action
		
		var events = InputMap.action_get_events(action)
		if events.size() > 0:
			button_key_label.text = events[0].as_text()
		else:
			button_key_label.text = ""
		
		button.pressed.connect(_on_input_button_pressed.bind(button, action))
		action_list_container.add_child(button)

func _on_input_button_pressed(button: Button, action: String) -> void:
	if is_remaping:
		return
	
	is_remaping = true
	action_to_remap = action
	button_to_remap = button
	
	_update_button_label(button, "LabelKey", "Press any key to bind...")

func _input(event: InputEvent) -> void:
	if !is_remaping:
		return
	
	if (
		event is InputEventKey ||
		(event is InputEventMouse && event.is_pressed())
	):
		InputMap.action_erase_events(action_to_remap)
		InputMap.action_add_event(action_to_remap, event)
		_update_button_label(button_to_remap, "LabelKey", event.as_text())
		
		is_remaping = false
		action_to_remap = null
		button_to_remap = null

func _update_button_label(button: Button, label_name: String, label_text: String) -> void:
	var label_key = button.find_child(label_name) as Label
	label_key.text = label_text
