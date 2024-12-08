extends Node

signal zombie_killed_signal(zombie: Zombie)

func zombie_killed(zombie: Zombie):
	emit_signal("zombie_killed_signal", zombie)
