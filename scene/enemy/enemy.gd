extends CharacterBody2D

const ENEMY_SPEED = 100
var player = null
var is_player_on_area = false
var is_get_attack = false
var is_animation_finished = false

signal enemy_died
signal enemy_respawn

func _physics_process(delta):
	enemy_velocity()
	enemy_animation()

# if player inside enemy collision
func _on_area_detector_body_entered(body):
	if body.is_in_group("player"):
		player = body
		is_player_on_area = true

# if player outside enenmy collision
func _on_area_detector_body_exited(body):
	if body.is_in_group("player"):
		player = null
		is_player_on_area = false

# if bullet touch the enemy move collision layer and play die animation
func _on_attack_detector_body_entered(body):
	if body.is_in_group("bullet"):
		is_get_attack = true
		$EnemySpawnTimer.wait_time = 5
		$EnemySpawnTimer.start()
		enemy_died.emit()
		set_collision_layer_value(1, false)
		set_collision_layer_value(2, false)
		remove_from_group("enemy")

# if animated die finished, hide object and wait until respawn countdown finished
func _on_animated_sprite_2d_animation_finished():
	if is_get_attack:
		is_animation_finished = true
		hide()

# if respawn countdown finished, clean enemy object and call it again
func _on_enemy_spawn_timer_timeout():
	enemy_respawn.emit()
	queue_free()
			
# set enemy to follow player
func enemy_velocity():
	if is_player_on_area:
		position += (player.get_global_position() - global_position)/ENEMY_SPEED

# set enemy animation
func enemy_animation():	
	if is_animation_finished:
		$AnimatedSprite2D.stop()
	elif is_get_attack:
		$AnimatedSprite2D.play("die")
	elif is_player_on_area and !is_get_attack:
		$AnimatedSprite2D.play("walk")
		
		if (player.get_global_position().x - global_position.x) < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.play("idle")

