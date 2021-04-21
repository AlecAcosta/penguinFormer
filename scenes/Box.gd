extends StaticBody2D

var rCoin = preload("res://scenes/Coin.tscn")

func _on_Area2D_body_entered(body):
	var iCoin = rCoin.instance()
	iCoin.global_position = self.global_position
	get_tree().get_root().add_child(iCoin)
	$AnimationPlayer.play("break")
	yield($AnimationPlayer,"animation_finished")
	queue_free()
