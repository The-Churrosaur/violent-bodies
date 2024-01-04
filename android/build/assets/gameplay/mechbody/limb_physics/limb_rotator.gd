## encapsulates rotating a given rigidbody to a target vector
## for selection of relative vectors (forward, up, right): 
## finds the cross product to get the axis of rotation,
## applies forces along that axis to match rotation,
## force values mediated by a PID controller,
## multiple vectors to catch rotation along vector axis
## can also do translation


class_name LimbRotator
extends Node3D

@export var debug = false

## body to be rotated
@export var body : RigidBody3D

## body will attempt to match rotation of target
@export var target : Node3D

## rotation torque on body
@export var max_torque_impulse = 0.1
@export var max_translation_impulse = 0.8
@export var damp = 0.5

@export var recoil_body : RigidBody3D ## equal and opposite

## will try to match these vectors
## selecting a single axis will  not catch rotation along that axis
@export_category("Matching Vectors")
@export var match_z = true
@export var match_y = true
@export var match_x = false 


@onready var rpid = $RotationalPidController
@onready var ppid = $PositionalPidController


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	print()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	if target == null: return
	_rotate_along_axis(delta)
	_apply_translation()


func _rotate_along_axis(delta):
	
	var b_basis = body.global_basis
	var t_basis = target.global_basis
	
	var error_basis : Basis = t_basis * b_basis.inverse()
	var error_quat = error_basis.get_rotation_quaternion()
	
	var error_axis = error_quat.get_axis().normalized()
	var error_angle = error_quat.get_angle()
	
	if debug: 
		print("target rotation: ", target.rotation)
		print("body rotation: ", body.rotation)
		print("ERROR AXIS: ", error_axis)
		pass
	
	_apply_rotation_along(error_axis, error_angle, delta)


func _apply_rotation_along(axis : Vector3, angle, delta):
	var k = rpid.solve(angle)
	body.apply_torque_impulse(axis * max_torque_impulse)


func _apply_translation():
	
	var towards = target.global_position - body.global_position
	var length = towards.length()
	var k = ppid.solve(length)
	if debug: print("TRANS K: ", k)
	
	# dampening by length
	var relative_vel = target.linear_velocity - body.linear_velocity
	var d = damp * relative_vel / length 
	
	var impulse = k * towards * max_translation_impulse
	
	body.apply_central_impulse(impulse)
	body.apply_central_impulse(d)
	
	# wheee
	if recoil_body != null:
		recoil_body.apply_central_impulse(-impulse)
		recoil_body.apply_central_impulse(-d)
