extends "res://scenes/scripts/Box.gd"

func _ready():
	$Sprite.modulate = Color(1,1,1,0)

func punched():
	if (dropCoin):
		dropCoin = false
		var iCoinGrabbed = rCoinGrabbed.instance()
		iCoinGrabbed.global_position = self.global_position + Vector2(0,-8)###
		get_tree().get_root().add_child(iCoinGrabbed)
		$Sprite.modulate = Color(1,1,1,1)
		$AnimationPlayer.play("break")
		yield($AnimationPlayer,"animation_finished")
		queue_free()
