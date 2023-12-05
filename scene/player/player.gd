extends CharacterBody2D

@export var CHAR_SPEED = 200
@export var BULLET_SPEED = 1000
@export var FIRE_RATE = 0.2

var bullet = preload("res://scene/player/bullet/bullet.tscn")
var is_freeze = false
var is_attacking = false

func _process(delta):
	if is_freeze == false:
		look_at(get_global_mouse_position())
		
func _physics_process(delta):	
	if is_freeze == false:
		character_velocity()
		attack()

func character_velocity():
	var direction = Vector2()
	if is_attacking == false:
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
			
func attack():
	if Input.is_action_just_pressed("attack") and is_attacking == false:
		spawn_bullet()
	
func spawn_bullet():
	# Call the bullet
	var bullet_instance = bullet.instantiate()
	bullet_instance.position = $BulletPosition.get_global_position()
	bullet_instance.rotation_degrees = rotation_degrees
	bullet_instance.apply_impulse(Vector2(BULLET_SPEED, 0).rotated(rotation), Vector2())	
	is_attacking = true
	get_tree().get_root().add_child(bullet_instance)
	await get_tree().create_timer(FIRE_RATE).timeout
	is_attacking = false


	
	
