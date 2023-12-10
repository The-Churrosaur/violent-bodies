extends StupidGun


func _set_projectile():
	$laser.visible = true

func _on_shot_timer_timeout():
	current_state = gun_state.BATTERY
	$laser.visible = false
