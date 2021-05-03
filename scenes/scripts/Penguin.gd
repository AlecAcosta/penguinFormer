extends KinematicBody2D

var rPenguinDead = preload("res://scenes/PenguinDead.tscn")

enum states {
	PLAYING,
	DYING
}

var state = states.PLAYING

onready var camera = $"../mainCamera"
onready var viewportWidth = get_viewport_rect().size.x

var acceleration : float = 256
var gravity : float = 384
var jumpForce : float = 128
var maxHorSpeed : float = 96
var maxVerFallingSpeed : float = 128
var frictionWeight : float = 0.2

var movement : Vector2 = Vector2(0,0)
var horDir : int = 0

func _ready():
	Global.levelCoins = 0

func _process(delta):
	if state == states.PLAYING:
		if Input.is_action_just_pressed("ui_cancel"):
			get_tree().reload_current_scene()

func _physics_process(delta):
	if state == states.PLAYING:
		movePlayer(delta)
		detectBoxes()
		applyAnimations()
	
	movement = move_and_slide(movement,Vector2.UP)
	global_position.x = clamp(global_position.x,camera.global_position.x-(viewportWidth/2),camera.global_position.x+(viewportWidth/2))
	

func movePlayer(_delta):
	horDir = Input.get_action_strength("right") - Input.get_action_strength("left")
	
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
	
	if is_on_floor():
		$Timer_coyoteGround.start()
	
	if Input.is_action_just_pressed("jump") and ! $Timer_coyoteGround.is_stopped():
		movement.y = -jumpForce

func detectBoxes():
	if $RayCast2D_up.is_colliding():
		var _coll = $RayCast2D_up.get_collider()
		if (_coll.is_in_group("Boxes")):
			_coll.punched()
			movement.y = jumpForce/2

func applyAnimations():
	var animation : String = "idle"
	
	if (horDir != 0):
		animation = "run"
	if (! is_on_floor()):
		if (movement.y < 0):
			animation = "jump"
		else:
			animation = "fall"
	
	$AnimationPlayer.play(animation)

func damaged():
	if state == states.PLAYING:
		state = states.DYING
		queue_free()
		var iPenguinDead = rPenguinDead.instance()
		iPenguinDead.global_position = self.global_position
		get_tree().get_root().add_child(iPenguinDead)

func bounce(_force):
	if state == states.PLAYING:
		movement.y = -_force
