extends Control
	
func _on_continue_btn_pressed():
	continue_game()
	
func _on_exit_btn_pressed():
	get_tree().quit()
	
func continue_game():
	Autoload.toggle_pause()
	if !Autoload.is_paused:
		$".".hide()
	
