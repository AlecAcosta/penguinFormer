extends StaticBody2D

var rCoinGrabbed = preload("res://scenes/CoinGrabbed.tscn")
var dropCoin = true

func punched():
	if (dropCoin):
		dropCoin = false
		var iCoinGrabbed = rCoinGrabbed.instance()
		iCoinGrabbed.global_position = self.global_position + Vector2(0,-8)###
		get_tree().get_root().add_child(iCoinGrabbed)
		$AnimationPlayer.play("break")
		yield($AnimationPlayer,"animation_finished")
		queue_free()
