extends Node2D

@onready var timer = $Camera2D/Timer
@onready var label = $Camera2D/Label

func  _ready():
	timer.start()

func _process(delta):
	# Move Camera position to follow user
	$Camera2D.position = $Player.position
	
	var labelText = "%02d:%02d" % time_left_to_live()
	label.text = labelText
	

func time_left_to_live():
	var time_left = timer.time_left
	var minute = floor(time_left / 60)
	var second = int(time_left) % 60
	return [minute, second]

func _on_timer_timeout():
	$Player.is_attacking = true
