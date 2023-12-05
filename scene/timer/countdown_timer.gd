extends Node2D

@export var TIME = 30

signal count_timeout

func _ready():
	$Timer.wait_time = TIME
	$Timer.start()
	
func _process(delta):
	var labelText = "%02d:%02d" % time_left_to_live()
	$Label.text = labelText
	
	if(labelText <= "00:00"):
		emit_signal("count_timeout")
		
func time_left_to_live():
	var time_left = $Timer.time_left
	var minute = floor(time_left / 60)
	var second = int(time_left) % 60
	return [minute, second]

