extends StupidGun

@onready var area : Area3D = $laser/Area3D


func _set_projectile():
	$laser.visible = true
	area.collision_mask = 1

func _on_shot_timer_timeout():
	current_state = gun_state.BATTERY
	$laser.visible = false
	area.collision_mask = 0
