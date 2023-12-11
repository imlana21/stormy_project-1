extends RigidBody2D

var group_collision = ["wall", "enemy"]

func _process(delta):
	gravity_scale = 0
	
func _on_body_entered(body):
	for i in group_collision:
		if body.is_in_group(i):
			queue_free()
			
	if body is TileMap:
		queue_free()
