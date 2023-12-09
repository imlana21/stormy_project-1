extends RigidBody2D

func _process(delta):
	$".".gravity_scale = 0
	
func _on_body_entered(body):
	if body.is_in_group("wall") or body.is_in_group("enemy"):
		queue_free()
	#remove bullet if touch wall map
	if body is TileMap:
		queue_free()
