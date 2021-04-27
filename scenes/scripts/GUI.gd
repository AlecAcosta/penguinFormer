extends Control

var coins = Global.coins setget set_coins

func set_coins(_value):
	coins = _value
	$Label.text = coins
