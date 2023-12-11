extends CharacterBody2D

@export var CHAR_SPEED = 100
@export var BULLET_SPEED = 400
@export var SHOTGUN_SPEED = 1000
@export var FIRE_RATE = 0.2

var bullet = preload("res://scene/player/bullet/bullet.tscn")
var is_freeze = false
var is_attacking = false
@onready var area_bullet = [$AreaBullet, $AreaBullet2, $AreaBullet3]

func _process(delta):
	for i in area_bullet:
		i.look_at(get_global_mouse_position())
		
func _physics_process(delta):	
	if !is_freeze:
		if !is_attacking:
			walk()
			fire()
		
# Character Walk
func walk():
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
	walk_animation()

# Character Attack
func fire():
	# Call bullet and run animation
	if Input.is_action_just_pressed("attack") or Input.is_action_just_pressed("attack2"):
		attack_animation()
		is_attacking = true
		
	if Input.is_action_just_pressed("attack"):
		spawn_bullet($AreaBullet, $AreaBullet/BulletPosition)
		await get_tree().create_timer(FIRE_RATE).timeout
		is_attacking = false
	elif Input.is_action_just_pressed("attack2"):
		spawn_bullet($AreaBullet, $AreaBullet/BulletPosition)
		spawn_bullet($AreaBullet2, $AreaBullet2/BulletPosition)
		spawn_bullet($AreaBullet3, $AreaBullet3/BulletPosition)
		await get_tree().create_timer(FIRE_RATE).timeout
		is_attacking = false	
	
func walk_animation():
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

func attack_animation():
	if(deg_mouse_position() > -135 and deg_mouse_position() < -45):
		$Sprite.play("attack_up")
	elif(deg_mouse_position() > -45 and deg_mouse_position() < 45):
		$Sprite.play("attack_right")
	elif(deg_mouse_position() > 45 and deg_mouse_position() < 135):
		$Sprite.play("attack_down")
	elif(deg_mouse_position() < -135 or deg_mouse_position() > 135):
		$Sprite.play("attack_left")
	
func deg_mouse_position():
	var mouse_position = get_global_mouse_position()
	var angle_to_mouse = atan2(mouse_position.y - global_position.y, mouse_position.x - global_position.x)
	return rad_to_deg(angle_to_mouse)

#func spawn_bullet(area, bullet_position):
	## Call the object
	#var bullet_instance = bullet.instantiate()
	#bullet_instance.position = bullet_position.get_global_position()
	#bullet_instance.direction = bullet_instance.get_global_position() - get_global_position()
	#bullet_instance.translate(bullet_instance.direction)
	#get_tree().get_root().add_child(bullet_instance)


func spawn_bullet(area, bullet_position):
	# Call the object
	var bullet_instance = bullet.instantiate()
	bullet_instance.position = bullet_position.get_global_position()
	bullet_instance.rotation_degrees = area.rotation_degrees
	bullet_instance.apply_impulse(Vector2(BULLET_SPEED, 0).rotated(area.rotation), Vector2())	
	get_tree().get_root().add_child(bullet_instance)
