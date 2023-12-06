extends StaticBody2D

signal wall_destroyed
	
func _on_area_2d_body_entered(body):
	if body.is_in_group("bullet"):
		wall_destroyed.emit(self)
		$WallTimerSpawn.wait_time = 5
		$WallTimerSpawn.start()
		self.hide()
		self.set_collision_layer_value(1, false)
		remove_from_group("wall")

func _on_wall_timer_spawn_timeout():
	self.set_collision_layer_value(1, true)
	add_to_group("wall")
	self.show()
