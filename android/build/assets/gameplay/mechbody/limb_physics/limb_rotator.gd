## encapsulates rotating a given rigidbody to a target vector
## for selection of relative vectors (forward, up, right): 
## finds the cross product to get the axis of rotation,
## applies forces along that axis to match rotation,
## force values mediated by a PID controller,
## multiple vectors to catch rotation along vector axis


class_name LimbRotator
extends Node3D

## body to be rotated
@export var body : RigidBody3D

## body will attempt to match rotation of target
@export var target : Node3D

## rotation torque on body
@export var max_torque_impulse = 0.05

## will try to match these vectors
## selecting a single axis will  not catch rotation along that axis
@export_category("Matching Vectors")
@export var match_z = true
@export var match_y = true
@export var match_x = false 




# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	print()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	if target == null: pass
	_rotate_along_axis(delta)


func _rotate_along_axis(delta):
	var b_basis = body.transform.basis
	var t_basis = target.transform.basis
	
	var rotation_axis = Vector3.ZERO
	
	if match_z: 
		var cross = b_basis.z.cross(t_basis.z)
		rotation_axis += cross
	if match_y: 
		var cross = b_basis.y.cross(t_basis.y)
		rotation_axis += cross
	if match_x: 
		var cross = b_basis.x.cross(t_basis.x)
		rotation_axis += cross
	
	rotation_axis = rotation_axis.normalized()
	_apply_rotation_along(rotation_axis, delta)


# just apply torque impulse for now
func _apply_rotation_along(axis : Vector3, delta):
	body.apply_torque_impulse(axis.normalized() * max_torque_impulse)
