extends CharacterBody2D

@export var CHAR_SPEED = 100
@export var BULLET_SPEED = 1000
@export var FIRE_RATE = 0.2

var bullet = preload("res://scene/player/bullet/bullet.tscn")
var is_freeze = false
var is_attacking = false

func _process(delta):
	$AreaBullet.look_at(get_global_mouse_position())
		
func _physics_process(delta):	
	if is_freeze == false:
		if is_attacking == false:
			character_velocity()
			idle_animation()
			attack_animation()
		
func character_velocity():
	var direction = Vector2()
	if Input.is_action_pressed("up"):
		direction += Vector2(0, -1)
	if Input.is_action_pressed("down"):
		direction += Vector2(0, 1)
	if Input.is_action_pressed("left"):
		direction += Vector2(-1, 0)
	if Input.is_action_pressed("right"):
		direction += Vector2(1, 0)
	set_velocity(direction * CHAR_SPEED)	
	move_and_slide()
			
func attack_animation():
	if Input.is_action_just_pressed("attack"):
		if(mouse_position() > -135 and mouse_position() < -45):
			$Sprite.play("attack_up")
		elif(mouse_position() > -45 and mouse_position() < 45):
			$Sprite.play("attack_right")
		elif(mouse_position() > 45 and mouse_position() < 135):
			$Sprite.play("attack_down")
		elif(mouse_position() < -135 or mouse_position() > 135):
			$Sprite.play("attack_left")
		spawn_bullet()
	
func spawn_bullet():
	# Call the bullet
	var bullet_instance = bullet.instantiate()
	bullet_instance.position = $AreaBullet/BulletPosition.get_global_position()
	bullet_instance.rotation_degrees = $AreaBullet.rotation_degrees
	bullet_instance.apply_impulse(Vector2(BULLET_SPEED, 0).rotated($AreaBullet.rotation), Vector2())	
	is_attacking = true
	get_tree().get_root().add_child(bullet_instance)
	await get_tree().create_timer(FIRE_RATE).timeout
	is_attacking = false

func idle_animation():
	if Input.is_action_pressed("up"):
		$Sprite.play("walk_up")
	elif Input.is_action_pressed("down"):
		$Sprite.play("walk_down")
	elif Input.is_action_pressed("left"):
		$Sprite.play("walk_left")
	elif Input.is_action_pressed("right"):
		$Sprite.play("walk_right")
	else:
		$Sprite.play("idle_down")
	
func mouse_position():
	var mouse_position = get_global_mouse_position()
	var angle_to_mouse = atan2(mouse_position.y - global_position.y, mouse_position.x - global_position.x)
	return rad_to_deg(angle_to_mouse)

	
	
