extends Camera2D

onready var player = $"../Penguin" 

onready var levelLenght = $"../ColorRect_lvlBkg".rect_size.x


onready var viewportWidth = get_viewport_rect().size.x

func _physics_process(delta):
	
	if is_instance_valid(player):
		if (player.global_position.x > global_position.x and global_position.x < levelLenght- (viewportWidth/2)-1):
			global_position.x = player.global_position.x
