
# makes the ship go whee
# align this with the axis of flight you want

class_name FlightModule
extends Node3D


@export var mechbody : RigidBody3D
@export var coefficient = 1.2
@export var max_aoa = PI / 2
@export var enabled = false


func _physics_process(delta):
	if !enabled: return
	
	var fore = -global_transform.basis.z
	var vel = mechbody.linear_velocity
	var alpha = fore.signed_angle_to(vel, -global_transform.basis.x)
	
	if alpha > max_aoa: 
		$Label3D3.text = "stalls"
		return
	if vel.dot(fore) < 0: 
		$Label3D3.text = "vectors opposite"
		return 
	
	var lift = global_transform.basis.y * alpha * coefficient * vel.length_squared()
	mechbody.apply_central_force(lift)
	
	var length = lift.length()
	$Label3D3.text = str(length)
	
	
