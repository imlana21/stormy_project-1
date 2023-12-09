extends Node2D

@onready var wall = $Wall
@onready var enemy = preload("res://scene/enemy/enemy.tscn")
@onready var cursor = preload("res://assets/cursor-32.png")

var wall_position = Vector2.ZERO

func _ready():
	$Pause.hide()

func _process(delta):
	#Make Pause follow Character Position
	$Pause.position = $Screen/Player.position
	pause_game()

func add_time():
	$Screen/Camera2D/Timer.wait_time = $Screen/Camera2D/Timer.time_left + 5
	$Screen/Camera2D/Timer.start()

func pause_game():
	if Input.is_action_just_pressed("pause"):
		Input.set_custom_mouse_cursor(null)
		Autoload.toggle_pause()
		if Autoload.is_paused:
			$Pause.show()
	else:
		Input.set_custom_mouse_cursor(cursor)
	
func random_tilemap_position():
	var map_size = $TileMap.get_used_rect().size
	var rand_x = randi() % (map_size.x + 1)
	var rand_y = randi() % (map_size.y + 1)
	
	return Vector2(rand_x, rand_y).floor()
	
func spawn_enemy():
	var enemy_spawn_chance = 0.7
	var enemy_total = 3
	
	for i in range(enemy_total):
		if randf() < enemy_spawn_chance:
			var enemy_instance = enemy.instantiate()
			enemy_instance.position = random_tilemap_position()
			add_child(enemy_instance)	

func _on_wall_destroyed(body):
	add_time()

func _on_enemy_enemy_died():
	add_time()

func _on_enemy_enemy_respawn():
	spawn_enemy()

