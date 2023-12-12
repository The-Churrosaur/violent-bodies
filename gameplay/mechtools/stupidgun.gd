
class_name StupidGun
extends MechTool


enum gun_state {EMPTY, CYCLING, BATTERY}

@export var haptics = true
@export var bullet_scene : PackedScene
@export var muzzle : Node3D
@export var launch_force = 100000.0
@export var is_automatic = true
@export var cycle_time = 0.05
@export var burst = true
@export var burst_length = 5
@export var burst_pause = 0.3
@export var launching_rigidbody : RigidBody3D

@onready var safety = false
@onready var shot_timer = $ShotTimer

var current_state : gun_state = gun_state.BATTERY
var trigger_down = false
var current_burst = burst_length

# old method
func trigger():
	pull_trigger()
	release_trigger()


func pull_trigger():
	trigger_down = true
	_try_fire()


func release_trigger():
	trigger_down = false


# attempts to fire and start cycling the gun
func _try_fire():
	if safety : return
	if current_state != gun_state.BATTERY: return
	
	if burst:
		if current_burst <= 0:
			current_burst = burst_length
			current_state = gun_state.CYCLING
			shot_timer.start(burst_pause)
	
	$Label3D.text = "FIRING"
	_set_projectile()
	shot_timer.start(cycle_time)
	current_state = gun_state.CYCLING
	if burst : current_burst -= 1


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
	if trigger_down and is_automatic : _try_fire()

