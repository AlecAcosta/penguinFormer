extends KinematicBody2D

var rSpriteTempPlaceHolder = preload("res://scenes/SpriteTempPlaceHolder.tscn")

var acceleration : float = 256
var gravity : float = 384
var jumpForce : float = 128
var maxHorSpeed : float = 40
var maxVerFallingSpeed : float = 128
var frictionWeight : float = 0.2

var movement : Vector2 = Vector2(0,0)
var horDir : int = 1

func _physics_process(delta):
	moveEnemy(delta)

func moveEnemy(_delta):
	#horDir = 0
	
	movement.x += horDir * acceleration * _delta
	movement.x = clamp(movement.x,-maxHorSpeed,maxHorSpeed)
	
	if (horDir == 0):
		if (abs(movement.x) < 0.1):
			movement.x = 0
		else:
			movement.x = lerp(movement.x,0,frictionWeight)
	else:
		$Sprite.scale.x = horDir
	
	movement.y += gravity * _delta
	movement.y = clamp(movement.y,movement.y,maxVerFallingSpeed)
	
#	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
#	movement.y = -jumpForce
	
	movement = move_and_slide(movement,Vector2.UP)

func _on_Area2D_Head_body_entered(body):
	if body.is_in_group("Penguin"):
		body.bounce(body.jumpForce/2)
		var iSpriteTempPlaceHolder = rSpriteTempPlaceHolder.instance()
		iSpriteTempPlaceHolder.get_node("AnimationPlayer").play("EnemyRed")
		iSpriteTempPlaceHolder.global_position = self.global_position
		get_tree().get_root().add_child(iSpriteTempPlaceHolder)
		queue_free()


func _on_Area2D_Right_body_entered(body):
	if (body.is_in_group("TilemapWorld") or body.is_in_group("Entity")):
		horDir = -1
		if body.is_in_group("Penguin"):
			body.damaged()


func _on_Area2D_Left_body_entered(body):
	if (body.is_in_group("TilemapWorld") or body.is_in_group("Entity")):
		horDir = 1
		if body.is_in_group("Penguin"):
			body.damaged()
