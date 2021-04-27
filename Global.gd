extends Node

var levelCoins: int = 0 setget set_levelCoins

func set_levelCoins(_value):
	levelCoins = _value
	get_tree().call_group("GUI","set_coins",levelCoins)
