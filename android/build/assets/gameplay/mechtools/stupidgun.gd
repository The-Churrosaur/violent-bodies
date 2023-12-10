
class_name StupidGun
extends MechTool


enum gun_state {EMPTY, CYCLING, BATTERY}


@export var bullet_scene : PackedScene
@export var launch_force = 10000.0
@export var cycle_time = 0.2

@onready var shot_timer = $ShotTimer

var current_state : gun_state = gun_state.BATTERY


func trigger():
	if current_state == gun_state.BATTERY: 
		_fire()
		$Label3D.text = "FIRING"
	else:
		$Label3D.text = "LOADING"


# cycles the gun
func _fire():
	_set_projectile()
	shot_timer.start(cycle_time)
	current_state = gun_state.CYCLING


# overridable
func _set_projectile():
	var bullet : RigidBody3D = bullet_scene.instantiate()
	get_tree().root.add_child(bullet)
	bullet.global_transform = global_transform
	bullet.global_rotation = global_rotation
	bullet.apply_central_force(global_transform.basis.z * launch_force)


func _on_shot_timer_timeout():
	current_state = gun_state.BATTERY
