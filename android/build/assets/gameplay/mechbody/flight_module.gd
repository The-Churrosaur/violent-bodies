
# makes the ship go whee
# align this with the axis of flight you want

class_name FlightModule
extends Node3D


@export var mechbody : RigidBody3D
@export var coefficient = 1.2
@export var enabled = false

var fore = global_transform.basis.z


func _physics_process(delta):
	if !enabled: return
	
	var vel = mechbody.linear_velocity
	var alpha = fore.angle_to(vel)
	
	var projected = vel.project(fore)
	var up = vel - projected.normalized()
	
	var lift = up * alpha * coefficient
	mechbody.apply_central_force(lift)
	
	
	
