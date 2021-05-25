extends Area2D

var rCoinGrabbed = preload("res://scenes/CoinGrabbed.tscn")
var dropCoin = true

func _on_body_entered(body):
	if (body.name == "Penguin"):
		queue_free()
	if (dropCoin):
		dropCoin = false
		var iCoinGrabbed = rCoinGrabbed.instance()
		iCoinGrabbed.global_position = self.global_position + Vector2(0,-8)
		get_tree().get_root().add_child(iCoinGrabbed)
		Global.levelCoins += 1
