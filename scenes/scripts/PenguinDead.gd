extends Sprite



func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().reload_current_scene()
