extends Camera2D

onready var player = $"../Penguin" 

export var levelLenght = 480

func _physics_process(delta):
	if (player.global_position.x > global_position.x and global_position.x < levelLenght-240):
		global_position.x = player.global_position.x
