extends Node2D

@onready var spawners: Node2D = $Spawners
@onready var score_label: Label = $Camera2D/ScoreLabel
@onready var round_label: Label = $Camera2D/RoundLabel
@onready var mid_title_label: Label = $Camera2D/MidTitleLabel

var round: int = -1
var dosh: int = 0
var zombies_left = 0

var zombies_per_round = [1, 2, 3, 4]
var spawn_rate_per_round = [1, 0.9, 0.8, 0.7]

func _ready() -> void:
	EventBus.connect(EventBus.on_zombie_killed, _on_zombie_killed)
	_show_next_round()

func _on_zombie_killed(zombie: Zombie) -> void:
	dosh += zombie.reward
	score_label.text = "Dosh: " + str(dosh) + "€"
	zombies_left -= 1
	if zombies_left == 0:
		_show_next_round()
 
func _show_next_round() -> void:
	mid_title_label.visible = true
	await get_tree().create_timer(5).timeout.connect(_start_next_round)

func _start_next_round() -> void:
	mid_title_label.visible = false
	round += 1
	zombies_left = zombies_per_round[round]
	spawners.number_of_zombies = zombies_left
	spawners.spawns_interval_in_seconds = spawn_rate_per_round[round]
	round_label.text = "Round: " + str(round + 1)
