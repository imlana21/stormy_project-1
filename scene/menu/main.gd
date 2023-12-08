extends Control

@onready var world = preload("res://scene/world.tscn")
func _ready():
	pass 

func _process(delta):
	pass

func _on_play_btn_pressed():
	get_tree().change_scene_to_file("res://scene/world.tscn")


func _on_exit_btn_pressed():
	get_tree().quit()


func _on_option_btn_pressed():
	# Coming Soon
	pass
