extends Node
var total_coins: int = 0
func coin_collected(value: int):
	total_coins += value
	Eventcontrol.emit_signal("coin_collected", total_coins)
