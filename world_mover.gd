
class_name WorldMover
extends RigidBody3D


@export var reference_body : RigidBody3D


@export var physics_objects : Array[RigidBody3D]


func apply_world_force(force):
	apply_central_force(force * mass)


func _physics_process(delta):
	#position -= reference_body.linear_velocity
	pass
