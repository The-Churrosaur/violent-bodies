extends StupidGun

@onready var area : Area3D = $laser/Area3D

var laser

func _set_projectile():
	laser = bullet_scene.instantiate()
	add_child(laser)

func _on_shot_timer_timeout():
	current_state = gun_state.BATTERY
	if laser != null: laser.queue_free()
