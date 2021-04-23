extends StaticBody2D

var rCoinGrabbed = preload("res://scenes/CoinGrabbed.tscn")

func punched():
	var iCoinGrabbed = rCoinGrabbed.instance()
	iCoinGrabbed.global_position = self.global_position #+ Vector2(0,-16)###
	get_tree().get_root().add_child(iCoinGrabbed)
	$AnimationPlayer.play("break")
	yield($AnimationPlayer,"animation_finished")
	queue_free()
