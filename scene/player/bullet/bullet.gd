extends RigidBody2D

func _ready():
	print("test")

func _on_body_entered(body):
	print(body.is_in_group("player"))
	if !body.is_in_group("player"):
		queue_free()
