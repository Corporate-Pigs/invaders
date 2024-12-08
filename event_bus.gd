extends Node

signal zombie_killed_signal(zombie: Zombie)

var on_zombie_killed :String = self.zombie_killed_signal.get_name()

func zombie_killed(zombie: Zombie):
	emit_signal(on_zombie_killed, zombie)
