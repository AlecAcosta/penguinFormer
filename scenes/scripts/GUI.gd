extends Control

var coins = Global.levelCoins setget set_coins

func set_coins(_value):
	coins = _value
	$Label.text = str(coins)
