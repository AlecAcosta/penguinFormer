extends KinematicBody2D

onready var camera = $"../mainCamera" 

var acceleration : float = 256
var gravity : float = 384
var jumpForce : float = 128
var maxHorSpeed : float = 96
var maxVerFallingSpeed : float = 128
var frictionWeight : float = 0.2

var movement : Vector2 = Vector2(0,0)


func _physics_process(delta):
	var horDir : int = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	movement.x += horDir * acceleration * delta
	movement.x = clamp(movement.x,-maxHorSpeed,maxHorSpeed)
	
	if (horDir == 0):
		if (abs(movement.x) < 0.1):
			movement.x = 0
		else:
			movement.x = lerp(movement.x,0,frictionWeight)
	else:
		$Sprite.scale.x = horDir
	
	movement.y += gravity * delta
	movement.y = clamp(movement.y,movement.y,maxVerFallingSpeed)
	
	if is_on_floor():
		$Timer_coyoteGround.start()
	
	if Input.is_action_just_pressed("ui_accept") and ! $Timer_coyoteGround.is_stopped():
		movement.y = -jumpForce
	
	movement = move_and_slide(movement,Vector2.UP)
	global_position.x = clamp(global_position.x,camera.global_position.x-240+1,camera.global_position.x+240-1)
	
	var animation : String = "idle"
	
	if (horDir != 0):
		animation = "run"
	if (! is_on_floor()):
		if (movement.y < 0):
			animation = "jump"
		else:
			animation = "fall"
	
	$AnimationPlayer.play(animation)
