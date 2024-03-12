

## base class for guns.
## attempts to mechanistically simulate the firing cycle of a weapon with state.
## implement burst as special firing if needed

class_name StupidGun
extends Node3D


signal firing()

enum GUN_STATE {CYCLING, BATTERY, OUT_BATTERY}

@export var bullet_scene : PackedScene
@export var muzzle : Node3D
@export var launch_force = 100000.0
@export var is_automatic = true
@export var cycle_when_empty = true ## if true, will cycle the gun to BATTERY on empty
@export var cycle_time = 0.05
@export var launching_rigidbody : RigidBody3D

@onready var safety = false
@onready var cycle_timer = $CycleTimer

var current_state : GUN_STATE = GUN_STATE.OUT_BATTERY
var trigger_down = false
var is_empty = false ## set me! checked before and after cycling 



# CALLBACKS  -------------------------------------------------------------------



func _on_cycle_timer_timeout():
	current_state = GUN_STATE.BATTERY
	
	# does not fire if empty
	if is_empty: 
		_click()
		return
	
	# starts cycle again if automatic
	if is_automatic and trigger_down: _fire()



# PUBLIC -----------------------------------------------------------------------



## trigger weapon once
func trigger():
	pull_trigger()
	release_trigger()


func pull_trigger():
	trigger_down = true
	
	match current_state:
		GUN_STATE.BATTERY: _fire()
		GUN_STATE.OUT_BATTERY: _click()
		GUN_STATE.CYCLING: _clunk()


func release_trigger():
	trigger_down = false


## cycles the action (done automatically if gun is automatic)
## does not cycle if empty
func cycle():
	
	# does not cycle if empty and told not to
	if is_empty and !cycle_when_empty: 
		_click()
		return
	
	current_state = GUN_STATE.CYCLING
	cycle_timer.start(cycle_time)



# PRIVATE ----------------------------------------------------------------------



# internally fires the weapon. if automatic, starts cycling the gun
func _fire():
	_set_projectile()
	firing.emit()
	current_state = GUN_STATE.OUT_BATTERY
	if is_automatic: cycle()


# if trigger is pulled while gun is out of battery
func _click():
	pass

# if trigger is pulled while gun is cycling 
func _clunk():
	pass


# the actual gun firing - spawns projectile -
# overridable for lasers or whatever
func _set_projectile():
	var bullet : RigidBody3D = bullet_scene.instantiate()
	get_tree().root.add_child(bullet)
	bullet.global_transform = muzzle.global_transform
	bullet.global_rotation = global_rotation
	bullet.linear_velocity = launching_rigidbody.linear_velocity
	bullet.apply_central_force(-global_transform.basis.z * launch_force)




