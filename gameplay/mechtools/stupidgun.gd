
class_name StupidGun
extends MechTool


enum gun_state {EMPTY, CYCLING, BATTERY}

@export var haptics = true
@export var bullet_scene : PackedScene
@export var muzzle : Node3D
@export var launch_force = 100000.0
@export var cycle_time = 0.05
@export var launching_rigidbody : RigidBody3D

@onready var safety = false
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
	if safety : return
	_set_projectile()
	shot_timer.start(cycle_time)
	current_state = gun_state.CYCLING


# overridable
func _set_projectile():
	var bullet : RigidBody3D = bullet_scene.instantiate()
	get_tree().root.add_child(bullet)
	bullet.global_transform = muzzle.global_transform
	bullet.global_rotation = global_rotation
	bullet.linear_velocity = launching_rigidbody.linear_velocity
	bullet.apply_central_force(-global_transform.basis.z * launch_force)
	if haptics:
		XRPlayerGlobals.rhand.trigger_haptic_pulse("haptic", 10, 0.2, 0.1, 0)


func _on_shot_timer_timeout():
	current_state = gun_state.BATTERY

