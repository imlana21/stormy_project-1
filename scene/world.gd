extends Node2D

@onready var wall = $Wall

var wall_position = Vector2.ZERO

func _on_wall_destroyed(body):
	$Screen/Camera2D/Timer.wait_time = $Screen/Camera2D/Timer.time_left + 5
	$Screen/Camera2D/Timer.start()
