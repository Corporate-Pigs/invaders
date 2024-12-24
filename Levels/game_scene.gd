extends Node2D

@onready var spawners: Node2D = $Trensh/Spawners
@onready var score_label: Label = $Camera2D/ScoreLabel
@onready var round_label: Label = $Camera2D/RoundLabel
@onready var mid_title_label: Label = $Camera2D/MidTitleLabel
@onready var input_settins = $CanvasLayer/InputSettings

var round: int = -1
var dosh: int = 0
var zombies_left = 0

var zombies_per_round = [100, 200, 300, 400]
var spawn_rate_per_round = [0.5, 0.9, 0.8, 0.7]

var is_paused: bool

func _ready() -> void:
	is_paused = false
	EventBus.connect(EventBus.on_zombie_killed, _on_zombie_killed)
	_show_next_round()

func _unhandled_input(event: InputEvent) -> void:
	if !event.is_action_pressed("pause"):
		return
	
	is_paused = !is_paused
	if is_paused:
		Engine.time_scale = 0
		input_settins.visible = 1
	else:
		Engine.time_scale = 1
		input_settins.visible = 0
	
	get_tree().root.get_viewport().set_input_as_handled()
	

func _on_zombie_killed(zombie: Zombie) -> void:
	dosh += zombie.reward
	score_label.text = "Dosh: " + str(dosh) + "€"
	zombies_left -= 1
	if zombies_left == 0:
		_show_next_round()
 
func _show_next_round() -> void:
	pass
	#mid_title_label.visible = true
	await get_tree().create_timer(5).timeout.connect(_start_next_round)

func _start_next_round() -> void:
	mid_title_label.visible = false
	round += 1
	zombies_left = zombies_per_round[round]
	spawners.number_of_zombies = zombies_left
	spawners.spawns_interval_in_seconds = spawn_rate_per_round[round]
	round_label.text = "Round: " + str(round + 1)
