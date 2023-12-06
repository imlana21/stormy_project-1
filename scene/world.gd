extends Node2D

@onready var wall = $Wall
@onready var enemy = preload("res://scene/enemy/enemy.tscn")

var wall_position = Vector2.ZERO

func add_time():
	$Screen/Camera2D/Timer.wait_time = $Screen/Camera2D/Timer.time_left + 5
	$Screen/Camera2D/Timer.start()
	
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
