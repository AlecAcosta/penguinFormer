extends Node

var coins: int = 0 setget set_coins

func set_coins(_value):
	coins = _value
	print("set_coins() on Global.gd\ncoins = "+str(coins))
